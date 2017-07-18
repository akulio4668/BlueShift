//
//  Profile.swift
//  BlueShift
//
//  Created by Akul Joshi on 6/28/17.
//  Copyright © 2017 Nebula. All rights reserved.
//

import UIKit

class Profile: NSObject
{
    let name: String!
    var image: UIImage!
    
    init(Name: String, Image: UIImage)
    {
        name = Name
        image = Image
    }
}
