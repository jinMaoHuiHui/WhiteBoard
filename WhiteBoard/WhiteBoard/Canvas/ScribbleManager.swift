//
//  ScribbleManager.swift
//  WhiteBoard
//
//  Created by jinmao on 2016/12/19.
//  Copyright © 2016年 jinmao. All rights reserved.
//

import UIKit

class ScribbleManager {
    
    func saveScribble(_ scribble: Scribble, thumbnail: UIImage) {
        let newIndex = numberOfScribbles() + 1
        let scribbleDataName = "data_\(newIndex)"
        let scribbleThumbnailName = "thumbnail_\(newIndex)"
        
        guard let scribbleMemento = scribble.scribbleMemento() else {
            logger("scribbleMemento nil")
            return
        }
        let mementoData = scribbleMemento.data()
        if let scribbleDataPath_ = scribbleDataPath, let scribbleThumbnailPath_ = scribbleThumbnailPath {
            let dataPath = (scribbleDataPath_ as NSString).appendingPathComponent(scribbleDataName)
            let thumbPath = (scribbleThumbnailPath_ as NSString).appendingPathComponent(scribbleThumbnailName)
            do {
                try mementoData.write(to: URL(string: dataPath)!, options: Data.WritingOptions.atomicWrite)
                if let thumbnailData = UIImagePNGRepresentation(thumbnail) {
                    try thumbnailData.write(to: URL(string: thumbPath)!, options: Data.WritingOptions.atomicWrite)
                }
            } catch {
                print(error)
            }
        }
    }
    
    func numberOfScribbles() -> NSInteger {
        return scribbleDataPaths.count
    }
    
    func scribbleAtIndex(_ index: NSInteger) -> Scribble? {
        var loadedScribble: Scribble? = nil
        if let scribblePath = scribbleDataPaths[safe: index] {
            if let scribbleData = FileManager.default.contents(atPath: (kScribbleDataPath as NSString).appendingPathComponent(scribblePath)) {
                if let scribbleMemento = ScribbleMemento.mementoWithData(scribbleData) {
                    loadedScribble = Scribble(withMemento: scribbleMemento)
                }
            }
        }
        return loadedScribble
    }
    
    func scribbleThumbnailViewAtIndex(_ index: NSInteger) -> UIView {
        
        return UIView()
    }
    
    
    //  MARK: Private
    
    private let kScribbleDataPath = (NSHomeDirectory() as NSString).appendingPathComponent("Documents/data")
    private let kScribbleThumbnailPath = (NSHomeDirectory() as NSString).appendingPathComponent("Documents/thumbnails")
    lazy private var scribbleDataPath: String? = {
        if !FileManager.default.fileExists(atPath: self.kScribbleDataPath) {
            do {
               try FileManager.default.createDirectory(at: URL(string: self.kScribbleDataPath)!, withIntermediateDirectories: true, attributes: nil)
            } catch {
                return nil
            }
        }
        return self.kScribbleDataPath
    }()
    
    lazy private var scribbleThumbnailPath: String? = {
        if !FileManager.default.fileExists(atPath: self.kScribbleThumbnailPath) {
            do {
                try FileManager.default.createDirectory(at: URL(string: self.kScribbleThumbnailPath)!, withIntermediateDirectories: true, attributes: nil)
            } catch {
                return nil
            }
        }
        return self.kScribbleThumbnailPath
    }()
    
    lazy private var scribbleDataPaths: [String] = {
        do {
            if let path = self.scribbleDataPath {
                return try FileManager.default.contentsOfDirectory(atPath: path)
            } else {
                return []
            }
        } catch {
            return []
        }
    }()
    
    lazy private var scribbleThumbnailPaths: [String] = {
        do {
            if let path = self.scribbleThumbnailPath {
                return try FileManager.default.contentsOfDirectory(atPath: path)
            } else {
                return []
            }
        } catch {
            return []
        }
    }()
}
