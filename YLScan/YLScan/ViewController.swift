//
//  ViewController.swift
//  YLScan
//
//  Created by 王留根 on 17/1/4.
//  Copyright © 2017年 ios-mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    var arrayItems:Array<Array<String>> = [
        //["模拟qq扫码界面","qqStyle"],
        ["模仿支付宝扫码区域","ZhiFuBaoStyle"],
        ["模仿微信扫码区域","weixinStyle"],
        ["无边框，内嵌4个角","InnerStyle"],
        ["4个角在矩形框线上,网格动画","OnStyle"],
        ["自定义颜色","changeColor"],
        ["只识别框内","recoCropRect"],
        ["改变尺寸","changeSize"],
        ["条形码效果","notSquare"],
        ["相册","openLocalPhotoAlbum"]
    ];
    var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView = UITableView(frame: CGRect(x: 0, y: 64, width: view.frame.width, height: view.frame.height))
        self.title = "swift 扫一扫"
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        view.addSubview(tableView)
        // Do any additional setup after loading the view, typically from a nib.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrayItems.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath as IndexPath)
        // Configure the cell...
        cell.textLabel?.text = arrayItems[indexPath.row].first
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //objc_msgSend对应方法好像没有
        let sel = NSSelectorFromString(arrayItems[indexPath.row].last!)
        if responds(to: sel) {
            perform(sel)
        }
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: ---模仿支付宝------
    func ZhiFuBaoStyle()
    {
        //设置扫码区域参数
        var style = YLScanViewSytle()
        
        style.centerUpOffset = 60;
        style.xScanRetangleOffset = 30;
        
        if UIScreen.main.bounds.size.height <= 480
        {
            //3.5inch 显示的扫码缩小
            style.centerUpOffset = 40;
            style.xScanRetangleOffset = 20;
        }
        
        style.red_notRecoginitonArea = 0.4
        style.green_notRecoginitonArea = 0.4
        style.blue_notRecoginitonArea = 0.4
        style.alpa_notRecoginitonArea = 0.4
        
        
        style.photoframeAngleStyle = YLScanViewPhotoframeAngleStyle.Inner;
        style.photoframeLineW = 2.0;
        style.photoframeAngleW = 16;
        style.photoframeAngleH = 16;
        
        style.isNeedShowRetangle = false;
        
        style.animationStyle = YLScanViewAnimationStyle.NetGrid;
        style.animationImage = UIImage(named: "CodeScan.bundle/qrcode_scan_full_net")
        
        
        
        let vc = YLScanViewController();
        
        vc.scanStyle = style
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    func createImageWithColor(color:UIColor)->UIImage
    {
        let rect=CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0);
        UIGraphicsBeginImageContext(rect.size);
        let context = UIGraphicsGetCurrentContext();
        context!.setFillColor(color.cgColor);
        context!.fill(rect);
        let theImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return theImage!;
    }
    
    //MARK: -------条形码扫码界面 ---------
    func notSquare()
    {
        //设置扫码区域参数
        //设置扫码区域参数
        var style = YLScanViewSytle()
        
        style.centerUpOffset = 44;
        style.photoframeAngleStyle = YLScanViewPhotoframeAngleStyle.Inner;
        style.photoframeLineW = 4;
        style.photoframeAngleW = 28;
        style.photoframeAngleH = 16;
        style.isNeedShowRetangle = false;
        
        style.animationStyle = YLScanViewAnimationStyle.LineStill;
        
        
        style.animationImage = createImageWithColor(color: UIColor.red)
        //非正方形
        //设置矩形宽高比
        style.whRatio = 4.3/2.18;
        
        //离左边和右边距离
        style.xScanRetangleOffset = 30;
        
        let vc = YLScanViewController();
        
        vc.scanStyle = style
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    //MARK: ----无边框，内嵌4个角 -----
    func InnerStyle()
    {
        //设置扫码区域参数
        var style = YLScanViewSytle()
        style.centerUpOffset = 44;
        style.photoframeAngleStyle = YLScanViewPhotoframeAngleStyle.Inner;
        style.photoframeLineW = 3;
        style.photoframeAngleW = 18;
        style.photoframeAngleH = 18;
        style.isNeedShowRetangle = false;
        
        style.animationStyle = YLScanViewAnimationStyle.LineMove;
        
        //qq里面的线条图片
        style.animationImage = UIImage(named: "CodeScan.bundle/qrcode_scan_light_green")
        
        let vc = YLScanViewController();
        vc.scanStyle = style
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    //MARK: ---无边框，内嵌4个角------
    func weixinStyle()
    {
        //设置扫码区域参数
        var style = YLScanViewSytle()
        style.centerUpOffset = 44;
        style.photoframeAngleStyle = YLScanViewPhotoframeAngleStyle.Inner;
        style.photoframeLineW = 2;
        style.photoframeAngleW = 18;
        style.photoframeAngleH = 18;
        style.isNeedShowRetangle = false;
        
        style.animationStyle = YLScanViewAnimationStyle.LineMove;
        
        style.colorAngle = UIColor(red: 0.0/255, green: 200.0/255.0, blue: 20.0/255.0, alpha: 1.0)
        
        
        style.animationImage = UIImage(named: "CodeScan.bundle/qrcode_Scan_weixin_Line")
        
        
        let vc = YLScanViewController();
        vc.scanStyle = style
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    //MARK: ----框内区域识别
    func  recoCropRect()
    {
        //设置扫码区域参数
        var style = YLScanViewSytle()
        style.centerUpOffset = 44;
        style.photoframeAngleStyle = YLScanViewPhotoframeAngleStyle.On;
        style.photoframeLineW = 6;
        style.photoframeAngleW = 24;
        style.photoframeAngleH = 24;
        style.isNeedShowRetangle = true;
        
        style.animationStyle = YLScanViewAnimationStyle.NetGrid;
        
        
        //矩形框离左边缘及右边缘的距离
        style.xScanRetangleOffset = 80;
        
        //使用的支付宝里面网格图片
        style.animationImage = UIImage(named: "CodeScan.bundle/qrcode_scan_part_net")
        
        let vc = YLScanViewController();
        vc.scanStyle = style
        
        
        vc.isOpenInterestRect = true
        //TODO:待设置框内识别
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
    
    //MARK: -----4个角在矩形框线上,网格动画
    func OnStyle()
    {
        //设置扫码区域参数
        var style = YLScanViewSytle()
        style.centerUpOffset = 44;
        style.photoframeAngleStyle = YLScanViewPhotoframeAngleStyle.On;
        style.photoframeLineW = 6;
        style.photoframeAngleW = 24;
        style.photoframeAngleH = 24;
        style.isNeedShowRetangle = true;
        
        style.animationStyle = YLScanViewAnimationStyle.NetGrid;
        
        
        //使用的支付宝里面网格图片
        style.animationImage = UIImage(named: "CodeScan.bundle/qrcode_scan_part_net");
        
        let vc = YLScanViewController();
        vc.scanStyle = style
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
    //MARK: -------自定义4个角及矩形框颜色
    func changeColor()
    {
        //设置扫码区域参数
        var style = YLScanViewSytle()
        style.centerUpOffset = 44;
        style.photoframeAngleStyle = YLScanViewPhotoframeAngleStyle.On;
        style.photoframeLineW = 6;
        style.photoframeAngleW = 24;
        style.photoframeAngleH = 24;
        style.isNeedShowRetangle = true;
        style.animationStyle = YLScanViewAnimationStyle.LineMove;
        
        //使用的支付宝里面网格图片
        style.animationImage = UIImage(named: "CodeScan.bundle/qrcode_scan_light_green");
        
        //4个角的颜色
        style.colorAngle = UIColor(red: 65.0/255.0, green: 174.0/255.0, blue: 57.0/255.0, alpha: 1.0)
        
        //矩形框颜色
        style.colorRetangleLine = UIColor(red: 247.0/255.0, green: 202.0/255.0, blue: 15.0/255.0, alpha: 1.0)
        
        //非矩形框区域颜色
        style.red_notRecoginitonArea = 247.0/255.0;
        style.green_notRecoginitonArea = 202.0/255.0;
        style.blue_notRecoginitonArea = 15.0/255.0;
        style.alpa_notRecoginitonArea = 0.2;
        
        let vc = YLScanViewController();
        vc.scanStyle = style
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
    //MARK: ------改变扫码区域位置
    func changeSize()
    {
        //设置扫码区域参数
        var style = YLScanViewSytle()
        
        //矩形框向上移动
        style.centerUpOffset = 60;
        //矩形框离左边缘及右边缘的距离
        style.xScanRetangleOffset = 100;
        
        
        style.photoframeAngleStyle = YLScanViewPhotoframeAngleStyle.On;
        style.photoframeLineW = 6;
        style.photoframeAngleW = 24;
        style.photoframeAngleH = 24;
        style.isNeedShowRetangle = true;
        style.animationStyle = YLScanViewAnimationStyle.LineMove;
        
        //qq里面的线条图片
        
        style.animationImage = UIImage(named: "CodeScan.bundle/qrcode_scan_light_green")
        let vc = YLScanViewController();
        vc.scanStyle = style
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    //MARK: -------- 相册
    func openLocalPhotoAlbum()
    {
        let picker = UIImagePickerController()
        
        picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        picker.delegate = self;
        
        picker.allowsEditing = true
        
        present(picker, animated: true, completion: nil)
    }
    
    //MARK: -----相册选择图片识别二维码 （条形码没有找到系统方法）
    private func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        picker.dismiss(animated: true, completion: nil)
        
        var image:UIImage? = info[UIImagePickerControllerEditedImage] as? UIImage
        
        if (image == nil )
        {
            image = info[UIImagePickerControllerOriginalImage] as? UIImage
        }
        
        if(image == nil)
        {
            return
        }
        
        if(image != nil)
        {
            let arrayResult = YLScanViewSetting.recognizeQRImage(image: image!)
            if arrayResult.count > 0
            {
                let result = arrayResult[0];
                
                showMsg(title: result.strBarCodeType, message: result.strScanned)
                
                return
            }
        }
        showMsg(title: "", message: "识别失败")
    }
    
    func showMsg(title:String?,message:String?)
    {
        let alertController = UIAlertController(title: title, message:message, preferredStyle: UIAlertControllerStyle.alert)
        
        let alertAction = UIAlertAction(title:  "知道了", style: UIAlertActionStyle.default) { (alertAction) -> Void in
            
            
        }
        
        alertController.addAction(alertAction)
        
        present(alertController, animated: true, completion: nil)
    }


}

