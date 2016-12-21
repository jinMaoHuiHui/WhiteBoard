//
//  Logger.swift
//  WhiteBoard
//
//  Created by jinmao on 2016/12/19.
//  Copyright © 2016年 jinmao. All rights reserved.
//

import Foundation

func logger(_ message: String, _ fileName: String = #file, _ functionName: String = #function, _ atLine: Int = #line) {
    print("----\n\((fileName as NSString).lastPathComponent) \(functionName) \(atLine)")
    print(message)
}
