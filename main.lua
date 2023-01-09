--[[
    Todo:
    - Sounds
    - remove debugtext

    

]]

opal = require("opal")
json = require("json")


local t, shakeDuration, shakeMagnitude = 0, -1, 0

function startShake(duration, magnitude)
    t, shakeDuration, shakeMagnitude = 0, duration or 1, magnitude or 5
end

function love.load()
    
    math.randomseed(os.time())

    animateSimList = {}
    textList = {}

-- music
    
    
    overmusicplaying = "true"
    bgm1List = {}
    bgmovList = {}

    opal.playMusic("music/time.mp3",bgm1List,0.5)


-- sound effects
    shootsoundList = {}
    bitesoundList = {}
    killsoundList = {}
    bossspawnsoundList = {}
    bosshurtsoundList = {}
    bossdeathsoundList = {}
    itempicksoundList = {}
    healsoundList = {}
    gethitsoundList = {}
    pbreaksoundList = {}
    legobreakList = {}
    chainssoundList = {}


    hacktimer = 1


    


-- Player Health

    phframesList = {}
    for index = 1,4,1 do
        framesnum = index
        phframesList[framesnum] = love.graphics.newImage("Health/f"..framesnum..".png")
    end

    phanimateList = {}
    for index = 1,4,1 do
        phanimate = index
        phanimateList[phanimate] = phframesList[index]
    end




-- gameover load
    ovframesList = {}
    for index = 1,33,1 do
        framesnum = index
        ovframesList[framesnum] = love.graphics.newImage("Over/f"..framesnum..".png")
    end

    ovanimateList = {}
    for index = 1,33,1 do
        ovanimate = index
        ovanimateList[ovanimate] = ovframesList[index]
    end



-- boss health bar
    bhframesList = {}
    for index = 1,30,1 do
        framesnum = index
        bhframesList[framesnum] = love.graphics.newImage("B_H/f"..framesnum..".png")
    end

    bhanimateList = {}
    for index = 1,30,1 do
        bhanimate = index
        bhanimateList[bhanimate] = bhframesList[index]
    end


--skull animations

    sframesList = {}
    for index = 1,34,1 do
        framesnum = index
        sframesList[framesnum] = love.graphics.newImage("Skull/s"..framesnum..".png")
    end

    sanimateList = {}
    for index = 1,34,1 do
        sanimate = index
        sanimateList[sanimate] = sframesList[index]
    end



-- Ammo bar
    aframesList = {}
    for index = 1,9,1 do
        framesnum = index
        aframesList[framesnum] = love.graphics.newImage("Ammo/s"..framesnum..".png")
    end

    aanimateList = {}
    for index = 1,9,1 do
        aanimate = index
        aanimateList[aanimate] = aframesList[index]
    end



-- player animation
    pframesList = {}
    for index = 1,12,1 do
        framesnum = index
        pframesList[framesnum] = love.graphics.newImage("Vampire/V"..framesnum..".png")
    end

    panimateList = {}
    for index = 1, 12,1 do
        panimate = index
        panimateList[panimate] = pframesList[index]
    end


-- player death animation
    pdfframesList = {}
    for index = 1,9,1 do
        framesnum = index
        pdfframesList[framesnum] = love.graphics.newImage("Vampire/df/vdf"..framesnum..".png")
    end

    pdfanimateList = {}
    for index = 1, 9,1 do
        pdfanimate = index
        pdfanimateList[pdfanimate] = pdfframesList[index]
    end

