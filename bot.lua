local discordia = require("discordia")
local client = discordia.Client {
    logFile = 'bot.log',
	cacheAllMembers = true,
}
discordia.extensions() -- Load useful extensions

local dotenv = {} -- Create empty table for dotenv variables
local fd = io.open('.env', 'r')
while true do
	local line = fd:read('*l') -- read all lines
	if not line then break end
	local var, data = line:match('^([^=]+)=(.*)$')
	if var then dotenv[var] = data end -- add all variables to the dotenv table
end
fd:close()

local prefix = 'l!'
local commands = {
	[prefix .. 'ping'] = {
		description = 'Answers with pong.',
		exec = function(message)
			message.channel:send('Pong!')
		end
	},
	[prefix .. 'owner'] = {
		description = 'Checks if you are the bot owner.',
		exec = function(message)
			if message.author == client.owner then
				message:reply('You are the bot owner.')
			else
				message:reply('You are not the bot owner.')
			end
		end
	},
	[prefix .. 'say'] = {
		description = 'Repeats your message.',
		exec = function(message)
			local args = message.content:split(' ')
			table.remove(args, 1)
			message:reply(table.concat(args, ' '))
		end
	}
}

client:on("ready", function() -- when bot sends ready event
	p(string.format('Logged in as %s', client.user.username))
end)

client:on("messageCreate", function(message)

	local args = message.content:split(' ')

	local command = commands[args[1]]
	if command then -- If the command exists within the table...
		command.exec(message) -- ...run the exec function in the command.
	end

end)

client:run('Bot '.. dotenv.TOKEN) -- login
