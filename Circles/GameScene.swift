//
//  GameScene.swift
//  Circles
//
//  Created by Apple on 16/5/30.
//  Copyright (c) 2016年 Apple. All rights reserved.
//

import SpriteKit

//label for collision detect
let PlayerCategory:UInt32 = 1<<1
let starCategory:UInt32 = 1<<2
let starCateGory_lv2:UInt32 = 1<<3
let fireballCategory:UInt32 = 1<<4

class GameScene: SKScene, SKPhysicsContactDelegate{//extend a delegate for collision detect
    var playerTexture = SKTexture(imageNamed: "player-earth")//all textures are download from web, but I PS those
    var playerTexture_change = SKTexture(imageNamed: "player-earth-change")
    var playerTexture2 = SKTexture(imageNamed: "player-X")
    var playerTexture2_change = SKTexture(imageNamed: "player-X-change")
    var playerTexture2_change2 = SKTexture(imageNamed: "player-X-change2")
    var starTexture = SKTexture(imageNamed: "star-lv1")
    var starTexture_lv2 = SKTexture(imageNamed: "star-lv2")
    var fireballTexture = SKTexture(imageNamed: "fireball-lv1")
    
    var player:SKSpriteNode!
    var touchGap = CGPoint(x:0, y:0)//add this, then don't need to drag it to move, just point direction
    let bgPic = SKSpriteNode(imageNamed: "gamePic")
    
    var changeTime = 10 //time that player can change himself
    
    var starTime:NSTimeInterval = 1
    var laststar:NSTimeInterval = 0
    
    var playerScale = CGFloat(0.3) //picture size
    let winScale = CGFloat(1.4) // if player scale reach this, then judge win or lose
    let loseScale = CGFloat(0.2)
    
    var progressView = UIProgressView(progressViewStyle: UIProgressViewStyle.Default) //进度条
    let sound = SoundManager() // 音乐和音效播放器 
    
    var id = -1 // character id
    
