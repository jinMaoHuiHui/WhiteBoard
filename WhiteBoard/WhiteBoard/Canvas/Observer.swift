//
//  Observer.swift
//  WhiteBoard
//
//  Created by jinmao on 2016/12/20.
//  Copyright © 2016年 jinmao. All rights reserved.
//

import Foundation

protocol Observer: class {
    func propertyOfPath(_ keyPath: NoticeKeyPath, ofObject object: Any?, UpdatedWithValue value: Any)
}

protocol Subject {
    func addObservers(observers obs: Observer...)
    func removeObserver(observer: Observer)
}

class SubjectBase: Subject {

    private var observers = [Observer]()
    private var collectionQueue = DispatchQueue(label: "queuename", attributes: .concurrent)
    internal func addObservers(observers obs: Observer...) {
        collectionQueue.sync(flags: DispatchWorkItemFlags.barrier){
            for newOb in obs {
                self.observers.append(newOb)
            }
        }
    }
    internal func removeObserver(observer: Observer) {
        collectionQueue.sync(flags: DispatchWorkItemFlags.barrier) {
            self.observers = self.observers.filter(){$0 !== observer }
        }
    }
    func sendNotification(path: NoticeKeyPath, data: Any) {
        collectionQueue.sync(){
            for ob in self.observers {
                ob.propertyOfPath(path, ofObject: self, UpdatedWithValue: data)
            }
        }
    }
}

enum NoticeKeyPath: String{
    case newDraw, addMarkToPrevious, addMarkToParent, removeMark, parentMark
}
