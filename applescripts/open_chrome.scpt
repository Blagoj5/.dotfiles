on run argv
    set excludedURLs to argv -- List of URLs to exclude from the condition

    tell application "Google Chrome"
        set activeWindow to missing value -- Initialize the active window as missing

        -- Loop through all Chrome windows
        repeat with w in (every window)
            set shouldExclude to false -- Initialize as false

            -- Loop through tabs in the current window
            repeat with t in (every tab of w)
                set tabURL to URL of t
                repeat with url in excludedURLs
                    if tabURL contains url then
                        set shouldExclude to true
                        exit repeat
                    end if
                end repeat
                if shouldExclude then exit repeat
            end repeat

            -- If the window doesn't contain unwanted tabs, set it as the active window
            if not shouldExclude then
                set activeWindow to w
                exit repeat
            end if
        end repeat

        -- If no window remains, open a new one
        if activeWindow is missing value then
            set activeWindow to make new window
        end if

        log "Active Window: " & id of activeWindow

        -- Make the active window frontmost and activate it
        set index of activeWindow to 1
        activate
    end tell
end run

