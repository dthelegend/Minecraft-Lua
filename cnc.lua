-- Global Constants
BUNDLE_SIDE = "right"
SLEEP_UNIT = 1

-- Bundle color definitions
X_SHAFT_DIRECTION = colors.cyan
X_SHAFT_STOP = colors.yellow

Y_SHAFT_AT_END0 = colors.red
Y_SHAFT_AT_END1 = colors.blue
Y_SHAFT_DIRECTION = colors.green
Y_SHAFT_STOP = colors.magenta

ROPE_DIRECTION = colors.brown

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
    set(X_SHAFT_DIRECTION)
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
    set(X_SHAFT_STOP + Y_SHAFT_DIRECTION)
    while (not get(Y_SHAFT_AT_END1)) do
        sleep(SLEEP_UNIT)
    end
end

function decrementY()
    set(X_SHAFT_STOP)
    while (not get(Y_SHAFT_AT_END0)) do
        sleep(SLEEP_UNIT)
    end
end

function rollY()
    if get(Y_SHAFT_AT_END0) then
        incrementY()
    else
        decrementY()
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