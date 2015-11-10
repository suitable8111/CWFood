//
//  FavorFood.swift
//  CWFood
//
//  Created by 김대호 on 2015. 11. 10..
//  Copyright © 2015년 김대호. All rights reserved.
//

import Foundation
import CoreData

@objc(MyFood)

class MyFood:NSManagedObject {
    @NSManaged var date: String
    @NSManaged var name: String
    @NSManaged var time: String
    @NSManaged var image: String
}