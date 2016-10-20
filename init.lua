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

  if (buf[1] == '49' and buf[2] == '49' and buf[3] == '2A' and buf[4] == '0') or (buf[1] == '4D' and buf[2] == '4D' and buf[3] == '0' and buf[4] == '2A') then
    return {
      ext = 'tif',
      mime = 'image/tiff'
    }
  end

  if buf[1] == '42' and buf[2] == '4D' then
    return {
      ext = 'bmp',
      mime = 'image/bmp'
    }
  end

  if (buf[0] == '49' and buf[1] == '49' and buf[2] == 'BC') {
    return {
      ext = 'jxr',
      mime = 'image/vnd.ms-photo'
    }
  }

  if (buf[0] == '38' and buf[1] == '42' and buf[2] == '50' and buf[3] == '53') {
    return {
      ext = 'psd',
      mime = 'image/vnd.adobe.photoshop'
    }
  }

  -- needs to be before `zip` check
  if (buf[0] == '50' and buf[1] == '4B' and buf[2] == '3' and buf[3] == '4' and buf[30] == '6D' and buf[31] == '69' and buf[32] == '6D' and buf[33] == '65' and buf[34] == '74' and buf[35] == '79' and buf[36] == '70' and buf[37] == '65' and buf[38] == '61' and buf[39] == '70' and buf[40] == '70' and buf[41] == '6C' and buf[42] == '69' and buf[43] == '63' and buf[44] == '61' and buf[45] == '74' and buf[46] == '69' and buf[47] == '6F' and buf[48] == '6E' and buf[49] == '2F' and buf[50] == '65' and buf[51] == '70' and buf[52] == '75' and buf[53] == '62' and buf[54] == '2B' and buf[55] == '7A' and buf[56] == '69' and buf[57] == '70') {
    return {
      ext = 'epub',
      mime = 'application/epub+zip'
    }
  }

  -- needs to be before `zip` check
  -- assumes signed .xpi from addons.mozilla.org
  if (buf[0] == '50' and buf[1] == '4B' and buf[2] == '3' and buf[3] == '4' and buf[30] == '4D' and buf[31] == '45' and buf[32] == '54' and buf[33] == '41' and buf[34] == '2D' and buf[35] == '49' and buf[36] == '4E' and buf[37] == '46' and buf[38] == '2F' and buf[39] == '6D' and buf[40] == '6F' and buf[41] == '7A' and buf[42] == '69' and buf[43] == '6C' and buf[44] == '6C' and buf[45] == '61' and buf[46] == '2E' and buf[47] == '72' and buf[48] == '73' and buf[49] == '61') {
    return {
      ext = 'xpi',
      mime = 'application/x-xpinstall'
    }
  }

  if (buf[0] == '50' and buf[1] == '4B' and (buf[2] == '3' or buf[2] == '5' or buf[2] == '7') and (buf[3] == '4' or buf[3] == '6' or buf[3] == '8')) {
    return {
      ext = 'zip',
      mime = 'application/zip'
    }
  }

  if (buf[257] == '75' and buf[258] == '73' and buf[259] == '74' and buf[260] == '61' and buf[261] == '72') {
    return {
      ext = 'tar',
      mime = 'application/x-tar'
    }
  }

  if (buf[0] == '52' and buf[1] == '61' and buf[2] == '72' and buf[3] == '21' and buf[4] == '1A' and buf[5] == '7' and (buf[6] == '0' or buf[6] == '1')) {
    return {
      ext = 'rar',
      mime = 'application/x-rar-compressed'
    }
  }

  if (buf[0] == '1F' and buf[1] == '8B' and buf[2] == '8') {
    return {
      ext = 'gz',
      mime = 'application/gzip'
    }
  }

  if (buf[0] == '42' and buf[1] == '5A' and buf[2] == '68') {
    return {
      ext = 'bz2',
      mime = 'application/x-bzip2'
    }
  }

  if (buf[0] == '37' and buf[1] == '7A' and buf[2] == 'BC' and buf[3] == 'AF' and buf[4] == '27' and buf[5] == '1C') {
    return {
      ext = '7z',
      mime = 'application/x-7z-compressed'
    }
  }

  if (buf[0] == '78' and buf[1] == '01') {
    return {
      ext = 'dmg',
      mime = 'application/x-apple-diskimage'
    }
  }

  if (
    (buf[0] == '0' and buf[1] == '0' and buf[2] == '0' and (buf[3] == '18' or buf[3] == '20') and buf[4] == '66' and buf[5] == '74' and buf[6] == '79' and buf[7] == '70') or
    (buf[0] == '33' and buf[1] == '67' and buf[2] == '70' and buf[3] == '35') or
    (buf[0] == '0' and buf[1] == '0' and buf[2] == '0' and buf[3] == '1C' and buf[4] == '66' and buf[5] == '74' and buf[6] == '79' and buf[7] == '70' and buf[8] == '6D' and buf[9] == '70' and buf[10] == '34' and buf[11] == '32' and buf[16] == '6D' and buf[17] == '70' and buf[18] == '34' and buf[19] == '31' and buf[20] == '6D' and buf[21] == '70' and buf[22] == '34' and buf[23] == '32' and buf[24] == '69' and buf[25] == '73' and buf[26] == '6F' and buf[27] == '6D') or
    (buf[0] == '0' and buf[1] == '0' and buf[2] == '0' and buf[3] == '1C' and buf[4] == '66' and buf[5] == '74' and buf[6] == '79' and buf[7] == '70' and buf[8] == '69' and buf[9] == '73' and buf[10] == '6F' and buf[11] == '6D') or
    (buf[0] == '0' and buf[1] == '0' and buf[2] == '0' and buf[3] == '1c' and buf[4] == '66' and buf[5] == '74' and buf[6] == '79' and buf[7] == '70' and buf[8] == '6D' and buf[9] == '70' and buf[10] == '34' and buf[11] == '32' and buf[12] == '0' and buf[13] == '0' and buf[14] == '0' and buf[15] == '0')
  ) {
    return {
      ext = 'mp4',
      mime = 'video/mp4'
    }
  }

  if ((buf[0] == '0' and buf[1] == '0' and buf[2] == '0' and buf[3] == '1C' and buf[4] == '66' and buf[5] == '74' and buf[6] == '79' and buf[7] == '70' and buf[8] == '4D' and buf[9] == '34' and buf[10] == '56')) {
    return {
      ext = 'm4v',
      mime = 'video/x-m4v'
    }
  }

  if (buf[0] == '4D' and buf[1] == '54' and buf[2] == '68' and buf[3] == '64') {
    return {
      ext = 'mid',
      mime = 'audio/midi'
    }
  }

  -- needs to be before the `webm` check
  if (buf[31] == '6D' and buf[32] == '61' and buf[33] == '74' and buf[34] == '72' and buf[35] == '6f' and buf[36] == '73' and buf[37] == '6B' and buf[38] == '61') {
    return {
      ext = 'mkv',
      mime = 'video/x-matroska'
    }
  }

  if (buf[0] == '1A' and buf[1] == '45' and buf[2] == 'DF' and buf[3] == 'A3') {
    return {
      ext = 'webm',
      mime = 'video/webm'
    }
  }

  if (buf[0] == '0' and buf[1] == '0' and buf[2] == '0' and buf[3] == '14' and buf[4] == '66' and buf[5] == '74' and buf[6] == '79' and buf[7] == '70') {
    return {
      ext = 'mov',
      mime = 'video/quicktime'
    }
  }

  if (buf[0] == '52' and buf[1] == '49' and buf[2] == '46' and buf[3] == '46' and buf[8] == '41' and buf[9] == '56' and buf[10] == '49') {
    return {
      ext = 'avi',
      mime = 'video/x-msvideo'
    }
  }

  if (buf[0] == '30' and buf[1] == '26' and buf[2] == 'B2' and buf[3] == '75' and buf[4] == '8E' and buf[5] == '66' and buf[6] == 'CF' and buf[7] == '11' and buf[8] == 'A6' and buf[9] == 'D9') {
    return {
      ext = 'wmv',
      mime = 'video/x-ms-wmv'
    }
  }

  if (buf[0] == '0' and buf[1] == '0' and buf[2] == '1' and buf[3].toString(16)[0] == 'b') {
    return {
      ext = 'mpg',
      mime = 'video/mpeg'
    }
  }

  if ((buf[0] == '49' and buf[1] == '44' and buf[2] == '33') or (buf[0] == 'FF' and buf[1] == 'fb')) {
    return {
      ext = 'mp3',
      mime = 'audio/mpeg'
    }
  }

  if ((buf[4] == '66' and buf[5] == '74' and buf[6] == '79' and buf[7] == '70' and buf[8] == '4D' and buf[9] == '34' and buf[10] == '41') or (buf[0] == '4D' and buf[1] == '34' and buf[2] == '41' and buf[3] == '20')) {
    return {
      ext = 'm4a',
      mime = 'audio/m4a'
    }
  }

  -- needs to be before `ogg` check
  if (buf[28] == '4F' and buf[29] == '70' and buf[30] == '75' and buf[31] == '73' and buf[32] == '48' and buf[33] == '65' and buf[34] == '61' and buf[35] == '64') {
    return {
      ext = 'opus',
      mime = 'audio/opus'
    }
  }

  if (buf[0] == '4F' and buf[1] == '67' and buf[2] == '67' and buf[3] == '53') {
    return {
      ext = 'ogg',
      mime = 'audio/ogg'
    }
  }

  if (buf[0] == '66' and buf[1] == '4C' and buf[2] == '61' and buf[3] == '43') {
    return {
      ext = 'flac',
      mime = 'audio/x-flac'
    }
  }

  if (buf[0] == '52' and buf[1] == '49' and buf[2] == '46' and buf[3] == '46' and buf[8] == '57' and buf[9] == '41' and buf[10] == '56' and buf[11] == '45') {
    return {
      ext = 'wav',
      mime = 'audio/x-wav'
    }
  }

  if (buf[0] == '23' and buf[1] == '21' and buf[2] == '41' and buf[3] == '4D' and buf[4] == '52' and buf[5] == '0A') {
    return {
      ext = 'amr',
      mime = 'audio/amr'
    }
  }

  if (buf[0] == '25' and buf[1] == '50' and buf[2] == '44' and buf[3] == '46') {
    return {
      ext = 'pdf',
      mime = 'application/pdf'
    }
  }

  if (buf[0] == '4D' and buf[1] == '5A') {
    return {
      ext = 'exe',
      mime = 'application/x-msdownload'
    }
  }

  if ((buf[0] == '43' or buf[0] == '46') and buf[1] == '57' and buf[2] == '53') {
    return {
      ext = 'swf',
      mime = 'application/x-shockwave-flash'
    }
  }

  if (buf[0] == '7B' and buf[1] == '5C' and buf[2] == '72' and buf[3] == '74' and buf[4] == '66') {
    return {
      ext = 'rtf',
      mime = 'application/rtf'
    }
  }

  if (
    (buf[0] == '77' and buf[1] == '4F' and buf[2] == '46' and buf[3] == '46') &&
    (
      (buf[4] == '00' and buf[5] == '01' and buf[6] == '00' and buf[7] == '00') or
      (buf[4] == '4F' and buf[5] == '54' and buf[6] == '54' and buf[7] == '4F')
    )
  ) {
    return {
      ext = 'woff',
      mime = 'application/font-woff'
    }
  }

  if (
    (buf[0] == '77' and buf[1] == '4F' and buf[2] == '46' and buf[3] == '32') &&
    (
      (buf[4] == '00' and buf[5] == '01' and buf[6] == '00' and buf[7] == '00') or
      (buf[4] == '4F' and buf[5] == '54' and buf[6] == '54' and buf[7] == '4F')
    )
  ) {
    return {
      ext = 'woff2',
      mime = 'application/font-woff'
    }
  }

  if (buf[34] == '4C' and buf[35] == '50') and ((buf[8] == '00' and buf[9] == '00' and buf[10] == '01') or (buf[8] == '01' and buf[9] == '00' and buf[10] == '02') or (buf[8] == '02' and buf[9] == '00' and buf[10] == '02')) {
    return {
      ext = 'eot',
      mime = 'application/octet-stream'
    }
  }

  if (buf[0] == '00' and buf[1] == '01' and buf[2] == '00' and buf[3] == '00' and buf[4] == '00') {
    return {
      ext = 'ttf',
      mime = 'application/font-sfnt'
    }
  }

  if (buf[0] == '4F' and buf[1] == '54' and buf[2] == '54' and buf[3] == '4F' and buf[4] == '00') {
    return {
      ext = 'otf',
      mime = 'application/font-sfnt'
    }
  }

  if (buf[0] == '00' and buf[1] == '00' and buf[2] == '01' and buf[3] == '00') {
    return {
      ext = 'ico',
      mime = 'image/x-icon'
    }
  }

  if (buf[0] == '46' and buf[1] == '4C' and buf[2] == '56' and buf[3] == '01') {
    return {
      ext = 'flv',
      mime = 'video/x-flv'
    }
  }

  if (buf[0] == '25' and buf[1] == '21') {
    return {
      ext = 'ps',
      mime = 'application/postscript'
    }
  }

  if (buf[0] == 'FD' and buf[1] == '37' and buf[2] == '7A' and buf[3] == '58' and buf[4] == '5A' and buf[5] == '00') {
    return {
      ext = 'xz',
      mime = 'application/x-xz'
    }
  }

  if (buf[0] == '53' and buf[1] == '51' and buf[2] == '4C' and buf[3] == '69') {
    return {
      ext = 'sqlite',
      mime = 'application/x-sqlite3'
    }
  }

  if (buf[0] == '4E' and buf[1] == '45' and buf[2] == '53' and buf[3] == '1A') {
    return {
      ext = 'nes',
      mime = 'application/x-nintendo-nes-rom'
    }
  }

  if (buf[0] == '43' and buf[1] == '72' and buf[2] == '32' and buf[3] == '34') {
    return {
      ext = 'crx',
      mime = 'application/x-google-chrome-extension'
    }
  }

  if (buf[0] == '4D' and buf[1] == '53' and buf[2] == '43' and buf[3] == '46') or (buf[0] == '49' and buf[1] == '53' and buf[2] == '63' and buf[3] == '28') {
    return {
      ext = 'cab',
      mime = 'application/vnd.ms-cab-compressed'
    }
  }

  -- needs to be before `ar` check
  if (buf[0] == '21' and buf[1] == '3C' and buf[2] == '61' and buf[3] == '72' and buf[4] == '63' and buf[5] == '68' and buf[6] == '3E' and buf[7] == '0A' and buf[8] == '64' and buf[9] == '65' and buf[10] == '62' and buf[11] == '69' and buf[12] == '61' and buf[13] == '6E' and buf[14] == '2D' and buf[15] == '62' and buf[16] == '69' and buf[17] == '6E' and buf[18] == '61' and buf[19] == '72' and buf[20] == '79') {
    return {
      ext = 'deb',
      mime = 'application/x-deb'
    }
  }

  if (buf[0] == '21' and buf[1] == '3C' and buf[2] == '61' and buf[3] == '72' and buf[4] == '63' and buf[5] == '68' and buf[6] == '3E') {
    return {
      ext = 'ar',
      mime = 'application/x-unix-archive'
    }
  }

  if (buf[0] == 'ED' and buf[1] == 'AB' and buf[2] == 'EE' and buf[3] == 'DB') {
    return {
      ext = 'rpm',
      mime = 'application/x-rpm'
    }
  }

  if (buf[0] == '1F' and buf[1] == 'A0') or (buf[0] == '1F' and buf[1] == '9D') {
    return {
      ext = 'Z',
      mime = 'application/x-compress'
    }
  }

  if (buf[0] == '4C' and buf[1] == '5A' and buf[2] == '49' and buf[3] == '50') {
    return {
      ext = 'lz',
      mime = 'application/x-lzip'
    }
  }

  if (buf[0] == 'D0' and buf[1] == 'CF' and buf[2] == '11' and buf[3] == 'E0' and buf[4] == 'A1' and buf[5] == 'B1' and buf[6] == '1A' and buf[7] == 'E1') {
    return {
      ext = 'msi',
      mime = 'application/x-msi'
    }
  }


  return nil
end

return fileType
