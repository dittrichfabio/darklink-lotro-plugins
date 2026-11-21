#!/usr/bin/env bash
# Deploy a plugin (plus shared common/ code) into the game's Plugins folder.
#
# Usage:
#   ./deploy.sh <PluginName> [PluginsDir]
#
# PluginsDir can also be set via the LOTRO_PLUGINS env var. From WSL, point it
# at the Windows Plugins folder through /mnt/c, e.g.:
#   export LOTRO_PLUGINS="/mnt/c/Users/you/Documents/The Lord of the Rings/Plugins"
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")" && pwd)"
PLUGIN="${1:-}"
PLUGINS_DIR="${2:-${LOTRO_PLUGINS:-}}"

if [[ -z "$PLUGIN" ]]; then
    echo "usage: $0 <PluginName> [PluginsDir]" >&2
    echo "available plugins:" >&2
    ls "$REPO_ROOT/plugins" >&2
    exit 1
fi
if [[ ! -d "$REPO_ROOT/plugins/$PLUGIN" ]]; then
    echo "no such plugin: plugins/$PLUGIN" >&2
    exit 1
fi
if [[ -z "$PLUGINS_DIR" || ! -d "$PLUGINS_DIR" ]]; then
    echo "Plugins dir not found: '${PLUGINS_DIR:-<unset>}'" >&2
    echo "Pass it as an argument or set LOTRO_PLUGINS." >&2
    exit 1
fi

cp -r "$REPO_ROOT/plugins/$PLUGIN" "$PLUGINS_DIR/"

# Deploy shared code only if there is anything to deploy.
if find "$REPO_ROOT/common" -name '*.lua' | grep -q .; then
    mkdir -p "$PLUGINS_DIR/Common"
    cp -r "$REPO_ROOT/common/." "$PLUGINS_DIR/Common/"
    echo "Deployed Common -> $PLUGINS_DIR/Common"
fi

echo "Deployed $PLUGIN -> $PLUGINS_DIR/$PLUGIN"
echo "Run '/plugins refresh' in-game to reload."
