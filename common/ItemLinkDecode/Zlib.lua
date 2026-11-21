-- Originally by Equendil: "Item Links Decoding" (lotrointerface.com info844).
-- Vendored into Common.ItemLinkDecode with compatibility patches.

-- Basic implementation of the zlib library in lua
-- FDICT is not supported
-- the static huffman codes method is not supported

Zlib = {};

-- inflate (uncompress) data
-- Data is a binary string
-- returns an array of bytes
function Zlib.Inflate( data )
	local inflatedData = {};
	local outputFun = function ( byte )
		table.insert( inflatedData, byte );
	end
	
	ZlibDeflate.inflate_zlib( { input = data, output = outputFun, disable_crc=false });
	
	return inflatedData;
end
