//
//  Vertex.swift
//  WhiteBoard
//
//  Created by jinmao on 2016/12/14.
//  Copyright © 2016年 jinmao. All rights reserved.
//

import UIKit

class Vertex: NSObject, Mark {
    
    internal var color: UIColor?
    internal var size: CGFloat?
    internal var location: CGPoint
    internal var lastChild: Mark?
    internal var count: UInt { return 0 }

    init(location: CGPoint) {
        self.location = location
        super.init()
        
    }

    func addMark() {}
    func removeMark(_ mark: Mark){}
    func childAtIndex(_ index: UInt) -> Mark? { return nil }
    
    func drawWithContext(_ contenxt: CGContext) { }
    
    //  MARK: NScopying
    func copy(with zone: NSZone? = nil) -> Any {
        
        return 1
    }
    //  MARK: NSCoding
    required init?(coder aDecoder: NSCoder) {
        location = aDecoder.decodeCGPoint(forKey: "location")
    }
    func encode(with: NSCoder) {
    
    }
}
