//
//  SelectCharaterScene.swift
//  Circles
//
//  Created by Apple on 16/6/7.
//  Copyright © 2016年 Apple. All rights reserved.
//

import SpriteKit

class SelectCharaterScene: SKScene {
    var characterTexture1 = SKTexture(imageNamed: "player-earth")
    var characterTexture2 = SKTexture(imageNamed: "player-X")
    var questionMarkTexture = SKTexture(imageNamed: "questionmark")
    var squareFrameTexture = SKTexture(imageNamed: "squareframe")
    let greenYes = SKSpriteNode(texture: SKTexture(imageNamed: "green-yes")) //point which is selected
    
    var chooseNumber = -1
    let sound = SoundManager()
    var isMusicOn = true
    
    override func didMoveToView(view: SKView) {
        //self.backgroundColor = UIColor(colorLiteralRed: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        let bgPic = SKSpriteNode(imageNamed: "transitPic")
        bgPic.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        bgPic.zPosition = -1
        self.addChild(bgPic)
        
        let titleLabel = SKLabelNode(fontNamed:"Chalkduster")
        titleLabel.text = "Charaters"
        titleLabel.fontSize = 60;
        titleLabel.fontColor = SKColor(colorLiteralRed: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)//not color preperty
        titleLabel.position = CGPoint(x: CGRectGetMidX(self.frame), y: 1.8*CGRectGetMidY(self.frame));
        self.addChild(titleLabel)
        
        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.text = "OK";
        myLabel.name = "OKLabel"
        myLabel.fontSize = 55
        myLabel.fontColor = SKColor(colorLiteralRed: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        myLabel.position = CGPoint(x: CGRectGetMidX(self.frame), y: 0.2*CGRectGetMidY(self.frame));
        self.addChild(myLabel)
        
        let num1 = SKLabelNode(fontNamed:"Chalkduster")
        num1.text = "1";
        num1.fontSize = 55
        num1.fontColor = SKColor(colorLiteralRed: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        num1.position = CGPoint(x: 0.2*CGRectGetMidX(self.frame), y: 1.6*CGRectGetMidY(self.frame));
        self.addChild(num1)
        
        let character1 = SKSpriteNode(texture: characterTexture1)
        character1.position = CGPoint(x: 0.6*CGRectGetMidX(self.frame), y: 1.6*CGRectGetMidY(self.frame));
        character1.name = "character"
        self.addChild(character1)
        
        let info1 = SKLabelNode(fontNamed:"Chalkduster")
        info1.text = "Planet that our human lived."
        info1.name = "info"
        info1.fontSize = 24
        info1.fontColor = SKColor(colorLiteralRed: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        info1.position = CGPoint(x: CGRectGetMidX(self.frame), y: 1.4*CGRectGetMidY(self.frame));
        self.addChild(info1)
        
        let info2 = SKLabelNode(fontNamed:"Chalkduster")
        info2.text = "Touch it to stay undefeated status for 0.5 second."
        info2.fontSize = 24
        info2.fontColor = SKColor(colorLiteralRed: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        info2.position = CGPoint(x: CGRectGetMidX(self.frame), y: 1.3*CGRectGetMidY(self.frame));
        self.addChild(info2)
        
        let num2 = SKLabelNode(fontNamed:"Chalkduster")
        num2.text = "2";
        num2.fontSize = 55
        num2.fontColor = SKColor(colorLiteralRed: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        num2.position = CGPoint(x: 0.2*CGRectGetMidX(self.frame), y: 1.1*CGRectGetMidY(self.frame));
        self.addChild(num2)
        
        let character2 = SKSpriteNode(texture: characterTexture2)
        character2.position = CGPoint(x: 0.6*CGRectGetMidX(self.frame), y: 1.1*CGRectGetMidY(self.frame));
        character2.name = "character2"
        self.addChild(character2)
        
        let info3 = SKLabelNode(fontNamed:"Chalkduster") // illustrate to a character
        info3.text = "Planet X. No special ability."
        info3.name = "info3"
        info3.fontSize = 24
        info3.fontColor = SKColor(colorLiteralRed: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        info3.position = CGPoint(x: CGRectGetMidX(self.frame), y: 0.9*CGRectGetMidY(self.frame));
        self.addChild(info3)

        let info4 = SKLabelNode(fontNamed:"Chalkduster")
        info4.text = "You can touch it to change skins during the game. "
        info4.fontSize = 24
        info4.fontColor = SKColor(colorLiteralRed: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        info4.position = CGPoint(x: CGRectGetMidX(self.frame), y: 0.8*CGRectGetMidY(self.frame));
        self.addChild(info4)
        
        let num3 = SKLabelNode(fontNamed:"Chalkduster")
        num3.text = "3";
        num3.fontSize = 55
        num3.fontColor = SKColor(colorLiteralRed: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        num3.position = CGPoint(x: 0.2*CGRectGetMidX(self.frame), y: 0.6*CGRectGetMidY(self.frame));
        self.addChild(num3)
        
        let character3 = SKSpriteNode(texture: questionMarkTexture)
        character3.position = CGPoint(x: 0.6*CGRectGetMidX(self.frame), y: 0.6*CGRectGetMidY(self.frame));
        character3.name = "character3"
        self.addChild(character3)

        let info5 = SKLabelNode(fontNamed:"Chalkduster")
        info5.text = "Still in prepare."
        info5.fontSize = 24
        info5.fontColor = SKColor(colorLiteralRed: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        info5.position = CGPoint(x: CGRectGetMidX(self.frame), y: 0.4*CGRectGetMidY(self.frame));
        self.addChild(info5)
        
        let squareFrame1 = SKSpriteNode(texture: squareFrameTexture) //use to hold green tick
        squareFrame1.position = CGPoint(x: 1.4*CGRectGetMidX(self.frame), y: 1.6*CGRectGetMidY(self.frame));
        squareFrame1.name = "squareFrame"
        self.addChild(squareFrame1)
        
        let squareFrame2 = SKSpriteNode(texture: squareFrameTexture)
        squareFrame2.position = CGPoint(x: 1.4*CGRectGetMidX(self.frame), y: 1.1*CGRectGetMidY(self.frame));
        squareFrame2.name = "squareFrame2"
        self.addChild(squareFrame2)
        
        greenYes.position = CGPoint(x: 0, y: 0) // hide at first
        self.addChild(greenYes)
        
        self.addChild(sound)
        isMusicOn = (self.userData?.valueForKey("isMusicOn")?.boolValue)!
        if (isMusicOn == true) {
            sound.playBackGround()
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        sound.playClick()
        
        let location:CGPoint! = touches.first?.locationInNode(self)
        let node = self.nodeAtPoint(location)
        if (node.name == "OKLabel") {
            if (chooseNumber == -1) {
                let text = "Select at least 1 character please"
                let alertController = UIAlertController(title: "Notice", message: text, preferredStyle: UIAlertControllerStyle.Alert)
                let okAction = UIAlertAction(title: "I know", style: UIAlertActionStyle.Default, handler: nil)
                alertController.addAction(okAction)
                self.view!.window?.rootViewController?.presentViewController(alertController, animated: true, completion: nil)
            }
            else {
                let nextScene = GameScene(size:self.size)
                nextScene.userData = NSMutableDictionary() // important init first !!!
                nextScene.userData!.setObject(chooseNumber, forKey: "characterId")// important pass data between scenes !!!
                nextScene.userData!.setObject(isMusicOn, forKey: "isMusicOn")
                let doors = SKTransition.flipHorizontalWithDuration(0.5)
                self.view?.presentScene(nextScene, transition: doors)
            }
        }
        else if (node.name == "character" || node.name == "info" || node.name == "squareFrame") { // large click area
            greenYes.position = CGPoint(x: 1.4*CGRectGetMidX(self.frame), y: 1.6*CGRectGetMidY(self.frame));
            chooseNumber = 1 // means you select the first character
        }
        else if (node.name == "character2" || node.name == "info3" || node.name == "squareFrame2") {
            greenYes.position = CGPoint(x: 1.4*CGRectGetMidX(self.frame), y: 1.1*CGRectGetMidY(self.frame));
            chooseNumber = 2
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}