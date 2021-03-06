//
//  QRcodeGenerator.swift
//  QRReaderDemo
//
//  Created by B1media on 2016/6/22.
//  Copyright © 2016年 AppCoda. All rights reserved.
//


import UIKit
import AVFoundation

class QRcodeGenerator : UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var imgQRCode: UIImageView!
    
    @IBOutlet weak var btnAction: UIButton!
    
    @IBOutlet weak var slider: UISlider!
    
    var userDefault = NSUserDefaults.standardUserDefaults()
    
//    private var currentTextField: UITextField?
    private var isKeyboardShown = false
    var qrcodeImage: CIImage!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: #selector(QRcodeGenerator.keyboardWillShow(_:)),
            name: UIKeyboardWillShowNotification,
            object: nil)
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: #selector(QRcodeGenerator.keyboardWillHide(_:)),
            name: UIKeyboardWillHideNotification,
            object: nil)
        slider.maximumValue = 1.5
        slider.minimumValue = 0.3
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        self.textField = textField
    }

    func keyboardWillShow(note: NSNotification) {
        if isKeyboardShown {
            return
        }
        if (self.textField != textField) {
            return
        }
        let keyboardAnimationDetail = note.userInfo as! [String: AnyObject]
        let duration = NSTimeInterval(keyboardAnimationDetail[UIKeyboardAnimationDurationUserInfoKey]! as! NSNumber)
        let keyboardFrameValue = keyboardAnimationDetail[UIKeyboardFrameBeginUserInfoKey]! as! NSValue
        let keyboardFrame = keyboardFrameValue.CGRectValue()
        
        UIView.animateWithDuration(duration, animations: { () -> Void in
            self.view.frame = CGRectOffset(self.view.frame, 0, -keyboardFrame.size.height)
        })
        isKeyboardShown = true
    }
    
    func keyboardWillHide(note: NSNotification) {
        let keyboardAnimationDetail = note.userInfo as! [String: AnyObject]
        let duration = NSTimeInterval(keyboardAnimationDetail[UIKeyboardAnimationDurationUserInfoKey]! as! NSNumber)
        UIView.animateWithDuration(duration, animations: { () -> Void in
            self.view.frame = CGRectOffset(self.view.frame, 0, -self.view.frame.origin.y)
        })
        isKeyboardShown = false
    }
    
    // MARK: IBAction method implementation
    
    @IBAction func performButtonAction(sender: AnyObject) {
        if qrcodeImage == nil {
            if textField.text == "" {
                return
            }
            
            let data = textField.text!.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        
            let filter = CIFilter(name: "CIQRCodeGenerator")
            
            filter!.setValue(data, forKey: "inputMessage")
            //inputCorrectionLevel用於定義生成二維碼對象的修正格式，關於修正格式可以參考二維碼的通行標準。
            filter!.setValue("Q", forKey: "inputCorrectionLevel")
        
            qrcodeImage = filter!.outputImage
        
            textField.resignFirstResponder()
            
            btnAction.setTitle("Clear", forState: UIControlState.Normal)
            
            displayQRCodeImage()
            
            //進行資料儲存
            userDefault.setObject(data , forKey: "data")
            userDefault.synchronize()
        }
        else {
            imgQRCode.image = nil
            qrcodeImage = nil
            btnAction.setTitle("Generate", forState: UIControlState.Normal)
        }
        
        textField.enabled = !textField.enabled
        slider.hidden = !slider.hidden
    }
    
    
    @IBAction func changeImageViewScale(sender: AnyObject) {
        imgQRCode.transform = CGAffineTransformMakeScale(CGFloat(slider.value), CGFloat(slider.value))
        print((slider.value))
    }
    
    
    @IBAction func lightOnAndOff(sender: AnyObject) {
        let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        if (device.hasTorch) {
            do {
                try device.lockForConfiguration()
                if (device.torchMode == AVCaptureTorchMode.On) {
                    device.torchMode = AVCaptureTorchMode.Off
                } else {
                    try device.setTorchModeOnWithLevel(1.0)
                }
                device.unlockForConfiguration()
            } catch {
                print(error)
            }
        }
    }
    
    
    // MARK: Custom method implementation
    
    func displayQRCodeImage() {
        let scaleX = imgQRCode.frame.size.width / qrcodeImage.extent.size.width
        let scaleY = imgQRCode.frame.size.height / qrcodeImage.extent.size.height
        let transformedImage = qrcodeImage.imageByApplyingTransform(CGAffineTransformMakeScale(scaleX, scaleY))
        
        imgQRCode.image = UIImage(CIImage: transformedImage)
    }
    
    
}

