//
//  CubeFlip.swift
//  CubeFlip
//
//  Created by Norbert Billa on 22/09/2015.
//  Copyright © 2015 norbert-billa. All rights reserved.
//

import UIKit
import QuartzCore

@IBDesignable class CubeFlip: UIView {
    
    private var view1               : UIView!
    private var view2               : UIView!
    private (set) var viewOff       : UIView!
    private (set) var viewOn        : UIView!
    private var isAnimated          : Bool = false
    
    internal var duration            : Double    = 1.2
    internal var perspective         : CGFloat   = 500
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        if self.subviews.count == 0 {
            self.xibSetup()
        }
    }
    
    private func xibSetup() {
        
        self.view1      = UIView(frame:self.bounds)
        self.view2      = UIView(frame:self.bounds)
        
        self.view1.backgroundColor = UIColor.blackColor()
        self.view2.backgroundColor = UIColor.blueColor()
        
        self.addSubview(self.view1)
        self.addSubview(self.view2)
        
        self.viewOn     = self.view1
        self.viewOff    = self.view2
        
        self.viewOff.removeFromSuperview()
    }
    
    func DEGREES_TO_RADIANS(degress : CGFloat) -> CGFloat { return degress * CGFloat(M_PI) / 180 }
    
    
    private func makeCloneViewIntoImage(viewOrigin : UIView) -> UIImageView {
        UIGraphicsBeginImageContext(viewOrigin.frame.size)
        viewOrigin.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let __ = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let viewImage = UIImageView(image: __)
        viewImage.frame = viewImage.frame
        self.addSubview(viewImage)
        return viewImage
    }
    
    
    private func commonSetupFlipEnd(imageOff imageOff : UIImageView, imageOn : UIImageView) {
        imageOff.removeFromSuperview()
        imageOn.removeFromSuperview()
        self.addSubview(self.viewOff)
        let tmp = self.viewOff
        self.viewOff = self.viewOn
        self.viewOn = tmp
        self.isAnimated = !self.isAnimated
        
    }
    
    private func commonSetupFlipStart() -> (imageOff:UIImageView, imageOn:UIImageView)? {
        if self.isAnimated { return nil }
        
        self.isAnimated = !self.isAnimated
        let imageOff    = self.makeCloneViewIntoImage(self.viewOff)
        let imageOn     = self.makeCloneViewIntoImage(self.viewOn)
        
        self.viewOff.removeFromSuperview()
        self.viewOn.removeFromSuperview()
        
        var rotationAndPerspectiveTransform = CATransform3DIdentity;
        rotationAndPerspectiveTransform.m34 = 1.0 / -(abs(self.perspective))
        self.layer.sublayerTransform = rotationAndPerspectiveTransform
        return (imageOff, imageOn)
    }
    
    internal func flipDown() {
        
        let imageOff    : UIImageView!
        let imageOn     : UIImageView!
        
        if let __ = self.commonSetupFlipStart() {
            imageOff    =  __.imageOff
            imageOn     =  __.imageOn
        } else { return }
        
        var trans : CATransform3D = CATransform3DIdentity
        trans = CATransform3DRotate(trans, self.DEGREES_TO_RADIANS(90), 1, 0, 0 )
        trans = CATransform3DTranslate ( trans, 0, -self.bounds.height/2, 0 )
        trans = CATransform3DTranslate ( trans, 0, 0, self.bounds.height/2 )
        imageOff.layer.transform     = trans
        
        
        UIView.animateKeyframesWithDuration(self.duration, delay: 0, options: .CalculationModeLinear, animations: { () -> Void in
            
            trans                           = CATransform3DIdentity
            imageOff.layer.transform        = trans
            imageOff.frame.origin.y         = 0
            
            trans  = CATransform3DIdentity
            trans = CATransform3DRotate(trans, self.DEGREES_TO_RADIANS(-90), 1, 0, 0 )
            imageOn.layer.transform         = trans
            imageOn.frame.origin.y          = self.bounds.height
            
            
            }) { (__) -> Void in
                self.commonSetupFlipEnd(imageOff: imageOff, imageOn: imageOn)
        }
    }
    
    internal func flipUp() {
        
        let imageOff    : UIImageView!
        let imageOn     : UIImageView!
        
        if let __ = self.commonSetupFlipStart() {
            imageOff    =  __.imageOff
            imageOn     =  __.imageOn
        } else { return }
        
        var trans : CATransform3D = CATransform3DIdentity
        trans = CATransform3DRotate(trans, self.DEGREES_TO_RADIANS(-90), 1, 0, 0 )
        trans = CATransform3DTranslate ( trans, 0, self.bounds.height/2, 0 )
        trans = CATransform3DTranslate ( trans, 0, 0, -self.bounds.height/2 )
        imageOff.frame.origin.y      = self.bounds.height
        imageOff.layer.transform     = trans
        
        UIView.animateKeyframesWithDuration(self.duration, delay: 0, options: UIViewKeyframeAnimationOptions.CalculationModeLinear, animations: { () -> Void in
            
            trans                           = CATransform3DIdentity
            trans = CATransform3DRotate(trans, self.DEGREES_TO_RADIANS(90), 1, 0, 0 )
            imageOn.layer.transform         = trans
            imageOn.frame.origin.y          = 0
            
            trans                           = CATransform3DIdentity
            imageOff.layer.transform        = trans
            imageOff.frame.origin.y         = 0
            
            }) { (__) -> Void in
                self.commonSetupFlipEnd(imageOff: imageOff, imageOn: imageOn)
        }
    }
    
}