function string.starts(String, Start)
    return String.sub(String,1,string.len(Start))==Start
end

EMBED_FIELD_MAP = {
    ptext       = "ptext",
    title       = "title",
    description = "description",
    desc        = "description",
    image       = "image",
    thumbnail   = "thumbnail",
    color       = "color",
    colour      = "color",
}

function parse_embed_data(data, defaults)
  local embed = {}

  if defaults then
      for key, val in pairs(defaults) do
        embed[key] = val
      end
  end

  for kvp in string.gmatch(data, "[^|]+") do
      local key, value = string.match(kvp, "^%s*(%S+)%s*=%s*(.-)%s*$")
      if key and value then
        key = EMBED_FIELD_MAP[string.lower(key)]
        embed[key] = value
      end
  end
  return embed
end