-- Boss animation

    bossframesList = {}
    for index = 1,12,1 do
        framesnum = index
        bossframesList[framesnum] = love.graphics.newImage("Skeleton/f"..framesnum..".png")
    end


    bossanimateList = {}
    for index = 1, 12,1 do
        banimate = index
        bossanimateList[banimate] = bossframesList[index]
    end

    -- objects

   


    smokeList = {}
    introBg = opal.newObject("Lair.png",1,500,300)
    P = opal.newObject("Vampire/V1.png",1,150,300)
    P.currentFrame = 1
    P.health = 3

    healthbar = opal.newObject("Health/f1.png",0.5,120,580)
    healthbar.currentFrame = 1

    ammoCount = opal.newObject("Ammo/s1.png",1,28,540)
    ammoCount.currentFrame = 1

    P_df = opal.newObject("Vampire/df/vdf1.png",1,1200,0)
    P_df.currentFrame = 1
    P_df.alpha = 0

    E_1 = opal.newObject("Skeleton/f1.png",1,1120,300)
    E_1.speed = 2
    E_1.currentFrame = 1

    B_hb = opal.newObject("B_H/f1.png",1,500,630)
    B_hb.currentFrame = 1

    overScreen = opal.newObject("Over/f1.png",1,500,300)
    overScreen.currentFrame = 1
    overScreen.alpha = 0

    overScreen2 = opal.newObject("Over/f1.png",1,500,300)
    overScreen2.alpha = 0


    bg = opal.newObject("bg.png",1,500,300)
    bg2 = opal.newObject("bg2.png",1,-500,300)
    fg = opal.newObject("fg.png",1,500,300)
    fg2 = opal.newObject("fg2.png",1,-500,300)
    fgg = opal.newObject("fgg.png",1,500,300)
    

    --powerup img

    -- infinity
    p_inf = opal.newObject("inf.png",0.7,85,540)
    p_inf.alpha = 0


    -- fangs
    biteframesList = {}
    for index = 1,22,1 do
        framesnum = index
        biteframesList[framesnum] = love.graphics.newImage("Bite/f"..framesnum..".png")
    end

    biteanimateList = {}
    for index = 1,22,1 do
        biteanimate = index
        biteanimateList[biteanimate] = biteframesList[index]
    end

    p_bite = opal.newObject("Bite/f1.png",1,500,300)
    p_bite.currentFrame = 1

    p_biteicon = opal.newObject("fang.png",0.7,140,540)
    p_biteicon.alpha = 0
    p_bitetext = opal.newTextObject("Bite Ready! (press E to use)","Zombie Monster.ttf",20,130,500)
    p_bitetext.alpha = 0



    --powerup var
    pv_inf = "false"
    inftimer = 300

    pv_bite = "false"
    bitetimer = 2
    pv_biteclearall = "false"



    --powerup list
    infList = {}
    heartList = {}
    biteList = {}



    --Texts

    font = love.graphics.newFont("Zombie Monster.ttf", 25)
    startfont = love.graphics.newFont("Zombie Monster.ttf", 200)
    love.graphics.setFont(love.graphics.newFont("Zombie Monster.ttf", 20))
    introTextList = {}
    currentText = 6
    introTextList.x = 400
    introTextList[1] = "Once upon a time..."
    introTextList[2] = "In a castle far, far away."
    introTextList[3] = "A sleepy vampire is facing a problem..."
    introTextList[4] = "The ghost of halloween is here... "
    introTextList[5] = "to collect his candy!!!"
    introTextList[6] = " "

    startTextList = {}
    currentStartText = 1
    startTextList.x = 450
    startTextList[1] = "3"
    startTextList[2] = "2"
    startTextList[3] = "1"
    startTextList[4] = "GO!!"
    startTextList[5] = ""


    --score
    scoreTextList = {}
    score = 0
    highscore = 0

    opal.loadData()
    


    -- variables
    
    saveScore = 0
    bosshit = "false"
    overheat = "false"
    bossInPosition = "false"
    fliptimer = 30
    flipvar = 0
    deathAnimationTimer = 220
    deathanimationtrigger = "false"
    frameTime = 1
    bg_moving = "true"
    E_moving = "false"
    playable = "true"
    gameStart = "false"
    Shootdirection = 0
    x = 1
    y = 1
    gameOver = "false"
    P_moving = "true"
    P_animating = "true"
    E_animating = "false"
    E_direction = math.random(1,8)
    holdspace = "false"

    --timer
    overtimer = 10
    ohTimer = 30
    Mtimer = 20
    patimer = 60
    timer = 120
    timer2 = 60
    timer3 = 30
    textTimer = 180
    startTimer = 210
    pumpkinTimer = 60
    bossHP = 30
    bossHurtTimer = 15

    --lists
    skullList = {}
    pumpkinList = {}
    ghostList = {}
    sunList = {}
    juonList = {}
end



function love.update(dt)
    highscore = opal.dataObject.highscore
    -- healthbar.x = P.x - 20
    -- healthbar.y = P.y - 65
    -- ammoCount.x = P.x + 40
    -- ammoCount.y = P.y - 65


    if bosshit == "true" then
        
        if bossHurtTimer > 0 then
            bossHurtTimer = bossHurtTimer -1 
        end

        if bossHurtTimer <= 0 then
            bossHurtTimer = 15
            bosshit = "false"
        end
    end

    if bosshit == "true" then
        E_1.red = 100
        E_1.green = 0
        E_1.blue = 0
    else
        E_1.red = 1
        E_1.green = 1
        E_1.blue = 1
    end

    P_df.x = P.x
    P_df.y = P.y


    frameTime = frameTime + dt

    if frameTime < 1/60 then
        return
    else
        frameTime = dt
    end

    if t < shakeDuration then
        t = t + dt
    end

    

    if love.keyboard.isDown("u") then
        opal.deleteData()
    end

    if love.keyboard.isDown("i") then
        opal.saveData()
    end

    if love.keyboard.isDown("o") then
        opal.loadData()
    end

    if love.keyboard.isDown("escape") then
        opal.saveData()
        love.event.quit()
    end

    if gameStart == "false" then

        if currentText < #introTextList then
            if textTimer <= 180 and textTimer > 0 then
                textTimer = textTimer - 1
                --textList[currentText].alpha = textList[currentText].alpha - 0.005
            end

            if textTimer == 0 then
                currentText = currentText + 1

                if currentText == 2 then
                    introTextList.x = 350
                end

                if currentText == 3 then
                    introTextList.x = 320
                end

                if currentText == 4 then
                    introTextList.x = 330
                end

                if currentText == 5 then
                    introTextList.x = 380
                end

                textTimer = 180

            end
        else
            gameStart = "true"
            textTime = -5
        end
        

        
        
    else

        --player movement
        if P_moving == "true" then
            if love.keyboard.isDown("w") then
                P.y = P.y - 3
            end

            if love.keyboard.isDown("a") then
                P.x = P.x - 3
                P.xscale = -1
                P_df.xscale = -1
            end

            if love.keyboard.isDown("s") then
                P.y = P.y + 3
            end

            if love.keyboard.isDown("d") then
                P.x = P.x + 3
                P.xscale = 1
                P_df.xscale = 1
                
            end


            if P.x <= 30 then
                P.x = 30
            end

            if P.y <= 30 then
                P.y = 30
            end

            if P.y >= 570 then
                P.y = 570
            end
        end

        --Player Health
        if P.health == 0 then
            gameOver = "true"
        end

        if P.health == 3 then
            healthbar.currentFrame = 1
        elseif P.health == 2 then
            healthbar.currentFrame = 2
        elseif P.health == 1 then
            healthbar.currentFrame = 3
        elseif P.health == 0 then
            healthbar.currentFrame = 4
        end
        


        -- Player animation
    
        if P_animating == "true"  then


            if patimer <= 60 and patimer > 0 then
                patimer = patimer - 1
            end

            if patimer == 0 then
                patimer = 60
            end

            if patimer == 60 then
                P.currentFrame = 1
            elseif patimer == 55 then
                P.currentFrame = 2
            elseif patimer == 50 then
                P.currentFrame = 3
            elseif patimer == 45 then
                P.currentFrame = 4
            elseif patimer == 40 then
                P.currentFrame = 5
            elseif patimer == 35 then
                P.currentFrame = 6
            elseif patimer == 30 then
                P.currentFrame = 7
            elseif patimer == 25 then
                P.currentFrame = 8
            elseif patimer == 20 then
                P.currentFrame = 9
            elseif patimer == 15 then
                P.currentFrame = 10
            elseif patimer == 10 then
                P.currentFrame = 11
            elseif patimer == 5 then
                P.currentFrame = 12
            end 

        
        end





        if playable == "true" then
        
        end


