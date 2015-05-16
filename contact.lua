local composer = require( "composer" )
local scene = composer.newScene()

local image, text1, text2  

local abouttxt="contact us: ccimspiritualgateway@gmail.com "
function scene:create( event )
	local sceneGroup = self.view
	
	image = display.newImage( "bg.jpg" )
	image.x = display.contentCenterX
	image.y = display.contentCenterY
	
	sceneGroup:insert( image )
	
	text1 = display.newText( "联系我们", 0, 0, native.systemFontBold, 24 )
	text1:setFillColor( 255 )
	text1.x, text1.y = display.contentWidth * 0.5, 50
	sceneGroup:insert( text1 )
	text2 = display.newText( abouttxt, 0, 0, display.contentWidth,display.contentHeight-200,native.systemFont, fontsize)
	text2:setFillColor( 255 )
	text2.x, text2.y = display.contentWidth * 0.5, 250
	sceneGroup:insert( text2 )
	
	
end

function scene:show( event )
	
	local phase = event.phase
	
	if "did" == phase then
	
		composer.removeScene( "prayscript53" )
	
		local showMem = function()
			image:addEventListener( "touch", image )
		end
	
	end
	
end

function scene:hide( event )
	
end

function scene:destroy( event )
end


scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )


return scene
