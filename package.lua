  return {
    name = "luabot",
    version = "0.0.1",
    description = "A Discord bot built on Lua with Discordia.",
    tags = { "lua", "lit", "luvit", "discord", "discordia" },
    license = "Apache-2.0",
    author = { name = "Keanu Timmermans", email = "keanutimmermans8@gmail.com" },
    homepage = "https://github.com/keanuplayz/luabot",
    dependencies = {
      "SinisterRectus/discordia@2.8.4"
    },
    files = {
      "**.lua",
      "!test*"
    }
  }
  