-- boss animation
    -- timer
        if timer <= 120 and timer > 0 then
            timer = timer - 1
        end

        if timer == 0 then
            timer = 120
        end



        if E_animating == "true"  then
                    
            if timer2 <= 60 and timer2 > 0 then
                timer2 = timer2 - 1
            end

            if timer2 == 0 then
                timer2 = 60
            end



            

            if timer2 == 60 then
                E_1.currentFrame = 1
            elseif timer2 == 55 then
                E_1.currentFrame = 2
            elseif timer2 == 50 then
                E_1.currentFrame = 3
            elseif timer2 == 45 then
                E_1.currentFrame = 4
            elseif timer2 == 40 then
                E_1.currentFrame = 5
            elseif timer2 == 35 then
                E_1.currentFrame = 6
            elseif timer2 == 30 then
                E_1.currentFrame = 7
            elseif timer2 == 25 then
                E_1.currentFrame = 8
            elseif timer2 == 20 then
                E_1.currentFrame = 9
            elseif timer2 == 15 then
                E_1.currentFrame = 10
            elseif timer2 == 10 then
                E_1.currentFrame = 11
            elseif timer2 == 5 then
                E_1.currentFrame = 12
            end 

            if timer2 == 60 then
                if startTimer == 0 then
                    if bossInPosition == "true" then
                        --34 frames
                        skull = opal.newObject("Skull/s1.png", 1, E_1.x - 100 ,E_1.y - 32)
                        skull.xscale = -1
                        skull.speed = 5
                        skull.currentFrame = 1
                        skullList[#skullList + 1] = skull

                        
                    end
                    
                end
            end

        end




        -- Boss Movement

        --boss appearing
        
        if ((score == 12 and bossInPosition == "false") or (score > (saveScore + 25))) and bossInPosition == "false" then
            opal.playSound("sfx/boss spawn.mp3",bossspawnsoundList)
            bossInPosition = "moving"
            if bossHP == 0 then
                bossHP = 30
                B_hb.currentFrame = 1
            end
        end

        if bossInPosition == "moving" then

            
            if B_hb.y > 570 then
                B_hb.y = B_hb.y - 0.5
            end

            E_1.x = E_1.x - 1
            if E_1.x == 800 then
                E_moving = "true"
                E_animating = "true"
                bossInPosition = "true"
            end
        end

        if bossInPosition == "false" then
            E_1.x = 1120
            E_1.y = 300
        end




        if E_moving == "true" then

            if timer == 120 then
                if math.random(1,8) == 1 then
                    E_direction = 1
                elseif math.random(1,8) == 2 then
                    E_direction = 2
                elseif math.random(1,8) == 3 then
                    E_direction = 3
                elseif math.random(1,8) == 4 then
                    E_direction = 4
                elseif math.random(1,8) == 5 then
                    E_direction = 5
                elseif math.random(1,8) == 6 then
                    E_direction = 6
                elseif math.random(1,8) == 7 then
                    E_direction = 7
                elseif math.random(1,8) == 8 then
                    E_direction = 8
                end
            end

            if E_direction == 1 then
                E_1.y = E_1.y - 1 * E_1.speed
            elseif E_direction == 2 then
                E_1.y = E_1.y - 1 * E_1.speed
                E_1.x = E_1.x + 1 * E_1.speed
            elseif E_direction == 3 then
                E_1.x = E_1.x + 1 * E_1.speed
            elseif E_direction == 4 then
                E_1.y = E_1.y + 1 * E_1.speed
                E_1.x = E_1.x + 1 * E_1.speed
            elseif E_direction == 5 then
                E_1.y = E_1.y + 1 * E_1.speed
            elseif E_direction == 6 then
                E_1.y = E_1.y + 1 * E_1.speed
                E_1.x = E_1.x - 1 * E_1.speed
            elseif E_direction == 7 then
                E_1.x = E_1.x - 1 * E_1.speed
            elseif E_direction == 8 then
                E_1.y = E_1.y - 1 * E_1.speed
                E_1.x = E_1.x - 1 * E_1.speed
            end
        end
        

            --Skel Borders

        if E_1.x + 130 > 1020 then
            E_direction = math.random(5,8)
        end

        if E_1.x - 130 < 520 then
            E_direction = math.random(1,5)
        end

        if E_1.y -130 < 0 then
            E_direction = math.random(3,7)
        end

        if E_1.y + 130 > 600 then
            local temp = math.random(1,5)
            if temp == 1 then
                E_direction = 1
            elseif temp == 2 then
                E_direction = 2
            elseif temp == 3 then
                E_direction = 3
            elseif temp == 4 then
                E_direction = 7
            elseif temp == 5 then
                E_direction = 8
            end
        end

        --intro set
        introBg.alpha = 0


        if currentStartText < #startTextList then
            if startTimer <= 210 and startTimer > 0 then
                startTimer = startTimer - 1
            end

            if startTimer == 150 or startTimer == 90 or startTimer == 30 or startTimer == 0 then
                currentStartText = currentStartText+1
                if currentStartText == 4 then
                    startTextList.x = 350
                else
                    startTextList.x = 450
                end
            end

        end

        

        if startTimer == 0 then
                -- background
                if bg_moving == "true" then
                    bg.x = bg.x + 2
                    fgg.x = fgg.x + 2
                    fg.x = fg.x + 1
                    fg2.x = fg2.x + 1
                    bg2.x = bg2.x + 2

                    if bg.x >= 1500 then
                        bg.x = -500
                    end

                    if fgg.x >= 1500 then
                        fgg.x = -500
                    end
        
        
                    if bg2.x >= 1500 then
                        bg2.x = -500
                    end

                    if fg.x >= 1500 then
                        fg.x = -500
                    end
        
                    if fg2.x >= 1500 then
                        fg2.x = -500
                    end
                end
            
                
            




            -- pumpkin enemy
                --if E_animating == "false" then

                    if pumpkinTimer <= 60 and pumpkinTimer > 0 then
                        pumpkinTimer = pumpkinTimer - 1
                    end
        
                    if pumpkinTimer == 0 then
                        pumpkinTimer = 60
                    end
        
                    if pumpkinTimer == 60 then
                        pumpkin = opal.newObject("E_Pump.png", 1, 1020 ,(math.random(-1.5,1.5) * 50) + P.y)
                        pumpkin.xscale = -1
                        pumpkin.speed = 3
                        pumpkinList[#pumpkinList+1] = pumpkin
                    end
        
                --end
    
                for index = #pumpkinList, 1, -1 do
                    pumpkin = pumpkinList[index]
                    pumpkin.x = pumpkin.x - (1 * pumpkin.speed)
                    
    
    
                    if opal.checkCollision(pumpkin,P) == true then
                        opal.playSound("sfx/get hit.mp3",gethitsoundList)
                        table.remove(pumpkinList,index)
                        P.health = P.health - 1
                        startShake(0.2,1)
                        
                    end
    
                
    
                    if pumpkin.x <= 0 or pv_biteclearall == "true" then
                        table.remove(pumpkinList,index)
                    end
                    
                end
    
    
            -- ghost enemy
                if timer3 <= 90 and timer3 > 0 then
                    timer3 = timer3 - 1
                end
    
                if timer3 == 0 then
                    timer3 = 90
                end
    
    
                if timer3 == 90 then
                    
                    ghost = opal.newObject("E_ghost.png", 1, 1000,math.random(100,500))
                    ghost.xscale = -1
                    ghostList[#ghostList+1] = ghost
                    
                end
    
                for index = #ghostList,1,-1 do
                    ghost = ghostList[index]
                    if x > 25 then
                        x = 0
                    end
                    x = x + 0.05
                    y =  math.sin(x) * math.random(5,8)
                    ghost.x = ghost.x - 4
                    ghost.y = ghost.y + y

                    if opal.checkCollision(ghost,P) == true then
                        opal.playSound("sfx/get hit.mp3",gethitsoundList)
                        table.remove(ghostList,index)
                        P.health = P.health - 1
                        startShake(0.2,1)
                    end
    
    
                end

            --Skull enemy

                for index = #skullList,1,-1 do
                    skull = skullList[index]

                    skull.x = skull.x - skull.speed
                    if skull.currentFrame < 32 then
                        skull.currentFrame = skull.currentFrame + 1
                    else
                        skull.currentFrame = 1
                    end
                    
                    if opal.checkCollision(skull,P) == true then
                        opal.playSound("sfx/get hit.mp3",gethitsoundList)
                        table.remove(skullList,index)
                        P.health = P.health - 1
                        startShake(0.2,1)
                    end
    
                    if skull.x < 0 then
                        table.remove(skullList,index)
                    end


                    

                end
                
    
                
    
            -- juon enemy
    
                for index = #juonList, 1, -1 do
                    juon = juonList[index]
    
                

                    
                    dist_at_click2 = (P.x - juon.x)^2 + (P.y - juon.y)^2
                    if dist_at_click2 == 0 then
                        juon.vx, juon.vy = 0, 0
                    else
                        dist_at_click = math.sqrt(dist_at_click2)
                        juon.vx = (P.x - juon.x) / dist_at_click * 5
                        juon.vy = (P.y - juon.y) / dist_at_click * 5
                    end
                    juon.x = juon.x +juon.vx
                    juon.y = juon.y + juon.vy
                
                    
               



                   
                    
    
                    if opal.checkCollision(juon,P) == true then
                        opal.playSound("sfx/get hit.mp3",gethitsoundList)
                        table.remove(juonList,index)
                        P.health = P.health - 1
                        startShake(0.2,1)
                    end
    
                    if ghost.x < 0 then
                        table.remove(ghostList,index)
                    end
                    
                end
    
                
    
            --shootdirection
                if Mtimer <= 20 and Mtimer > 0 then
                    Mtimer = Mtimer - 1
                end
    
                if Mtimer == 0 then
                    Mtimer = 20
                end
                    
                
                if love.mouse.isDown(1) then
    
                    if overheat == "false" then
                        if (Mtimer == 20)then
                            sun = opal.newObject("sun.png",0.3,P.x,P.y)
                            sun.Shootdirection = Shootdirection
                            sunList[#sunList+1] = sun
                            opal.playSound("sfx/shoot.mp3",shootsoundList)
                            ammoCount.currentFrame  = ammoCount.currentFrame + 1         
                        end
                    end
                    
                
                end
    
                --shootdirection
    
                
                if love.keyboard.isDown("right") and love.keyboard.isDown("down") then
                    Shootdirection = 315
                elseif love.keyboard.isDown("left") and love.keyboard.isDown("down") then
                    Shootdirection = 225
                elseif love.keyboard.isDown("left") and love.keyboard.isDown("up") then
                    Shootdirection = 135
                elseif love.keyboard.isDown("right") and love.keyboard.isDown("up") then
                    Shootdirection = 45
                elseif love.keyboard.isDown("right") then
                    Shootdirection = 0
                elseif love.keyboard.isDown("up") then
                    Shootdirection = 90
                elseif love.keyboard.isDown("left") then
                    Shootdirection = 180
                elseif love.keyboard.isDown("down") then
                    Shootdirection = 270
                else
                    Shootdirection = 0
                end
                
                -- scoremovement
                for index = #scoreTextList,1,-1 do
                    scoreText = scoreTextList[index]
                    scoreText.y = scoreText.y - 0.5
                    scoreText.alpha = scoreText.alpha - 0.02

                    if scoreText.alpha <= 0 then
                        table.remove(scoreTextList,index)
                    end
                    


                end


            -- powerup implement
            --power/inf
            for index = #infList,1,-1 do
                pinf = infList[index]

                if opal.checkDistant(P,pinf) < 150 then
                    dist_at_click2 = (P.x - pinf.x)^2 + (P.y - pinf.y)^2
                    if dist_at_click2 == 0 then
                        pinf.vx, pinf.vy = 0, 0
                    else
                        dist_at_click = math.sqrt(dist_at_click2)
                        pinf.vx = (P.x - pinf.x) / dist_at_click * 6
                        pinf.vy = (P.y - pinf.y) / dist_at_click * 6
                    end
                    pinf.x = pinf.x +pinf.vx
                    pinf.y = pinf.y + pinf.vy
                else
                    pinf.x = pinf.x - 3 
                end

                if opal.checkCollision(P,pinf) == true then
                    table.remove(infList,index)
                    if pv_inf == "false" then
                        opal.playSound("sfx/item pick.mp3",itempicksoundList)
                        pv_inf = "true"
                    end
                end

                if pinf.x < 0 then
                    table.remove(infList,index)
                end
            end
            

            if pv_inf == "true" then
                ammoCount.currentFrame = 1
                p_inf.alpha = 1
                if inftimer > 0 then
                    inftimer = inftimer - 1
                end
                

                if inftimer == 0 then
                    pv_inf = "false"
                    inftimer = 300
                    p_inf.alpha = 0
                end
            end



            --power/bite

            if love.keyboard.isDown("0") then
                pv_bite = "true"
                pv_inf = "true"
                P.health = 3
                ammoCount.currentFrame = 1
            end

            for index = #biteList,1,-1 do
                pbite = biteList[index]

                if opal.checkDistant(P,pbite) < 150 then
                    dist_at_click2 = (P.x - pbite.x)^2 + (P.y - pbite.y)^2
                    if dist_at_click2 == 0 then
                        pbite.vx, pbite.vy = 0, 0
                    else
                        dist_at_click = math.sqrt(dist_at_click2)
                        pbite.vx = (P.x - pbite.x) / dist_at_click * 6
                        pbite.vy = (P.y - pbite.y) / dist_at_click * 6
                    end
                    pbite.x = pbite.x + pbite.vx
                    pbite.y = pbite.y + pbite.vy
                else
                    pbite.x = pbite.x - 3 
                end

                if opal.checkCollision(P,pbite) == true then
                    table.remove(biteList,index)
                    if pv_bite == "false" then
                        opal.playSound("sfx/item pick.mp3",itempicksoundList)
                        pv_bite = "true"
                    end
                end

                if pbite.x < 0 then
                    table.remove(biteList,index)
                end
            end

            if pv_bite == "true" then
                p_biteicon.alpha = 1
                p_bitetext.alpha = 1


                if love.keyboard.isDown("e") then
                    opal.playSound("sfx/bite.mp3",bitesoundList)
                    pv_bite = "biting"
                end
            end

            if pv_bite == "biting" then
                p_biteicon.alpha = 0
                p_bitetext.alpha = 0

                if bitetimer > 0 then
                    bitetimer = bitetimer - 1
                end




                if p_bite.currentFrame < 22 then
                    if p_bite.currentFrame < 12 then
                        if bitetimer == 0 then
                            
                            bitetimer = 3
                            p_bite.currentFrame = p_bite.currentFrame + 1 
                        end
                    elseif p_bite.currentFrame == 11 then
                        
                        if bitetimer == 0 then
                            startShake(0.2,1)
                            bitetimer = 30
                            p_bite.currentFrame = p_bite.currentFrame + 1
                            
                        end
                    else
                        if bitetimer == 0 then
                            pv_biteclearall = "true"
                            bitetimer = 3
                            p_bite.currentFrame = p_bite.currentFrame + 1 
                            P.health = 3
                        end
                    end
                elseif p_bite.currentFrame == 22 then
                    pv_biteclearall = "false"
                    pv_bite = "false"
                    p_bite.currentFrame = 1
                    bitetimer = 2
                end
                

            end

            for index = #pumpkinList,1,-1 do
                pumpkin = pumpkinList[index]
                if pv_biteclearall == "true" then
                    score = score + 1
                    table.remove(pumpkinList,index)
                end
            end

            for index = #ghostList,1,-1 do
                ghost = ghostList[index]
                if pv_biteclearall == "true" then
                    score = score + 1
                    table.remove(ghostList,index)
                end
            end

            for index = #juonList,1,-1 do
                juon = juonList[index]
                if pv_biteclearall == "true" then
                    score = score + 1
                    table.remove(juonList,index)
                end
            end

            for index = #skullList,1,-1 do
                skull = skullList[index]
                if pv_biteclearall == "true" then
                    score = score + 1
                    table.remove(skullList,index)
                end
            end





            --power/heart


            for index = #heartList,1,-1 do
                pheart = heartList[index]

                if opal.checkDistant(P,pheart) < 150 then
                    dist_at_click2 = (P.x - pheart.x)^2 + (P.y - pheart.y)^2
                    if dist_at_click2 == 0 then
                        pheart.vx, pheart.vy = 0, 0
                    else
                        dist_at_click = math.sqrt(dist_at_click2)
                        pheart.vx = (P.x - pheart.x) / dist_at_click * 6
                        pheart.vy = (P.y - pheart.y) / dist_at_click * 6
                    end
                    pheart.x = pheart.x + pheart.vx
                    pheart.y = pheart.y + pheart.vy
                else
                    pheart.x = pheart.x - 3 
                end
                
                if opal.checkCollision(P,pheart) == true then
                    if P.health < 3 then
                        opal.playSound("sfx/heal.mp3",healsoundList)
                        P.health = P.health + 1
                    end
                    table.remove(heartList,index)
                end

                if pheart.x < 0 then
                    table.remove(heartList,index)
                end

                
            end



            --playershooting
                if love.keyboard.isDown("space") then
                    if holdspace == "false" then
                        if overheat == "false" then
                            sun = opal.newObject("sun.png",0.3,P.x,P.y)
                            sun.Shootdirection = Shootdirection
                            sunList[#sunList+1] = sun 
                            opal.playSound("sfx/shoot.mp3",shootsoundList)
                            if pv_inf == "false" then
                                ammoCount.currentFrame = ammoCount.currentFrame + 1
                            end
                            
                            
                            holdspace = "true"
                        end
                        
                        
                    end
                else
                    holdspace = "false"
                end

                --overheat

                if ammoCount.currentFrame == 9 then
                   overheat = "true"
                else
                    overheat = "false"
                end

                if ammoCount.currentFrame > 1 and (love.keyboard.isDown("space") ~= true) and (love.mouse.isDown(1) ~= true) then
                    if ohTimer > 0 then
                        ohTimer = ohTimer - 1
                    end

                    if ohTimer <= 0 then
                        ammoCount.currentFrame = ammoCount.currentFrame - 1
                        ohTimer = 30
                    end
                end





    
                for index = #sunList, 1, -1 do
                    sun = sunList[index]
                    if love.mouse.isDown(1) then
                        angle = math.atan2(sun.y-love.mouse.getY(), sun.x-love.mouse.getX())
                        --sun.x = sun.x - math.cos(angle) * 400 / 60
                        sun.x = sun.x + 5
                        sun.y = sun.y - math.sin(angle)* 400 / 60
                    else 
                        if sun.Shootdirection == 315 then
                            sun.x = sun.x + 6
                            sun.y = sun.y + 6
                        elseif sun.Shootdirection == 135 then
                            sun.x = sun.x - 6
                            sun.y = sun.y - 6
                        elseif  sun.Shootdirection == 225 then
                            sun.x = sun.x - 6
                            sun.y = sun.y + 6
                        elseif sun.Shootdirection == 45 then
                            sun.x = sun.x + 6
                            sun.y = sun.y - 6
                        elseif sun.Shootdirection == 180 then
                            sun.x = sun.x - 6
                        elseif sun.Shootdirection == 90 then
                            sun.y = sun.y - 6
                        elseif sun.Shootdirection == 270 then
                            sun.y = sun.y + 6
                        elseif sun.Shootdirection == 0 then
                            sun.x = sun.x + 6
                        end
                    end
    
                    
                    
    
                    if sun.x >= 1000 then
                        table.remove(sunList,index)
                    end
                    
                end
    
            --[[
    
            BULLET LOOPING AND ENEMY LOOPING
            (nested for loop)
    
            -Loop bullet
                -loop enemy
                -remove bullet and enemy
    
            ]]
    
    
            -- check collisions: bullets vs enemies
                for index = #sunList, 1, -1 do
                    sun = sunList[index]
            -- This is a nested for loop

                    for index2 = #pumpkinList,1,-1 do
                        pumpkin = pumpkinList[index2]
    
    
                        if opal.checkCollision(sun,pumpkin) == true then
                            opal.playSound("sfx/kill.mp3",killsoundList)
                            scoreText = opal.newTextObject("What a shot!","Zombie Monster.ttf",20,sun.x,sun.y)
                            scoreTextList[#scoreTextList+1] = scoreText
                            score = score + 1

                            if math.random(0,10) == 0 then -- 10
                                pinf = opal.newObject("inf.png",0.7,pumpkin.x,pumpkin.y)
                                
                                infList[#infList+1] = pinf
                            end


                            table.remove(sunList,index)
                            table.remove(pumpkinList,index2)
                            break
                        end
    
    
                    end
    
                    for index3 = #ghostList,1,-1 do
                        ghost = ghostList[index3]
    
                        if opal.checkCollision(sun,ghost) == true then
                            opal.playSound("sfx/kill.mp3",killsoundList)
                            

                            if math.random(0,5) == 0 then -- 5
                                pheart = opal.newObject("heart.png",0.7,ghost.x,ghost.y)
                                
                                heartList[#heartList+1] = pheart
                            end

                            scoreText = opal.newTextObject("Boo!","Zombie Monster.ttf",20,sun.x,sun.y)
                            scoreTextList[#scoreTextList+1] = scoreText
                            score = score+1
                            table.remove(sunList,index3)
                            table.remove(ghostList,index3)
                            break
                        end
                    end
    
                    for index4 = #juonList,1,-1 do
                        juon = juonList[index4]
    
                        if opal.checkCollision(sun,juon) == true then
                            opal.playSound("sfx/kill.mp3",killsoundList)
                            if math.random(0,10) == 0 then -- 10
                                pbite = opal.newObject("fang.png",0.7,juon.x,juon.y)
                                biteList[#biteList+1] = pbite
                            end
    
                            scoreText = opal.newTextObject("Not Fair!","Zombie Monster.ttf",20,sun.x,sun.y)
                            scoreTextList[#scoreTextList+1] = scoreText
                            score = score+1

                            table.remove(sunList,index4)
                            table.remove(juonList,index4)
                            break
                        end
                    end

                    for index5 = #skullList,1,-1 do
                        skull = skullList[index5]
                        if opal.checkCollision(sun,skull) == true then
                            opal.playSound("sfx/kill.mp3",killsoundList)
                            scoreText = opal.newTextObject("Grrr!","Zombie Monster.ttf",20,sun.x,sun.y)
                            scoreTextList[#scoreTextList+1] = scoreText
                            score = score+1
                            table.remove(sunList,index5)
                            table.remove(skullList,index5)
                            break
                        end
                    end

                    if opal.checkCollision(sun,E_1) == true then
                        if bossInPosition == "true" then
                            opal.playSound("sfx/boss hurt.mp3",bosshurtsoundList)
                            bossHP = bossHP - 1
                            if B_hb.currentFrame ~= 30 then
                                B_hb.currentFrame = B_hb.currentFrame + 1
                            end
                            
                            
                            
                            scoreText = opal.newTextObject("Ouch!","Zombie Monster.ttf",20,sun.x,sun.y)
                            scoreText.red = 255
                            scoreText.blue = 0
                            scoreText.green = 0
                            scoreTextList[#scoreTextList+1] = scoreText

                            startShake(0.1,1)
                            if bosshit == "false" then
                                bosshit = "true"
                            end
                            table.remove(sunList,index)
                            
                        end
                        
                        
                        
                        
                        
                    end
    
                
    
    
                end
    
                for index = #pumpkinList,1,-1 do
                    pumpkin = pumpkinList[index]
    
                    for index2 = #ghostList,1,-1 do
                        ghost = ghostList[index2]
    
                        if opal.checkCollision(ghost,pumpkin) == true and math.random(0,1) == 1 then
                            table.remove(ghostList,index2)
                            table.remove(pumpkinList,index)
                            juon = opal.newObject("E_juon.png", 1, pumpkin.x ,pumpkin.y)
                            juon.xscale = -1
                            juon.speed = 3
                            juonList[#juonList+1] = juon
    
                            break
                        end
    
                    end
    
                end
        end
        
 
        
    end

    if score > opal.dataObject.highscore then
        opal.dataObject.highscore = score
        
    end
    
-- Boss Death

    if bossHP == 0 and bossInPosition == "true" then
        opal.playSound("sfx/boss death.mp3",bossdeathsoundList)
        saveScore = score
        E_moving = "false"
        E_direction = 0
        bossInPosition = "death"
    end

    if E_1.x < 1120 and bossInPosition == "death" then

        if B_hb.y < 630 then
                B_hb.y = B_hb.y + 1
            end



        E_1.x = E_1.x + 3
        if E_1.x >= 1120 then
            bossInPosition = "false"
        end
    end
    
    


    -- gameover
    
    if gameOver == "true" then
        opal.saveData()
        if overmusicplaying == "true" then
            love.audio.stop()
            opal.playSound("sfx/P break.mp3",pbreaksoundList)
            overmusicplaying = "false"
        end
        

        
        startTimer = 1
        opal.clearList(sunList)
        opal.clearList(ghostList)
        opal.clearList(pumpkinList)
        opal.clearList(juonList)
        opal.clearList(scoreTextList)
        opal.clearList(skullList)
        opal.clearList(heartList)
        opal.clearList(biteList)
        opal.clearList(infList)
        P_moving = "false"
        E_animating = "false"
        E_moving = "false"
        bg_moving = "false"
        E_direction = 0
        patimer = 60
        
        


        

        if deathAnimationTimer > 0 then

            
            if deathAnimationTimer > 40 then
                deathAnimationTimer = deathAnimationTimer - 1

                if fliptimer >= 0 then
                    fliptimer = fliptimer - 1
                end
                
                if fliptimer <= 0 then
                    fliptimer = 30
                end

                if fliptimer == 30 then
                    if P.alpha == 1 then
                        P.alpha = 0
                    elseif P.alpha == 0 then
                        P.alpha = 1
                    end
                end
            else
                

                P.alpha = 0
                if deathanimationtrigger == "false" and P_df.alpha == 0 then
                    P_df.alpha = 1
                    opal.playSound("sfx/lego break.mp3",legobreakList)
                end
                

                if deathAnimationTimer <= 40 and deathAnimationTimer > 0 then
                    deathAnimationTimer = deathAnimationTimer - 1
                    P_df.alpha = P_df.alpha - 0.025
                end
    
    
                if deathAnimationTimer == 40 then
                    P_df.currentFrame = 1
                elseif deathAnimationTimer == 35 then
                    P_df.currentFrame = 2
                elseif deathAnimationTimer == 30 then
                    P_df.currentFrame = 3
                elseif deathAnimationTimer == 25 then
                    P_df.currentFrame = 4
                elseif deathAnimationTimer == 20 then
                    P_df.currentFrame = 5
                elseif deathAnimationTimer == 15 then
                    P_df.currentFrame = 6
                elseif deathAnimationTimer == 10 then
                    P_df.currentFrame = 7
                elseif deathAnimationTimer == 5 then
                    P_df.currentFrame = 8
                elseif deathAnimationTimer == 0 then
                    P_df.currentFrame = 9
                end

            end
            

        else
            overScreen.alpha = 1
            if overScreen.currentFrame < 33 then

                if overScreen.currentFrame == 2 and overtimer == 1 then
                    opal.playSound("sfx/chains.mp3",chainssoundList)
                end

                if overtimer > 0 then
                    overtimer = overtimer - 1
                end

                if overtimer == 0 then
                    
                        overtimer = 2

                        overScreen.currentFrame = overScreen.currentFrame + 1

                        if overScreen.currentFrame == 22 then
                            startShake(0.005,2)
                            overtimer = 20
                        end

                        if overScreen.currentFrame == 25 then
                            startShake(0.005,2)
                            overtimer = 20
                        end

                        
                    
                    
                end
            else
                if overtimer < 30 then
                    overtimer = overtimer + 1
                end

                if overtimer == 30 then
                    if overScreen2.alpha < 1 then
                        overScreen2.alpha = overScreen2.alpha + 0.05
                    end
                    if overmusicplaying ~= "ending" then
                        opal.playMusic("music/gameoverscreen.mp3",bgmovList,0.5)
                        overmusicplaying = "ending"
                    end
                    

                    ammoCount.alpha = 0
                    font = love.graphics.newFont("Opal's Writing.ttf", 30)
                    pv_biteclearall = "false"
                    pv_bite = "false"
                    p_bite.currentFrame = 1
                    bitetimer = 2
                    pv_inf = "false"
                    inftimer = 300



                    if love.keyboard.isDown("r") then
                        if overmusicplaying ~= "true" then
                            love.audio.stop()
                            opal.playMusic("music/time.mp3",bgm1List,0.5)
                            overmusicplaying = "true"
                        end
                    
                    
                    highscore = opal.dataObject.highscore
                    p_biteicon.alpha = 0
                    p_bitetext.alpha = 0
                    p_inf.alpha = 0
                    P.health = 3
                    font = love.graphics.newFont("Zombie Monster.ttf", 25)
                    overScreen2.alpha = 0
                    overScreen.currentFrame = 1
                    pumpkinTimer = 60
                    fliptimer = 30
                    flipvar = 0
                    deathanimationtrigger = "false"
                    P_df.currentFrame = 1
                    P_df.alpha = 0
                    P.alpha = 1
                    E_1.x = 1120
                    E_1.y = 300
                    overScreen.alpha = 0
                    ammoCount.alpha = 1
                    ammoCount.currentFrame = 1
                    overheat = "false"
                    gameOver = "false"
                    opal.loadData()
                    currentStartText = 1
                    gameStart = "false"
                    startTimer = 210
                    bg.x = 500
                    bg2.x = -500
                    fg.x = 500
                    fgg.x = 500
                    fg2.x = -500
                    P.x = 150
                    P.x = 300
                    deathAnimationTimer = 220
                    E_animating = "true"
                    E_moving = "false"
                    bg_moving = "true"
                    P_moving = "true"
                    bossInPosition = "false"
                    bossHP = 30
                    B_hb.currentFrame = 1
                    score = 0
                    B_hb.y = 630
                    end
                
                
                
                end
            end

            
            
        end
    end
        

        

end







function love.draw()

    if t < shakeDuration then
        local dx = love.math.random(-shakeMagnitude, shakeMagnitude)
        local dy = love.math.random(-shakeMagnitude, shakeMagnitude)
        love.graphics.translate(dx, dy)
    end

    opal.drawObject(bg)
    opal.drawObject(bg2)
    opal.drawObject(fg)
    opal.drawObject(fg2)
    opal.drawObject(fgg)
    for index = #startTextList, 1,-1 do
        love.graphics.print(startTextList[currentStartText],startfont,startTextList.x,200)
    end
    

    
    for index = #skullList,1,-1 do
        skull = skullList[index]
        opal.drawAnimate(skull,sanimateList[skull.currentFrame])
    end
    
    for index = #pumpkinList, 1, -1 do
        pumpkin = pumpkinList[index]
        opal.drawObject(pumpkin)
    end

    for index = #ghostList, 1, -1 do
        ghost = ghostList[index]
        opal.drawObject(ghost)
    end 

    for index = #juonList, 1, -1 do
        juon = juonList[index]
        opal.drawObject(juon)
    end 

    for index = #sunList, 1, -1 do
        sun = sunList[index]
        opal.drawObject(sun)
    end 
    love.graphics.print("Ghosts Banished: ".. score,font,760,540)
    love.graphics.print("Highscore: ".. highscore,font,760,570)

    opal.drawAnimate(B_hb,bhanimateList[B_hb.currentFrame])
    



    --draw collectable powerup
    for index = #infList,1,-1 do
        pinf = infList[index]
        opal.drawObject(pinf)
    end

    for index = #heartList,1,-1 do
        pheart = heartList[index]
        opal.drawObject(pheart)
    end

    for index = #biteList,1,-1 do
        pbite = biteList[index]
        opal.drawObject(pbite)
    end
    


    --drawpowerup icon
    opal.drawObject(p_inf)
    opal.drawObject(p_biteicon)
    opal.drawTextObject(p_bitetext)
    




    
    

    
    opal.drawAnimate(healthbar,phanimateList[healthbar.currentFrame])
    opal.drawAnimate(E_1,bossanimateList[E_1.currentFrame])
    opal.drawAnimate(ammoCount,aanimateList[ammoCount.currentFrame])
    opal.drawAnimate(P,panimateList[P.currentFrame])
    opal.drawAnimate(P_df,pdfanimateList[P_df.currentFrame])


    --love.graphics.print(#pumpkinList,20,20)
    --love.graphics.print(#ghostList,20,40)
    
    opal.drawObject(introBg)

    for index = #scoreTextList,1,-1 do
        scoreText = scoreTextList[index]
        opal.drawTextObject(scoreText)
    end
    
    

    

    --intro texts
    for index = #introTextList, 1,-1 do
        love.graphics.print(introTextList[currentText],introTextList.x,500)
    end

    --love.graphics.print(currentText,20,50)
    --love.graphics.print(textTimer,20,80)
    
    

    
    opal.drawAnimate(p_bite,biteanimateList[p_bite.currentFrame])

    opal.drawAnimate(overScreen,ovanimateList[overScreen.currentFrame])
    opal.drawObject(overScreen2)
    love.graphics.print("Ghosts Banished: ".. score,font,400,450)
    love.graphics.print("Boss HP: "..bossHP,font,430,500)
    love.graphics.print("Highscore: " .. highscore, font, 420,550)
    --love.graphics.print("Most Banished: ".. highscore .. " Ghosts",font,500,550)
    --love.graphics.print(overtimer,50,100)

    love.graphics.setColor(1,1,1,1)
    for index = 1,#opal.debugList,1 do
        oldText = opal.debugList[index]
        love.graphics.print(oldText,0,20 * (index - 1))
    end

    
    
    

    
    

    
    

end












