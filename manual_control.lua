os.loadAPI("cnc.lua")

function rawread()
    local sEvent, param = os.pullEvent("key")
    if sEvent == "key" then
        if param == 87 then
            cnc.incrementY()
        elseif param == 83 then
            cnc.decrementY()
        elseif param == 65 then
            cnc.decrementX()
        elseif param == 68 then
            cnc.incrementX()
        elseif param == 340 then
            cnc.pullRopeAllTheWayUp()
        elseif param == 32 then
            cnc.ropeDown()
        elseif param == 257 then
            return false
        else
            print("Unknown key: ", param)
        end
    end
    return true
end

function main()
    while rawread() do
        -- pass
    end
end

main()