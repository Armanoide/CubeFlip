# CubeFlip
Simple flip cube, box in swift

## Install

With CocoaPods:

    pod 'CubeFlip'
CocoaPods requires iOS 8.0 or higher.
If you're supporting iOS 7, or if you prefer, you can just drop CubeFlip.swift to your project.


## Basic

        let cube = CubeFlip(frame: CGRectMake(10, 100, self.view.bounds.width - 20, 160), view1: UIView()), view2: UIView()))
        self.view.addSubview(cube)

        cube.flipUp { (s: UIView) -> () in
        }

## Animation
You can change animation with proprety animationWith.
       
        cube.animationWith = CubeFlipAnimation.Bouncing


## Contributors
thanks to [badeleux] (https://github.com/badeleux) to adding a new simple way to customizing views on the fly.

![alt tag](https://github.com/Armanoide/CubeFlip/blob/master/DEMO/demo.gif)

