//
//  MarkCoder.swift
//  WhiteBoard
//
//  Created by jinmao on 2016/12/21.
//  Copyright © 2016年 jinmao. All rights reserved.
//

import Foundation

class MarkCoder {
    class func encodeMark(_ mark: Mark) -> Data? {
        let data = NSKeyedArchiver.archivedData(withRootObject: mark)
        return data
    }
    
    class func decodeMarkFromData(_ data: Data) -> Mark? {
        let mark = NSKeyedUnarchiver.unarchiveObject(with: data) as? Mark
        return mark
    }
}
