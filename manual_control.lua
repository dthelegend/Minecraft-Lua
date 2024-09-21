os.loadAPI("cnc.lua")

function rawread()
    local sEvent, param = os.pullEvent("key")
    if sEvent == "key" then
        if param == 17 then
            cnc.incrementY()
        elseif param == 31 then
            cnc.decrementY()
        elseif param == 30 then
            cnc.decrementX()
        elseif param == 32 then
            cnc.incrementX()
        elseif param == 42 then
            cnc.pullRopeAllTheWayUp()
        elseif param == 57 then
            cnc.ropeDown()
        elseif param == 28 then
            return false
        else
            print("Unknown key: ", param)
        end
    else
        return true
    end
end

function main()
    while rawread() do
        -- pass
    end
end