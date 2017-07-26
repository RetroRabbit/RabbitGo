//
//  RhinoRocksFont.swift
//  ProjectR
//
//  Created by Wesley Buck on 2017/07/21.
//  Copyright © 2017 Retro Rabbit Professional Services. All rights reserved.
//

import Material
import UIKit

public struct ProjectRFont: FontType {
    /**
     Regular with size font.
     - Parameter with size: A CGFLoat for the font size.
     - Returns: A UIFont.
     */
    public static func RhinoRocks(with size: CGFloat) -> UIFont {
        Font.loadFontIfNeeded(name: "Rhinos-rocks")
        
        if let f = UIFont(name: "Rhinos-rocks", size: size) {
            return f
        }
        
        return Font.systemFont(ofSize: size)
    }
    
    public static func AvenirLightOblique(with size: CGFloat) -> UIFont {
        Font.loadFontIfNeeded(name: "Avenir-LightOblique")
        
        if let f = UIFont(name: "Avenir-LightOblique", size: size) {
            return f
        }
        
        return Font.systemFont(ofSize: size)
    }
    
    public static func AvenirHeavy(with size: CGFloat) -> UIFont {
        Font.loadFontIfNeeded(name: "Avenir-Heavy")
        
        if let f = UIFont(name: "Avenir-Heavy", size: size) {
            return f
        }
        
        return Font.systemFont(ofSize: size)
    }
}
