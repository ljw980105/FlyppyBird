//
//  ObstacleBehavior.swift
//  Flyppy Bird
//
//  Created by Jing Wei Li on 1/12/18.
//  Copyright © 2018 Jing Wei Li. All rights reserved.
//

import UIKit

class ObstacleBehavior: UIDynamicBehavior {
    
    override init() {
        super.init()
        addChildBehavior(obstacleGravity)
    }
    
    private lazy var obstacleGravity: UIGravityBehavior = {
        let gravityBehavior = UIGravityBehavior()
        gravityBehavior.angle = CGFloat.pi
        gravityBehavior.magnitude = 0.1
        return gravityBehavior
    }()
    
    private lazy var physics: UIDynamicItemBehavior = {
        let spd = UIDynamicItemBehavior()
        return spd
    }()
    
    private lazy var obstacleCollision: UICollisionBehavior = {
        let collision = UICollisionBehavior()
        collision.collisionMode = .everything
        return collision
    }()
    
    func addObstacle(with obstacle:UIDynamicItem){
        obstacleGravity.addItem(obstacle)
    }
    
    func removeObstacle(with obstacle:UIDynamicItem){
        obstacleGravity.removeItem(obstacle)
    }

}
