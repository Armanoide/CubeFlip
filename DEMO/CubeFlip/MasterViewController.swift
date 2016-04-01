//
//  MasterViewController.swift
//  CubeFlip
//
//  Created by Norbert Billa on 22/09/2015.
//  Copyright © 2015 norbert-billa. All rights reserved.
//

import UIKit

class CubeSubView : UIView {
    let label: UILabel = UILabel()
    init () {
        super.init(frame: CGRectZero)
        label.text = "Default Text!"
        label.textAlignment = .Center
        self.addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = self.bounds
    }
    
    func bgColor(color: UIColor) -> CubeSubView {
        self.backgroundColor = color
        return self
    }
    
}

class MasterViewController: UIViewController {
    
    var cube : CubeFlip<CubeSubView>!
    var counter: Int = 0
    
    @IBOutlet private weak var btnFlipDOWN          : UIButton!
    @IBOutlet private weak var btnFlipUP            : UIButton!
    @IBOutlet private weak var btnFlipUpWHIZZING    : UIButton!
    @IBOutlet private weak var btnFlipUpBOUNCING    : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.cube = CubeFlip(frame: CGRectMake(10, 100, self.view.bounds.width - 20, 160), view1: CubeSubView().bgColor(UIColor.redColor()), view2: CubeSubView().bgColor(UIColor.greenColor()))
        self.view.addSubview(cube)
        self.btnFlipDOWN.addTarget(self, action: #selector(MasterViewController.flipDown), forControlEvents: UIControlEvents.TouchUpInside)
        self.btnFlipUP.addTarget(self, action: #selector(MasterViewController.flipUP), forControlEvents: UIControlEvents.TouchUpInside)
        self.btnFlipUpWHIZZING.addTarget(self, action: #selector(MasterViewController.flipUPWhizzing), forControlEvents: UIControlEvents.TouchUpInside)
        self.btnFlipUpBOUNCING.addTarget(self, action: #selector(MasterViewController.flipUPBouncing), forControlEvents: UIControlEvents.TouchUpInside)
    }

    func flipUPBouncing()
    {
        self.cube.animationWith = CubeFlipAnimation.Bouncing
        
        self.cube.flipUp { (s: CubeSubView) -> () in
            self.counter -= 1
            s.label.text = "Flip number: " + ( self.counter ).description
        }
        self.cube.animationWith = CubeFlipAnimation.None
        
    }
    
    func flipUPWhizzing()
    {
        self.cube.animationWith = CubeFlipAnimation.Whizzing
        
        self.cube.flipUp { (s: CubeSubView) -> () in
            self.counter -= 1
            s.label.text = "Flip number: " + ( self.counter ).description
        }
        self.cube.animationWith = CubeFlipAnimation.None
        
    }
    
    

    
    func flipUP()
    {
        self.cube.flipUp { (s: CubeSubView) -> () in
            self.counter -= 1
            s.label.text = "Flip number: " + ( self.counter ).description
        }
    }
    
    func flipDown() {
        
        self.cube.flipDown { (s: CubeSubView) -> () in
            self.counter += 1
            s.label.text = "Flip number: " + (self.counter ).description
        }
    }
    
}

