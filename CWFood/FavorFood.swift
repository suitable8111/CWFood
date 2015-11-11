//
//  FavorFood.swift
//  CWFood
//
//  Created by 김대호 on 2015. 11. 10..
//  Copyright © 2015년 김대호. All rights reserved.
//

import Foundation
import CoreData

@objc(FavorFood)

class FavorFood:NSManagedObject {
    
    @NSManaged var primeKey: Int32
    @NSManaged var date: String
    @NSManaged var name: String
    @NSManaged var time: String

}