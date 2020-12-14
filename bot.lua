local discordia = require("discordia")
local client = discordia.Client {
    logFile = 'bot.log',
	cacheAllMembers = true,
}

client:on("ready", function() -- when bot sends ready event
	print("Logged in as " .. client.user.username)
end)

client:on("messageCreate", function(message)

	local content = message.content

	if content == "l!ping" then
		message:reply("Pong!")
	elseif content == "l!pong" then
		message:reply("Ping!")
	end

end)

client:run("Bot BOT_TOKEN") -- login
