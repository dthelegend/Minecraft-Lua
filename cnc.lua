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
    return redstone.getBundledOutput(BUNDLE_SIDE, in_color)
end

-- X Controls

function incrementX()
    set(X_SHAFT_DIRECTION)
    sleep(SLEEP_UNIT)
    set(X_SHAFT_STOP)
    X += 1
end

function decrementX()
    set(0)
    sleep(SLEEP_UNIT)
    set(X_SHAFT_STOP)
    X -= 1
end

function main()
    for i=0,8 do
        incrementX()
    end
    for i=8,0 do
        decrementX()
    end

    if X == 0 then
        print("Success!")
    else
        print("Fail!")
    end
end
