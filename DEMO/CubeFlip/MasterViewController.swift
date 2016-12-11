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
        super.init(frame: CGRect.zero)
        label.text = "Default Text!"
        label.textAlignment = .center
        self.addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = self.bounds
    }
    
    func bgColor(_ color: UIColor) -> CubeSubView {
        self.backgroundColor = color
        return self
    }
    
}

class MasterViewController: UIViewController {
    
    var cube : CubeFlip<CubeSubView>!
    var counter: Int = 0
    
    @IBOutlet fileprivate weak var btnFlipDOWN          : UIButton!
    @IBOutlet fileprivate weak var btnFlipUP            : UIButton!
    @IBOutlet fileprivate weak var btnFlipUpWHIZZING    : UIButton!
    @IBOutlet fileprivate weak var btnFlipUpBOUNCING    : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.cube = CubeFlip(frame: CGRect(x: 10, y: 100, width: self.view.bounds.width - 20, height: 160), view1: CubeSubView().bgColor(UIColor.red), view2: CubeSubView().bgColor(UIColor.green))
        self.view.addSubview(cube)
        self.btnFlipDOWN.addTarget(self, action: #selector(MasterViewController.flipDown), for: UIControlEvents.touchUpInside)
        self.btnFlipUP.addTarget(self, action: #selector(MasterViewController.flipUP), for: UIControlEvents.touchUpInside)
        self.btnFlipUpWHIZZING.addTarget(self, action: #selector(MasterViewController.flipUPWhizzing), for: UIControlEvents.touchUpInside)
        self.btnFlipUpBOUNCING.addTarget(self, action: #selector(MasterViewController.flipUPBouncing), for: UIControlEvents.touchUpInside)
    }

    func flipUPBouncing()
    {
        self.cube.animationWith = CubeFlipAnimation.bouncing
        
        self.cube.flipUp { (s: CubeSubView) -> () in
            self.counter -= 1
            s.label.text = "Flip number: " + ( self.counter ).description
        }
        self.cube.animationWith = CubeFlipAnimation.none
        
    }
    
    func flipUPWhizzing()
    {
        self.cube.animationWith = CubeFlipAnimation.whizzing
        
        self.cube.flipUp { (s: CubeSubView) -> () in
            self.counter -= 1
            s.label.text = "Flip number: " + ( self.counter ).description
        }
        self.cube.animationWith = CubeFlipAnimation.none
        
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

