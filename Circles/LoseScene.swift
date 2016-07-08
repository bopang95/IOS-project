//
//  LoseScene.swift
//  Circles
//
//  Created by Apple on 16/6/6.
//  Copyright © 2016年 Apple. All rights reserved.
//

import SpriteKit

class LoseScene: SKScene {
    let sound = SoundManager()
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.text = "You Lose!";
        myLabel.fontSize = 45;
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        self.addChild(myLabel)
        
        let againLabel = SKLabelNode(fontNamed:"Chalkduster")
        againLabel.name = "AgainLabel"
        againLabel.text = "Try Again?";
        againLabel.fontSize = 30;
        againLabel.position = CGPoint(x: CGRectGetMidX(self.frame), y: 0.8*CGRectGetMidY(self.frame));
        self.addChild(againLabel)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        sound.playClick()
        
        let location:CGPoint! = touches.first?.locationInNode(self)
        let node = self.nodeAtPoint(location)
        if node.name == "AgainLabel" {
            let nextScene = GameScene(size:self.size)
            let doors = SKTransition.flipHorizontalWithDuration(0.5)
            self.view?.presentScene(nextScene, transition: doors)
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}