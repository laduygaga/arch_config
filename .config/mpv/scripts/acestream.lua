local function open_acestream()
    -- Grab the URL that mpv is currently trying to load
    local url = mp.get_property("stream-open-filename")
    
    -- Check if it starts with "acestream://"
    if url and string.match(url, "^acestream://") then
        -- Strip the prefix to get just the ID
        local id = string.gsub(url, "acestream://", "")
        -- Construct the local HTTP link
        local new_url = "http://127.0.0.1:6878/ace/getstream?id=" .. id
        
        -- Print to terminal so you know it's working
        print("Redirecting AceStream to: " .. new_url)
        
        -- Tell mpv to open the new HTTP link instead
        mp.set_property("stream-open-filename", new_url)
    end
end

-- 'on_load' is the right time to intercept and change the URL
mp.add_hook("on_load", 10, open_acestream)
