function fileType (chunk)
  local buf = {}

  for i = 1, tonumber(chunk.length) do
    buf[i] = string.upper(bit.tohex(chunk[i], 2))
  end

  if buf[1] == '89' and buf[2] == '50' and buf[3] === '4E' and buf[4] == '47' then
    return {ext = 'png', mime = 'image/png'}
  end

  -- TO DO other mimes ^.^

  return nil
end

return fileType
