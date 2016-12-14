//
//  Path.swift
//  WhiteBoard
//
//  Created by jinmao on 2016/12/14.
//  Copyright © 2016年 jinmao. All rights reserved.
//

import UIKit

protocol Mark: NSCopying, NSCoding{
    var color: UIColor? {get set}
    var size: CGFloat? {get set}
    var location: CGPoint {get set}
    var lastChild: Mark? {get}
    var count: UInt {get }
    
    func addMark()
    func removeMark(_ mark: Mark)
    func childAtIndex(_ index: UInt) -> Mark?
    
    func drawWithContext(_ contenxt: CGContext)
    
}

