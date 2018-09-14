import Foundation
import UIKit
import QMUIKit

public class AnimView : UIView{
    public override init(frame: CGRect){
        super.init(frame: frame)
        custom()
    }
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        custom()
    }
    private func custom(){
        let shapeView1 = UIView(frame: CGRect(x: CGFloat(0), y: CGFloat(7), width: CGFloat(16), height: CGFloat(16)))
        shapeView1.backgroundColor = QMUIConfiguration.sharedInstance()?.greenColor
        shapeView1.layer.cornerRadius = 8
        self.addSubview(shapeView1)
        
        let shapeView2 = UIView(frame: CGRect(x: CGFloat(0), y: CGFloat(7), width: CGFloat(16), height: CGFloat(16)))
        shapeView2.backgroundColor = QMUIConfiguration.sharedInstance()?.redColor
        shapeView2.layer.cornerRadius = 8
        self.addSubview(shapeView2)
        
        let shapeView3 = UIView(frame: CGRect(x: CGFloat(0), y: CGFloat(7), width: CGFloat(16), height: CGFloat(16)))
        shapeView3.backgroundColor = QMUIConfiguration.sharedInstance()?.blueColor
        shapeView3.layer.cornerRadius = 8
        self.addSubview(shapeView3)
        
        let positionAnimation = CAKeyframeAnimation()
        positionAnimation.keyPath = "position.x"
        positionAnimation.values = [-5, 0, 10, 40, 70, 80, 75]
        positionAnimation.keyTimes = [0, (5.0/90.0) as NSNumber, (15.0/90.0)  as NSNumber, (45.0/90.0) as NSNumber, (75.0/90.0) as NSNumber, (85.0/90.0) as NSNumber, 1]
        positionAnimation.isAdditive = true
        
        let scaleAnimation = CAKeyframeAnimation()
        scaleAnimation.keyPath = "transform.scale"
        scaleAnimation.values = [0.7, 0.9, 1, 0.9, 0.7]
        scaleAnimation.keyTimes = [0, (15 / 90.0) as NSNumber, (45 / 90.0) as NSNumber, (75 / 90.0) as NSNumber, 1]
        
        let alphaAnimation = CAKeyframeAnimation()
        alphaAnimation.keyPath = "opacity"
        alphaAnimation.values = [0, 1, 1, 1, 0]
        alphaAnimation.keyTimes = [0, (1 / 6.0) as NSNumber, (3 / 6.0) as NSNumber, (5 / 6.0) as NSNumber, 1]
        
        let group = CAAnimationGroup()//.animation()
        group.animations = [positionAnimation, scaleAnimation, alphaAnimation]
        group.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        group.repeatCount = Float.infinity
        group.duration = 1.3
        
        shapeView1.layer.add(group, forKey: "basic1")
        group.timeOffset = 0.43
        shapeView2.layer.add(group, forKey: "basic2")
        group.timeOffset = 0.86
        shapeView3.layer.add(group, forKey: "basic3")
    }
}
