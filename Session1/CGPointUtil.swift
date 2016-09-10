//
//  CGPointUtil.swift
//  Session1
//
//  Created by Hoang Doan on 9/4/16.
//  Copyright © 2016 Hoang Doan. All rights reserved.
//

import Foundation

import SpriteKit

extension CGPoint {
    func add(p : CGPoint) -> CGPoint {
        let retX = self.x + p.x
        let retY = self.y + p.y
        
        return(CGPoint(x: retX, y: retY))
    }
    
    func subtract(p : CGPoint) -> CGPoint {
        let retX = self.x - p.x
        let retY = self.y - p.y
        
        return(CGPoint(x: retX, y: retY))
    }
    
    func multiply(n : CGFloat) -> CGPoint {
        let newX = self.x * n
        let newY = self.y * n
        return(CGPoint(x: newX, y: newY))
    }
    
    func distance(p1: CGPoint) -> CGFloat {
        let distanceX = pow(self.x - p1.x, 2)
        let distanceY = pow(self.y - p1.y, 2)
        let distance = distanceX + distanceY
        
        return sqrt(distance)
    }
    
    func normalizeVector(p1: CGPoint) -> CGPoint {
        let vectorX = x/sqrt(pow(self.x - p1.x,2) + pow(self.y - p1.y,2))
        let vectorY = y/sqrt(pow(self.x - p1.x,2) + pow(self.y - p1.y,2))
        return CGPoint(x: vectorX , y: vectorY)
    }
}


