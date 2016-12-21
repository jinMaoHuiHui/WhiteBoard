//
//  Path.swift
//  WhiteBoard
//
//  Created by jinmao on 2016/12/14.
//  Copyright © 2016年 jinmao. All rights reserved.
//

import UIKit

protocol Mark: class, NSCopying, NSCoding{
    var color: UIColor? {get set}
    var size: CGFloat? {get set}
    var location: CGPoint? {get set}
    var lastChild: Mark? {get}
    var count: Int {get }
    var description: String {get}
    
    func addMark(_ mark: Mark)
    func removeMark(_ mark: Mark)
    func childAtIndex(_ index: Int) -> Mark?
    
    func drawWithContext(_ contenxt: CGContext)

    func acceptMarkVisitor(_ visitor: MarkVisitor)
    
}

