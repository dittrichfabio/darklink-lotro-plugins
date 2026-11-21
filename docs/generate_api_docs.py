#!/usr/bin/env python3
"""Convert the official LotRO Lua API HTML docs (docs/OfficialLuaDocumentation)
into consolidated Markdown files under docs/api/.

One Markdown file is generated per API type (class / static class / enum),
merging the type's overview page, its "$Members" listing and every member
detail page (syntax, parameters, returns, remarks, examples).

Namespace overview pages (Turbine, Turbine.Gameplay, ...) get their own file,
and a README.md index links everything together.

Usage:  python3 docs/generate_api_docs.py
"""

import glob
import html as html_mod
import os
import re

from bs4 import BeautifulSoup, NavigableString, Tag

SRC_DIR = os.path.join(os.path.dirname(os.path.abspath(__file__)), "OfficialLuaDocumentation")
OUT_DIR = os.path.join(os.path.dirname(os.path.abspath(__file__)), "api")

SKIP_FILES = {"index.html", "toc.html", "package_index.html"}


def load_soup(fname):
    data = open(os.path.join(SRC_DIR, fname), "rb").read()
    enc = "utf-16" if data[:2] == b"\xff\xfe" else "utf-8"
    return BeautifulSoup(data.decode(enc, errors="replace"), "html.parser")


def type_name(stem):
    """Turbine_Gameplay_Actor -> Turbine.Gameplay.Actor"""
    return stem.replace("_", ".")


def md_escape(text):
    return text.replace("|", "\\|").replace("\n", " ").strip()


