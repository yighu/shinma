

local widget = require( "widget" )

local function scrollListener( event )
	local phase = event.phase
	local direction = event.direction
	
	if "began" == phase then
		--print( "Began" )
	elseif "moved" == phase then
		--print( "Moved" )
	elseif "ended" == phase then
		--print( "Ended" )
	end
	
	if event.limitReached then
		if "up" == direction then
			print( "Reached Top Limit" )
		elseif "down" == direction then
			print( "Reached Bottom Limit" )
		elseif "left" == direction then
			print( "Reached Left Limit" )
		elseif "right" == direction then
			print( "Reached Right Limit" )
		end
	end
			
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
titleText:setFillColor( 0 )

scrollView:insert( titleText )

local lotsOfText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur imperdiet consectetur euismod. Phasellus non ipsum vel eros vestibulum consequat. Integer convallis quam id urna tristique eu viverra risus eleifend.\n\nAenean suscipit placerat venenatis. Pellentesque faucibus venenatis eleifend. Nam lorem felis, rhoncus vel rutrum quis, tincidunt in sapien. Proin eu elit tortor. Nam ut mauris pellentesque justo vulputate convallis eu vitae metus. Praesent mauris eros, hendrerit ac convallis vel, cursus quis sem. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque fermentum, dui in vehicula dapibus, lorem nisi placerat turpis, quis gravida elit lectus eget nibh. Mauris molestie auctor facilisis.\n\nCurabitur lorem mi, molestie eget tincidunt quis, blandit a libero. Cras a lorem sed purus gravida rhoncus. Cras vel risus dolor, at accumsan nisi. Morbi sit amet sem purus, ut tempor mauris.\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur imperdiet consectetur euismod. Phasellus non ipsum vel eros vestibulum consequat. Integer convallis quam id urna tristique eu viverra risus eleifend.\n\nAenean suscipit placerat venenatis. Pellentesque faucibus venenatis eleifend. Nam lorem felis, rhoncus vel rutrum quis, tincidunt in sapien. Proin eu elit tortor. Nam ut mauris pellentesque justo vulputate convallis eu vitae metus. Praesent mauris eros, hendrerit ac convallis vel, cursus quis sem. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque fermentum, dui in vehicula dapibus, lorem nisi placerat turpis, quis gravida elit lectus eget nibh. Mauris molestie auctor facilisis.\n\nCurabitur lorem mi, molestie eget tincidunt quis, blandit a libero. Cras a lorem sed purus gravida rhoncus. Cras vel risus dolor, at accumsan nisi. Morbi sit amet sem purus, ut tempor mauris. "

local lotsOfTextObject = display.newText( lotsOfText, display.contentCenterX, 0, 300, 0, native.systemFont, 14)
lotsOfTextObject:setFillColor( 0 ) 
lotsOfTextObject.anchorY = 0.0		
lotsOfTextObject.y = titleText.y + titleText.contentHeight + 10

scrollView:insert( lotsOfTextObject )
