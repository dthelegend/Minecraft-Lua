-- Global Constants
BUNDLE_SIDE = "right"
SLEEP_UNIT = 1

-- Bundle color definitions
GLOBAL_SHAFT_DIRECTION = colors.cyan -- Increasing when active

X_SHAFT_STOP = colors.yellow
Y_SHAFT_STOP = colors.brown

ROPE_DIRECTION = colors.magenta

Y_SHAFT_AT_END = colors.red

-- Global Position variables
X_LENGTH = 7
Y_LENGTH = 7
GLOBAL_X = 0

-- helper functions

function get(in_color)
    return (colors.test (redstone.getBundledInput(BUNDLE_SIDE), in_color))
end

function set(in_color)
    return redstone.setBundledOutput(BUNDLE_SIDE, in_color)
end

-- X Controls

function incrementX()
    set(GLOBAL_SHAFT_DIRECTION)
    sleep(SLEEP_UNIT)
    set(X_SHAFT_STOP)
    GLOBAL_X = GLOBAL_X + 1
end

function decrementX()
    set(0)
    sleep(SLEEP_UNIT)
    set(X_SHAFT_STOP)
    GLOBAL_X = GLOBAL_X - 1
end

-- Y Controls

function incrementY()
    set(X_SHAFT_STOP + GLOBAL_SHAFT_DIRECTION)
    while (not get(Y_SHAFT_AT_END)) do
        sleep(SLEEP_UNIT)
    end
end

function decrementY()
    set(X_SHAFT_STOP)
    while get(Y_SHAFT_AT_END) do
        sleep(SLEEP_UNIT)
    end
end

function rollY()
    if get(Y_SHAFT_AT_END) then
        print("rolling is decrementing")
        decrementY()
    else
        print("rolling is incrementing")
        incrementY()
    end
end

-- Calibration
function reset()
    print("Waiting for Y to reach start")
    decrementY()
    set(0)
    -- Extra long sleep just in case
    print("Waiting for X to reach start")
    sleep(SLEEP_UNIT * X_LENGTH * 2)
end

function main()
    reset()

    print("Starting mainloop")
    rollY()
    for i=1,X_LENGTH do
        incrementX()
        rollY()
    end
    print("Finished mainloop")

    reset()
end

main()