class Converter:
    def __init__(self):
        self.generated = set()  # dotted type names that get their own .md file
        self.anchors = {}       # dotted type name -> set of member anchors

    # ---------- link / anchor helpers ----------

    def href_stem(self, a):
        href = (a.get("href") or "").strip()
        if href.endswith(".html"):
            return href[: -len(".html")]
        return None

    def resolve_link(self, stem, text):
        """Turn an .html href target into a markdown link when we can."""
        base = stem.split("$")[0].split("~")[0]
        dotted = type_name(base)
        if dotted in self.generated:
            return f"[{text}]({dotted}.md)"
        return f"`{text}`"

    def anchor(self, title):
        return re.sub(r"[^a-z0-9 -]", "", title.lower()).replace(" ", "-")

    # ---------- inline / block conversion ----------

    def inline(self, node):
        """Convert a node's children to inline markdown."""
        out = []
        for ch in node.children if isinstance(node, Tag) else [node]:
            if isinstance(ch, NavigableString):
                out.append(str(ch))
            elif not isinstance(ch, Tag):
                continue
            elif ch.name in ("img", "include", "script", "style"):
                continue
            elif ch.name == "br":
                out.append(" ")
            elif ch.name == "a":
                text = ch.get_text(" ", strip=True)
                stem = self.href_stem(ch)
                if stem:
                    out.append(self.resolve_link(stem, text))
                else:
                    out.append(text)
            elif ch.name in ("b", "strong"):
                out.append(f"**{ch.get_text(' ', strip=True)}**")
            elif ch.name in ("i", "em"):
                out.append(f"*{ch.get_text(' ', strip=True)}*")
            elif ch.name in ("span", "font", "para"):
                out.append(self.inline(ch))
            elif ch.name in ("ul", "ol", "dl", "table", "div", "p", "h1", "h4", "pre"):
                out.append(" " + ch.get_text(" ", strip=True) + " ")
            else:
                out.append(self.inline(ch))
        text = "".join(out)
        text = html_mod.unescape(text)
        text = re.sub(r"[ \t]+", " ", text)
        text = re.sub(r" *\n *", "\n", text)
        return text.strip()

    def code_blocks(self, container):
        """Extract fenced lua code blocks from a div.code container."""
        parts = []
        divs = []
        if isinstance(container, Tag) and "code" in (container.get("class") or []):
            divs.append(container)
        divs += container.find_all("div", class_="code")
        for div in divs:
            pre = div.find("pre")
            if not pre:
                continue
            th = div.find("th")
            title = th.get_text(strip=True) if th else ""
            code = pre.get_text().rstrip("\n")
            if title and title != "Lua":
                parts.append(f"*{title}:*\n\n```lua\n{code}\n```")
            else:
                parts.append(f"```lua\n{code}\n```")
        # a bare <pre> not wrapped in div.code
        for pre in container.find_all("pre"):
            if not pre.find_parent("div", class_="code"):
                parts.append(f"```lua\n{pre.get_text().rstrip()}\n```")
        return parts

    def table_md(self, table):
        rows = []
        for tr in table.find_all("tr"):
            cells = tr.find_all(["td", "th"])
            rows.append([self.inline(td) for td in cells])
        rows = [r for r in rows if any(c for c in r)]
        if not rows:
            return ""
        # drop icon column (always empty after img removal)
        rows = [[c for c in r] for r in rows]
        ncols = max(len(r) for r in rows)
        if rows[0] and rows[0][0] == "":
            for r in rows:
                if r:
                    r.pop(0)
            ncols -= 1
        lines = []
        header = rows[0] + [""] * (ncols - len(rows[0]))
        lines.append("| " + " | ".join(md_escape(c) for c in header) + " |")
        lines.append("|" + "---|" * ncols)
        for r in rows[1:]:
            r = r + [""] * (ncols - len(r))
            lines.append("| " + " | ".join(md_escape(c) for c in r) + " |")
        return "\n".join(lines)

    def params_md(self, div):
        """div#parameters -> markdown definition list."""
        lines = ["**Parameters:**", ""]
        for dl in div.find_all("dl"):
            dt = dl.find("dt")
            dd = dl.find("dd")
            if not dt or not dd:
                continue
            name = dt.get_text(strip=True)
            type_span = dd.find("span", class_="type")
            ptype = ""
            if type_span:
                a = type_span.find("a")
                if a and self.href_stem(a):
                    ptype = self.resolve_link(
                        self.href_stem(a), a.get_text(strip=True)
                    )
                else:
                    ptype = f"`{type_span.get_text(strip=True).replace('Type:', '').strip()}`"
                type_span.extract()
            desc = self.inline(dd)
            entry = f"- `{name}`"
            if ptype:
                entry += f" ({ptype})"
            if desc:
                entry += f" — {desc}"
            lines.append(entry)
        return "\n".join(lines)

    def returns_md(self, div):
        h4 = div.find("h4")
        if h4:
            h4.extract()
        type_span = div.find("span", class_="type")
        rtype = ""
        if type_span:
            a = type_span.find("a")
            if a and self.href_stem(a):
                rtype = self.resolve_link(
                    self.href_stem(a), a.get_text(strip=True)
                )
            else:
                rtype = f"`{type_span.get_text(strip=True).replace('Type:', '').strip()}`"
            type_span.extract()
        desc = self.inline(div)
        out = "**Returns:**"
        if rtype:
            out += f" {rtype}"
        if desc:
            out += f" — {desc}"
        return out

    def section_md(self, section_div):
        """Generic conversion of a div.Section's contents."""
        parts = []
        for ch in section_div.children:
            if isinstance(ch, NavigableString):
                t = str(ch).strip()
                if t:
                    parts.append(t)
            elif not isinstance(ch, Tag):
                continue
            elif ch.name == "a":
                continue  # stray 'top' link
            elif ch.get("id") == "syntaxCodeBlocks":
                parts.extend(self.code_blocks(ch))
            elif ch.get("id") == "parameters":
                parts.append(self.params_md(ch))
            elif ch.get("id") == "returns":
                parts.append(self.returns_md(ch))
            elif ch.name == "table":
                parts.append(self.table_md(ch))
            elif ch.name in ("ul", "ol"):
                for li in ch.find_all("li", recursive=False):
                    parts.append(f"- {self.inline(li)}")
            elif ch.name == "pre":
                parts.append(f"```lua\n{ch.get_text().rstrip()}\n```")
            elif ch.name in ("div",):
                if "code" in (ch.get("class") or []):
                    parts.extend(self.code_blocks(ch.parent))
                    break
                sub = self.section_md(ch)
                if sub:
                    parts.append(sub)
            elif ch.name in ("para", "p", "span"):
                t = self.inline(ch)
                if t:
                    parts.append(t)
            elif ch.name == "br":
                continue
            else:
                t = self.inline(ch)
                if t:
                    parts.append(t)
        return "\n\n".join(p for p in parts if p)

    # ---------- page parsing ----------

    def page_sections(self, soup):
        """Return (summary, [(title, section_div)]) for a mainBody."""
        main = soup.find("div", id="mainBody")
        if not main:
            return "", []
        summary_parts = []
        sections = []
        pending_title = None
        for ch in main.children:
            if isinstance(ch, NavigableString):
                if str(ch).strip() and pending_title is None:
                    summary_parts.append(str(ch).strip())
                continue
            if not isinstance(ch, Tag):
                continue
            if ch.name == "h1" and "heading" in (ch.get("class") or []):
                pending_title = ch.get_text(" ", strip=True)
            elif ch.name == "div" and "Section" in (ch.get("class") or []):
                sections.append((pending_title or ch.get("id", "Section"), ch))
                pending_title = None
            elif pending_title is None:
                if ch.name == "para" and "Beta Documentation" in ch.get_text():
                    continue
                if ch.name in ("para", "p", "span") or ch.name is None:
                    t = self.inline(ch)
                    if t:
                        summary_parts.append(t)
                else:
                    t = self.inline(ch)
                    if t:
                        summary_parts.append(t)
        return " ".join(summary_parts).strip(), sections

    def member_detail_md(self, fname):
        """Full markdown body for a single member page."""
        soup = load_soup(fname)
        summary, sections = self.page_sections(soup)
        parts = []
        if summary:
            parts.append(summary)
        for title, div in sections:
            sid = div.get("id", "")
            if sid == "syntaxSection":
                parts.append(self.section_md(div))
            elif title in ("Remarks",):
                body = self.section_md(div)
                if body and body != summary:
                    parts.append(body)
            elif title in ("See Also",):
                continue
            else:
                body = self.section_md(div)
                if body:
                    parts.append(f"*{title}:*\n\n{body}" if title not in body else body)
        return "\n\n".join(p for p in parts if p)


