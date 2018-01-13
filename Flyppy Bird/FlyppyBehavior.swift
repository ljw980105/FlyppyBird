//
//  FlyppyBehavior.swift
//  Flyppy Bird
//
//  Created by Jing Wei Li on 1/12/18.
//  Copyright © 2018 Jing Wei Li. All rights reserved.
//

import UIKit

class FlyppyBehavior: UIDynamicBehavior, UICollisionBehaviorDelegate{

    override init() {
        super.init()
        addChildBehavior(gravity)
        addChildBehavior(physics)
        addChildBehavior(collider)
    }
    
    private lazy var gravity: UIGravityBehavior = {
       let gravityBehavior = UIGravityBehavior()
        gravityBehavior.angle = CGFloat.pi * 0.5
        gravityBehavior.magnitude = 0.4
        return gravityBehavior
    }()
    
    private lazy var physics: UIDynamicItemBehavior = {
        let phys = UIDynamicItemBehavior()
        phys.resistance = 0
        phys.friction = 0
        phys.allowsRotation = false
        phys.elasticity = 1 // bounce ?
        return phys
    }()
    
    private lazy var collider: UICollisionBehavior = {
        let colli = UICollisionBehavior()
        colli.collisionMode = .everything
        colli.collisionDelegate = self
        //colli.translatesReferenceBoundsIntoBoundary = true
        let startPosition = CGPoint(x: 0, y: UIScreen.main.bounds.size.height)
        let endPosition = CGPoint(x: UIScreen.main.bounds.size.width, y: UIScreen.main.bounds.size.height)
        colli.addBoundary(withIdentifier: "Hello" as NSString, from: startPosition, to: endPosition)
        return colli
    }()
    
    func addBird(with bird:BirdView){
        gravity.addItem(bird)
        physics.addItem(bird)
        collider.addItem(bird)
    }
    
    func removeBird(with bird:BirdView){
        gravity.removeItem(bird)
        physics.removeItem(bird)
        collider.removeItem(bird)
    }
    
    func addObstacle(with obstacle:UIDynamicItem){
        collider.addItem(obstacle)
    }
    
    func removeObstacle(with obstacle:UIDynamicItem){
        collider.removeItem(obstacle)
    }
    
    func fly(){
        gravity.angle = CGFloat.pi * 1.5 // reverse gravity
        gravity.magnitude = 4.0
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false){ _ in
             self.gravity.angle = CGFloat.pi * 0.5
             self.gravity.magnitude = 0.4
        }
    }
    
    func flyByPush(with bird:BirdView){
        let pusher = UIPushBehavior(items: [bird], mode: .instantaneous)
        pusher.magnitude = 1.0
        pusher.angle = CGFloat.pi * 1.5
        addChildBehavior(pusher)
    }
    
    func collisionBehavior(_ behavior: UICollisionBehavior,
                           beganContactFor item1: UIDynamicItem, with item2: UIDynamicItem, at p: CGPoint) {
        print(p)
    }
}
