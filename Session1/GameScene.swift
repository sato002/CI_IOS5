//
//  GameScene.swift
//  Session1
//
//  Created by Hoang Doan on 8/28/16.
//  Copyright (c) 2016 Hoang Doan. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    //Node
    var plane: SKSpriteNode!
    var bullets:[SKSpriteNode] = []
    var enemybullets:[SKSpriteNode] = []
    var enemys:[SKSpriteNode] = []
    
    //timer
    var lastUpdateTime: NSTimeInterval = -1;
    
    //counter
    var bulletIntervalCount = 0
    var enemyIntervalCount = 0
    
    override func didMoveToView(view: SKView) {
        addBackground()
        addPlane()
        
        // Add enemy
        let addEnemy = SKAction.runBlock {
            self.addEnemy()
        }
        
        let EnemyInSec = SKAction.sequence([addEnemy, SKAction.waitForDuration(3)])
        let EnemyForever = SKAction.repeatActionForever(EnemyInSec)

        self.runAction(EnemyForever)
        
        // Enemy fly
            let enemyFly = SKAction.runBlock{
                for enemy in self.enemys
                {
                    enemy.position.y -= 1
                }
                
            }
            
            let enemyFlyInSec = SKAction.sequence([enemyFly, SKAction.waitForDuration(0.02)])
            let enemyFlyForever = SKAction.repeatActionForever(enemyFlyInSec)
            
            self.runAction(enemyFlyForever)
        
        // Enemy bullet fly
        let EnemyBulletFly = SKAction.runBlock {
            for enemybullet in self.enemybullets{
                enemybullet.position.y -= 2
            }
        }
        let EnemyBulletFlyInSec = SKAction.sequence([EnemyBulletFly, SKAction.waitForDuration(0.01)])
        let EnemyBulletFlyForever = SKAction.repeatActionForever(EnemyBulletFlyInSec)
        self.runAction(EnemyBulletFlyForever)
        
    }
    
    func addBackground() {
        //1
        let background = SKSpriteNode(imageNamed: "background.png")
        //2
        background.anchorPoint = CGPointZero
        background.position = CGPointZero
        //3
        addChild(background)
        
    }
    

    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        print("touchBegan")
        
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("touchesMoved")
        print("touches: \(touches.count)")
        if let touch = touches.first {
            let currentTouch = touch.locationInNode(self)
            let previousTouch = touch.previousLocationInNode(self)
            
//            let movementVector = currentTouch.subtract(previousTouch)
//            
//            let newPosition = movementVector.add(plane.position)
           
            plane.position = currentTouch.subtract(previousTouch).add(plane.position)
            
            
            if(plane.position.x - plane.size.width/2 <= 0) {
                plane.position.x = 0 +  plane.size.width/2
            }
            
            if (plane.position.x + plane.size.width/2 >= self.frame.width) {
                plane.position.x = self.frame.width -  plane.size.width/2
            }
            
            if (plane.position.y - plane.size.height/2 < 0 || plane.position.y - plane.size.height/2 == 0  ) {
                plane.position.y = plane.size.height/2
            }
            
            if (plane.position.y + plane.size.height/2 > self.frame.height) {
                plane.position.y = self.frame.height - plane.size.height/2
            }
            
//            print("Vi tri may bay: \(plane.position)")
//            print("Diem sau khi multiply: \(multiExmaple)")
//            print("Distance: \(currentTouch.distance(previousTouch))")
            
        }
    }
    
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
//        if(lastUpdateTime == -1)
//        {
//            lastUpdateTime = currentTime
//        } else {
//            let deltaTime = currentTime - lastUpdateTime
//            let deltaTimeInMilisecond = deltaTime * 1000
//            if(deltaTimeInMilisecond > 10)
//            {
//                bulletIntervalCount += 1
//                if(bulletIntervalCount > 10)
//                {
//                    
////                    addBullet()
////                    bulletIntervalCount = 0
//                }
//                
//                enemyIntervalCount += 1
//                if (enemyIntervalCount > 20)
//                {
//                    addEnemy()
//                    enemyIntervalCount = 0
//                }
//                
//                lastUpdateTime = currentTime
//                
//            }
//        }
        
        
        
        for (bulletIndex, bullet) in bullets.enumerate()
        {
            for (enemyIndex, enemy) in enemys.enumerate() {
                let bulletFrame = bullet.frame
                let enemyFrame = enemy.frame
                if CGRectIntersectsRect(bulletFrame, enemyFrame)
                {
                    bullet.removeFromParent()
                    enemy.removeFromParent()
                    
                    bullets.removeAtIndex(bulletIndex)
                    enemys.removeAtIndex(enemyIndex)
                }
            }
        }
    

        

    }
    func addPlane() {
        //1
        plane = SKSpriteNode(imageNamed: "plane3.png")
        plane.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        let shot = SKAction.runBlock {
            self.addBullet()
        }
        
        let shotInSec = SKAction.sequence([shot, SKAction.waitForDuration(0.3)])
        let shotForever = SKAction.repeatActionForever(shotInSec)
        
        let bulletFly = SKAction.runBlock {
            for bullet in self.bullets
            {
                bullet.position.y += 10
            }
        }
        
        let flyInSec = SKAction.sequence([bulletFly, SKAction.waitForDuration(0.02)])
        let flyForever = SKAction.repeatActionForever(flyInSec)
        
        plane.runAction(flyForever)
        plane.runAction(shotForever)
        addChild(plane)
    }
    
    func addEnemy() {
        let enemy = SKSpriteNode(imageNamed: "enemy_plane_yellow_2.png")
        
        enemy.position.x = CGFloat(arc4random_uniform(UInt32(frame.size.width)))
        enemy.position.y = self.frame.size.height
        

        // Add enemy bullet to gamesence
        let addEnemyBullet = SKAction.runBlock {
            let enemyBullet = SKSpriteNode(imageNamed: "enemy_bullet.png")
            enemyBullet.position = CGPoint(x: enemy.position.x,y: enemy.position.y - enemy.size.height/2)
            self.addChild(enemyBullet)
            self.enemybullets.append(enemyBullet)
        }
        let EnemyBulletInSec = SKAction.sequence([addEnemyBullet, SKAction.waitForDuration(3)])
        let EnemyBulletForever = SKAction.repeatActionForever(EnemyBulletInSec)
        self.runAction(EnemyBulletForever)

        
        addChild(enemy)
        enemys.append(enemy)
    }
    
    
    func addBullet() {
        let bullet = SKSpriteNode(imageNamed: "bullet.png")
        bullet.position.x = plane.position.x
        bullet.position.y = plane.position.y + plane.size.height/2
        addChild(bullet)
        bullets.append(bullet)

    }
    

}
