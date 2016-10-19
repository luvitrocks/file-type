# file-type

> Detect the file type of a Buffer in [Luvit.io](https://luvit.io).

The file type is detected by checking the [magic number](http://en.wikipedia.org/wiki/Magic_number_(programming)#Magic_numbers_in_files) of the buffer.

## Install

```bash
lit install voronianski/file-type
```

## Example

```lua
local http = require('http')
local fileType = require('file-type')
local url = 'http://assets-cdn.github.com/images/spinners/octocat-spinner-32.gif'

http.get(url, function (res)
  res:on('data', function (chunk) 
    print(fileType(chunk))
    -- {ext = 'gif', mime = 'image/gif'}
  end)
end)
```

## API

### fileType(buffer)

Returns a `Table` (or `nil` when no match) with:

- `ext` - one of the [supported file types](#supported-file-types)
- `mime` - the [MIME type](http://en.wikipedia.org/wiki/Internet_media_type)

#### buffer

Type: [`Buffer`](https://luvit.io/api/buffer.html)

It only needs the first 262 bytes.

## Supported file types

- [`jpg`](https://en.wikipedia.org/wiki/JPEG)
- [`png`](https://en.wikipedia.org/wiki/Portable_Network_Graphics)
- [`gif`](https://en.wikipedia.org/wiki/GIF)
- [`webp`](https://en.wikipedia.org/wiki/WebP)
- [`flif`](https://en.wikipedia.org/wiki/Free_Lossless_Image_Format)
- [`cr2`](http://fileinfo.com/extension/cr2)
- [`tif`](https://en.wikipedia.org/wiki/Tagged_Image_File_Format)
- [`bmp`](https://en.wikipedia.org/wiki/BMP_file_format)
- [`jxr`](https://en.wikipedia.org/wiki/JPEG_XR)
- [`psd`](https://en.wikipedia.org/wiki/Adobe_Photoshop#File_format)
- [`zip`](https://en.wikipedia.org/wiki/Zip_(file_format))
- [`tar`](https://en.wikipedia.org/wiki/Tar_(computing)#File_format)
- [`rar`](https://en.wikipedia.org/wiki/RAR_(file_format))
- [`gz`](https://en.wikipedia.org/wiki/Gzip)
- [`bz2`](https://en.wikipedia.org/wiki/Bzip2)
- [`7z`](https://en.wikipedia.org/wiki/7z)
- [`dmg`](https://en.wikipedia.org/wiki/Apple_Disk_Image)
- [`mp4`](https://en.wikipedia.org/wiki/MPEG-4_Part_14#Filename_extensions)
- [`m4v`](https://en.wikipedia.org/wiki/M4V)
- [`mid`](https://en.wikipedia.org/wiki/MIDI)
- [`mkv`](https://en.wikipedia.org/wiki/Matroska)
- [`webm`](https://en.wikipedia.org/wiki/WebM)
- [`mov`](https://en.wikipedia.org/wiki/QuickTime_File_Format)
- [`avi`](https://en.wikipedia.org/wiki/Audio_Video_Interleave)
- [`wmv`](https://en.wikipedia.org/wiki/Windows_Media_Video)
- [`mpg`](https://en.wikipedia.org/wiki/MPEG-1)
- [`mp3`](https://en.wikipedia.org/wiki/MP3)
- [`m4a`](https://en.wikipedia.org/wiki/MPEG-4_Part_14#.MP4_versus_.M4A)
- [`ogg`](https://en.wikipedia.org/wiki/Ogg)
- [`opus`](https://en.wikipedia.org/wiki/Opus_(audio_format))
- [`flac`](https://en.wikipedia.org/wiki/FLAC)
- [`wav`](https://en.wikipedia.org/wiki/WAV)
- [`amr`](https://en.wikipedia.org/wiki/Adaptive_Multi-Rate_audio_codec)
- [`pdf`](https://en.wikipedia.org/wiki/Portable_Document_Format)
- [`epub`](https://en.wikipedia.org/wiki/EPUB)
- [`exe`](https://en.wikipedia.org/wiki/.exe)
- [`swf`](https://en.wikipedia.org/wiki/SWF)
- [`rtf`](https://en.wikipedia.org/wiki/Rich_Text_Format)
- [`woff`](https://en.wikipedia.org/wiki/Web_Open_Font_Format)
- [`woff2`](https://en.wikipedia.org/wiki/Web_Open_Font_Format)
- [`eot`](https://en.wikipedia.org/wiki/Embedded_OpenType)
- [`ttf`](https://en.wikipedia.org/wiki/TrueType)
- [`otf`](https://en.wikipedia.org/wiki/OpenType)
- [`ico`](https://en.wikipedia.org/wiki/ICO_(file_format))
- [`flv`](https://en.wikipedia.org/wiki/Flash_Video)
- [`ps`](https://en.wikipedia.org/wiki/Postscript)
- [`xz`](https://en.wikipedia.org/wiki/Xz)
- [`sqlite`](https://www.sqlite.org/fileformat2.html)
- [`nes`](http://fileinfo.com/extension/nes)
- [`crx`](https://developer.chrome.com/extensions/crx)
- [`xpi`](https://en.wikipedia.org/wiki/XPInstall)
- [`cab`](https://en.wikipedia.org/wiki/Cabinet_(file_format))
- [`deb`](https://en.wikipedia.org/wiki/Deb_(file_format))
- [`ar`](https://en.wikipedia.org/wiki/Ar_(Unix))
- [`rpm`](http://fileinfo.com/extension/rpm)
- [`Z`](http://fileinfo.com/extension/z)
- [`lz`](https://en.wikipedia.org/wiki/Lzip)
- [`msi`](https://en.wikipedia.org/wiki/Windows_Installer)

**SVG isn't included as it requires the whole file to be read.**

**PR welcome for additional commonly used file types.**

## License

MIT Licensed

Copyright (c) 2016 Dmitri Voronianski [dmitri.voronianski@gmail.com](mailto:dmitri.voronianski@gmail.com)

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
