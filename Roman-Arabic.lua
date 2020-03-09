function toRomanUtil(pos, numb)

	local result = ""
	local p = 0
	
	if pos == 1 then
		p = pos
	else
		p = pos + pos - 1
	end
	
	if numb == 9 then
		result = rDict:sub(p + 2, p + 2) .. rDict:sub(p, p)
		
	elseif numb >= 5 then
		result = string.rep(rDict:sub(p, p), numb - 5)
		result = result .. rDict:sub(p + 1, p + 1)
		
	elseif numb == 4 and pos ~= 4 then
		result = rDict:sub(p + 1, p + 1) .. rDict:sub(p, p)
	else
		result = string.rep(rDict:sub(p, p), numb)
	end
	
	return result
end


function toRoman(numb)

	local temp = tostring(numb):reverse()
	local strSize = #temp
	local result = ""
	local denom = {
		[1] = 0,
		[2] = 0,
		[3] = 0,
		[4] = 0,
	}
	for i = strSize, 1, -1 do
		denom[i] = tonumber(temp:sub(i, i))
	end
	
	for i = 1, #denom do
		if denom[i] ~= 0 then result = result .. toRomanUtil(i, denom[i]) end
	end
	return result:reverse()
end


function toArabic(str)
	
	local numbInArab = 0;
	
	if #str == 1 then return aDict[str] end
	
	local rstr = str:reverse()
	local prev = rstr:sub(1, 1)
	local current = ""
	numbInArab = aDict[prev]
	
	for i = 2, #rstr do
		current = rstr:sub(i, i)
		local temp = aDict[current]
		if temp < aDict[prev] then 
			numbInArab = numbInArab - temp
		else
			numbInArab = numbInArab + temp
		end
		prev = current
	end
	
	return numbInArab
end
	
	
function compare(str)
	

	local numbInArab = toArabic(str)
	local numbInRoman = toRoman(numbInArab)
	--local again = toArabic(numbInRoman)
	
	--if str ~= numbInRoman then print("diff = ", #str - #numbInRoman, str, " --> ", numbInArab , " --> ", numbInRoman, " --> ", again) end
	
	return #str - #numbInRoman
end

aDict = {
	["I"] = 1,
	["V"] = 5,
	["X"] = 10,
	["L"] = 50,
	["C"] = 100,
	["D"] = 500,
	["M"] = 1000
}

rDict = "IVXLCDM"
	
path = arg[0]:sub(0, -17) .. "roman.txt"

data = {}
for line in io.lines(path) do
	data[#data+1] = line
end

result = 0

for i, line in pairs(data) do
	local temp = compare(line)
	
	if temp ~= 0 then
		result = result + compare(line)
	end
end

print("Result = " .. result)