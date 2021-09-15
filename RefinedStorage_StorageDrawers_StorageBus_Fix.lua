-- This should get the stupid Refined Storage
-- storage bus to properly read the Storage
-- Drawers Controller.
-- Basically any time the chunk is loaded this
-- computer should run 'startup' and then turn
-- off the "External Storage" RS cable to the
-- right of this computer (it is set to de-
-- activate on redstone signal)
-- "front", "back", "left", "right", "top" or
-- "bottom"

varSide=left

print("Emitting redstone to "..varSide.." side for 5s...")
redstone.setOutput(varSide, true)
os.sleep(5)
print("Turning off redstone signal. Cable should")
print("  now be on...")
redstone.setOutput(varSide, false)
return 0
