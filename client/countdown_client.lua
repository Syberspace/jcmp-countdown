class("CountdownClient")

function CountdownClient:__init()
	self.CdString = 0
	self.CdStartTime = 0
	self.CdLastTick = 0
	self.RenderEvent = nil

	self.NetworkEvent = Network:Subscribe('CountdownStart', self, self.CountdownStart)
	Network:Subscribe('CountdownStop', self, self.CountdownStop)
	
	Events:Subscribe( "ModuleLoad", self, self.ModuleLoad )
    Events:Subscribe( "ModulesLoad", self, self.ModuleLoad )
    Events:Subscribe( "ModuleUnload", self, self.ModuleUnload )
end

function CountdownClient:CountdownStart(arg)
	self.RenderEvent = Events:Subscribe('Render', self, self.DrawCountdown)
	Network:Unsubscribe(self.NetworkEvent)
	self.CdString = arg
	self.CdStartTime = os.clock()
	self.CdLastTick = self.CdStartTime
end

function CountdownClient:CountdownStop()
	print('countdown stopped')
	Events:Unsubscribe(self.RenderEvent)
	self.NetworkEvent = Network:Subscribe('CountdownStart', self, self.CountdownStart)
end

function CountdownClient:DrawCountdown()

	local displayString = ''
	
	if	self.CdString > 0 then
		displayString = self.CdString..''
	elseif self.CdString == 0 then
		displayString = 'Go!'
	elseif self.CdString < 0 then
		Events:Unsubscribe(self.RenderEvent)
		self.NetworkEvent = Network:Subscribe('CountdownStart', self, self.CountdownStart)
	end
	
	local position = Vector2(Render.Width/2, Render.Height/100*20)
	position.y = position.y - Render:GetTextHeight(displayString, TextSize.VeryLarge)
	position.x = position.x - Render:GetTextWidth(displayString, TextSize.VeryLarge) / 2
	
	Render:DrawText(position, displayString, Color(255,255,0), TextSize.VeryLarge)
	
	if(os.clock() >= self.CdLastTick + 1) then
		self.CdString = self.CdString - 1
		self.CdLastTick = os.clock()
	end
	
end

function CountdownClient:ModuleLoad()
    Events:Fire( "HelpAddItem",
        {
            name = "Countdown",
            text = 
                "Countdown displays a numeral countdown\r\n " ..
                "on the top quarter of every player's screen\r\n" ..
                "Commands:\n" ..
                "/countdown or /cd - Starts the default countdown (10 seconds)\n" ..
                "/cd <amount> - Starts a countdown for <amount> seconds\n"..
				"/cd stop or /countdown stop - Stops the current countdown, can only be used by the player who started the countdown\n"..
				"/cd help or /countdown help - Displays the available commands in chat\n"
        })
end

function CountdownClient:ModuleUnload()
    Events:Fire( "HelpRemoveItem",
        {
            name = "Countdown"
        })
end


countdownclient = CountdownClient()