local composer = require( "composer" )
local scene = composer.newScene()

local image, text1, text2,  memTimer

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

local titleText = display.newText("工具", display.contentCenterX, 48, native.systemFontBold, 16)
titleText:setFillColor( 255 )

	image = display.newImage( "bg.jpg" )
	image.x = display.contentCenterX
	image.y = display.contentCenterY
scrollView:insert( image)
scrollView:insert( titleText )

local lotsOfText = "lots of stuff"

local lotsOfTextObject = display.newText( lotsOfText, display.contentCenterX, 0, 300, 0, native.systemFont, fontsize)
lotsOfTextObject:setFillColor( 255 ) 
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
local msg=""
local function genMsg()
local nl="\n\n"
msg=""
for i=1,5 do
msg=msg..nl..a[i][2]..nl..a[i][4]..nl..a[i][5]..nl..a[i][3]..nl
end
end
local function onPrayEmail(event)

   genMsg()
local options =
{
   to = "ccimspiritualgateway@gmail.com",
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
feedEmail.y = display.contentHeight - 120

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
prayEmail.y = display.contentHeight -200 

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
sendSMS.y = display.contentHeight -156

scrollView:insert( prayEmail)
scrollView:insert( sendSMS)
scrollView:insert( feedEmail)

function scene:create( event )
	local sceneGroup = self.view
	sceneGroup:insert( scrollView)
end

function scene:show( event )
	
	local phase = event.phase
	
	if "did" == phase then
	
		composer.removeScene( "prayscript53" )
	
		-- Update Lua memory text display
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
