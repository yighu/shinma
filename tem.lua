require "sqlite3"
local path = system.pathForFile("pray.db", system.DocumentsDirectory)
db = sqlite3.open( path )   
local script=""
local v=math.random(233)
for row in db:nrows("SELECT bible FROM closet where type=1 and id="..v) do
  script= row.bible
end
