os.loadAPI("cnc")

function rawread()
    while true do
        local sEvent, param = os.pullEvent("key")
        if sEvent == "key" then
            if param == 17 then
                cnc.incrementY()
                return true
            else if param == 31 then
                cnc.decrementY()
                return true
            else if param == 30 then
                cnc.decrementX()
                return true
            else if param == 32 then
                cnc.incrementX()
                return true
            else if param == 42 then
                cnc.pullRopeAllTheWayUp()
                return true
            else if param == 57 then
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