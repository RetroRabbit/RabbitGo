//
//  String+ProjectR.swift
//  ProjectR
//
//  Created by Wesley Buck on 2017/07/27.
//  Copyright © 2017 Retro Rabbit Professional Services. All rights reserved.
//

import UIKit

extension NSAttributedString {
    func highlight(attributes: [String: Any]) -> NSAttributedString {
        let regex = try! NSRegularExpression(pattern:"\\*(.*?)\\*", options: [])
        let mutable = NSMutableAttributedString(attributedString: self)
        let numberMatches = regex.numberOfMatches(in: mutable.string, options: [], range: NSMakeRange(0, mutable.string.characters.count))
        for _ in 0 ..< numberMatches {
            let range0 = regex.rangeOfFirstMatch(in: mutable.string, options: [], range: NSMakeRange(0, mutable.string.characters.count))
            let range1 = NSRange(location: range0.location + 1, length: range0.length - 2)
            mutable.replaceCharacters(
                in: range0,
                with: NSAttributedString(
                    string: (mutable.string as NSString).substring(with: range1),
                    attributes: attributes))
        }
        return mutable as NSAttributedString
    }
    
    func height(forWidth width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        return boundingBox.height
    }
    
    func width(forHeight height: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        return boundingBox.width
    }
}
