# CubeFlip
Simple flip cube, box in swift

## Install

With CocoaPods:

    pod 'CubeFlip'
Cocoapods requires iOS 8.0 or higher.
If you're supporting iOS 7, or if you prefer, you can just drop CubeFlip.swift to your project.


## Basic
     
        let cube = CubeFlip(frame: CGRectMake(10, 200, self.view.bounds.width - 20, 160))
        var text = UILabel(frame: self.cube.bounds)
        text.textAlignment = .Center
        text.text = "TEXT 1"
        text.textColor = UIColor.whiteColor()
        cube.viewOn.addSubview(text)
        cube.viewOn.backgroundColor = UIColor.redColor()

        text = UILabel(frame: self.cube.bounds)
        text.textAlignment = .Center
        text.text = "TEXT 2"
        text.textColor = UIColor.whiteColor()
        cube.viewOff.addSubview(text)
        cube.viewOff.backgroundColor = UIColor.blueColor()
        
        self.view.addSubview(cube)