def main():
    conv = Converter()

    all_files = sorted(
        os.path.basename(p)
        for p in glob.glob(os.path.join(SRC_DIR, "*.html"))
        if os.path.basename(p) not in SKIP_FILES
    )
    stems = [f[: -len(".html")] for f in all_files]

    members_files = {s[: -len("$Members")]: s for s in stems if s.endswith("$Members")}
    overload_files = {s[: -len("$Overloads")]: s for s in stems if s.endswith("$Overloads")}
    overload_pages = {}  # member stem -> [overload detail stems]
    for s in stems:
        m = re.match(r"^(.*)~(\d+)$", s)
        if m:
            overload_pages.setdefault(m.group(1), []).append((int(m.group(2)), s))
    for k in overload_pages:
        overload_pages[k] = [s for _, s in sorted(overload_pages[k])]

    # member detail pages are exactly the files linked from the name column
    # of $Members tables (not "Inherited from" / See Also links)
    member_page_stems = set()
    for s in members_files.values():
        soup = load_soup(s + ".html")
        for table in soup.find_all("table", class_="members"):
            for tr in table.find_all("tr"):
                tds = tr.find_all("td")
                if len(tds) >= 2:
                    a = tds[1].find("a")
                    if a:
                        h = conv.href_stem(a)
                        if h and h in stems:
                            member_page_stems.add(h)

    # overloaded members (constructors etc.) are member pages too, even
    # though their base page has no "$"/"~" marker in its own name
    member_page_stems |= set(overload_files) | set(overload_pages)

    base_pages = [
        s
        for s in stems
        if "$" not in s and "~" not in s and s not in member_page_stems
    ]

    # classify base pages: namespace pages have Classes/Enumerations sections
    namespace_pages = set()
    parsed_base = {}
    for s in base_pages:
        soup = load_soup(s + ".html")
        summary, sections = conv.page_sections(soup)
        sec_ids = {d.get("id") for _, d in sections}
        if sec_ids & {"ClassesSection", "EnumerationsSection", "PackagesSection"}:
            namespace_pages.add(s)
        parsed_base[s] = (summary, sections)

    # every base page that isn't a namespace page is a type; also types are
    # those with $Members files
    type_stems = [s for s in base_pages if s not in namespace_pages]

    conv.generated = {type_name(s) for s in type_stems} | {
        type_name(s) for s in namespace_pages
    }

    os.makedirs(OUT_DIR, exist_ok=True)
    for old in glob.glob(os.path.join(OUT_DIR, "*.md")):
        os.remove(old)

    ns_index = {}  # namespace dotted name -> md body

    # ---- type files ----
    type_info = {}  # stem -> dict(kind, title, member names)
    for stem in type_stems:
        dotted = type_name(stem)
        summary, sections = parsed_base[stem]
        kind = "Enumeration" if any(
            d.get("id") == "FieldsSection" for _, d in sections
        ) else "Class"
        info = {"kind": kind, "members": []}

        lines = [f"# `{dotted}`"]
        if summary:
            lines += ["", summary]

        for title, div in sections:
            sid = div.get("id", "")
            if sid == "inheritanceSection":
                seq = []
                for el in div.children:
                    if isinstance(el, Tag) and el.name in ("a", "b"):
                        t = el.get_text(strip=True)
                        if not seq or seq[-1] != t:
                            seq.append(t)
                chain_md = " → ".join(
                    f"**{c}**" if c == dotted else f"`{c}`" for c in seq
                )
                lines += ["", f"**Inheritance:** {chain_md}"]
            elif title == "Remarks":
                body = conv.section_md(div)
                if body and body != summary:
                    lines += ["", body]
            elif sid == "FieldsSection":
                lines += ["", "## Fields", "", conv.table_md(div.find("table"))]
            elif title == "See Also":
                continue
            else:
                body = conv.section_md(div)
                if body:
                    lines += ["", f"## {title}", "", body]

        # ---- members ----
        member_groups = []  # (group title, [(name, href_stem, desc, inherited)])
        if stem in members_files:
            soup = load_soup(members_files[stem] + ".html")
            _, msecs = conv.page_sections(soup)
            for title, div in msecs:
                table = div.find("table", class_="members")
                if not table:
                    continue
                entries = []
                for tr in table.find_all("tr")[1:]:
                    tds = tr.find_all("td")
                    if len(tds) < 3:
                        continue
                    link = tds[1].find("a")
                    if not link:
                        continue
                    name = link.get_text(strip=True)
                    href = conv.href_stem(link)
                    desc = conv.inline(tds[2])
                    inherited = None
                    m = re.search(r"Inherited from\s+\[?([A-Za-z0-9_.]+)", desc)
                    if m:
                        inherited = m.group(1)
                    desc = re.sub(r"\s*\(Inherited from.*\)\s*$", "", desc)
                    entries.append((name, href, desc, inherited))
                    info["members"].append(name)
                if entries:
                    member_groups.append((title, entries))

        anchor_names = set()
        for title, entries in member_groups:
            lines += ["", f"## {title}", ""]
            # detail sections
            for name, href, desc, inherited in entries:
                anchor_names.add(name.lower())
                if inherited:
                    continue
                page_stem = None
                overload_member = None
                if href:
                    if href.endswith("$Overloads"):
                        overload_member = href[: -len("$Overloads")]
                    elif "~" in href:
                        overload_member = re.match(r"^(.*)~\d+$", href).group(1)
                    elif href in stems:
                        page_stem = href
                heading = name + ("()" if title in ("Methods", "Constructors") else "")
                lines.append(f"### `{heading}`")
                lines.append("")
                if overload_member:
                    details = []
                    if overload_member in member_page_stems and overload_member in stems:
                        details.append(
                            conv.member_detail_md(overload_member + ".html")
                        )
                    details += [
                        conv.member_detail_md(ostem + ".html")
                        for ostem in overload_pages.get(overload_member, [])
                    ]
                    lines.append("\n\n".join(d for d in details if d) or desc)
                elif page_stem and page_stem not in base_pages:
                    lines.append(conv.member_detail_md(page_stem + ".html"))
                elif page_stem and page_stem in base_pages:
                    lines.append(desc)
                else:
                    lines.append(desc)
                lines.append("")
            inherited = [(n, d) for n, h, d, i in entries if i]
            if inherited:
                lines.append(f"*{title} inherited from base classes:*")
                lines.append("")
                for n, d in inherited:
                    lines.append(f"- `{n}` — {d}")
                lines.append("")

        type_info[stem] = info
        out = os.path.join(OUT_DIR, f"{dotted}.md")
        with open(out, "w", encoding="utf-8") as fh:
            fh.write("\n".join(lines).replace("\n\n\n\n", "\n\n") + "\n")

    # ---- namespace files ----
    for stem in sorted(namespace_pages):
        dotted = type_name(stem)
        summary, sections = parsed_base[stem]
        lines = [f"# `{dotted}` (namespace)"]
        if summary:
            lines += ["", summary]
        for title, div in sections:
            sid = div.get("id", "")
            if sid in ("ClassesSection", "EnumerationsSection", "PackagesSection"):
                lines += ["", f"## {title}", ""]
                table = div.find("table")
                if table:
                    lines.append(conv.table_md(table))
            elif title in ("Remarks", "See Also"):
                body = conv.section_md(div)
                if body:
                    lines += ["", f"## {title}", "", body]
        with open(os.path.join(OUT_DIR, f"{dotted}.md"), "w", encoding="utf-8") as fh:
            fh.write("\n".join(lines) + "\n")

    # ---- index ----
    idx = ["# Turbine Lua API Reference", ""]
    idx.append(
        "Markdown conversion of the official LotRO Lua API docs "
        "(`docs/OfficialLuaDocumentation/`). Regenerate with "
        "`python3 docs/generate_api_docs.py`."
    )
    idx.append("")

    # group each type under its nearest ancestor namespace page. Some types
    # (e.g. Turbine.Gameplay.Attributes) double as namespaces for the types
    # below them.
    containers = set(namespace_pages) | set(type_stems)

    def parent_of(stem):
        parts = stem.split("_")
        for i in range(len(parts) - 1, 0, -1):
            cand = "_".join(parts[:i])
            if cand in containers:
                return cand
        return None

    groups = {}
    for s in type_stems:
        groups.setdefault(parent_of(s), []).append(s)

    for stem in sorted(namespace_pages):
        idx.append(f"## [{type_name(stem)}]({type_name(stem)}.md)")
        idx.append("")
        for s in sorted(groups.get(stem, [])):
            d = type_name(s)
            note = "namespace + class" if s in groups and s in type_stems else type_info[s]["kind"].lower()
            idx.append(f"- [{d}]({d}.md) ({note})")
            for sub in sorted(groups.get(s, [])):
                ds = type_name(sub)
                idx.append(f"  - [{ds}]({ds}.md) ({type_info[sub]['kind'].lower()})")
        idx.append("")
    with open(os.path.join(OUT_DIR, "README.md"), "w", encoding="utf-8") as fh:
        fh.write("\n".join(idx) + "\n")

    print(f"Wrote {len(type_stems)} type files, {len(namespace_pages)} namespace files -> {OUT_DIR}")

    # sanity: html files not consumed
    consumed = set(members_files.values()) | set(overload_files.values()) | set(base_pages)
    for lst in overload_pages.values():
        consumed.update(lst)
    # member detail pages
    consumed.update(member_page_stems)
    leftover = [s for s in stems if s not in consumed]
    if leftover:
        print("Unparsed files:", leftover)


if __name__ == "__main__":
    main()
