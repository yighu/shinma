local composer = require( "composer" )
local scene = composer.newScene()

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

local titleText = display.newText("使用说明", display.contentCenterX, 60, native.systemFontBold, 16)
titleText:setFillColor( 0)

scrollView:insert( titleText )

local lotsOfText ="祷告是基督徒的权力和义务。生命的成长离不开祷告。圣经教导我们要常常祷告。圣经中记载了无数的祷告。神听我们的祷告。耶稣基督也在天上为我们祷告。可是不少基督徒对自己的祷告生活不满意，甚至挫败。好消息是读经与祷告间有不可割裂的关系。读经需要祷告，让圣灵带领并开启我们心灵的眼睛，使我们能听到并明白神所要教导我们的。另一方面，读经过程中，神的话会感动我们，有的让我们看到自己的罪，有的让我们看到人们需要主，有的鼓舞我们对神的信心，有的让我们感谢赞美神。这些都可以带到主面前。所以有一种祷告方式叫祷告圣经。就是将神的话向神祷告回去，同时领会神的话对我们的提醒，再向神摆上我们自己的赞美，祈求和感恩。此软件就是为此而作。此程序偏重灵命成长通过祷告神的话。 \n\n内容根据<<Hand Book To Renewal>>(Kenneth Boa)翻译编集而成。 \n\n此程序由胡益光弟兄和陈彪博士（牧师）合作完成。\n\n图标背景为申命记6:4(以色列啊，你要听，耶和华我们的　神是独一的耶和华)希伯来原文。"

local lotsOfTextObject = display.newText( lotsOfText, display.contentCenterX, 0, 300, 0, native.systemFont, fontsize/2)
lotsOfTextObject:setFillColor( 0) 
lotsOfTextObject.anchorY = 0.0		
lotsOfTextObject.y = titleText.y + titleText.contentHeight + 10

scrollView:insert( lotsOfTextObject )

function scene:create( event )
	local sceneGroup = self.view
	sceneGroup:insert( scrollView)
end

scene:addEventListener( "create", scene )

return scene
