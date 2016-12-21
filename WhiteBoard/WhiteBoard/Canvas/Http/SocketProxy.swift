//
//  Websocket.swift
//  WhiteBoard
//
//  Created by jinmao on 2016/12/21.
//  Copyright © 2016年 jinmao. All rights reserved.
//

import UIKit
import SocketIO

private let socketURL = URL(string: "http://10.0.0.6:8008")!
class HttpFactory: NSObject, UIAlertViewDelegate {
    class func createSocket() -> SocketImplementation {
        let socket = SocketImplementation(withSocketURL: socketURL)
        return socket
    }
    
}

protocol SocketProxy {
    init(withSocketURL url: URL)
    func connect()
    func disconnect()
}

class SocketImplementation: SocketProxy, Observer{
    
    weak var scribble: Scribble?
    
    enum SocketEvent: String {
        case newDraw = "mark/post"
        case addMarkToPrevious = "mark/update/previous"
        case addMarkToParent = "mark/update/parent"
        case removeMark = "mark/delete"
        
    }

    let socket: SocketIOClient?
    
    required init(withSocketURL url: URL) {
        socket = SocketIOClient(socketURL: socketURL, config: [.log(false), .forcePolling(true)])
        addHandlers()
        socket?.connect()
    }
    
    private func addHandlers() {
        func parseData(_ data: [Any]) -> Mark? {
            guard data[0] is Data else {
                logger("收到不能识别的信息")
                return nil
            }
            let mark = MarkCoder.decodeMarkFromData(data[0] as! Data)
            return mark
        }
        print("\(socket)")
        /*
        socket?.on(SocketEvent.newDraw.rawValue) { [weak self] data, ack in
            if let mark = parseData(data), let model = self?.scribble {
                
            }
        }
         */
        
        socket?.on(SocketEvent.addMarkToParent.rawValue) { [weak self] data, ack in
            if let aMark = parseData(data), let model = self?.scribble {
                logger("parent received")
                model.addMark(aMark, shouldAddToPreviousMark: false, shouldShare: false)
            }
        }
        
        socket?.on(SocketEvent.addMarkToPrevious.rawValue) { [weak self] data, ack in
            if let aMark = parseData(data), let model = self?.scribble {
                logger("previous received")
                model.addMark(aMark, shouldAddToPreviousMark: true, shouldShare: false)
            }
        }
        socket?.on(SocketEvent.removeMark.rawValue) { [weak self] data, ack in
            if let aMark = parseData(data), let model = self?.scribble {
                model.removeMark(aMark, shouldShare: false)
            }
        }
       
    }
    
    internal func disconnect() {
        socket?.disconnect()
    }
    
    internal func connect() {
        if UserAuthentication.sharedInstance.authenticated {
            socket?.connect()
        }
    }
    
    //  MARK: Observer, send mark to server
    func propertyOfPath(_ keyPath: NoticeKeyPath, ofObject object: Any?, UpdatedWithValue value: Any) {
        guard keyPath == NoticeKeyPath.addMarkToParent || keyPath == NoticeKeyPath.addMarkToPrevious && object is Scribble && value is Mark else {
            //  不相关的通知
            return
        }
        if let markData = MarkCoder.encodeMark(value as! Mark) {
            if keyPath == NoticeKeyPath.addMarkToParent {
                logger("parent send")
                socket?.emit(SocketEvent.addMarkToParent.rawValue, markData)
            }
            else if keyPath == NoticeKeyPath.addMarkToPrevious {
                logger("previous send")
                socket?.emit(SocketEvent.addMarkToPrevious.rawValue, markData)
            }
        }
    }
    
}
