
local centerX = display.contentCenterX
local centerY = display.contentCenterY
local _W = display.contentWidth
local _H = display.contentHeight

io.output():setvbuf('no') 		-- **debug: disable output buffering for Xcode Console **tjn

local widget = require("widget")
local facebook = require("facebook")
local json = require("json")

display.setStatusBar( display.HiddenStatusBar )
	
local fbCommand			
local LOGOUT = 1
local SHOW_DIALOG = 2
local POST_MSG = 3
local POST_PHOTO = 4
local GET_USER_INFO = 5
local GET_PLATFORM_INFO = 6

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

local function listener( event )

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
				--printTable( response, "message", 3 )
				statusMessage.textObject.text = "Message Posted"
				
			end

        else
			statusMessage.textObject.text = "Post failed"
			--printTable( event.response, "Post Failed Response", 3 )
		end
		
    end
end


local appId  = "1622244821333488"	
local apiKey = nil	

if ( appId ) then
	facebook.login( appId, listener )
	
	local function postMsg_onRelease( event )
		fbCommand = POST_MSG
		facebook.login( appId, listener, {"publish_actions"} )
	end
	
	
	local fbButton2 = widget.newButton
	{
		defaultFile = "fbButton184.png",
		overFile = "fbButtonOver184.png",
		label = "Post Msg",
		labelColor = 
		{ 
			default = { 255, 255, 255 }, 
		},
		onRelease = postMsg_onRelease,
	}
	fbButton2.x = 160
	fbButton2.y = ButtonOrigY + ButtonYOffset * 1
end
