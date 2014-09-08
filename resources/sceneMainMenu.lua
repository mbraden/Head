
local scene = director:createScene()
local btnPlayGame
local btnExit



function playGame(event)
  
  
  if (event.phase == "ended") then      
      switchToScene("sceneGame")
      
  end
    
end



function exitApp(event)  
  if (event.phase == "ended") then
      
      system:quit()
    
  end
   
end




function scene:setUp(event)
    
    self.label = director:createLabel(0, 0, "Scene Main Menu")
    
    --PLAY GAME BUTTON
    btnPlayGame = director:createLabel( { x = 50, y = 100, text="Play Game!", name="PLAYGAME" })    
    btnPlayGame:addEventListener("touch", playGame)    
    
    
    --EXIT BUTTON
    btnExit = director:createLabel ({ x = 50, y = 150, text="Exit" })    
    btnExit:addEventListener("touch", exitApp)
    
    
end

function scene:tearDown(event)    
    self.label = self.label:removeFromParent() -- remove from the scene graph, and set self.label to nil
    
    
end

scene:addEventListener({"setUp", "tearDown"}, scene)











return scene
