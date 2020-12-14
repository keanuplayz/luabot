local discordia = require("discordia")
local client = discordia.Client {
    logFile = 'bot.log',
	cacheAllMembers = true,
}
discordia.extensions() -- Load useful extensions

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

end)

client:run("Bot BOT_TOKEN") -- login
