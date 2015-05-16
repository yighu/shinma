
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

local titleText = display.newText("Move Up to Scroll", display.contentCenterX, 48, native.systemFontBold, 16)
titleText:setFillColor( 255 )

	image = display.newImage( "bg.jpg" )
	image.x = display.contentCenterX
	image.y = display.contentCenterY
scrollView:insert( image)
scrollView:insert( titleText )

local lotsOfText = "replace it"

local lotsOfTextObject = display.newText( lotsOfText, display.contentCenterX, 0, 300, 0, native.systemFont, fontsize)
lotsOfTextObject:setFillColor( 255 ) 
lotsOfTextObject.anchorY = 0.0		
lotsOfTextObject.y = titleText.y + titleText.contentHeight + 10

scrollView:insert( lotsOfTextObject )
