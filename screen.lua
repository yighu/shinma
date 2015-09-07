local function screenshot()	

	--I set the filename to be "widthxheight_time.png"
	--e.g. "1920x1080_20140923151732.png"
	local date = os.date( "*t" )
	local timeStamp = table.concat({date.year .. date.month .. date.day .. date.hour .. date.min .. date.sec})
	local fname = display.pixelWidth.."x"..display.pixelHeight.."_"..timeStamp..".png"
	
	--capture screen
	local capture = display.captureScreen(false)

	--make sure image is right in the center of the screen
	capture.x, capture.y = display.contentWidth * 0.5, display.contentHeight * 0.5

	--save the image and then remove
	local function save()
		display.save( capture, { filename=fname, baseDir=system.DocumentsDirectory, isFullResolution=true } )    
		capture:removeSelf()
		capture = nil
	end
	timer.performWithDelay( 100, save, 1)
	       	
	return true               
end


--works in simulator too
local function onKeyEvent(event)
	if event.phase == "up" then
		--press s key to take screenshot which matches resolution of the device
    	    if event.keyName == "s" then
    		screenshot()
    	    end
        end
end

Runtime:addEventListener("key", onKeyEvent)
