-----------------------------------------------------------------
-- @package     Skeleton
-- @authors     Your Name
-- @build       v1.0
-- @release     11.12.2015
-----------------------------------------------------------------

Skeleton = Skeleton or {}

-----------------------------------------------------------------
-- [ YOUR SERVER CODE BELOW ]
-----------------------------------------------------------------

-----------------------------------------------------------------
-- [ SCRIPT ENFORCER INTEGRATION ]
-----------------------------------------------------------------

--[[

hook.Add("Think", "GetSkeletonUpdate", function()
	SkeletonFetchHashAuth(Skeleton.Script.ScriptfodderID, {{ se_hashkey }}, "sv_init", Skeleton.Script.Build, nil, game.GetIP())
	hook.Remove("Think", "GetSkeletonUpdate")
end)

]]--