//
//  CanvasViewController.swift
//  WhiteBoard
//
//  Created by jinmao on 2016/12/13.
//  Copyright © 2016年 jinmao. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {
    
    //  MARK: property
    lazy public var canvasView: CanvasView = {
        return CanvasView()
    }()
    public var strokeColor: UIColor = UIColor.black
    public var strokeSize: CGFloat = 1.0
    
    //  MARK: init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    //  MARK: life span
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
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
    



}
