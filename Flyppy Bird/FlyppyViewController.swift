//
//  ViewController.swift
//  Flyppy Bird
//
//  Created by Jing Wei Li on 1/12/18.
//  Copyright © 2018 Jing Wei Li. All rights reserved.
//

import UIKit

class FlyppyViewController: UIViewController {

    var counter  = 0
    private lazy var animator: UIDynamicAnimator = UIDynamicAnimator()
    private lazy var obstacleAnimator: UIDynamicAnimator = UIDynamicAnimator()
    private var flyppyBird:BirdView!
    private var flyppyBehavior = FlyppyBehavior()
    private var obstacleBehavior = ObstacleBehavior()
    var timer1: Timer!
    var timer2: Timer!
    var isGeneratingObstacle = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        flyppyBird = BirdView()
        flyppyBird.center = CGPoint(x: view.frame.size.width/2, y: view.frame.size.height/2)
        view.addSubview(flyppyBird)
        //view.backgroundColor = UIColor.blue
        generateObstacles()
        timer2 = Timer.scheduledTimer(withTimeInterval: 2.5, repeats: true){ _ in
            self.generateObstacles()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        flyppyBehavior.addBird(with: flyppyBird)
        animator.addBehavior(flyppyBehavior)
        obstacleAnimator.addBehavior(obstacleBehavior)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        animator.removeBehavior(flyppyBehavior)
        obstacleAnimator.removeBehavior(obstacleBehavior)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tap(_ sender: UITapGestureRecognizer) {
        flyppyBehavior.fly()
    }
    
    func randomNumber(range: ClosedRange<Int> = -80...198) -> CGFloat {
        let min = range.lowerBound
        let max = range.upperBound
        return CGFloat(Int(arc4random_uniform(UInt32(1 + max - min))) + min)
    }
    
    private func generateObstacles(){
        let topObstacle = TopObstacleView()
        let bottomObstacle = BottomObstacleView()
        // position randomly
        let openingOffset:CGFloat = randomNumber()// value ranges between -80 to 198
        let widthOffset:CGFloat = view.frame.size.width + 30//-topObstacle.frame.size.width
        topObstacle.center = CGPoint(x: widthOffset, y: openingOffset)
        bottomObstacle.center = CGPoint(x: widthOffset, y: openingOffset+topObstacle.frame.size.height + 150)

        obstacleBehavior.addObstacle(with: topObstacle)
        obstacleBehavior.addObstacle(with: bottomObstacle)
        flyppyBehavior.addObstacle(with: topObstacle)
        flyppyBehavior.addObstacle(with: bottomObstacle)
        
        view.addSubview(topObstacle)
        view.addSubview(bottomObstacle)
        
        timer1 = Timer.scheduledTimer(withTimeInterval: 3.3, repeats: false){ _ in
            self.obstacleBehavior.removeObstacle(with: topObstacle)
            self.obstacleBehavior.removeObstacle(with: bottomObstacle)
//            self.flyppyBehavior.removeObstacle(with: topObstacle)
//            self.flyppyBehavior.removeObstacle(with: bottomObstacle)
            topObstacle.removeFromSuperview()
            bottomObstacle.removeFromSuperview()
            self.timer1.invalidate()
        }
    
    }
    
}

