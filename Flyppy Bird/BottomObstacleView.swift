//
//  BottomObstacleView.swift
//  Flyppy Bird
//
//  Created by Jing Wei Li on 1/12/18.
//  Copyright © 2018 Jing Wei Li. All rights reserved.
//

import UIKit

class BottomObstacleView: UIImageView {

    convenience init(){
        self.init(frame: CGRect.zero)
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup(){
        image = UIImage(named: "obstacle-bottom")
        frame.size = image!.size
    }

}
