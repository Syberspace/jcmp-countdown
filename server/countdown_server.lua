class("Countdown")

function Countdown:__init()
	print('init')
	
	self.DefaultDuration = 10
	self.CountdownPlayer = nil
	
	Events:Subscribe('AuthedCommand', self, self.Command)
end

function Countdown:Command(cmd)
	if cmd.name == 'countdown' or cmd.name == 'cd' then
		if cmd.args[1] == 'help' then
			cmd.player:SendChatMessage('Countdown-Help', Color(255,100,255))
			cmd.player:SendChatMessage('Usage: /countdown - Starts the default countdown (10 seconds)', Color(255,100,255))
			cmd.player:SendChatMessage('Usage: /countdown <amount> - Starts a countdown for <amount> seconds', Color(255,100,255))
			cmd.player:SendChatMessage('Usage: /countdown help - Displays this message', Color(255,100,255))
			cmd.player:SendChatMessage('Usage: /cd  - Starts the default countdown (10 seconds)', Color(255,100,255))
			cmd.player:SendChatMessage('Usage: /cd <amount> - Starts a countdown for <amount> seconds', Color(255,100,255))
			cmd.player:SendChatMessage('Usage: /cd help - Displays this message', Color(255,100,255))
			return
		elseif cmd.args[1] == 'stop' then
			if cmd.player == self.CountdownPlayer then
				Network:Broadcast('CountdownStop')
				print(cmd.player,' stopped the cd')
			else
				cmd.player:SendChatMessage('Only '..self.CountdownPlayer..' can stop this countdown', Color(255,0,0))
			end
			return
		end
		
		self.CountdownPlayer = cmd.player
		duration = tonumber(cmd.args[1]) or self.DefaultDuration
		Network:Broadcast('CountdownStart', duration)
	end
end

countdown = Countdown()