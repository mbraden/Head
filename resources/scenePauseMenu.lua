
--CREATE PAUSE SCENE
local scenePauseMenu = director:createScene()

function scenePauseMenu:setUp(event)
    dbg.print("scene2:setUp")
    self.label = director:createLabel(0, 0, "Scene 2")
end

function scenePauseMenu:tearDown(event)
    dbg.print("scene2:tearDown")
    self.label = self.label:removeFromParent() -- remove from the scene graph, and set self.label to nil
end

scenePauseMenu:addEventListener({"setUp", "tearDown"}, scenePauseMenu)


function continueGame()
  switchToScene("sceneMainMenu")  
end


-- Create Continue Game button
continueGameButton = director:createSprite(director.displayCenterX, director.displayCenterY + 100, "textures/button_bg.png")

local atlas = continueGameButton:getAtlas()
local atlas_w, atlas_h = atlas:getTextureSize()

continueGameButton.xAnchor = 0.5
continueGameButton.yAnchor = 0.5
continueGameButton.xScale = 0.5
continueGameButton.yScale = 0.5

continueGameButton:addEventListener("touch", continueGame)


-- Create Continue Game button text
local label = director:createLabel( {
    x = 0, y = 0,
    w = atlas_w, h = atlas_h,
    hAlignment="centre", vAlignment="middle",
    textXScale = 2, textYScale = 2,
    text="Continue"
})
continueGameButton:addChild(label)



