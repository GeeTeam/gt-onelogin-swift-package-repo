//
//  ViewController.swift
//  OneLoginExample-Swift
//
//  Created by noctis on 2020/9/17.
//  Copyright © 2020 com.geetest. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.title = "无感本机认证"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if(!OLTermsHelper.hasAcceptedTermsWithAlert(flag: false)){
            OLTermsHelper.showTermsAlertFrom(presentingVC: self, onAccept: {_ in })
        }
    }
        
    @IBAction func nLoginAction(_ sender: Any) {
        if !(OLTermsHelper.hasAcceptedTermsWithAlert(flag: true)){
            return
        }
        
        guard let navigationController else {
            return
        }
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        if #available(iOS 13, *) {
            let vc = sb.instantiateViewController(identifier: "LoginViewController")
            navigationController.pushViewController(vc, animated: true)
        }
        else {
            let vc = sb.instantiateViewController(withIdentifier: "LoginViewController")
            navigationController.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func onepassAction(_ sender: Any) {
        if !(OLTermsHelper.hasAcceptedTermsWithAlert(flag: true)){
            return
        }
        
        guard let navigationController else {
            return
        }
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        if #available(iOS 13, *) {
            let vc = sb.instantiateViewController(identifier: "OnePassViewController")
            navigationController.pushViewController(vc, animated: true)
        }
        else {
            let vc = sb.instantiateViewController(withIdentifier: "OnePassViewController")
            navigationController.pushViewController(vc, animated: true)
        }
        
    }
}

