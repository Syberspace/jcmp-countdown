class("CommandParser")

function CommandParser:__init()
	Events:Subscribe('PlayerChat', self, self.Command)
	print("commandparser init")
end

function CommandParser:Command(args)
	if (args.text:sub(1,1) ~= '/') then
		return true
	end
	local cmd 	= { }
	cmd.player 	= args.player
	cmd.args 	= self:Parse(args.text)
	cmd.name	= cmd.args[1]
	table.remove(cmd.args, 1)
	Events:Fire('ParsedPlayerCommand', cmd)
	return false		
end

function CommandParser:Parse(txt)
	local tmp = { }
	local quote = false
	local words = txt:gsub('^/', '')
	words = words:gsub('%s$', ''):split(' ')
	local param = { }
		
	for i = 1, #words do
		local f = words[i]:sub( 1,  1)
		local l = words[i]:sub(-1, -1)
		local e = words[i]:sub(-2, -2)
		if (f == '"' and l == '"' and e ~= '\\') then
			words[i] = words[i]:gsub('"(.-)"', '%1')
			table.insert(param, words[i])
		elseif (f == '"' and quote == false) then
			quote = true
			tmp = { }
			words[i] = words[i]:gsub('^"','')
			table.insert(tmp, words[i])
		elseif (l == '"' and quote == true and e ~= '\\') then
			quote = false
			words[i] = words[i]:gsub('"$','')
			table.insert(tmp, words[i])
			table.insert(param, table.concat(tmp, ' '))
		elseif (quote == true) then
			words[i] = words[i]:gsub('\\"', '"')
			table.insert(tmp, words[i])
		else
			words[i] = words[i]:gsub('\\"', '"')
			table.insert(param, words[i])
		end
	end
	return param
end

commandparser = CommandParser()