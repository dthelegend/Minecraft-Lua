os.loadAPI("cnc")

function rawread()
    while true do
        local sEvent, param = os.pullEvent("key")
        if sEvent == "key" then
            if param == 17 then
                cnc.incrementY()
                return true
            elseif param == 31 then
                cnc.decrementY()
                return true
            elseif param == 30 then
                cnc.decrementX()
                return true
            elseif param == 32 then
                cnc.incrementX()
                return true
            elseif param == 42 then
                cnc.pullRopeAllTheWayUp()
                return true
            elseif param == 57 then
                cnc.ropeDown()
                return true
            else
                return false
            end
        end
    end
end

function main()
    while rawread() do
        sleep(0.5)
    end
end