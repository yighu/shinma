
local ButtonOrigY = 175
local ButtonYOffset = 45
local StatusMessageY = 420

local background = display.newImage( "facebook_bkg.png", centerX, centerY, true )

local function printTable( t, label, level )
	if label then print( label ) end
	level = level or 1

	if t then
		for k,v in pairs( t ) do
			local prefix = ""
			for i=1,level do
				prefix = prefix .. "\t"
			end

			print( prefix .. "[" .. tostring(k) .. "] = " .. tostring(v) )
			if type( v ) == "table" then
				print( prefix .. "{" )
				printTable( v, nil, level + 1 )
				print( prefix .. "}" )
			end
		end
	end
end

local function createStatusMessage( message, x, y )
	local textObject = display.newText( message, 0, 0, native.systemFontBold, 24 )
	textObject:setFillColor( 1,1,1 )

	local group = display.newGroup()
	group.x = x
	group.y = y
	group:insert( textObject, true )

	local r = 10
	local roundedRect = display.newRoundedRect( 0, 0, textObject.contentWidth + 2*r, textObject.contentHeight + 2*r, r )
	roundedRect:setFillColor( 55/255, 55/255, 55/255, 190/255 )
	group:insert( 1, roundedRect, true )

	group.textObject = textObject
	return group
end

local statusMessage = createStatusMessage( "   Not connected  ", centerX, StatusMessageY )

local function flistener( event )

	local maxStr = 20		
	local endStr
	
    if ( "session" == event.type ) then
		
		if fbCommand == POST_MSG then
			local time = os.date("*t")
			local postMsg = {
				message = "Posting from ShinMa! " ..
					os.date("%A, %B %e")  .. ", " .. time.hour .. ":"
					.. time.min .. "." .. time.sec
			}
		
			facebook.request( "me/feed", "POST", postMsg )	
		end

    elseif ( "request" == event.type ) then
        local response = event.response
        
		if ( not event.isError ) then
	        response = json.decode( event.response )
	        
		if fbCommand == POST_MSG then
				printTable( response, "message", 3 )
				statusMessage.textObject.text = "Message Posted"
				
			end

        else
			statusMessage.textObject.text = "Post failed"
			printTable( event.response, "Post Failed Response", 3 )
		end
		
    end
end

