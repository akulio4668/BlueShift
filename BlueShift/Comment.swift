//
//  Comment.swift
//  BlueShift
//
//  Created by Akul Joshi on 7/7/17.
//  Copyright © 2017 Nebula. All rights reserved.
//

import UIKit

class Comment: NSObject
{
    var letterPossibilities = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    let imageRandom = Int(arc4random() % UInt32(5))
    var imageUsing: UIImage!
    var nameUsing: String = "Person "
    var content: String!
    var likesCount: Int = 0
    var isClicked: Bool = false
    var imageString: String!
    
    init(CommentName: String, CommentImage: UIImage, Content: String, NumLikes: Int)
    {
        nameUsing = CommentName
        imageUsing = CommentImage
        content = Content
        likesCount = NumLikes
    }
    
    init(Content: String)
    {
        switch imageRandom
        {
        case 0:
            imageString = "pWhite"
        case 1:
            imageString = "pRed"
        case 2:
            imageString = "pBlue"
        case 3:
            imageString = "pGreen"
        case 4:
            imageString = "pBlack"
        default:
            break
        }
        
        imageUsing = UIImage(named: imageString)
        
        for index in 0...7
        {
            let letterRandom = Int(arc4random() % UInt32(letterPossibilities.count))
            nameUsing += letterPossibilities[letterRandom]
        }
        
        content = Content
    }
}
