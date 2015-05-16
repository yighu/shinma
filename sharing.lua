io.output():setvbuf('no') 		
local widget = require("widget")
local facebook = require("facebook")
local json = require("json")
local appId  = "1622244821333488"	
local composer = require( "composer" )
local scene = composer.newScene()
local hspace=50
local startbar=10
local fbCommand			
local msg=""
------------------


local ButtonOrigY = 175
local ButtonYOffset = 45
local StatusMessageY = 420

--local background = display.newImage( "facebook_bkg.png", centerX, centerY, true )

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

--local statusMessage = createStatusMessage( "", centerX, StatusMessageY )
	
local image,  memTimer

local widget = require( "widget" )

local function scrollListener( event )
	return true
end

local scrollView = widget.newScrollView
{
	left = 0,
	top = 0,
	width = display.contentWidth,
	height = display.contentHeight,
	bottomPadding = 50,
	id = "onBottom",
	horizontalScrollDisabled = true,
	verticalScrollDisabled = false,
	listener = scrollListener,
}

local titleText = display.newText("分享", display.contentCenterX, 48, native.systemFontBold, 16)
titleText:setFillColor( 0)

	image = display.newImage( "bg.jpg" )
	image.x = display.contentCenterX
	image.y = display.contentCenterY
scrollView:insert( image)
scrollView:insert( titleText )

local lotsOfText = ""

local lotsOfTextObject = display.newText( lotsOfText, display.contentCenterX, 0, 300, 0, native.systemFont, fontsize)
lotsOfTextObject:setFillColor( text_R,text_G,text_B) 
lotsOfTextObject.anchorY = 0.0		
lotsOfTextObject.y = titleText.y + titleText.contentHeight + 10

scrollView:insert( lotsOfTextObject )

local function onFeedEmail(event)
local options =
{
   to = "ccimspiritualgateway@gmail.com",
   subject = "用神的话祷告应用反溃",
   body = "",
}

local result=native.showPopup( "mail", options )
if not result then 
	native.showAlert("警告!","这个设备不送电子邮件",{"好"}
 );
end
end
local function genMsg()
local nl="\n\n"
msg=""
for i=1,5 do
msg=msg..nl..a[i][2]..nl..a[i][4]..nl..a[i][5]..nl..a[i][3]..nl
end
msg=msg.."\t\t来自'听'－听神的话带领我们祷告\t\t"
end
local function flistener( event )

	local maxStr = 20000
	local endStr
	
    if ( "session" == event.type ) then
		
		if fbCommand == POST_MSG then
   				genMsg()
			local postMsg = {
				message = msg.."--Posting from ShinMa! " 
			}
		
			facebook.request( "me/feed", "POST", postMsg )	
		end

    elseif ( "request" == event.type ) then
    end
end
	local fblogin=false
	local function postMsg_onRelease( event )
		if (fblogin ~= true) then
			facebook.login( appId, flistener )
			fblogin=true
		end
		fbCommand = POST_MSG
		facebook.login( appId, flistener, {"publish_actions"} )
	end
local function onPrayEmail(event)

   genMsg()
local options =
{
   to = "friend@email",
   subject = "用神的话祷告",
   body = msg
}
local result=native.showPopup( "mail", options )
if not result then 
	native.showAlert("警告!","这个设备不送电子邮件",{"好"}
 );
end
end
local feedEmail = widget.newButton
{
        left = 0,
        top = 0,
        width = 298,
        height = 56,
        label = "联系开发员",
        onRelease = onFeedEmail
}

feedEmail.x = display.contentWidth/2
feedEmail.y = display.contentHeight - hspace -startbar

local prayEmail = widget.newButton
{
        left = 0,
        top = 0,
        width = 298,
        height = 56,
        label = "电邮给朋友",
        onRelease = onPrayEmail
}
prayEmail.x = display.contentWidth/2
prayEmail.y = display.contentHeight - 4*hspace-startbar

local function onSendSMS( event )
   genMsg()
	local options =
	{
	   to = { "1234567890" },
	   body = msg;
	}
	local result = native.showPopup("sms", options)

	if not result then
		print( "SMS Not supported/setup on this device" )
		native.showAlert("警告!","这个设备不送SMS",{"好"}
		)
	end
	
end


local sendSMS = widget.newButton
{
	left = 0, 
	top = 0,
	width = 298,
	height = 56,
	label = "SMS",
	onRelease = onSendSMS
}

sendSMS.x = display.contentWidth/2
sendSMS.y = display.contentHeight - 3*hspace-startbar

local postFb= widget.newButton
{
	left = 0, 
	top = 0,
	width = 298,
	height = 56,
	label = "送脸书",
	onRelease = postMsg_onRelease
}

postFb.x = display.contentWidth/2
postFb.y = display.contentHeight - 2*hspace-startbar


scrollView:insert( prayEmail)
scrollView:insert( sendSMS)
scrollView:insert( feedEmail)
scrollView:insert( postFb)

function scene:create( event )
	local sceneGroup = self.view
	sceneGroup:insert( scrollView)
end

function scene:show( event )
	
	local phase = event.phase
	
	if "did" == phase then
		composer.removeScene( "prayscript53" )
		local showMem = function()
			image:addEventListener( "touch", image )
		end
		memTimer = timer.performWithDelay( 1000, showMem, 1 )
	end
	
end

function scene:hide( event )
	
	local phase = event.phase
	
	if "will" == phase then
	
		image:removeEventListener( "touch", image )
	
		timer.cancel( memTimer ); memTimer = nil;
	
	
	end
	
end

function scene:destroy( event )
end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )


return scene







	
