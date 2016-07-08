//
//  BeginScene.swift
//  Circles
//
//  Created by Apple on 16/6/6.
//  Copyright © 2016年 Apple. All rights reserved.
//
import SpriteKit

class StartScene: SKScene{
    let icon1 = SKSpriteNode(texture: SKTexture(imageNamed: "music-on"))
    let icon2 = SKSpriteNode(texture: SKTexture(imageNamed: "music-off"))
    var isMusicOn = true
    let sound = SoundManager()
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        let bgPic = SKSpriteNode(imageNamed: "startPic")//i used mac's function to resize origin pic from the web
        bgPic.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))//set pic in whole scene
        bgPic.zPosition = 0;//default value is 0, used for visual layer
        self.addChild(bgPic)
        
        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.name = "StartLabel"
        myLabel.text = "Start Game";
        myLabel.fontSize = 45;
        myLabel.position = CGPoint(x: CGRectGetMidX(self.frame), y: 1.2*CGRectGetMidY(self.frame));
        myLabel.zPosition = 1//show on the background Picture
        self.addChild(myLabel)

        let myLabel2 = SKLabelNode(fontNamed:"Chalkduster")
        myLabel2.name = "RulesLabel"
        myLabel2.text = "How to Play";
        myLabel2.fontSize = 45;
        myLabel2.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame));
        myLabel2.zPosition = 1
        self.addChild(myLabel2)
        
        let myLabel3 = SKLabelNode(fontNamed:"Chalkduster")
        myLabel3.name = "MusicLabel"
        myLabel3.text = "Music";
        myLabel3.fontSize = 45;
        myLabel3.position = CGPoint(x: 0.8*CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame) * 4 / 5);
        myLabel3.zPosition = 1
        self.addChild(myLabel3)
        
        icon1.position = CGPoint(x: 1.3*CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame) * 4 / 5);
        icon1.name = "icon1"
        icon1.setScale(0.6)
        icon1.zPosition = 1
        self.addChild(icon1)
        
        icon2.position = CGPoint(x: 1.3*CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame) * 4 / 5);
        icon2.zPosition = 1
        icon2.setScale(0.6)
        icon2.name = "icon2"
        
        self.addChild(sound) // add sound   important
        sound.playBackGround()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        sound.playClick()
        
        let location:CGPoint! = touches.first?.locationInNode(self)
        let node = self.nodeAtPoint(location)
        if (node.name == "StartLabel") {
            let nextScene = SelectCharaterScene(size:self.size)
            nextScene.userData = NSMutableDictionary()
            nextScene.userData!.setObject(isMusicOn, forKey: "isMusicOn")
            let doors = SKTransition.flipHorizontalWithDuration(0.5)
            self.view?.presentScene(nextScene, transition: doors)
        }
        if (node.name == "RulesLabel") { // not use scene, but a alertView to illustrate
            let text = "Move to dodge fireballs, or you will lose half of points. Eat stars to get points and grow bigger, when the progress bar is full you win. You have 2 characters to select, each of them has different ability. And the stars have 2 size which means you can get different points from them."
            let alertController = UIAlertController(title: "How to Play", message: text, preferredStyle: UIAlertControllerStyle.Alert)
            let okAction = UIAlertAction(title: "I know", style: UIAlertActionStyle.Default, handler: nil)
            alertController.addAction(okAction)
            self.view!.window?.rootViewController?.presentViewController(alertController, animated: true, completion: nil)
        }
        if (node.name == "MusicLabel" || node.name == "icon1" || node.name == "icon2") {
            if (isMusicOn) {
                isMusicOn = false
                self.addChild(icon2)
                icon1.removeFromParent()
                sound.stopBackGround()
            }
            else {
                isMusicOn = true
                self.addChild(icon1)
                icon2.removeFromParent()
                sound.playBackGround()
            }
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
