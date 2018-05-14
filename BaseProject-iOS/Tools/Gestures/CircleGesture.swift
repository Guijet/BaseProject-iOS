//
//  CircleGesture
//  TestCircle
//
//  Created by Guillaume Jette on 2018-01-08.
//  Copyright © 2018 Guillaume Jette. All rights reserved.
//

import UIKit
import UIKit.UIGestureRecognizerSubclass

class CyclingGestureRecognizer: UIGestureRecognizer {
    var rotation:CGFloat = 0
    var cumulativeRotation: CGFloat = 0
    var velocitySamples: [CGFloat] = []
    override init(target: (Any)?, action: Selector?) {
        super.init(target: target, action: action)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        if event.touches(for: self)!.count > 1 {
            self.state = .failed
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        if self.state == .possible {
            self.state = .began
        } else {
            self.state = .changed
        }
        
        let touch = touches.first!
        let view = self.view!
        let center = CGPoint(x:view.bounds.midX, y:view.bounds.midY)
        let currentTouchPoint = touch.location(in: view)
        let previousTouchPoint = touch.previousLocation(in: view)
        
        let angle1 = atan2f(Float(currentTouchPoint.y - center.y),
                            Float(currentTouchPoint.x - center.x))
        let angle2 = atan2f(Float(previousTouchPoint.y - center.y),
                            Float(previousTouchPoint.x - center.x))
        if abs(angle2 - angle1) > 4 {
            cumulativeRotation += rotation
        } else {
            velocitySamples.append(CGFloat(angle2 - angle1))
            let angleInRadians:CGFloat = CGFloat(angle1 - angle2)
            //let angleInDegrees: CGFloat = angleInRadians / (2 * CGFloat(Double.pi)) * 360
            rotation = angleInRadians
            cumulativeRotation += angleInRadians
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        self.state = .failed
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        if (self.state == .changed) {
            self.state = .ended
            cumulativeRotation = cumulativeRotation .truncatingRemainder(dividingBy: (2 * CGFloat(Double.pi)))
        } else {
            self.state = .failed
        }
    }
}

