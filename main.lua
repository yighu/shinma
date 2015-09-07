
require "sqlite3"
text_R=165/255
text_G=42/255
text_B=42/255
a={}
b={}
a[1]={}
a[1][1]=233
a[1][2]="神的属性"
a[1][3]="停下来思想有关神的位格，能力，和完美"
a[2]={}
a[2][1]=342
a[2][2]="神的工作"
a[2][3]="停下来思想神奇妙工作的伟大"
a[3]={}
a[3][1]=516
a[3][2]="我同神的关系"
a[3][3]="停下来为你在基督耶稣里所享受的关系感谢神"
a[4]={}
a[4][1]=370
a[4][2]="我要培养的品格"
a[4][3]="停下来请求神赐给你恩典成长敬虔的品格"
a[5]={}
a[5][1]=203
a[5][2]="我同别人的关系"
a[5][3]="停下来反思你同他人的关系，并将他们交托给神"
fontsize=16*2
titley0=50
titley1=300
ratiow=1.8
ratiot=0.5
nextpage="prayscript11"
prevpage="prayscript53"

function doesFileExist( fname, path )

    local results = false

    local filePath = system.pathForFile( fname, path )

    --filePath will be 'nil' if file doesn't exist and the path is 'system.ResourceDirectory'
    if ( filePath ) then
        filePath = io.open( filePath, "r" )
    end

    if ( filePath ) then
        --print( "File found: " .. fname )
        --clean up file handles
        filePath:close()
        results = true
    else
        print( "File does not exist: " .. fname )
    end

    return results
end
function copyFile( srcName, srcPath, dstName, dstPath, overwrite )

    local results = false

    local srcPath = doesFileExist( srcName, srcPath )

    if ( srcPath == false ) then
        return nil  -- nil = source file not found
    end

    --check to see if destination file already exists
    if not ( overwrite ) then
        if ( doesFileExist( dstName, dstPath ) ) then
            return 1  -- 1 = file already exists (don't overwrite)
        end
    end

    --copy the source file to the destination file
    local rfilePath = system.pathForFile( srcName, srcPath )
    local wfilePath = system.pathForFile( dstName, dstPath )

    local rfh = io.open( rfilePath, "rb" )
    local wfh = io.open( wfilePath, "wb" )

    if not ( wfh ) then
        print( "writeFileName open error!" )
        return false
    else
        --read the file from 'system.ResourceDirectory' and write to the destination directory
        local data = rfh:read( "*a" )
        if not ( data ) then
            print( "read error!" )
            return false
        else
            if not ( wfh:write( data ) ) then
                print( "write error!" )
                return false
            end
        end
    end

    results = 2  -- 2 = file copied successfully!

    --clean up file handles
    rfh:close()
    wfh:close()

    return results
end


setVerse=function()
local result=copyFile( "pray.db", system.ResourceDirectory, "pray.db", system.DocumentsDirectory,false)
--print ("result..."..result)
local path = system.pathForFile("pray.db", system.DocumentsDirectory)
local db = sqlite3.open( path )   
for row in db:nrows("SELECT * FROM track") do
  b[1]= row.s1
  b[2]= row.s2
  b[3]= row.s3
  b[4]= row.s4
  b[5]= row.s5
end
--print("doing start setverse..."..b[1])
for i=1,5 do
	b[i]=b[i]+1
	if b[i]>a[i][1] then 
		b[i]=1
	end
local v=b[i] 
--print("doing middle setverse..."..b[i])
for row in db:nrows("SELECT bible FROM closet where type="..i.." and id="..v) do
  a[i][4]= row.bible
end
	b[i]=b[i]+1
	if b[i]>a[i][1] then 
		b[i]=1
	end
v=b[i]
for row in db:nrows("SELECT bible FROM closet where type="..i.." and id="..v) do
  a[i][5]= row.bible
end
end

local dbsexec=db:exec("UPDATE track SET s1="..b[1]..",s2="..b[2]..",s3="..b[3]..",s4="..b[4]..",s5="..b[5])
db:close()
--print("doing setverse..."..b[1].."db exec status  "..dbsexec)
end
setVerse()

touchtocontinue="按一下屏幕继续"
	text3 = display.newText( touchtocontinue, 0, 0, native.systemFontBold, 18 )
	text3:setFillColor( 255 ); text3.isVisible = true
	text3.x, text3.y = display.contentWidth * 0.5, display.contentHeight - 100

display.setStatusBar( display.HiddenStatusBar )

local composer = require "composer"

local widget = require "widget"

composer.gotoScene( "prayscript11", "fade", 400 )

local tabButtons = 
{
	{ 
		width = 32,
		height = 32,
		defaultFile = "icon1.png",
		overFile = "icon1-down.png",
		label = "祷告",
    onPress = function() composer.gotoScene( "prayscript11" ); end, 

		selected = true,

	},
	{ 
		width = 32,
		height = 32,
		defaultFile = "icon1.png",
		overFile = "icon1-down.png",
		label = "刷新",
    		onPress = function () 
				setVerse()
    				composer.gotoScene( "prayscript11","fade",400 )
		 end, 

	},
	{ 
		width = 32,
		height = 32,
		defaultFile = "icon2.png",
		overFile = "icon2-down.png",
		label = "信息",
    onPress = function() composer.gotoScene( "about" ); end, 
	},
	{ 
		width = 32,
		height = 32,
		defaultFile = "icon2.png",
		overFile = "icon2-down.png",
		label = "分享",
    		onPress = function() composer.gotoScene( "sharing" ); end, 
	}
}

local tabBar = widget.newTabBar
{
	top = display.contentHeight-50,
	width = display.contentWidth,
	backgroundFile = "tabbar.png",
	tabSelectedLeftFile = "tabBar_tabSelectedLeft.png",
	tabSelectedMiddleFile = "tabBar_tabSelectedMiddle.png",
	tabSelectedRightFile = "tabBar_tabSelectedRight.png",
	tabSelectedFrameWidth = 32,
	tabSelectedFrameHeight = 32,
	buttons = tabButtons
}

-- hit 'c' to capture your screen
local function cap(event)
    if event.keyName== "c" and event.phase == "up" then
        local screenCap = display.captureScreen( true )
        display.remove (screenCap)
        screenCap = nil
    end
    return true
end
 
Runtime:addEventListener("key",cap)
-- hit 'c' to capture your screen
