-- Your app starts here!
print("This is my app!")

local sceneMainMenu = dofile("sceneMainMenu.lua")
local sceneGame = dofile("sceneGame.lua")

controlBorderHeight = 200




function switchToScene(scene_name)
  print("In SwitchToScene")
    if (scene_name == "sceneGame") then
        director:moveToScene(sceneGame, {transitionType="slideInR", transitionTime=0.5})
    elseif (scene_name == "sceneMainMenu") then
        director:moveToScene(sceneMainMenu, {transitionType="slideInL", transitionTime=0.5})    
    end
end




--OPEN THE MAIN MENU
director:setCurrentScene(nil)
director:moveToScene(sceneMainMenu)





