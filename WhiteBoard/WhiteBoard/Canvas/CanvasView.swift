//
//  CanvasView.swift
//  WhiteBoard
//
//  Created by jinmao on 2016/12/14.
//  Copyright © 2016年 jinmao. All rights reserved.
//

import UIKit

class CanvasView: UIView {

    private var mark_: Mark?
    
    var mark: Mark? {
        get{
            return mark_
        }
        set(newMark) {
            self.mark_ = newMark
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        if let context = UIGraphicsGetCurrentContext() {
            let markRenderer = MarkRenderer(withContext: context)
            mark?.acceptMarkVisitor(markRenderer)
        }
    }
    

}
