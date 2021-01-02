local discordia = require("discordia")
local client =
    discordia.Client {
    logFile = "bot.log",
    cacheAllMembers = true
}
discordia.extensions() -- Load useful extensions

local util = require("lib.util")

local dotenv = {} -- Create empty table for dotenv variables
local fd = io.open(".env", "r") -- Open a read stream for the `.env` file
while true do
    local line = fd:read("*l") -- read all lines
    if not line then
        break
    end
    local var, data = line:match("^([^=]+)=(.*)$")
    if var then
        dotenv[var] = data
    end -- add all variables to the dotenv table
end
fd:close()

local prefix = "l!"
local commands = {
    -- table with all commands
    [prefix .. "ping"] = {
        description = "Answers with pong.",
        exec = function(message)
            message.channel:send("Pong!")
        end
    },
    [prefix .. "owner"] = {
        description = "Checks if you are the bot owner.",
        exec = function(message)
            if message.author == client.owner then
                message:reply("You are the bot owner.")
            else
                message:reply("You are not the bot owner.")
            end
        end
    },
    [prefix .. "say"] = {
        description = "Repeats your message.",
        exec = function(message)
            local args = message.content:split(" ")
            table.remove(args, 1)
            message:reply(table.concat(args, " "))
        end
    },
    [prefix .. "embed"] = {
        description = "Displays an embed.",
        exec = function(message)
            local args = message.content:split(" ")
            table.remove(args, 1)
            local embedStr = table.concat(args, " ")
            local defaults = {
                color = "ff4040"
            }

            local parsedembed = parse_embed_data(embedStr, defaults)

            print(parsedembed.title)

            for key, val in pairs(parsedembed) do
                print(key, "=", val)
            end

            message:reply {
                -- https://discord.com/developers/docs/resources/channel#embed-object-embed-image-structure
                embed = {
                    title = parsedembed.title,
                    description = parsedembed.description
                }
            }
        end
    }
}

client:on(
    "ready",
    function()
        -- when bot sends ready event
        p(string.format("Logged in as %s", client.user.username))
    end
)

client:on(
    "messageCreate",
    function(message)
        local args = message.content:split(" ")

        if message.author == client.user then
            return
        end
        if message.author.bot == true then
            return
        end

        local command = commands[args[1]]
        if command then -- If the command exists within the table...
            command.exec(message) -- ...run the exec function in the command definition.
        end

        if args[1] == prefix .. "help" then -- display all the commands within the table
            local output = {}
            for word, tbl in pairs(commands) do
                table.insert(output, "**Command:** " .. word .. "\n - **Description:** " .. tbl.description)
            end
            message:reply {
                embed = {
                    title = "**LuaBot Help**",
                    description = table.concat(output, "\n\n")
                }
            }
        end
    end
)

client:run("Bot " .. dotenv.TOKEN) -- login
