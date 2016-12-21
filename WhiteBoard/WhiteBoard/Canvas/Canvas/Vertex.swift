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
    internal var location: CGPoint?
    internal var lastChild: Mark?
    internal var count: Int { return 0 }
    
    override internal var description: String {
        return "{ type: Vertex, size: \(size), color:\(color), location:\(location) }"
    }

    init(location: CGPoint) {
        self.location = location
        super.init()
        
    }

    func addMark(_ mark: Mark) {}
    func removeMark(_ mark: Mark){}
    func childAtIndex(_ index: Int) -> Mark? { return nil }
    
    func drawWithContext(_ context: CGContext) {
        if let vertexLocation = location {
            context.addLine(to: vertexLocation)
        }
    }

    func acceptMarkVisitor(_ visitor: MarkVisitor) {
        visitor.visitVertex(self)
    }
    
    //  MARK: NScopying
    func copy(with zone: NSZone? = nil) -> Any {
        let vertexLocation = location ?? CGPoint(x: 0, y: 0)
        let vertexCopy = Vertex(location: vertexLocation)
        return vertexCopy
    }
    //  MARK: NSCoding
    required init?(coder aDecoder: NSCoder) {
        location = aDecoder.decodeCGPoint(forKey: "Vertexlocation")
    }
    func encode(with aCoder: NSCoder) {
        if let vertexLocation = location {
            aCoder.encode(vertexLocation, forKey: "Vertexlocation")
        }
    }

}
