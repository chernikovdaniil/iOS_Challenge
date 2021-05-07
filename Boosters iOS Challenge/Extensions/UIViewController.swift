//
//  UIViewController.swift
//  Boosters iOS Challenge
//
//  Created by Danil Chernikov on 07.05.2021.
//

import UIKit

extension UIViewController {
    func showActivityIndicator() {
        let tag = "backgroundView".hashValue
        let backgroundView = UIView()
        backgroundView.tag = tag
        backgroundView.frame = view.frame
        backgroundView.center = CGPoint(x: view.bounds.size.width / 2, y: view.bounds.size.height / 2)
        
        let whiteColor = UIColor.white
        whiteColor.withAlphaComponent(0.5)
        backgroundView.backgroundColor = whiteColor
        view.addSubview(backgroundView)
        let wrapperView = UIView()
        wrapperView.frame = CGRect(origin: .zero, size: CGSize(width: 80.0, height: 80.0))
        wrapperView.center = CGPoint(x: backgroundView.bounds.size.width / 2, y: backgroundView.bounds.size.height / 2)
        wrapperView.backgroundColor = whiteColor
        wrapperView.layer.cornerRadius = 8.0
        backgroundView.addSubview(wrapperView)
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        activityIndicatorView.frame = CGRect(origin: .zero, size: CGSize(width: 40.0, height: 40.0))
        activityIndicatorView.center = CGPoint(x: wrapperView.bounds.size.width / 2, y: wrapperView.bounds.size.height / 2)
        activityIndicatorView.startAnimating()
        wrapperView.addSubview(activityIndicatorView)
    }
    
    func hideActivityIndicator() {
        let tag = "backgroundView".hashValue
        let backgroundView = view.subviews.first(where: { $0.tag == tag })
        backgroundView?.removeFromSuperview()
    }
}
