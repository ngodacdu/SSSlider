//
//  SSForcegroundView.swift
//  SSForcegroundView
//
//  Created by ngodacdu on 6/30/17.
//  Copyright © 2017 ngodacdu. All rights reserved.
//

import UIKit

enum TouchAction {
    case down
    case move
    case up
}

class SSForcegroundView: UIView {
    
    var didTouchBegan: ((_ touches: Set<UITouch>, _ event: UIEvent?) -> ())?
    var didTouchMoved: ((_ touches: Set<UITouch>, _ event: UIEvent?) -> ())?
    var didTouchEnded: ((_ touches: Set<UITouch>, _ event: UIEvent?) -> ())?

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        didTouchBegan?(touches, event)
        super.touchesBegan(touches, with: event)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        didTouchMoved?(touches, event)
        super.touchesMoved(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        didTouchEnded?(touches, event)
        super.touchesEnded(touches, with: event)
    }

}