    override func didMoveToView(view: SKView) {
        self.addChild(sound)
        if (self.userData?.valueForKey("isMusicOn")?.integerValue == 1) {
            sound.playBackGround()
        }
        
        id = (self.userData?.valueForKey("characterId")?.integerValue)!
        if (id == 1) {
            player = SKSpriteNode(texture: playerTexture)//create a sprite
        }
        else if (id == 2) {
            player = SKSpriteNode(texture: playerTexture2)
        }
        
        bgPic.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame) * 1 / 2)
        bgPic.zPosition = -1;
        self.addChild(bgPic)
        
        physicsWorld.contactDelegate = self //use this class when detect collision
        physicsWorld.gravity = CGVector(dx: 0, dy: 0) // things will not fall by itself
  
        player.position = CGPointMake(size.width * 0.5, size.height * 0.5)//start position
        player.name = "player"//add a label for the following use
        player.setScale(playerScale)//set size
        
        let widthAfterScale = playerTexture.size().width * playerScale
        let heightAfterScale = playerTexture.size().height * playerScale
        
        player.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: widthAfterScale, height: heightAfterScale),
            center:CGPoint(x:0.5, y:0.5)) //attention to set center!!
        player.physicsBody?.categoryBitMask = PlayerCategory //catagory label
        player.physicsBody?.collisionBitMask = 0
        player.physicsBody?.contactTestBitMask = starCategory //collision inform label
        addChild(player)
        
        progressView.frame = CGRectMake((self.view?.center.x)!, 5/3*(self.view?.center.y)!, 100, 50)//use view not frame !!! don't understand
        progressView.progress = (Float)((playerScale-loseScale)/(winScale-loseScale)) // 1.0 is the finish value
        progressView.progressTintColor = UIColor.greenColor() // has finished part
        progressView.trackTintColor = UIColor.redColor()
        self.view?.addSubview(progressView)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let location:CGPoint! = touches.first?.locationInNode(self)
        let node = self.nodeAtPoint(location)
        if (node.name == "player" && player.texture == playerTexture) {//tap player to change style and has ability
            changeTime = 150
            player.texture = playerTexture_change
        }
        else if (node.name == "player" && player.texture == playerTexture2) {
            player.texture = playerTexture2_change
        }
        else if (node.name == "player" && player.texture == playerTexture2_change) {
            player.texture = playerTexture2_change2
        }
        else if (node.name == "player" && player.texture == playerTexture2_change2) {
            player.texture = playerTexture2
        }
        else {
            //touchGap = CGPoint(x: location.x - player.position.x, y: location.y - player.position.y)
            let xoff = location.x - player.position.x
            let yoff = location.y - player.position.y
            let length = sqrt(xoff * xoff + yoff * yoff)
            let velocity = self.size.width/1 // change speed here
            let realMoveDuration = NSTimeInterval(length/velocity)
            player.runAction(SKAction.sequence([SKAction.moveTo(location, duration: realMoveDuration)]))
        }
    
    }
    
    func clamp(x: CGFloat, min: CGFloat, max: CGFloat) -> CGFloat {//limit in screen border
        if (x <= min) {
            return min
        }
        else if (x >= max) {
            return max
        }
        else {
            return x
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {//perhaps when drag do this func
        /*if isTouched {
            if let touch = touches.first as UITouch? {
                let location:CGPoint! = touch.locationInNode(self)
                player.position  = CGPointMake(location.x, location.y)
            }
        }
        */
        
        /*
        let location:CGPoint! = touches.first?.locationInNode(self)
        let xDir = clamp(location.x - touchGap.x, min:0, max: size.width)
        let yDir = clamp(location.y - touchGap.y, min:0, max: size.height)
        player.position = CGPoint(x: xDir, y: yDir)
        */
    }

    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //isTouched = false
    }

    func createstar(level: UInt32){
        let star = SKSpriteNode(texture: starTexture)//here cannot use null to init, because it will use color to fill it
        let starScale = CGFloat(0.2)
        star.setScale(starScale)
        
        if (level == 1) {
            star.texture = starTexture //then at this place, u set texture useless because color will cover this texture
            let widthAfterScale = starTexture.size().width * starScale
            let heightAfterScale = starTexture.size().height * starScale
            star.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: widthAfterScale, height: heightAfterScale),
                center:CGPoint(x:0.5, y:0.5))
            star.physicsBody?.categoryBitMask = starCategory
        }
        else if (level == 2){
            star.texture = starTexture_lv2
            let widthAfterScale = starTexture_lv2.size().width * starScale
            let heightAfterScale = starTexture_lv2.size().height * starScale
            star.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: widthAfterScale, height: heightAfterScale),
                center:CGPoint(x:0.5, y:0.5))
            star.physicsBody?.categoryBitMask = starCateGory_lv2
        }
        //star.physicsBody = SKPhysicsBody(rectangleOfSize: starTexture.size(), center:CGPoint(x:0.5, y:0.5))
        star.physicsBody?.collisionBitMask = 0
        star.physicsBody?.contactTestBitMask = PlayerCategory
        
        let chooseDirect = CGFloat(arc4random()) % 4
        let randomX = CGFloat(arc4random()) % size.width//mod to screen wide
        let randomY = CGFloat(arc4random()) % size.height//mod to screen wide
        switch (chooseDirect) {
        case 0 : star.position = CGPointMake(randomX, size.height);break;
        case 1 : star.position = CGPointMake(randomX, 0);break;
        case 2 : star.position = CGPointMake(size.width, randomY);break;
        case 3 : star.position = CGPointMake(0, randomY);break;
        default: break;
        }
        
        addChild(star)
        
        let velocity = NSTimeInterval(arc4random()) % 3 + 2//3 kinds of speed
        switch (chooseDirect) {
        case 0 :         star.runAction(SKAction.sequence([SKAction.moveByX(0, y: -size.height, duration: velocity), SKAction.removeFromParent()]));break;
        case 1 :         star.runAction(SKAction.sequence([SKAction.moveByX(0, y: size.height, duration: velocity), SKAction.removeFromParent()]));break;
        case 2 :         star.runAction(SKAction.sequence([SKAction.moveToX(0, duration: velocity), SKAction.removeFromParent()]));break;
        case 3 :         star.runAction(SKAction.sequence([SKAction.moveToX(size.width, duration: velocity), SKAction.removeFromParent()]));break;
        default: break;
        }
    }
    
    func createfireball(){
        let fireball = SKSpriteNode(texture: fireballTexture)
        
        let fireballScale = CGFloat(0.2)
        fireball.setScale(fireballScale)
        let widthAfterScale = fireballTexture.size().width * fireballScale
        let heightAfterScale = fireballTexture.size().height * fireballScale
        
        fireball.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: widthAfterScale, height: heightAfterScale),
            center:CGPoint(x:0.5, y:0.5))
        fireball.physicsBody?.categoryBitMask = fireballCategory
        fireball.physicsBody?.collisionBitMask = 0
        fireball.physicsBody?.contactTestBitMask = PlayerCategory
        
        let chooseDirect = CGFloat(arc4random()) % 2
        var randomX = CGFloat(arc4random()) % size.width//mod to screen wide
        var randomY = CGFloat(arc4random()) % size.height//mod to screen wide
        switch (chooseDirect) {
        case 0 : fireball.position = CGPointMake(randomX, size.height);break;
        case 1 : fireball.position = CGPointMake(size.width, randomY);break;
        default: break;
        }
        
        if (randomX > randomY) {//fireball fly from right-top to left-bootom, becase icon i found is with angle of 45 degree
            randomX = randomX - randomY;
            randomY = 0;
        }
        else {
            randomY = randomY - randomX;
            randomX = 0;
        }
        let velocity = NSTimeInterval(arc4random()) % 3 + 2
        fireball.runAction(SKAction.sequence([SKAction.moveTo(CGPoint(x: randomX, y: randomY), duration: velocity), SKAction.removeFromParent()]))
        
        addChild(fireball)
    }
    
    func didBeginContact(contact: SKPhysicsContact) {//operation when a collision begin
        if (contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask == PlayerCategory | starCategory) {
            contact.bodyB.node?.removeFromParent()
            playerScale = playerScale + 0.1;
            sound.playScore()
        }
        if (contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask == PlayerCategory | starCateGory_lv2) {
            contact.bodyB.node?.removeFromParent()
            playerScale = playerScale + 0.3;
            sound.playScore()
        }
        if (contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask == PlayerCategory | fireballCategory) {
            contact.bodyB.node?.removeFromParent()
            sound.playHit() // sound effect
            if (player.texture != playerTexture_change) {
                playerScale = playerScale / 2
            }
            
        }
        player.setScale(playerScale)
        
        if(playerScale >= winScale) {//win
            progressView.setProgress((Float)((playerScale-loseScale)/(winScale-loseScale)), animated: true)
            let nextScene = WinScene(size:self.size)
            let doors = SKTransition.flipHorizontalWithDuration(0.5)
            self.view?.presentScene(nextScene, transition: doors)
        }
        if(playerScale <= loseScale) {//lose
            progressView.setProgress((Float)((playerScale-loseScale)/(winScale-loseScale)), animated: true)
            let nextScene = LoseScene(size:self.size)
            let doors = SKTransition.flipHorizontalWithDuration(0.5)
            self.view?.presentScene(nextScene, transition: doors)
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        let ifCreatefireball = arc4random() % (12 * UInt32(winScale / playerScale))
        if (ifCreatefireball == 0) { // the higher score, the more dangerous fireballs
            createfireball()
        }
        
        if(player.texture == playerTexture_change) { // character1-earth 变身时间
            changeTime = changeTime - 2
            if (changeTime == 0) {
                player.texture = playerTexture
            }
        }
        
        if (currentTime >= laststar + starTime) {
            let level = arc4random() % 4 + 1
            if level == 1 { // big star have high score, appear less
                createstar(2)
            }
            else {
                createstar(1)
            }
            laststar = currentTime
            starTime = NSTimeInterval(arc4random() % 20 + 5) / 10 //一个不错的随机时间间隔
        }
        
        bgPic.position.y = bgPic.position.y - 2 // background is rolling
        if (bgPic.position.y < self.frame.height * 3 / 8) {
            bgPic.position.y = self.frame.height * 5 / 8
        }
        progressView.setProgress((Float)((playerScale-loseScale)/(winScale-loseScale)), animated: true)//animate help smooth
    }
}
