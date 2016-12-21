//
//  Collection+SafeSubscript.swift
//  WhiteBoard
//
//  Created by jinmao on 2016/12/19.
//  Copyright © 2016年 jinmao. All rights reserved.
//

import Foundation

extension Collection where Indices.Iterator.Element == Index {
    
    subscript (safe index: Index) -> Generator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
