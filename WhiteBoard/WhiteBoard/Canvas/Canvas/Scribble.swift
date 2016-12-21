//
//  Scribble.swift
//  WhiteBoard
//
//  Created by jinmao on 2016/12/19.
//  Copyright © 2016年 jinmao. All rights reserved.
//

import Foundation


class Scribble: SubjectBase {
    var mark: Mark {
        get {
            return parentMark
        }
        set(newMark) {
            parentMark = newMark
        }
    }
    
    required override init() {
        parentMark = Stroke()
        super.init()
    }
    //  MARK: Mark Management
    func addMark(_ aMark: Mark, shouldAddToPreviousMark: Bool, shouldShare: Bool = true) {
//        self.willChangeValue(forKey: "parentMark")
        if shouldAddToPreviousMark {
            parentMark.lastChild?.addMark(aMark)
            if shouldShare {
                self.sendNotification(path: NoticeKeyPath.addMarkToPrevious, data: aMark)
            }
        } else {
            parentMark.addMark(aMark)
            incrememtalMark = aMark
            if shouldShare {
                self.sendNotification(path: NoticeKeyPath.addMarkToParent, data: aMark)
            }
        }
//        logger("\(parentMark)")
        self.sendNotification(path: NoticeKeyPath.parentMark, data: parentMark)
//        self.didChangeValue(forKey: "parentMark")
    }
    func removeMark(_ aMark: Mark, shouldShare: Bool = true) {
        //  待解决
    }
    
    //  MARK: memento
    init(withMemento aMemento: ScribbleMemento) {
        if aMemento.hasCompleteSnapshot != nil && aMemento.hasCompleteSnapshot! {
            parentMark = aMemento.mark
        } else {
            parentMark = Stroke()
        }
        super.init()
        if aMemento.hasCompleteSnapshot == nil || !aMemento.hasCompleteSnapshot! {
            self.attachStateFromMemento(aMemento)
        }
    }
    class func scribbleWithMemento(_ aMemento: ScribbleMemento) -> Scribble {
        return Scribble(withMemento: aMemento)
    }
    func scribbleMemento() -> ScribbleMemento? {
        
        return self.scribbleMemento(withCompleteSnapshot: true)
    }
    func scribbleMemento(withCompleteSnapshot hasCompleteSnapshot: Bool) -> ScribbleMemento? {
        var mementoMark = incrememtalMark
        if hasCompleteSnapshot {
            mementoMark = parentMark
        } else if  mementoMark == nil {
            return nil
        }
        let memento = ScribbleMemento(withMark: mementoMark!)
        memento.hasCompleteSnapshot = hasCompleteSnapshot
        return memento
    }
    func attachStateFromMemento(_ fromMemento: ScribbleMemento) {
        self.addMark(fromMemento.mark, shouldAddToPreviousMark: false)
    }
    
    
    //  MARK: Private
    var parentMark: Mark
    var incrememtalMark: Mark?
}


class ScribbleMemento {
    
    func data() -> Data {
        return NSKeyedArchiver.archivedData(withRootObject: mark) as Data;
    }
    
    class func mementoWithData(_ data: Data) -> ScribbleMemento? {
        if let restoredMark = NSKeyedUnarchiver.unarchiveObject(with: data) as? Mark {
            let memento = ScribbleMemento(withMark: restoredMark)
            return memento
        } else {
            return nil
        }
    }
    
    // MARK: Private
    fileprivate var mark: Mark
    fileprivate var hasCompleteSnapshot: Bool?
    fileprivate init(withMark aMark: Mark) {
        self.mark = aMark
    } 
}
