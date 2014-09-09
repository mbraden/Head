
local scene = director:createScene()

local spriteMainMenu
local wall1
local gem2
local enemy1
local btnMainMenu
local touchedPoint
local playerMoving
local moveToX
local moveToY
local hammer1

physics.debugDraw=true

--GO TO MAIN MENU
function goMainMenu(event)
  if (event.phase == "ended") then
      switchToScene("sceneMainMenu")
  end   
end

--SCREEN TOUCHED
local function screenTouched(event)    
   
    if (event.phase == "ended" ) then
      
      if (event.y > controlBorderHeight) then
      
            --GET END SPOT (TOUCHED SPOT)
            moveToX = event.x
            moveToY = event.y            
            
            --GET START SPOT (CURRENT SPOT)
            startx = gem2.x
            starty = gem2.y
            
            --SET VELOCITIES
            vx = moveToX - startx
            vy = moveToY - starty
            
            
            --SET DESTINATION PIOINT POSITION
            --touchedPoint.physics:setTransform(endx, endy, 1)
            --touchedPoint:addEventListener("collision", collisionOccured)
            
            
            --MOVE PLAYER              
            gem2.physics:setLinearVelocity(vx, vy)
            playerMoving = true
            
      --else
        --print("TOO LOW")
            
      end
      
    end
  
  
  
end



--UPDATE EVERYTHING
function updateEverything()
  
    if (playerMoving == true) then
                  
      --  DISTANCE FORMULA
      x1 = gem2.x
      y1 = gem2.y
      x2 = moveToX
      y2 = moveToY
      
      x3 = (x2 - x1)
      x3 = x3 * x3
      y3 = (y2 - y1)
      y3 = y3 * y3
      z = x3 + y3
      
      --DISTANCE
      d = math.sqrt(z)
                 
      
      --CHECK IF PLAYER HAS REACHED TOUCHED POINT. IF SO, STOP HIM
      if (d <20) then
        gem2.physics:setLinearVelocity(0, 0)
          playerMoving = false
      end                   
      
    end    
  
end




--COLLISION OCCURED
function collisionOccured(event)  
    if (event.phase == "ended") then
        if (event.nodeA.name == "PLAYER" and event.nodeB.name == "ENEMY1") or (event.nodeB.name == "PLAYER" and event.nodeA.name == "ENEMY1")then      
            gem2.physics:setLinearVelocity(0, 0)
            enemy1.physics:setLinearVelocity(0, 0)
        end
    end
end




--PLAYER TOUCHED
function playerTouched(event)
  if (event.phase == "ended") then
      
      print("PLAYER TOUCHED")
      
      
      --PLAY THE ANIMATION
      i = gem2:play() 
      
      --ROTATE TOO
      --wheel1.physics:setTransform(wheel1.x, wheel1.y, wheel1.rotation + 45)
      
      
      
  end   
end





--SETUP SCENE
function scene:setUp(event)
    
    system:setFrameRateLimit(30)
    
    
    physics:setGravity(0, 0)
    
    
    self.label = director:createLabel(0, 0, "Scene Game")
    
    
    
    --CREATE PLAYER    
    theAtlas = director:createAtlas(  { width=85, height=85, numFrames=15, textureName="textures/sparkle_tomato.png"  }  )
    theAnim = director:createAnimation({start = 1, count = 15, atlas = theAtlas, delay=1/8})        
    gem2 = director:createSprite( {x = 70, y = 240, 
                                    xAnchor = .5, yAnchor = .5, 
                                    source = theAnim, name = "PLAYER" } )   
    
       
    
    
    hammer1 = director:createSprite({ x = -160, y = 0, xAnchor = .5, yAnchor = .5, source = "textures/h1.png", xScale = 3, yScale = 3 } )
    
    gem2:addChild(hammer1)
    
    
    
    physics:addNode(gem2, {radius = 40, density=0} )
    physics:addNode(hammer1)
    playerMoving = false
    gem2:addEventListener("collision", collisionOccured)
    gem2:addEventListener("touch", playerTouched)
    
    
    --PAUSE THE ANIMATION
    i = gem2:pause()    
    
    
    
    
    --CREATE ENEMY1
    enemy1 = director:createSprite({x = 300, y = 700, xAnchor = .5, yAnchor = .5, name = "ENEMY1", source = "textures/gem1.png"  }  )
    physics:addNode(enemy1, {radius = 40, density=0} )
    
    
     
    
    
    
    --CREATE EXIT BUTTON
    btnExit = director:createLabel ({ x = 100, y = 10, text="Main Menu" })    
    btnExit:addEventListener("touch", goMainMenu)
    
    
    
    
    --CREATE RED WALL
    wall1 = director:createSprite(50, 380, "textures/redwall.png")
    
    
    
    ----physics:addNode(redwall, {type="static"})
    ----physics:addNode(touchedPoint, {radius = 1, isSensor = true, name = "touchedpoint"} )
    
    
       
    
    
end

--TEAR DOWN SCENE
function scene:tearDown(event)    
    self.label = self.label:removeFromParent() -- remove from the scene graph, and set self.label to nil
end



--SYSTEM EVENT LISTENERS
scene:addEventListener({"setUp", "tearDown"}, scene)
system:addEventListener("touch", screenTouched)
system:addEventListener("update", updateEverything)


return scene

