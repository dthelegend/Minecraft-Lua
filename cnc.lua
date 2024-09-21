-- Global Constants
BUNDLE_SIDE = "right"
SLEEP_UNIT = 1

-- Bundle color definitions
GLOBAL_SHAFT_DIRECTION = colors.cyan -- Increasing when active

X_SHAFT_STOP = colors.yellow
Y_SHAFT_STOP = colors.brown

ROPE_DIRECTION = colors.magenta

Y_SHAFT_AT_END = colors.red
OBSERVER_ACTIVATE = colors.blue

-- Global Position variables
X_LENGTH = 7
MAX_DEPTH = 5
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
    sleep(SLEEP_UNIT)
    set(X_SHAFT_STOP + GLOBAL_SHAFT_DIRECTION + OBSERVER_ACTIVATE)
    while (not get(Y_SHAFT_AT_END)) do
        sleep(SLEEP_UNIT)
    end
    set(X_SHAFT_STOP + GLOBAL_SHAFT_DIRECTION)
end

function decrementY()
    set(X_SHAFT_STOP)
    sleep(SLEEP_UNIT)
    set(X_SHAFT_STOP + OBSERVER_ACTIVATE)
    while get(Y_SHAFT_AT_END) do
        sleep(SLEEP_UNIT)
    end
    set(X_SHAFT_STOP)
    sleep(SLEEP_UNIT)
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

-- Rope controls
function pullRopeAllTheWayUp()
    initial_direction = get(Y_SHAFT_AT_END)
    set(X_SHAFT_STOP + Y_SHAFT_STOP + GLOBAL_SHAFT_DIRECTION)
    sleep(SLEEP_UNIT * 10)
    if initial_direction then
        set(X_SHAFT_STOP + GLOBAL_SHAFT_DIRECTION)
    else
        set(X_SHAFT_STOP)
    end
end

function ropeDown()
    initial_direction = get(Y_SHAFT_AT_END)
    set(X_SHAFT_STOP + Y_SHAFT_STOP)
    sleep(SLEEP_UNIT)
    if initial_direction then
        set(X_SHAFT_STOP + GLOBAL_SHAFT_DIRECTION)
    else
        set(X_SHAFT_STOP)
    end
end

-- Calibration
function reset()
    print("Pulling rope out")
    pullRopeAllTheWayUp()
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
    for i=0,(MAX_DEPTH / 2) do
        rollY()
        for i=1,X_LENGTH do
            incrementX()
            rollY()
        end
        ropeDown()
        rollY()
        for i=1,X_LENGTH do
            decrementX()
            rollY()
        end
        ropeDown()
    end
    print("Finished mainloop")

    reset()
end

main()