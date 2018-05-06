-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

local background = display.newImageRect("background.png",360,570)

background.x = display.contentCenterX
background.y = display.contentCenterY

local tapCount = 0

local tapText = display.newText( tapCount,
    display.contentCenterX, 20, native.systemFont, 40)
    tapText:setFillColor( 0, 0, 0)


local ball = display.newImageRect("ball.png",100,100)

local platform = display.newImageRect("platform.png",300,50)

platform.x = display.contentCenterX
platform.y = display.contentHeight + 25

platform.surfaceType = "superbounce"

ball.x = display.contentCenterX
ball.y = 0

local physics = require("physics")
physics.start()

physics.addBody(ball, "dynamic", {radius = 50, bounce = 0.3})

physics.addBody(platform, "static")



local function pushBall()
    ball:applyLinearImpulse(0, -0.75, ball.x, ball.y)
    tapCount = tapCount +1
    tapText.text = tapCount
end

local function restart()

end

ball:addEventListener("tap",pushBall)

local function onCollision( self, event )

    local collideObject = event.other
    if ( collideObject.surfaceType == "superbounce" ) then
        tapCount = 0
        tapText.text = tapCount
    end
end

ball.collision = onCollision
ball:addEventListener( "collision" )