function fileType (buffer)
  local buf = {}

  for i = 1, tonumber(buffer.length) do
    buf[i] = string.upper(bit.tohex(buffer[i], 2))
  end

  if buf[1] == 'FF' and buf[2] == 'D8' and buf[3] == 'FF' then
    return {
      ext = 'jpg',
      mime = 'image/jpeg'
    }
  end

  if buf[1] == '89' and buf[2] == '50' and buf[3] == '4E' and buf[4] == '47' then
    return {
      ext = 'png',
      mime = 'image/png'
    }
  end

  if buf[1] == '47' and buf[2] == '49' and buf[3] == '46' then
    return {
      ext = 'gif',
      mime = 'image/gif'
    }
  end

  if buf[1] == '46' and buf[2] == '4C' and buf[3] == '49' and buf[4] == '46' then
    return {
      ext = 'flif',
      mime = 'image/flif'
    }
  end

  -- needs to be before `tif` check
  if ((buf[1] == '49' and buf[2] == '49' and buf[3] == '2A' and buf[4] == '0') or (buf[1] == '4D' and buf[2] == '4D' and buf[3] == '0' and buf[4] == '2A')) and buf[7] == '43' and buf[8] == '52' then
    return {
      ext = 'cr2',
      mime = 'image/x-canon-cr2'
    }
  end

  if (buf[0] == 0x49 and buf[1] == 0x49 and buf[2] == 0x2A and buf[3] == 0x0) or (buf[0] == 0x4D and buf[1] == 0x4D and buf[2] == 0x0 and buf[3] == 0x2A)) {
    return {
      ext = 'tif',
      mime = 'image/tiff'
    }
  }

  if (buf[0] == 0x42 and buf[1] == 0x4D) {
    return {
      ext = 'bmp',
      mime = 'image/bmp'
    }
  }

  if (buf[0] == 0x49 and buf[1] == 0x49 and buf[2] == 0xBC) {
    return {
      ext = 'jxr',
      mime = 'image/vnd.ms-photo'
    }
  }

  if (buf[0] == 0x38 and buf[1] == 0x42 and buf[2] == 0x50 and buf[3] == 0x53) {
    return {
      ext = 'psd',
      mime = 'image/vnd.adobe.photoshop'
    }
  }

  -- needs to be before `zip` check
  if (buf[0] == 0x50 and buf[1] == 0x4B and buf[2] == 0x3 and buf[3] == 0x4 and buf[30] == 0x6D and buf[31] == 0x69 and buf[32] == 0x6D and buf[33] == 0x65 and buf[34] == 0x74 and buf[35] == 0x79 and buf[36] == 0x70 and buf[37] == 0x65 and buf[38] == 0x61 and buf[39] == 0x70 and buf[40] == 0x70 and buf[41] == 0x6C and buf[42] == 0x69 and buf[43] == 0x63 and buf[44] == 0x61 and buf[45] == 0x74 and buf[46] == 0x69 and buf[47] == 0x6F and buf[48] == 0x6E and buf[49] == 0x2F and buf[50] == 0x65 and buf[51] == 0x70 and buf[52] == 0x75 and buf[53] == 0x62 and buf[54] == 0x2B and buf[55] == 0x7A and buf[56] == 0x69 and buf[57] == 0x70) {
    return {
      ext = 'epub',
      mime = 'application/epub+zip'
    }
  }

  -- needs to be before `zip` check
  -- assumes signed .xpi from addons.mozilla.org
  if (buf[0] == 0x50 and buf[1] == 0x4B and buf[2] == 0x3 and buf[3] == 0x4 and buf[30] == 0x4D and buf[31] == 0x45 and buf[32] == 0x54 and buf[33] == 0x41 and buf[34] == 0x2D and buf[35] == 0x49 and buf[36] == 0x4E and buf[37] == 0x46 and buf[38] == 0x2F and buf[39] == 0x6D and buf[40] == 0x6F and buf[41] == 0x7A and buf[42] == 0x69 and buf[43] == 0x6C and buf[44] == 0x6C and buf[45] == 0x61 and buf[46] == 0x2E and buf[47] == 0x72 and buf[48] == 0x73 and buf[49] == 0x61) {
    return {
      ext = 'xpi',
      mime = 'application/x-xpinstall'
    }
  }

  if (buf[0] == 0x50 and buf[1] == 0x4B and (buf[2] == 0x3 or buf[2] == 0x5 or buf[2] == 0x7) and (buf[3] == 0x4 or buf[3] == 0x6 or buf[3] == 0x8)) {
    return {
      ext = 'zip',
      mime = 'application/zip'
    }
  }

  if (buf[257] == 0x75 and buf[258] == 0x73 and buf[259] == 0x74 and buf[260] == 0x61 and buf[261] == 0x72) {
    return {
      ext = 'tar',
      mime = 'application/x-tar'
    }
  }

  if (buf[0] == 0x52 and buf[1] == 0x61 and buf[2] == 0x72 and buf[3] == 0x21 and buf[4] == 0x1A and buf[5] == 0x7 and (buf[6] == 0x0 or buf[6] == 0x1)) {
    return {
      ext = 'rar',
      mime = 'application/x-rar-compressed'
    }
  }

  if (buf[0] == 0x1F and buf[1] == 0x8B and buf[2] == 0x8) {
    return {
      ext = 'gz',
      mime = 'application/gzip'
    }
  }

  if (buf[0] == 0x42 and buf[1] == 0x5A and buf[2] == 0x68) {
    return {
      ext = 'bz2',
      mime = 'application/x-bzip2'
    }
  }

  if (buf[0] == 0x37 and buf[1] == 0x7A and buf[2] == 0xBC and buf[3] == 0xAF and buf[4] == 0x27 and buf[5] == 0x1C) {
    return {
      ext = '7z',
      mime = 'application/x-7z-compressed'
    }
  }

  if (buf[0] == 0x78 and buf[1] == 0x01) {
    return {
      ext = 'dmg',
      mime = 'application/x-apple-diskimage'
    }
  }

  if (
    (buf[0] == 0x0 and buf[1] == 0x0 and buf[2] == 0x0 and (buf[3] == 0x18 or buf[3] == 0x20) and buf[4] == 0x66 and buf[5] == 0x74 and buf[6] == 0x79 and buf[7] == 0x70) or
    (buf[0] == 0x33 and buf[1] == 0x67 and buf[2] == 0x70 and buf[3] == 0x35) or
    (buf[0] == 0x0 and buf[1] == 0x0 and buf[2] == 0x0 and buf[3] == 0x1C and buf[4] == 0x66 and buf[5] == 0x74 and buf[6] == 0x79 and buf[7] == 0x70 and buf[8] == 0x6D and buf[9] == 0x70 and buf[10] == 0x34 and buf[11] == 0x32 and buf[16] == 0x6D and buf[17] == 0x70 and buf[18] == 0x34 and buf[19] == 0x31 and buf[20] == 0x6D and buf[21] == 0x70 and buf[22] == 0x34 and buf[23] == 0x32 and buf[24] == 0x69 and buf[25] == 0x73 and buf[26] == 0x6F and buf[27] == 0x6D) or
    (buf[0] == 0x0 and buf[1] == 0x0 and buf[2] == 0x0 and buf[3] == 0x1C and buf[4] == 0x66 and buf[5] == 0x74 and buf[6] == 0x79 and buf[7] == 0x70 and buf[8] == 0x69 and buf[9] == 0x73 and buf[10] == 0x6F and buf[11] == 0x6D) or
    (buf[0] == 0x0 and buf[1] == 0x0 and buf[2] == 0x0 and buf[3] == 0x1c and buf[4] == 0x66 and buf[5] == 0x74 and buf[6] == 0x79 and buf[7] == 0x70 and buf[8] == 0x6D and buf[9] == 0x70 and buf[10] == 0x34 and buf[11] == 0x32 and buf[12] == 0x0 and buf[13] == 0x0 and buf[14] == 0x0 and buf[15] == 0x0)
  ) {
    return {
      ext = 'mp4',
      mime = 'video/mp4'
    }
  }

  if ((buf[0] == 0x0 and buf[1] == 0x0 and buf[2] == 0x0 and buf[3] == 0x1C and buf[4] == 0x66 and buf[5] == 0x74 and buf[6] == 0x79 and buf[7] == 0x70 and buf[8] == 0x4D and buf[9] == 0x34 and buf[10] == 0x56)) {
    return {
      ext = 'm4v',
      mime = 'video/x-m4v'
    }
  }

  if (buf[0] == 0x4D and buf[1] == 0x54 and buf[2] == 0x68 and buf[3] == 0x64) {
    return {
      ext = 'mid',
      mime = 'audio/midi'
    }
  }

  -- needs to be before the `webm` check
  if (buf[31] == 0x6D and buf[32] == 0x61 and buf[33] == 0x74 and buf[34] == 0x72 and buf[35] == 0x6f and buf[36] == 0x73 and buf[37] == 0x6B and buf[38] == 0x61) {
    return {
      ext = 'mkv',
      mime = 'video/x-matroska'
    }
  }

  if (buf[0] == 0x1A and buf[1] == 0x45 and buf[2] == 0xDF and buf[3] == 0xA3) {
    return {
      ext = 'webm',
      mime = 'video/webm'
    }
  }

  if (buf[0] == 0x0 and buf[1] == 0x0 and buf[2] == 0x0 and buf[3] == 0x14 and buf[4] == 0x66 and buf[5] == 0x74 and buf[6] == 0x79 and buf[7] == 0x70) {
    return {
      ext = 'mov',
      mime = 'video/quicktime'
    }
  }

  if (buf[0] == 0x52 and buf[1] == 0x49 and buf[2] == 0x46 and buf[3] == 0x46 and buf[8] == 0x41 and buf[9] == 0x56 and buf[10] == 0x49) {
    return {
      ext = 'avi',
      mime = 'video/x-msvideo'
    }
  }

  if (buf[0] == 0x30 and buf[1] == 0x26 and buf[2] == 0xB2 and buf[3] == 0x75 and buf[4] == 0x8E and buf[5] == 0x66 and buf[6] == 0xCF and buf[7] == 0x11 and buf[8] == 0xA6 and buf[9] == 0xD9) {
    return {
      ext = 'wmv',
      mime = 'video/x-ms-wmv'
    }
  }

  if (buf[0] == 0x0 and buf[1] == 0x0 and buf[2] == 0x1 and buf[3].toString(16)[0] == 'b') {
    return {
      ext = 'mpg',
      mime = 'video/mpeg'
    }
  }

  if ((buf[0] == 0x49 and buf[1] == 0x44 and buf[2] == 0x33) or (buf[0] == 0xFF and buf[1] == 0xfb)) {
    return {
      ext = 'mp3',
      mime = 'audio/mpeg'
    }
  }

  if ((buf[4] == 0x66 and buf[5] == 0x74 and buf[6] == 0x79 and buf[7] == 0x70 and buf[8] == 0x4D and buf[9] == 0x34 and buf[10] == 0x41) or (buf[0] == 0x4D and buf[1] == 0x34 and buf[2] == 0x41 and buf[3] == 0x20)) {
    return {
      ext = 'm4a',
      mime = 'audio/m4a'
    }
  }

  -- needs to be before `ogg` check
  if (buf[28] == 0x4F and buf[29] == 0x70 and buf[30] == 0x75 and buf[31] == 0x73 and buf[32] == 0x48 and buf[33] == 0x65 and buf[34] == 0x61 and buf[35] == 0x64) {
    return {
      ext = 'opus',
      mime = 'audio/opus'
    }
  }

  if (buf[0] == 0x4F and buf[1] == 0x67 and buf[2] == 0x67 and buf[3] == 0x53) {
    return {
      ext = 'ogg',
      mime = 'audio/ogg'
    }
  }

  if (buf[0] == 0x66 and buf[1] == 0x4C and buf[2] == 0x61 and buf[3] == 0x43) {
    return {
      ext = 'flac',
      mime = 'audio/x-flac'
    }
  }

  if (buf[0] == 0x52 and buf[1] == 0x49 and buf[2] == 0x46 and buf[3] == 0x46 and buf[8] == 0x57 and buf[9] == 0x41 and buf[10] == 0x56 and buf[11] == 0x45) {
    return {
      ext = 'wav',
      mime = 'audio/x-wav'
    }
  }

  if (buf[0] == 0x23 and buf[1] == 0x21 and buf[2] == 0x41 and buf[3] == 0x4D and buf[4] == 0x52 and buf[5] == 0x0A) {
    return {
      ext = 'amr',
      mime = 'audio/amr'
    }
  }

  if (buf[0] == 0x25 and buf[1] == 0x50 and buf[2] == 0x44 and buf[3] == 0x46) {
    return {
      ext = 'pdf',
      mime = 'application/pdf'
    }
  }

  if (buf[0] == 0x4D and buf[1] == 0x5A) {
    return {
      ext = 'exe',
      mime = 'application/x-msdownload'
    }
  }

  if ((buf[0] == 0x43 or buf[0] == 0x46) and buf[1] == 0x57 and buf[2] == 0x53) {
    return {
      ext = 'swf',
      mime = 'application/x-shockwave-flash'
    }
  }

  if (buf[0] == 0x7B and buf[1] == 0x5C and buf[2] == 0x72 and buf[3] == 0x74 and buf[4] == 0x66) {
    return {
      ext = 'rtf',
      mime = 'application/rtf'
    }
  }

  if (
    (buf[0] == 0x77 and buf[1] == 0x4F and buf[2] == 0x46 and buf[3] == 0x46) &&
    (
      (buf[4] == 0x00 and buf[5] == 0x01 and buf[6] == 0x00 and buf[7] == 0x00) or
      (buf[4] == 0x4F and buf[5] == 0x54 and buf[6] == 0x54 and buf[7] == 0x4F)
    )
  ) {
    return {
      ext = 'woff',
      mime = 'application/font-woff'
    }
  }

  if (
    (buf[0] == 0x77 and buf[1] == 0x4F and buf[2] == 0x46 and buf[3] == 0x32) &&
    (
      (buf[4] == 0x00 and buf[5] == 0x01 and buf[6] == 0x00 and buf[7] == 0x00) or
      (buf[4] == 0x4F and buf[5] == 0x54 and buf[6] == 0x54 and buf[7] == 0x4F)
    )
  ) {
    return {
      ext = 'woff2',
      mime = 'application/font-woff'
    }
  }

  if (buf[34] == 0x4C and buf[35] == 0x50) and ((buf[8] == 0x00 and buf[9] == 0x00 and buf[10] == 0x01) or (buf[8] == 0x01 and buf[9] == 0x00 and buf[10] == 0x02) or (buf[8] == 0x02 and buf[9] == 0x00 and buf[10] == 0x02)) {
    return {
      ext = 'eot',
      mime = 'application/octet-stream'
    }
  }

  if (buf[0] == 0x00 and buf[1] == 0x01 and buf[2] == 0x00 and buf[3] == 0x00 and buf[4] == 0x00) {
    return {
      ext = 'ttf',
      mime = 'application/font-sfnt'
    }
  }

  if (buf[0] == 0x4F and buf[1] == 0x54 and buf[2] == 0x54 and buf[3] == 0x4F and buf[4] == 0x00) {
    return {
      ext = 'otf',
      mime = 'application/font-sfnt'
    }
  }

  if (buf[0] == 0x00 and buf[1] == 0x00 and buf[2] == 0x01 and buf[3] == 0x00) {
    return {
      ext = 'ico',
      mime = 'image/x-icon'
    }
  }

  if (buf[0] == 0x46 and buf[1] == 0x4C and buf[2] == 0x56 and buf[3] == 0x01) {
    return {
      ext = 'flv',
      mime = 'video/x-flv'
    }
  }

  if (buf[0] == 0x25 and buf[1] == 0x21) {
    return {
      ext = 'ps',
      mime = 'application/postscript'
    }
  }

  if (buf[0] == 0xFD and buf[1] == 0x37 and buf[2] == 0x7A and buf[3] == 0x58 and buf[4] == 0x5A and buf[5] == 0x00) {
    return {
      ext = 'xz',
      mime = 'application/x-xz'
    }
  }

  if (buf[0] == 0x53 and buf[1] == 0x51 and buf[2] == 0x4C and buf[3] == 0x69) {
    return {
      ext = 'sqlite',
      mime = 'application/x-sqlite3'
    }
  }

  if (buf[0] == 0x4E and buf[1] == 0x45 and buf[2] == 0x53 and buf[3] == 0x1A) {
    return {
      ext = 'nes',
      mime = 'application/x-nintendo-nes-rom'
    }
  }

  if (buf[0] == 0x43 and buf[1] == 0x72 and buf[2] == 0x32 and buf[3] == 0x34) {
    return {
      ext = 'crx',
      mime = 'application/x-google-chrome-extension'
    }
  }

  if (buf[0] == 0x4D and buf[1] == 0x53 and buf[2] == 0x43 and buf[3] == 0x46) or (buf[0] == 0x49 and buf[1] == 0x53 and buf[2] == 0x63 and buf[3] == 0x28) {
    return {
      ext = 'cab',
      mime = 'application/vnd.ms-cab-compressed'
    }
  }

  -- needs to be before `ar` check
  if (buf[0] == 0x21 and buf[1] == 0x3C and buf[2] == 0x61 and buf[3] == 0x72 and buf[4] == 0x63 and buf[5] == 0x68 and buf[6] == 0x3E and buf[7] == 0x0A and buf[8] == 0x64 and buf[9] == 0x65 and buf[10] == 0x62 and buf[11] == 0x69 and buf[12] == 0x61 and buf[13] == 0x6E and buf[14] == 0x2D and buf[15] == 0x62 and buf[16] == 0x69 and buf[17] == 0x6E and buf[18] == 0x61 and buf[19] == 0x72 and buf[20] == 0x79) {
    return {
      ext = 'deb',
      mime = 'application/x-deb'
    }
  }

  if (buf[0] == 0x21 and buf[1] == 0x3C and buf[2] == 0x61 and buf[3] == 0x72 and buf[4] == 0x63 and buf[5] == 0x68 and buf[6] == 0x3E) {
    return {
      ext = 'ar',
      mime = 'application/x-unix-archive'
    }
  }

  if (buf[0] == 0xED and buf[1] == 0xAB and buf[2] == 0xEE and buf[3] == 0xDB) {
    return {
      ext = 'rpm',
      mime = 'application/x-rpm'
    }
  }

  if (buf[0] == 0x1F and buf[1] == 0xA0) or (buf[0] == 0x1F and buf[1] == 0x9D) {
    return {
      ext = 'Z',
      mime = 'application/x-compress'
    }
  }

  if (buf[0] == 0x4C and buf[1] == 0x5A and buf[2] == 0x49 and buf[3] == 0x50) {
    return {
      ext = 'lz',
      mime = 'application/x-lzip'
    }
  }

  if (buf[0] == 0xD0 and buf[1] == 0xCF and buf[2] == 0x11 and buf[3] == 0xE0 and buf[4] == 0xA1 and buf[5] == 0xB1 and buf[6] == 0x1A and buf[7] == 0xE1) {
    return {
      ext = 'msi',
      mime = 'application/x-msi'
    }
  }


  return nil
end

return fileType
