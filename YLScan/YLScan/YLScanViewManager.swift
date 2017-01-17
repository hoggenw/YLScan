//
//  YLScanViewManager.swift
//  YLScan
//
//  Created by 王留根 on 17/1/17.
//  Copyright © 2017年 ios-mac. All rights reserved.
//

import UIKit

protocol YLScanViewManagerDelegate {
    func scanSuccessWith(result: YLScanResult)
}

public class YLScanViewManager: NSObject {
    //是否需要扫描框
    public var isNeedShowRetangle:Bool? {
        didSet {
            scanViewController.scanStyle.isNeedShowRetangle = isNeedShowRetangle!
        }
    }
    /**
     *  默认扫码区域为正方形，如果扫码区域不是正方形，设置宽高比
     */
    public var whRatio: CGFloat? {
        didSet {
            scanViewController.scanStyle.whRatio = whRatio!
        }
    }
    /**
     *  矩形框(视频显示透明区)域向上移动偏移量，0表示扫码透明区域在当前视图中心位置，如果负值表示扫码区域下移(默认44)
     */
    public var centerUpOffset:CGFloat? {
        didSet {
            scanViewController.scanStyle.centerUpOffset = centerUpOffset!
        }
    }
    /**
     *  矩形框宽度
     */
    public var scanViewWidth: CGFloat? {//xScanRetangleOffset:CGFloat = 60
        didSet {
            scanViewController.scanStyle.xScanRetangleOffset = (UIScreen.main.bounds.size.width - scanViewWidth!) / 2
        }
    }
    public static let scanViewManager = YLScanViewManager()
    private var scanViewController = YLScanViewController()
    var delegate: YLScanViewManagerDelegate?

    
    public class func shareManager() -> YLScanViewManager {
        return scanViewManager;
    }

    public func showScanView(viewController: UIViewController) {
        scanViewController.delegate = self
        viewController.navigationController?.pushViewController(scanViewController, animated: true)
    }
    
}

extension YLScanViewManager: YLScanViewControllerDelegate {
    func scanViewControllerSuccessWith(result: YLScanResult) {
        delegate?.scanSuccessWith(result: result)
    }
}
