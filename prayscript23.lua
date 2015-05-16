local composer = require( "composer" )
local scene = composer.newScene()
local image, text1, text2,  memTimer

local function onSceneTouch( self, event )
	if event.phase == "began" then
		
		
		if (event.x>display.contentCenterX) then		
		nextpage="prayscript31"
		prevpage="prayscript22"
		composer.gotoScene( nextpage, "slideLeft", 800  )
		else
		nextpage="prayscript22"
		prevpage="prayscript31"
		composer.gotoScene( nextpage, "slideRight", 800  )
		end	
		return true
	end
end


-- Called when the scene's view does not exist:
function scene:create( event )
	local sceneGroup = self.view
	
	image = display.newImage( "bg.jpg" )
	image.x = display.contentCenterX
	image.y = display.contentCenterY
	
	sceneGroup:insert( image )
	
	image.touch = onSceneTouch
	
end

function scene:show( event )
	
	local phase = event.phase
	
	if "did" == phase then
	
		composer.removeScene( prevpage )
	
		-- Update Lua memory text display
		local showMem = function()
			image:addEventListener( "touch", image )
		end
		memTimer = timer.performWithDelay( 1000, showMem, 1 )
	
	local sceneGroup = self.view
	text1 = display.newText( a[2][2], 0, 0, native.systemFontBold, 24 )
	text1:setFillColor( text_R,text_G,text_B)
	text1.x, text1.y = display.contentWidth * ratiot, titley0
	sceneGroup:insert( text1 )
	text2 = display.newText( a[2][3], 0, 0, display.contentWidth*ratiow,display.contentHeight*ratiow,native.systemFont, fontsize)
	text2:setFillColor( text_R,text_G,text_B)
	text2.xScale=ratiot;text2.yScale=ratiot
	text2.x, text2.y = display.contentWidth * ratiot, titley1
	sceneGroup:insert( text2 )
	end
	
end

function scene:hide( event )
	
	local phase = event.phase
	
	if "will" == phase then
	
		image:removeEventListener( "touch", image )
	
		timer.cancel( memTimer ); memTimer = nil;
	
	local sceneGroup = self.view
	sceneGroup:remove( text1 )
	sceneGroup:remove( text2 )
	
	end
	
end

function scene:destroy( event )
end


scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )


return scene
