//
//  QRcodeGenerator.swift
//  QRReaderDemo
//
//  Created by B1media on 2016/6/22.
//  Copyright © 2016年 AppCoda. All rights reserved.
//

import UIKit

import CoreImage





class QRcodeGenerator: UIViewController {
    @IBOutlet weak var QRcodeImg: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    if let img = createQRFromString("Hello world program created by someone") {
        QRcodeImg.image = UIImage(CIImage: img, scale: 1.0, orientation: UIImageOrientation.Down)
    }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func createQRFromString(str: String) -> CIImage? {
        let stringData = str.dataUsingEncoding(NSUTF8StringEncoding)
        
        let filter = CIFilter(name: "CIQRCodeGenerator")
        
        filter?.setValue(stringData, forKey: "inputMessage")
        
        filter?.setValue("H", forKey: "inputCorrectionLevel")
        
        return filter?.outputImage
    }

    

}
