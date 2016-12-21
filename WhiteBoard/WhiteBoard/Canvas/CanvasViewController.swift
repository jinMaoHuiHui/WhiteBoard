//
//  CanvasViewController.swift
//  WhiteBoard
//
//  Created by jinmao on 2016/12/13.
//  Copyright © 2016年 jinmao. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController, Observer {
    //  MARK: Public properties
    var startPoint: CGPoint = CGPoint(x: 0, y: 0)
    var scribble: Scribble?
    lazy public var canvasView: CanvasView = {
        return CanvasView()
    }()
    public var strokeColor: UIColor = UIColor.black
    public var strokeSize: CGFloat = 1.0
    
    //  MARK: Initialize
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    //  MARK: Lifespan
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        // testStrokeArchive()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //  MARK: private
    private func setup() {
        canvasView.frame = view.bounds
        canvasView.backgroundColor = UIColor.yellow
        view.addSubview(canvasView)
    }
    
    //  MARK: Touch Event Handlers
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            startPoint = touch.location(in: canvasView)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch> , with event: UIEvent?) {
        if let lastPoint = touches.first?.previousLocation(in: canvasView), let thisPoint = touches.first?.location(in: canvasView) {   //  开始移动的第二点，新建 stroke
            if (__CGPointEqualToPoint(startPoint, lastPoint)) {
                let newStroke = Stroke()
                newStroke.color = strokeColor
                newStroke.size = strokeSize
                self.scribble?.addMark(newStroke, shouldAddToPreviousMark: false)
            }
            let vertex = Vertex(location: thisPoint)
            self.scribble?.addMark(vertex, shouldAddToPreviousMark: true)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let lastPoint = touches.first?.previousLocation(in: canvasView),
            let thisPoint = touches.first?.location(in: canvasView) else {
            logger("can`t fetch point in touch")
            return
        }
        if __CGPointEqualToPoint(lastPoint, thisPoint) {
            let singleDot = Dot(location: thisPoint)
            singleDot.color = strokeColor
            singleDot.size = strokeSize
            scribble?.addMark(singleDot, shouldAddToPreviousMark: false)
        } else {
            let vertex = Vertex(location: thisPoint)
            scribble?.addMark(vertex, shouldAddToPreviousMark: true)
        }
        startPoint = CGPoint(x: 0, y: 0)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        startPoint = CGPoint(x: 0, y: 0)
    }
    //  MARK: Observer Protocol
    func propertyOfPath(_ keyPath: NoticeKeyPath, ofObject object: Any?, UpdatedWithValue value: Any) {
        if object is Scribble && keyPath == NoticeKeyPath.parentMark {
            if let mark = value as? Mark {
                canvasView.mark = mark
//                logger("\(mark)")
                canvasView.setNeedsDisplay()
            }
        }
    }
    
    deinit {
        scribble?.removeObserver(observer: self)
    }
    /*
    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {
        if  object is Scribble && keyPath == "parentMark" {
            if let mark = change?[NSKeyValueChangeKey.newKey] as? Mark{
                canvasView.mark = mark
                canvasView.setNeedsDisplay()
            }
        }
    }
    */
    /*
    private func addMark(_ mark: Mark, shouldAddToPreviousMark: Bool) {
     
    }
     */
    
    private func testStrokeArchive() {
        let a = "\(UIColor.red.description)"
        print(a)
       
        let dot1 = Dot(location: CGPoint(x: 100, y: 20))
        dot1.color = UIColor.black
        dot1.size = 12.2
        print(dot1)
        let dot1Archived = NSKeyedArchiver.archivedData(withRootObject: dot1)
        print(dot1Archived)
        let dot_1 = NSKeyedUnarchiver.unarchiveObject(with: dot1Archived)
        print(dot_1 ?? "nil")
        
        let dot2 = Dot(location: CGPoint(x: 123, y: 324))
        dot2.color = UIColor.red
        dot2.size = 2
        
        let stroke = Stroke()
        stroke.color = UIColor.yellow
        stroke.size = 4
        stroke.addMark(dot1)
        stroke.addMark(dot2)
        
        print(stroke)
        let strokeArchived = NSKeyedArchiver.archivedData(withRootObject: stroke)
        print(strokeArchived)
        let stroke2 = NSKeyedUnarchiver.unarchiveObject(with: strokeArchived) as? Stroke
        print(stroke2 ?? "nil")
    }


}
