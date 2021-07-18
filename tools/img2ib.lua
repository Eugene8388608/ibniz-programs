local bmp = {}

local function pix2loadimm(i)
	return string.format('%X', bmp[i+2]<<24 | bmp[i+3]<<16 | bmp[i]<<8 | bmp[i+1])
end
local function pix2data(i)
	return string.format('%02X%02X%02X%02X', bmp[i], bmp[i+1], bmp[i+2], bmp[i+3])
end

local inp_name, out_name = ...

local out_file = assert(io.open(out_name, 'w'))
local in_file = assert(io.popen('ffmpeg -v 16 -i "'..inp_name..'" -f rawvideo -s 128x128 -pix_fmt yuvj422p -', 'rb'))

for i = 1, 32765, 4 do
	bmp[i+2], bmp[i+3] = string.unpack('BB', in_file:read(2))
end

for i = 1, 32765, 4 do
	bmp[i+1] = string.unpack('B', in_file:read(1))~128
end

for i = 1, 32765, 4 do
	bmp[i] = string.unpack('B', in_file:read(1))~128
end

out_file:write('1+5l3F.8&x1+Cl1FC0&|d@dFFFF&xv4l8&l.FF&|xpxFFE@', pix2loadimm(16377), '^?')
for i = 16377, 32573, 4 do
	out_file:write(pix2loadimm(i), ',')
end
out_file:write('FD2XiFFD+!L;$')
for i = 1, 16373, 4 do
	out_file:write(pix2data(i))
end

out_file:write(string.format('%02X', bmp[16377]~255))
--out_file:write('0000001')

::close::
in_file:close()
out_file:close()