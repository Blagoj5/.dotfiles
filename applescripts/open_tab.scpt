on run argv
    set targetURL to item 1 of argv

    tell application "Google Chrome"
        set foundTab to false
        set foundWindowIndex to 0

        repeat with wIndex from 1 to (count windows)
            repeat with tIndex from 1 to (count tabs of window wIndex)
                set tabURL to URL of tab tIndex of window wIndex
                if tabURL contains targetURL then
                    set foundTab to true
                    set foundWindowIndex to wIndex
                    set active tab index of window wIndex to tIndex
                    exit repeat
                end if
            end repeat
            if foundTab then exit repeat
        end repeat

        if not foundTab then
            open location targetURL
        end if

        if foundWindowIndex is not 0 then
            -- Activate the window where the tab was found
            set index of window foundWindowIndex to 1
        end if

        -- Activate Chrome to bring it to the front
        activate
    end tell
end run

