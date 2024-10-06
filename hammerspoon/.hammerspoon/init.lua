mouse_follows_focus = hs.loadSpoon("MouseFollowsFocus")
mouse_follows_focus:configure({})
mouse_follows_focus:start()

-- hs.hotkey.bind({ "cmd", "alt" }, "W", function()
-- 	-- local wf = hs.window.filter
-- 	-- wf_timewaster = wf.new(false):setAppFilter("Safari", { allowTitles = "reddit" }) -- any Safari windows with "reddit" anywhere in the title
-- 	-- print("***", wf_timewaster)
-- 	local allWindows = hs.window.allWindows()
-- 	for _, v in pairs(allWindows) do
-- 		print(v:application():name())
-- 	end
-- 	local chromeWindows = hs.application("Google Chrome"):allWindows() --> Terminal
--   -- print("Chrome***", chromeWindows:b)
-- 	for _, v in pairs(chromeWindows) do
-- 		print(v)
-- 	end
-- end)
--
--
-- for key in keys
-- key split by empty space
-- hs.hotkey.bind({ ...splittedKey }, lastKeyPart, function()
-- end)
