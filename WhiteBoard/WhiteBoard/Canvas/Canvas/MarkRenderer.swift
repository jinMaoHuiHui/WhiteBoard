//
//  MarkRenderer.swift
//  WhiteBoard
//
//  Created by jinmao on 2016/12/19.
//  Copyright © 2016年 jinmao. All rights reserved.
//

import UIKit

protocol MarkVisitor {
    func visitMark(_ mark: Mark)
    func visitDot(_ dot: Dot)
    func visitVertex(_ vertex: Vertex)
    func visitStroke(_ stroke: Stroke)
}

class MarkRenderer: MarkVisitor {
    
    var context: CGContext
    
    init(withContext aContext: CGContext) {
        self.context = aContext
        shouldMoveContextToDot_ = true
    }
    
    func visitMark(_ mark: Mark) {
        // default behavior
    }
    
    func visitDot(_ dot: Dot) {
        guard let dotPoint =  dot.location, let frameSize = dot.size else {
            return
        }
        let x = dotPoint.x
        let y = dotPoint.y
        let frame = CGRect(x: x - frameSize / 2.0,
                           y: y - frameSize / 2.0,
                           width: frameSize,
                           height: frameSize)
        let fillColor = dot.color ?? UIColor.white
        context.setFillColor(fillColor.cgColor)
        context.fillEllipse(in: frame)
    }
    
    func visitVertex(_ vertex: Vertex) {
        guard let vertexPoint = vertex.location else {
            return
        }
        if shouldMoveContextToDot_ {
            context.move(to: vertexPoint)
            shouldMoveContextToDot_ = false 
        } else {
            context.addLine(to: vertexPoint)
        }
    }
    
    func visitStroke(_ stroke: Stroke) {
        let strokeColor = stroke.color ?? UIColor.white
        let strokeSize = stroke.size ?? 1.0
        context.setStrokeColor(strokeColor.cgColor)
        context.setLineWidth(strokeSize)
        context.setLineCap(.round)
        context.strokePath()
        shouldMoveContextToDot_ = true
    }
   
    
    // MARK: Private
    var shouldMoveContextToDot_: Bool
    
    
}
