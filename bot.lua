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

client:on("ready", function() -- when bot sends ready event
	p(string.format('Logged in as %s', client.user.username))
end)

client:on("messageCreate", function(message)

	local content = message.content
	local args = message.content:split(' ')

	if content == "l!ping" then
		message:reply("Pong!")
	elseif content == "l!pong" then
		message:reply("Ping!")
	end

	if content == 'l!say' then
		table.remove(args, 1) -- Remove l!say from args
		message:reply(table.concat(args, ' '))
	end

	if content == 'l!owner' then
		if message.author == client.owner then
			message.channel:send('You are the owner.')
		else
			message.channel:send('You are not the owner.')
		end
	end

end)

client:run('Bot '.. dotenv.TOKEN) -- login
