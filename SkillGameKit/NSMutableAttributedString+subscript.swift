//
//  NSMutableAttributedString+subscript.swift
//  SkillGameKit
//
//  Created by Kirill Khudyakov on 18.07.17.
//  Copyright © 2017 adeveloper. All rights reserved.
//

import UIKit

extension NSMutableAttributedString
{
    enum scripting : Int
    {
        case aSub = -1
        case aSuper = 1
    }
    
    func characterSubscriptAndSuperscript(string:String,
                                          characters:[Character],
                                          type:scripting,
                                          fontSize:CGFloat,
                                          scriptFontSize:CGFloat,
                                          offSet:Int,
                                          length:[Int],
                                          alignment:NSTextAlignment)-> NSMutableAttributedString
    {
        let paraghraphStyle = NSMutableParagraphStyle()
        // Set The Paragraph aligmnet , you can ignore this part and delet off the function
        paraghraphStyle.alignment = alignment
        
        var scriptedCharaterLocation = Int()
        //Define the fonts you want to use and sizes
        let stringFont = UIFont.boldSystemFont(ofSize: fontSize)
        let scriptFont = UIFont.boldSystemFont(ofSize: scriptFontSize)
        // Define Attributes of the text body , this part can be removed of the function
        let attString = NSMutableAttributedString(string:string, attributes: [NSFontAttributeName:stringFont,NSForegroundColorAttributeName:UIColor.black,NSParagraphStyleAttributeName: paraghraphStyle])
        
        // the enum is used here declaring the required offset
        let baseLineOffset = offSet * type.rawValue
        // enumerated the main text characters using a for loop
        for (i,c) in string.characters.enumerated()
        {
            // enumerated the array of first characters to subscript
            for (theLength,aCharacter) in characters.enumerated()
            {
                if c == aCharacter
                {
                    // Get to location of the first character
                    scriptedCharaterLocation = i
                    //Now set attributes starting from the character above
                    attString.setAttributes([NSFontAttributeName:scriptFont,
                                             // baseline off set from . the enum i.e. +/- 1
                        NSBaselineOffsetAttributeName:baseLineOffset,
                        NSForegroundColorAttributeName:UIColor.black],
                                            // the range from above location
                        range:NSRange(location:scriptedCharaterLocation,
                                      // you define the length in the length array
                            // if subscripting at different location
                            // you need to define the length for each one
                            length:length[theLength]))
                    
                }
            }
        }
        return attString}
}
