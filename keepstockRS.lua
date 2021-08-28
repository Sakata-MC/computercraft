local bridge = peripheral.find("rsBridge") -- Finds the peripheral if one is connected
if bridge == nil then error("rsBridge not found") end
local monitor = peripheral.find("monitor")
if monitor == nil then error("monitor not found") end

monTitle = "RS FE Use:".. bridge.getEnergyUsage().. "Keep in Stock:"

-- Format:  [index] = {"Anything","mod:itemname",minimum amount}
-- Example: [1] = {"Oak Planks","minecraft:oak_planks",128}
reqItems = {
[1] = {"Oak Planks","minecraft:oak_planks",128}
[2] = {"Glass","minecraft:glass",128}
}

function craftItems(name, reqName, reqCount)
	craftable = bridge.listCraftableItems()
	for i = 1, #craftable do
		craftableCount = tostring(craftable[i].amount)
		craftableName = craftable[i].name
		if craftableName == reqName
			row = row+1
			CenterT(name, row+1, colors.black, colors.lightGray, "left")
			if tonumber(craftableCount) <= tonumber(reqCount)-1 then
				CenterT(craftableCount.. "/".. reqCount, row+1, colors.black, colors.red, "right")
				if bridge.isItemCrafting(reqName) == false then
					bridge.craftItem(reqName,reqCount-craftableCount)
					print("Crafting ".. reqCount-craftableCount .. " ".. name)
				end
			else
				CenterT(craftableCount.. "/".. reqCount, row+1, colors.black, colors.green, "right")
			end
		end
	end
end

-- Clears the screen and writes the title
function clearScreen()
	monitor.setBackgroundColor(colors.black)
	monitor.clear()
	monitor.setCursorPos(1,1)
	CenterT(monTitle, 1, colors.black, colors.white, "head")
end
 
-- Function to write text to monitor easier
function CenterT(text, line, txtback, txtcolor, pos)
	monX,monY = monitor.getSize()
	monitor.setBackgroundColor(txtback)
	monitor.setTextColor(txtcolor)
	length = string.len(text)
	dif = math.floor(monX-length)
	x = math.floor(dif/2)
	if pos == "head" then
		monitor.setCursorPos(x+1, line)
		monitor.write(text)
	elseif pos == "left" then
		monitor.setCursorPos(2, line)
		monitor.write(text)
	elseif pos == "right" then
		monitor.setCursorPos(monX-length, line)
		monitor.write(text)
	end
end

-- Runs craftItems() with each item in reqItems
function checkTable()
	row = 1
	clearScreen()
	for i = 1, #reqItems do
		name = reqItems[i][1]
		reqName = reqItems[i][2]
		reqCount = reqItems[i][3]
		craftItems(name, reqName, reqCount)
	end
end 
 
while true do
  checkTable()
  -- CheckTable runs every 30 seconds, you can increase that.
  sleep(3)
end