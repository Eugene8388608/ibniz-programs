How to convert an image to IBNIZ program:
1. Download [FFmpeg](https://www.gyan.dev/ffmpeg/builds/ffmpeg-release-essentials.7z) and [Lua 5.3.5](https://sourceforge.net/projects/luabinaries/files/5.3.5/Tools%20Executables/lua-5.3.5_Win64_bin.zip/download) (Lua 5.3.**6** doesn't work, see below)
2. Extract files `ffmpeg.exe`, `lua53.exe`, `lua53.dll` in a new folder
3. Run command prompt in this folder (enter `cmd` in address bar)
4. Enter `lua53 img2ib.lua your_image.png program.ib`
5. Open `program.ib` in IBNIZ and enjoy

Lua 5.3.6 and later versions don't want to open pipes in binary modes, and because of this img2ib.lua fails

Pixel format `yuvj422p` is used. I also tried `yuv422` as it's simpler to adapt for IBNIZ but the colors were desaturated a bit.

This converter stores each couple of pixels as `VVUU.Y1Y2`, where `VV` and `UU` are their average chroma components and `Y1` and `Y2` are luma components of left and right pixels respectively.
