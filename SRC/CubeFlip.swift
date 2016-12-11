//
//  CubeFlip.swift
//  CubeFlip
//
//  Created by Norbert Billa on 22/09/2015.
//  Copyright © 2015 norbert-billa. All rights reserved.
//

import UIKit
import QuartzCore

public enum CubeFlipAnimation : CGFloat {
    case none       = 1
    case bouncing   = 0.58
    case whizzing   = 0.1
}

@IBDesignable open class CubeFlip<T: UIView>: UIView {
    
    public typealias CustomizeView = (T) -> ()
    
    open var animationWith                : CubeFlipAnimation = .bouncing
    fileprivate var view1                       : T!
    fileprivate var view2                       : T!
    fileprivate (set) open var viewOff        : T!
    fileprivate (set) open var viewOn         : T!
    fileprivate var isAnimated                  : Bool    = false
    
    
    open var duration                     : Double  = 1
    open var perspective                  : CGFloat = 500
    
    init(frame: CGRect, view1: T, view2: T, CubeFlipAnimation animation: CubeFlipAnimation = .bouncing) {
        super.init(frame: frame)
        self.view1          = view1
        self.view2          = view2
        self.animationWith  = animation
        
        view1.frame         = self.bounds
        view2.frame         = self.bounds
        
        self.subviewsSetup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        if self.subviews.count == 0 {
            self.xibSetup()
        }
    }
    
    fileprivate func xibSetup() {
        
        self.view1      = UIView(frame:self.bounds) as! T
        self.view2      = UIView(frame:self.bounds) as! T
        
        self.view1.backgroundColor = UIColor.black
        self.view2.backgroundColor = UIColor.blue
        
        self.subviewsSetup()
        
    }
    
    fileprivate func subviewsSetup() {
        self.addSubview(self.view1)
        self.addSubview(self.view2)
        
        self.viewOn     = self.view1
        self.viewOff    = self.view2
        
        self.viewOff.removeFromSuperview()
    }
    
    fileprivate func DEGREES_TO_RADIANS(_ degress : CGFloat) -> CGFloat { return degress * CGFloat(M_PI) / 180 }
    
    fileprivate func makeCloneViewIntoImage(_ viewOrigin : UIView) -> UIImageView {
        UIGraphicsBeginImageContext(viewOrigin.frame.size)
        viewOrigin.layer.render(in: UIGraphicsGetCurrentContext()!)
        let __ = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let viewImage = UIImageView(image: __)
        viewImage.frame = viewImage.frame
        self.addSubview(viewImage)
        return viewImage
    }
    
    
    fileprivate func commonSetupFlipEnd(imageOff : UIImageView, imageOn : UIImageView) {
        imageOff.removeFromSuperview()
        imageOn.removeFromSuperview()
        self.addSubview(self.viewOff)
        let tmp = self.viewOff
        self.viewOff = self.viewOn
        self.viewOn = tmp
        self.isAnimated = !self.isAnimated
        
    }
    
    fileprivate func commonSetupFlipStart() -> (imageOff:UIImageView, imageOn:UIImageView)? {
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
    
    open func flipDown(_ to: CustomizeView? = nil) {
        
        let imageOff    : UIImageView!
        let imageOn     : UIImageView!
        
        if let setupBlock = to {
            setupBlock(self.viewOff)
        }
        
        if let __ = self.commonSetupFlipStart() {
            imageOff    =  __.imageOff
            imageOn     =  __.imageOn
        } else { return }
        
        var trans : CATransform3D = CATransform3DIdentity
        trans = CATransform3DRotate(trans, self.DEGREES_TO_RADIANS(90), 1, 0, 0 )
        trans = CATransform3DTranslate ( trans, 0, -self.bounds.height/2, 0 )
        trans = CATransform3DTranslate ( trans, 0, 0, self.bounds.height/2 )
        imageOff.layer.transform     = trans
        
        
        UIView.animate(withDuration: self.duration, delay: 0, usingSpringWithDamping:  self.animationWith.rawValue, initialSpringVelocity: 0, options: UIViewAnimationOptions(), animations: {
            
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
    
    open func flipUp(_ to: CustomizeView? = nil) {
        
        let imageOff    : UIImageView!
        let imageOn     : UIImageView!
        
        if let setupBlock = to {
            setupBlock(self.viewOff)
        }        
        
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
        
        UIView.animate(withDuration: self.duration, delay: 0, usingSpringWithDamping:  self.animationWith.rawValue, initialSpringVelocity: 0, options: UIViewAnimationOptions(), animations: {
            
            
            trans                           = CATransform3DIdentity
            trans = CATransform3DRotate(trans, self.DEGREES_TO_RADIANS(90), 1, 0, 0 )
            imageOn.layer.transform         = trans
            imageOn.frame.origin.y          = 0
            
            trans                           = CATransform3DIdentity
            imageOff.layer.transform        = trans
            imageOff.frame.origin.y         = 0
            self.layoutIfNeeded()
            
        }) { (_) in
            self.commonSetupFlipEnd(imageOff: imageOff, imageOn: imageOn)
   
        }
    }
    
}
