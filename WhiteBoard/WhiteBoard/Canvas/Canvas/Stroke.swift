//
//  Stroke.swift
//  WhiteBoard
//
//  Created by jinmao on 2016/12/15.
//  Copyright © 2016年 jinmao. All rights reserved.
//

import UIKit
import Foundation

class Stroke:NSObject, Mark {



    internal var color: UIColor?
    internal var size: CGFloat? 
    internal var location: CGPoint?
    internal var count: Int {
        return children.count
    }
    internal var lastChild: Mark? {
        return children.last
    }
    override init() {
        children = [Mark]()
        
    }
    //  MARK: Mark, draw
    private var children: Array<Mark>
    
    override var description: String {
        func add(x:String, y:Mark) -> String {  return x == "" ? y.description : x + "," + y.description }
        let childrenDesc: String = children.reduce(""){$0 == "" ? $1.description : $0 + "," + $1.description }
        return "color:\(color), size:\(size), children:[ \(childrenDesc) ]"
    }


    func drawWithContext(_ context: CGContext) {
        if let strokeLocation = location {
            let strokeColor = color ?? UIColor.white
            context.move(to: strokeLocation)
            for mark in children {
                mark.drawWithContext(context)
            }
            context.setLineWidth(size ?? 1)
            context.setLineCap(.round)
            context.setStrokeColor(strokeColor.cgColor)
            context.strokePath()
        }
    }
    
    func addMark(_ mark: Mark) {
        children.append(mark)
    }
    
    func removeMark(_ mark: Mark) {
        //  怎么移除一个协议组成的数组，是个问题。。。
    }
    
    func childAtIndex(_ index: Int) -> Mark? {
        guard index >= 0 else {
            // exception
            return nil
        }
        if index > children.count-1 {
            return nil
        } else {
            return children[index]
        }
    }
    internal func acceptMarkVisitor(_ visitor: MarkVisitor) {
        for mark in children  {
            mark.acceptMarkVisitor(visitor)
        }
        visitor.visitStroke(self)
    }
    //  MARK: Mark, NSCopying
    func copy(with zone: NSZone? = nil) -> Any {
        let strokeCopy = Stroke()
        strokeCopy.color = color
        strokeCopy.size = size
        for mark in children {
            strokeCopy.addMark(mark.copy() as! Mark)
        }
        return strokeCopy
    }
    
    required init?(coder aDecoder: NSCoder) {
        color = aDecoder.decodeObject(of: UIColor.self, forKey: "StrokeColor") as UIColor?
        size = aDecoder.decodeObject(forKey: "StrokeSize") as! CGFloat?
        children = aDecoder.decodeObject(forKey: "StrokeChildren") as? [Mark] ?? [Mark]()
        super.init()
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(children, forKey: "StrokeChildren")
        aCoder.encode(color, forKey: "StrokeColor")
        aCoder.encode(size, forKey: "StrokeSize")
    }
    

}
