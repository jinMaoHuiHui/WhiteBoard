//
//  Dot.swift
//  WhiteBoard
//
//  Created by jinmao on 2016/12/14.
//  Copyright © 2016年 jinmao. All rights reserved.
//

import UIKit

class Dot: Vertex {
    

    override init(location: CGPoint) {
        super.init(location: location)
    }
    
    override func drawWithContext(_ contenxt: CGContext) {
        if let frameSize = size, let fillColor = color{
            if let center = location {
                let frame = CGRect(x: center.x - frameSize/2.0, y: center.y - frameSize/2.0, width: frameSize, height: frameSize)
                contenxt.setFillColor(fillColor.cgColor)
                contenxt.fillEllipse(in: frame)
                contenxt.addLine(to: center)
            }
        }
    }

    override func acceptMarkVisitor(_ visitor: MarkVisitor) {
        visitor.visitDot(self)
    }
    //  MARK: Mark, NScopying
    override func copy(with zone: NSZone? = nil) -> Any {
        let dotLocation = location ?? CGPoint(x: 0, y: 0)
        let dotCopy = Dot(location: dotLocation)
        dotCopy.color = color
        dotCopy.size = size
        return dotCopy
    }
    //  MARK: Mark, NSCoding
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        color = aDecoder.decodeObject(of: UIColor.self, forKey: "DotColor") as UIColor?
        size = aDecoder.decodeObject(forKey: "DotSize") as! CGFloat?
        
    }
    override func encode(with aCoder: NSCoder) {
        super.encode(with: aCoder)
        aCoder.encode(color, forKey: "DotColor")
        aCoder.encode(size, forKey: "DotSize")
    }
    

}
