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

    @IBOutlet weak var btnFlipDOWN: UIButton!
    @IBOutlet weak var btnFlipUP: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
<<<<<<< HEAD
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

=======
        self.cube = CubeFlip(frame: CGRectMake(10, 200, self.view.bounds.width - 20, 160), view1: CubeSubView().bgColor(UIColor.redColor()), view2: CubeSubView().bgColor(UIColor.greenColor()))
>>>>>>> 59b3355e254978394f753d228256b63c89cf1912
        
        self.view.addSubview(cube)
        self.btnFlipDOWN.addTarget(self, action: "flipDown", forControlEvents: UIControlEvents.TouchUpInside)
        self.btnFlipUP.addTarget(self, action: "flipUP", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    
    func flipUP()
    {
<<<<<<< HEAD
        self.cube.flipUp { () -> Void in
            print("over up")
=======
        self.cube.flipUp { (s: CubeSubView) -> () in
            s.label.text = "Flip number: " + (--self.counter).description
>>>>>>> 59b3355e254978394f753d228256b63c89cf1912
        }
    }
    
    func flipDown() {
<<<<<<< HEAD
        self.cube.flipDown { () -> Void in
            print("over down")
=======
        self.cube.flipDown { (s: CubeSubView) -> () in
            s.label.text = "Flip number: " + (++self.counter).description
>>>>>>> 59b3355e254978394f753d228256b63c89cf1912
        }
    }
    
}

