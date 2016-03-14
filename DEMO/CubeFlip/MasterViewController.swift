//
//  MasterViewController.swift
//  CubeFlip
//
//  Created by Norbert Billa on 22/09/2015.
//  Copyright © 2015 norbert-billa. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController {

    var cube : CubeFlip!

    @IBOutlet weak var btnFlipDOWN: UIButton!
    @IBOutlet weak var btnFlipUP: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cube = CubeFlip(frame: CGRectMake(10, 200, self.view.bounds.width - 20, 160))
        var text = UILabel(frame: self.cube.bounds)
        text.textAlignment = .Center
        text.text = "TEXT 1"
        text.textColor = UIColor.whiteColor()
        self.cube.viewOn.addSubview(text)
        self.cube.viewOn.backgroundColor = UIColor.redColor()

        text = UILabel(frame: self.cube.bounds)
        text.textAlignment = .Center
        text.text = "TEXT 2"
        text.textColor = UIColor.whiteColor()
        self.cube.viewOff.addSubview(text)
        self.cube.viewOff.backgroundColor = UIColor.blueColor()

        
        self.view.addSubview(cube)
        self.btnFlipDOWN.addTarget(self, action: "flipDown", forControlEvents: UIControlEvents.TouchUpInside)
        self.btnFlipUP.addTarget(self, action: "flipUP", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func flipUP()
    {
        self.cube.flipUp { () -> Void in
            print("over up")
        }
    }
    
    func flipDown() {
        self.cube.flipDown { () -> Void in
            print("over down")
        }
    }
    
}

