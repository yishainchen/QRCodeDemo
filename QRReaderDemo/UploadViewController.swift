//
//  UploadViewController.swift
//  QRReaderDemo
//
//  Created by B1media on 2016/7/11.
//  Copyright © 2016年 AppCoda. All rights reserved.
//

import UIKit

class UploadViewController: UIViewController {

    @IBOutlet weak var idText: UITextField!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var phoneText: UITextField!
    @IBOutlet weak var moneyText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func submitButton(sender: AnyObject) {
        
        API.pushData(idText.text!, username: nameText.text!, userphone: phoneText.text! , usermoney: moneyText.text! )
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
