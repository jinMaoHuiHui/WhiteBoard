//
//  Array+Remove.swift
//  WhiteBoard
//
//  Created by jinmao on 2016/12/15.
//  Copyright © 2016年 jinmao. All rights reserved.
//

import Foundation

extension Array where Element: Equatable {
    mutating func removeEqualItems(_ item: Element) {
        self = self.filter(){ return $0 != item }
    }
    
    mutating func removeFirstEqualItem(item: Element) {
        guard var currentItem = self.first else { return }
        var index = 0
        while currentItem != item {
            index += 1
            currentItem = self[index]
        }
        self.remove(at: index)
    }
}

