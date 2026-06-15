//
//  OLTermsHelper.swift
//  OneLoginExample-Swift
//
//  Created by GeeTest on 2025/9/1.
//  Copyright © 2025 com.geetest. All rights reserved.
//

import UIKit

private let KTermsAcceptedKey = "TermsAccepted"

extension UIApplication {
    var currentKeyWindow: UIWindow? {
        if #available(iOS 13.0, *) {
            for scene in self.connectedScenes {
                if scene.isKind(of: UIWindowScene.self),let windowScene = scene as? UIWindowScene,
                                   windowScene.activationState == .foregroundActive {
                                    return windowScene.windows.first { $0.isKeyWindow }
                                }
            }
            
            return nil
        } else {
            return self.keyWindow
        }
    }
    
    var currentRootViewController: UIViewController {
        return (self.currentKeyWindow?.rootViewController)!
    }
}



//富文本 +链接点击
 class OLTermsAlertController : UIAlertController, UITextViewDelegate, UITextFieldDelegate {
     var onAccept: ((Bool) -> Void)?
     func alertWithTitle(title: String, content: NSAttributedString, onAccept: @escaping ((Bool) ->Void )) -> OLTermsAlertController {
        
        let alert = OLTermsAlertController(title: title, message: "", preferredStyle: UIAlertController.Style.alert)
        alert.onAccept = onAccept
         
         //按钮
         let agree = UIAlertAction(title: "同意",
                                   style: UIAlertAction.Style.default,
                                   handler: {_ in
             UserDefaults.standard.set(true, forKey: KTermsAcceptedKey)
             UserDefaults.standard.synchronize()
             alert.onAccept!(true)})
         
         let disaggree = UIAlertAction(title: "不同意",
                                       style: UIAlertAction.Style.cancel,
                                       handler:  {_ in
              alert.onAccept!(false)
         })
         alert.addAction(agree)
         alert.addAction(disaggree)
         
         //用 UITextView 装富文本
         let textView = UITextView()
         textView.attributedText = content
         textView.isEditable = false
         textView.isScrollEnabled = false
         textView.textContainerInset = UIEdgeInsets.zero
         textView.textContainer.lineFragmentPadding = 0
         textView.backgroundColor = nil
         textView.delegate = alert
         textView.sizeToFit()
             
         alert.setValue(textView, forKey: "contentViewController")//KVC注入
         return alert
    }
     
     
       
}

class OLTermsHelper {
    static func hasAcceptedTermsWithAlert(flag: Bool) -> Bool {
        let status = UserDefaults.standard.bool(forKey: KTermsAcceptedKey)
        if !status && flag {
            let alertVC = UIAlertController(title: "体验产品前请同意服务协议以及隐私政策",
                                            message: "如果不小心点了\"不同意\"，请重启 App 再次进行确认",
                                            preferredStyle: UIAlertController.Style.alert)
            //按钮
            let okAction = UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil)
            alertVC.addAction(okAction)
            UIApplication.shared.currentRootViewController.present(alertVC, animated: true, completion: nil)
        }
        return status
    }
    
    static func showTermsAlertFrom(presentingVC: ViewController, onAccept: @escaping (Bool) ->Void){
        let title = "使用前请同意相关协议"
        
        //富文本内容
        let plain = "请阅读并同意《服务协议》和《隐私政策》后才能继续使用本 Demo 进行相关产品的体验"
        let attr = NSMutableAttributedString(string: plain, attributes: [.font: UIFont.systemFont(ofSize: 16)])
        
        attr.addAttribute(.link, value: "https://www.geetest.com/Private/onelogin", range: NSRange(plain.range(of: "《服务协议》")!, in: plain))
        attr.addAttribute(.link, value: "https://www.geetest.com/Service", range: NSRange(plain.range(of: "《隐私政策》")!, in: plain))
        
        if #available(iOS 13.0, *) {
            let alert = OLAlertViewController(title: title,
                                              content: attr, confirmButtonText: "同意",
                                              cancelButtontext: "不同意",
                                              confirmhandler: {UserDefaults.standard.set(true, forKey: KTermsAcceptedKey)
                UserDefaults.standard.synchronize()
                onAccept(true)},
                                              cancelhandler: {onAccept(false)})
            alert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            presentingVC.present(alert, animated: true, completion: nil)
        }
        else {
            let alert = OLTermsAlertController().alertWithTitle(title: title , content: attr, onAccept: onAccept)
            presentingVC.present(alert, animated: true, completion: nil)
        }
    }
    
}


