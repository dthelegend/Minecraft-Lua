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

function rollY()
    if get(Y_SHAFT_AT_END1) then
        decrementY()
    else
        incrementY()
    end
end

function incrementY()
    set(X_SHAFT_STOP + Y_SHAFT_DIRECTION)
    while (not get(Y_SHAFT_AT_END1)) do
        -- Nothing lol
    end
end

function decrementY()
    set(X_SHAFT_STOP)
    while (not get(Y_SHAFT_AT_END0)) do
        -- Nothing lol
    end
end

function main()
    set(0)
    for i=0,7 do
        incrementX()
        rollY()
    end
    for i=0,7 do
        decrementX()
        rollY()
    end

    if GLOBAL_X == 0 then
        print("Success!")
    else
        print("Fail!")
    end
    set(0)
end

main()