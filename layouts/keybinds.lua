require("keybow")

-- [[
-- This keybind file rotates the classic layout of the keybow counter-clockwise by 90 degrees.
-- Essentially, the GPIO is now on the bottom of the keybow (in my case this is to make the cable come out of the "top" rather than side)
--
-- CLASSIC SETUP:
-- G  |  9  |  10 |  11 |
-- P  |  6  |  7  |  8  |
-- I  |  3  |  4  |  5  |
-- O  |  0  |  1  |  2  |
--
-- MY SETUP:
-- |  11  |  8  |  5  |  2  |
-- |  10  |  7  |  4  |  1  |
-- |  9   |  6  |  3  |  0  |
--    G      P     I     O
-- ]]

active = {}

function setup()
    keybow.auto_lights(false)
    keybow.clear_lights()
end

-- Blink key  --
function blink(key_index)
    local blink_times = 6

    for i = 1, blink_times do
        keybow.set_pixel(key_index - 1, 255, 165, 0) -- Orange on
        keybow.sleep(250)
        keybow.set_pixel(key_index - 1, 0, 0, 0)     -- Off
        keybow.sleep(250)
    end
end

-- This code lets me press multiple keys at once (use a keyboard shortcut)
-- https://gist.github.com/capjamesg/e7f27684170b9a4ed19bc0e3aa9141b2
function modifier(key, ...)
    for i = 1, select("#", ...) do
        local j = select(i, ...)
        keybow.set_modifier(j, keybow.KEY_DOWN)
    end
    keybow.tap_key(key)
    for i = 1, select("#", ...) do
        local j = select(i, ...)
        keybow.set_modifier(j, keybow.KEY_UP)
    end
end

-- Helper function to handle key toggles --
function toggle_active(key_index, pressed, modifier_func)
    local _active = active[key_index]

    if _active then
        keybow.set_pixel(key_index - 1, 255, 0, 0) -- Red
    else
        keybow.set_pixel(key_index - 1, 0, 255, 0) -- Green
    end

    if pressed then
        modifier_func()
        active[key_index] = not _active
    end
end

-- Key Mappings

-- X X X X
-- X X X X
-- X X X O
-- Delete Key --
function handle_key_00(pressed)
    if pressed then
        toggle_active(1, pressed, function()
            modifier("m", keybow.LEFT_CTRL, keybow.LEFT_SHIFT)
        end)
    end
end

-- X X X X
-- X X X O
-- X X X X
-- Asterisk Key --
function handle_key_01(pressed) if pressed then blink(2) end end

-- X X X O
-- X X X X
-- X X X X
-- Blank Key -- Discord Mute Sound
function handle_key_02(pressed)
    if pressed then
        toggle_active(3, pressed, function()
            modifier("d", keybow.LEFT_CTRL, keybow.LEFT_SHIFT)
        end)
    end
end

-- X X X X
-- X X X X
-- X X O X
-- 3 Key --
function handle_key_03(pressed) if pressed then blink(4) end end

-- X X X X
-- X X O X
-- X X X X
-- 6 Key --
function handle_key_04(pressed) if pressed then blink(5) end end

-- X X O X
-- X X X X
-- X X X X
-- 9 Key --
function handle_key_05(pressed) if pressed then blink(6) end end

-- X X X X
-- X X X X
-- X O X X
-- 2 Key --
function handle_key_06(pressed) if pressed then blink(7) end end

-- X X X X
-- X O X X
-- X X X X
-- 5 Key --
function handle_key_07(pressed) if pressed then blink(8) end end

-- X O X X
-- X X X X
-- X X X X
-- 8 Key --
function handle_key_08(pressed) if pressed then blink(9) end end

-- X X X X
-- X X X X
-- O X X X
-- 1 Key --
function handle_key_09(pressed) if pressed then blink(10) end end

-- X X X X
-- O X X X
-- X X X X
-- 4 Key --
function handle_key_10(pressed) if pressed then blink(11) end end

-- O X X X
-- X X X X
-- X X X X
-- 7 Key --
function handle_key_11(pressed) if pressed then blink(12) end end
