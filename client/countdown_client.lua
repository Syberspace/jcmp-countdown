class("CountdownClient")

function CountdownClient:__init()
	self.CdString = 0
	self.CdStartTime = 0
	self.CdLastTick = 0
	self.RenderEvent = nil

	Network:Subscribe('CountdownStart', self, self.CountdownStart)
	Network:Subscribe('CountdownDecrement', self, self.CountdownDecrement)
	
	Events:Subscribe( "ModuleLoad", self, self.ModuleLoad )
    Events:Subscribe( "ModulesLoad", self, self.ModuleLoad )
    Events:Subscribe( "ModuleUnload", self, self.ModuleUnload )
end

function CountdownClient:CountdownStart(arg)
	self.RenderEvent = Events:Subscribe('Render', self, self.DrawCountdown)
	self.CdString = arg
	self.CdStartTime = os.clock()
	self.CdLastTick = self.CdStartTime
end

function CountdownClient:CountdownDecrement(arg)
	if(arg == self.CdString - 1) then
		self.CdString = arg
	end
end

function CountdownClient:DrawCountdown()

	local displayString = ''
	
	if	self.CdString > 0 then
		displayString = self.CdString..''
	elseif self.CdString == 0 then
		displayString = 'Go!'
	elseif self.CdString < 0 then
		Events:Unsubscribe(self.RenderEvent)
	end
	
	local position = Vector2(Render.Width/2, Render.Height/100*20)
	position.y = position.y - Render:GetTextHeight(displayString, TextSize.VeryLarge)
	position.x = position.x - Render:GetTextWidth(displayString, TextSize.VeryLarge) / 2
	
	Render:DrawText(position, displayString, Color(255,255,0), TextSize.VeryLarge)
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
                "/cd <amount> - Starts a countdown for <amount> seconds\n"
        })
end

function CountdownClient:ModuleUnload()
    Events:Fire( "HelpRemoveItem",
        {
            name = "Countdown"
        })
end


countdownclient = CountdownClient()