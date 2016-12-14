//
//  Dot.swift
//  WhiteBoard
//
//  Created by jinmao on 2016/12/14.
//  Copyright © 2016年 jinmao. All rights reserved.
//

import UIKit

class Dot: Vertex {
    

    override func drawWithContext(_ contenxt: CGContext) {
        
    }

    //  MARK: NScopying
    override func copy(with zone: NSZone? = nil) -> Any {
        
        return 1
    }
    //  MARK: NSCoding
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func encode(with: NSCoder) {
        
    }
}
