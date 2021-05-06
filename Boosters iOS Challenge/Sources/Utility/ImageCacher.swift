//
//  ImageCacher.swift
//  Boosters iOS Challenge
//
//  Created by Danil Chernikov on 06.05.2021.
//

import CommonCrypto
import Dispatch
import Foundation
import UIKit

private let kConcurentRequestsCount: Int = 5

class ImageCacheItem {
    let url: URL
    var bInProgress: Bool = false
    
    init(url: URL) {
        self.url = url
    }
}

protocol ImageCacherType {
    func loadImages(items: [URL])
    func load(from imageURL: URL?, completion: ((UIImage?) -> Void)?)
    func cleanCache()
}

class ImageCacher: ImageCacherType {
    static let shared: ImageCacherType = ImageCacher()
    
    private let myPropertyQueue = DispatchQueue(label: "thread_safe", qos: .background,
                                                attributes: .concurrent, autoreleaseFrequency: .never)
    private var itemsQueue: [ImageCacheItem] = []
    private var pathForFolder: String?
    
    private init() {
        createPathForFolder()
    }
    
    func load(from imageURL: URL?, completion: ((UIImage?) -> Void)? = nil) {
        guard let url = imageURL else {
            completion?(nil)
            return
        }

        if let image = loadImageFromCache(url: url.absoluteString) {
            completion?(image)
            return
        }
        
        let request = URLRequest(url: url)
        DispatchQueue.global(qos: .userInitiated).async {
            let session = URLSession.shared.dataTask(with: request,
                                                     completionHandler: { [weak self] data, response, _ in
                if let data = data, let response = response, ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300,
                   let image = UIImage(data: data) {
                    self?.saveImageToCache(url: url.absoluteString, imageData: data)
                    completion?(image)
                }}
            )
            session.resume()
        }
    }
    
    private func saveImageToCache(url: String, imageData: Data) {
        guard let filePath = getPath(urlString: url) else { return }
        let filePathUrl = URL(fileURLWithPath: filePath)
        try? imageData.write(to: filePathUrl)
        //print("ImageCachingService saveImageToCache \(url)")
    }
    
    private func loadImageFromCache(url: String) -> UIImage? {
        guard let filePath = getPath(urlString: url) else { return nil }
        if checkFromImageFromCache(url: url) {
            if let image = UIImage(contentsOfFile: filePath) {
                //print("ImageCachingService from cache \(url)")
                return image
            }
        }
        return nil
    }
    
    private func checkFromImageFromCache(url: String) -> Bool {
        guard let filePath = getPath(urlString: url) else { return false }
        if FileManager.default.fileExists(atPath: filePath) {
            return true
        }
        return false
    }
}

// MARK: - Prefetch images
extension ImageCacher {
    func loadImages(items: [URL]) {
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.loadImagesThread(items: items)
        }
    }
    
    private func loadImagesThread(items: [URL]) {
        for item in items {
            //check for already in queue
            let filtered = self.itemsQueue.filter({ $0.url == item })
            //check for already exist
            let exist = checkFromImageFromCache(url: item.absoluteString)
            if filtered.isEmpty, !exist {
                myPropertyQueue.sync { [weak self] in
                    self?.itemsQueue.append(ImageCacheItem(url: item))
                }
            }
        }
        
        let inProgress = itemsQueue.filter { $0.bInProgress == true }
        for _ in inProgress.count..<kConcurentRequestsCount {
            prefetchImages()
        }
    }
    
    private func prefetchImages() {
        myPropertyQueue.sync { [weak self] in
            let inProgress = self?.itemsQueue.filter { $0.bInProgress == true } ?? []
            let filtered = self?.itemsQueue.filter { $0.bInProgress == false } ?? []
            if inProgress.count <= kConcurentRequestsCount, let first = filtered.first {
                first.bInProgress = true
                prefetchImage(item: first)
            }
        }
    }
    
    private func prefetchImage(item: ImageCacheItem) {
        load(from: item.url) { [weak self] _ in
            self?.removeItemFromQueue(url: item.url)
            self?.prefetchImages()
        }
    }
    
    private func removeItemFromQueue(url: URL) {
        myPropertyQueue.sync { [weak self] in
            if let index = self?.itemsQueue.firstIndex(where: { $0.url == url }) {
                self?.itemsQueue.remove(at: index)
                //print("prefetchImages remove \(url.absoluteString)")
            }
        }
    }
}

// MARK: - Disk routine
extension ImageCacher {
    func cleanCache() {
        guard let folder = pathForFolder else { return }
        let folderURL = URL(fileURLWithPath: folder)
        try? FileManager.default.removeItem(at: folderURL)
        
        createPathForFolder()
    }
    
    private func createPathForFolder() {
        guard let cacheDirPath = NSSearchPathForDirectoriesInDomains(.cachesDirectory,
                                                                     .userDomainMask, true).first else { return }
        let folderPath = cacheDirPath + "/ImageViewCache"
        
        if FileManager.default.fileExists(atPath: folderPath) == false {
            do {
                try FileManager.default.createDirectory(atPath: folderPath,
                                                        withIntermediateDirectories: false,
                                                        attributes: nil)
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        pathForFolder = folderPath
    }
    
    private func getPath(urlString: String) -> String? {
        // added url contain runtime query items, cache dont work
        guard let url = URL(string: urlString), let host = url.host else { return nil }
        guard let path = pathForFolder else { return nil }
        let file = SHA256(string: host + url.path)
        let fileUrl = path + "/" + file + ".jpg"
        return fileUrl
    }
    
    private func SHA256(string: String) -> String {
        let data = string.data(using: .utf8) ?? Data()
        let hash = data.withUnsafeBytes { (bytes: UnsafeRawBufferPointer) -> [UInt8] in
            var hash = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
            CC_SHA256(bytes.baseAddress, CC_LONG(data.count), &hash)
            return hash
        }
        let sha256Hex = hash.map { String(format: "%02x", $0) }.joined()
        return sha256Hex
    }
}
