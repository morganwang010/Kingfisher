//
//  ImageCacheTests.swift
//  Kingfisher
//
//  Created by WANG WEI on 2015/04/10.
//  Copyright (c) 2015年 Wei Wang. All rights reserved.
//

import UIKit
import XCTest
import Kingfisher

private let cacheName = "com.onevcat.Kingfisher.ImageCache.test"


class ImageCacheTests: XCTestCase {

    var cache: ImageCache!
    lazy var testImage: UIImage = {
        let testImageString = "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"
        let decodedData = NSData(base64EncodedString:testImageString, options: NSDataBase64DecodingOptions(rawValue: 0))
        return UIImage(data: decodedData!)!
        }()
    let testKeys = ["http://stackoverflow.com/questions/11251340/convert-image-to-base64-string-in-ios-swift","123","http://onevcat.com/content/images/2014/May/200.jpg","http://onevcat.com/content/images/2014/May/200.jpg?fads#kj1asf"]
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        cache = ImageCache(name: "test")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        cache.clearDiskCache()
        cache = nil
    }
    
    func testClearDiskCache() {
        let paths = NSSearchPathForDirectoriesInDomains(.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        let diskCachePath = paths.first!.stringByAppendingPathComponent(cacheName)
        
        let expectation = expectationWithDescription("wait for clearing disk cache")
        
        cache.storeImage(testImage, forKey: testKeys[0], toDisk: true) { () -> () in
            
            let files = NSFileManager.defaultManager().contentsOfDirectoryAtPath(diskCachePath, error:nil)
            XCTAssert(files?.count == 1, "Should be 1 file at the path")
            
            self.cache.clearDiskCacheWithCompletionHandler { () -> () in
                
                let files = NSFileManager.defaultManager().contentsOfDirectoryAtPath(diskCachePath, error:nil)
                XCTAssert(files?.count == 0, "Files should be at deleted")
                expectation.fulfill()
            }
        }
        waitForExpectationsWithTimeout(1, handler:nil)
    }
    
    func testClearMemoryCache() {
        let expectation = expectationWithDescription("wait for retriving image")
        
        cache.storeImage(testImage, forKey: testKeys[0], toDisk: true) { () -> () in
            self.cache.clearMemoryCache()
            self.cache.retrieveImageForKey(self.testKeys[0], options: KingfisherManager.OptionsNone, completionHandler: { (image, type) -> () in
                XCTAssert(image != nil && type == .Disk, "Should be cached in disk.")
                expectation.fulfill()
            })
        }
        
        waitForExpectationsWithTimeout(1, handler: nil)
    }
    
    func testNoImageFound() {
        let expectation = expectationWithDescription("wait for retriving image")
        
        cache.clearDiskCacheWithCompletionHandler { () -> () in
            self.cache.retrieveImageForKey(self.testKeys[0], options: KingfisherManager.OptionsNone, completionHandler: { (image, type) -> () in
                XCTAssert(image == nil, "Should not be cached in memory yet")
                expectation.fulfill()
            })
            return
        }
        
        waitForExpectationsWithTimeout(1, handler: nil)
    }
    
    func testStoreImageInMemory() {
        let expectation = expectationWithDescription("wait for retriving image")
        
        cache.storeImage(testImage, forKey: testKeys[0], toDisk: false) { () -> () in
            self.cache.retrieveImageForKey(self.testKeys[0], options: KingfisherManager.OptionsNone, completionHandler: { (image, type) -> () in
                XCTAssert(image != nil && type == .Memory, "Should be cached in memory.")
                expectation.fulfill()
            })
            return
        }
        
        waitForExpectationsWithTimeout(1, handler: nil)
    }
    
    func testStoreMultipleImages() {
        let expectation = expectationWithDescription("wait for writing image")
        
        storeMultipleImages { () -> () in
            let paths = NSSearchPathForDirectoriesInDomains(.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true)
            let diskCachePath = paths.first!.stringByAppendingPathComponent(cacheName)
            
            let files = NSFileManager.defaultManager().contentsOfDirectoryAtPath(diskCachePath, error:nil)
            XCTAssert(files?.count == 4, "All test images should be at locaitons. Expected 4, actually \(files?.count)")
            
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(1, handler: nil)
    }
    
    // MARK: - Helper
    func storeMultipleImages(completionHandler:()->()) {
        
        let group = dispatch_group_create()
        
        dispatch_group_enter(group)
        cache.storeImage(testImage, forKey: testKeys[0], toDisk: true) { () -> () in
            dispatch_group_leave(group)
        }
        dispatch_group_enter(group)
        cache.storeImage(testImage, forKey: testKeys[1], toDisk: true) { () -> () in
            dispatch_group_leave(group)
        }
        dispatch_group_enter(group)
        cache.storeImage(testImage, forKey: testKeys[2], toDisk: true) { () -> () in
            dispatch_group_leave(group)
        }
        dispatch_group_enter(group)
        cache.storeImage(testImage, forKey: testKeys[3], toDisk: true) { () -> () in
            dispatch_group_leave(group)
        }
        
        dispatch_group_notify(group, dispatch_get_main_queue()) {
            completionHandler()
        }
    }
}