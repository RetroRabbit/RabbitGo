//
//  CGRect + ProjectR .swift
//  ProjectR
//
//  Created by Niell Agenbag on 2017/07/12.
//  Copyright © 2017 Retro Rabbit Professional Services. All rights reserved.
//

import UIKit

extension CGRect {
    var x: CGFloat {
        get { return origin.x }
        set { self = CGRect(x: newValue, y: minY, width: width, height: height) }
    }
    
    var y: CGFloat {
        get { return origin.y }
        set { self = CGRect(x: x, y: newValue, width: width, height: height) }
    }
    
    var width: CGFloat {
        get { return size.width }
        set { self = CGRect(x: x, y: width, width: newValue, height: height) }
    }
    
    var height: CGFloat {
        get { return size.height }
        set { self = CGRect(x: x, y: minY, width: width, height: newValue) }
    }
    
    
    var top: CGFloat {
        get { return origin.y }
        set { y = newValue }
    }
    
    var bottom: CGFloat {
        get { return origin.y + size.height }
        set { self = CGRect(x: x, y: newValue - height, width: width, height: height) }
    }
    
    var left: CGFloat {
        get { return origin.x }
        set { x = newValue }
    }
    
    var right: CGFloat {
        get { return x + width }
        set { self = CGRect(x: newValue - width, y: y, width: width, height: height) }
    }
    
    
    var midX: CGFloat {
        get { return x + width / 2 }
        set { self = CGRect(x: newValue - width / 2, y: y, width: width, height: height) }
    }
    
    var midY: CGFloat {
        get { return y + height / 2 }
        set { self = CGRect(x: x, y: newValue - height / 2, width: width, height: height) }
    }
    
    
    var center: CGPoint {
        get { return CGPoint(x: midX, y: midY) }
        set { self = CGRect(x: newValue.x - width / 2, y: newValue.y - height / 2, width: width, height: height) }
    }
}
