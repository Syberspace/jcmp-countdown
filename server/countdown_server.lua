class("Countdown")

function Countdown:__init()
	print('init')
	
	self.DefaultDuration = 10
	
	self.CdString = 0
	self.CdStartTime = 0
	self.CdLastTick = 0
	
	Events:Subscribe('AuthedCommand', self, self.Command)
	Events:Subscribe('PreTick', self, self.CountdownRender)
end

function Countdown:Command(cmd)
	if cmd.name == 'countdown' or cmd.name == 'cd' then
		if cmd.args[1] == 'help' then
			cmd.player:SendChatMessage('Countdown-Help', Color(255,100,255))
			cmd.player:SendChatMessage('Usage: /countdown <duration_in_seconds>', Color(255,100,255))
			cmd.player:SendChatMessage('Usage: /cd <duration_in_seconds>', Color(255,100,255))
			return
		end
		duration = tonumber(cmd.args[1]) or self.DefaultDuration
		print('duration '..duration)
		Network:Broadcast('CountdownStart', duration)
		self.CdString = duration
		self.CdStartTime = os.clock()
		self.CdLastTick = self.CdStartTime
	end
end

function Countdown:CountdownRender()
	if self.CdString >= 0 then
		if(os.clock() >= self.CdLastTick + 1) then
			self.CdString = self.CdString - 1
			self.CdLastTick = os.clock()
			Network:Broadcast('CountdownDecrement', self.CdString)
		end
	end
end

countdown = Countdown()