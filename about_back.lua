local composer = require( "composer" )
local scene = composer.newScene()

local image, text1, text2  

local abouttxt=" -- Called when the scene's view does not exist: hn 6:65) 所以你要靠著你的　神歸回，謹守忠信和公平，常常等候你的　神。 (Hosea 12:6) 停下来为你在基督耶稣里所享受的关系感谢神。 我要培养的品格 你要除掉欺詐的口，遠離乖謬的嘴唇。 (Proverbs 4:24) 因為人的道路都在耶和華眼前，他也審察人的一切路徑。 (Proverbs 5:21) 停下来请求神赐给你恩典成长敬虔的品格。 我同别人的关系 你們要注意，不管是誰都不要以惡報惡，卻要在彼此相處和對待眾人這方面，常常追求良善。 (1 Thessalonians 5:15) 我的弟兄們，你們既然對我們榮耀的主耶穌基督有信心，就不應該憑外貌待人。 (James 2:1) "
function scene:create( event )
	local sceneGroup = self.view
	
	image = display.newImage( "bg.jpg" )
	image.x = display.contentCenterX
	image.y = display.contentCenterY
	
	sceneGroup:insert( image )
	
	text1 = display.newText( "使用说明", 0, 0, native.systemFontBold, 24 )
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
