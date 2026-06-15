//
//  OLAlertViewController.swift
//  OneLoginExample-Swift
//
//  Created by GeeTest on 2025/9/1.
//  Copyright © 2025 com.geetest. All rights reserved.
//

import UIKit

class OLAlertViewController :UIViewController, UITextViewDelegate  {
    
    typealias OLAlertAction = () -> Void
    
    private var alertContainer: UIView!
    private var titleLabel: UILabel!
    private var contentTextView: UITextView!
    private var confirmButton: UIButton!
    private var cancelButton: UIButton!
    
    var confirmAction : OLAlertAction?
    var cancelAction : OLAlertAction?
    
    private var titleText: String!
    private var contentAttr: NSAttributedString!
    private var confirmText: String!
    private var cancelText: String!
    
    convenience init(title: String ,content: NSAttributedString,
                     confirmButtonText confirmText: String,
                     cancelButtontext cancelText: String,
                     confirmhandler: @escaping OLAlertAction,
                     cancelhandler: @escaping OLAlertAction){

        self.init()
        self.titleText = title
        self.contentAttr = content
        self.confirmText = confirmText
        self.cancelText = cancelText
        self.confirmAction = confirmhandler
        self.cancelAction = cancelhandler
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.showWithAnimation()
    }
    
    
    func setupUI() {
        self.modalPresentationStyle = UIModalPresentationStyle(rawValue: 6)!
        self.modalTransitionStyle = UIModalTransitionStyle(rawValue: 2)!
        self.view.backgroundColor = UIColor .clear
        
        
        //毛玻璃背景
        let blurEffect: UIBlurEffect
        if #available(iOS 13.0, *) {
            blurEffect = UIBlurEffect(style: .systemMaterial)
        }
        else {
            blurEffect = UIBlurEffect(style: .light)
        }
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(blurView)
        
        //容器
        alertContainer = UIView()
        if #available(iOS 13.0, *){
            self.alertContainer.backgroundColor = UIColor.systemBackground
        }else{
            self.alertContainer.backgroundColor = UIColor.white
        }
        self.alertContainer.layer.cornerRadius = 14
        self.alertContainer.layer.masksToBounds = true
        self.alertContainer.layer.borderWidth = 0.5
        self.alertContainer.layer.borderColor = UIColor.lightGray.cgColor
        self.alertContainer.translatesAutoresizingMaskIntoConstraints = false
        
        let topSpacer = UIView()
        topSpacer.translatesAutoresizingMaskIntoConstraints = false
        topSpacer.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        self.view.addSubview(alertContainer)
        
        //title
        self.titleLabel = UILabel()
        self.titleLabel.text = self.titleText
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        self.titleLabel.textAlignment = NSTextAlignment(.center)
        self.titleLabel.numberOfLines = 0
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //content textview
        self.contentTextView = UITextView()
        self.contentTextView.attributedText = self.contentAttr
        self.contentTextView.isEditable = false
        self.contentTextView.isScrollEnabled = false
        self.contentTextView.textContainerInset = UIEdgeInsets.zero
        self.contentTextView.textContainer.lineFragmentPadding = 0
        self.contentTextView.backgroundColor = UIColor.clear
        self.contentTextView.delegate = self
        self.contentTextView.translatesAutoresizingMaskIntoConstraints = false
        
        let wrapper = UIView()
        wrapper.addSubview(self.contentTextView)
        NSLayoutConstraint.activate([
            self.contentTextView.centerXAnchor.constraint(equalTo: wrapper.centerXAnchor),
            self.contentTextView.centerYAnchor.constraint(equalTo: wrapper.centerYAnchor),
            self.contentTextView.widthAnchor.constraint(equalTo: wrapper.widthAnchor, multiplier: 0.90),
            wrapper.heightAnchor.constraint(equalTo: self.contentTextView.heightAnchor)
        ])
        
        //buttons
        self.confirmButton = UIButton(type:UIButton.ButtonType.system)
        self.confirmButton.setTitle(self.confirmText, for: UIControl.State.normal)
        self.confirmButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        self.confirmButton.setTitleColor(UIColor.systemBlue, for: UIControl.State.normal)
        self.confirmButton.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
        self.confirmButton.addTarget(self, action: #selector(confirmTapped), for: UIControl.Event.touchUpInside)
        
        self.cancelButton = UIButton(type:UIButton.ButtonType.system)
        self.cancelButton.setTitle(self.cancelText, for: UIControl.State.normal)
        self.cancelButton.setTitleColor(UIColor.systemBlue, for: UIControl.State.normal)
        self.cancelButton.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
        self.cancelButton.addTarget(self, action: #selector(cancelTapped), for: UIControl.Event.touchUpInside)
        
        //stack for buttons
        let buttonStack = UIStackView(arrangedSubviews: [self.cancelButton,self.confirmButton])
        buttonStack.distribution = UIStackView.Distribution.fillEqually
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        
        //组装
        let mainStack = UIStackView(arrangedSubviews: [topSpacer,self.titleLabel,wrapper,buttonStack])
        mainStack.axis = NSLayoutConstraint.Axis.vertical
        mainStack.spacing = 12
        mainStack.layoutMargins = UIEdgeInsets(top: 20, left: 24, bottom: 16, right: 24)
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        
        
        self.alertContainer.addSubview(mainStack)
        
        //auto layout
        NSLayoutConstraint.activate([blurView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                                     blurView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                                     blurView.topAnchor.constraint(equalTo: self.view.topAnchor),
                                     blurView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
                                     
                                     self.alertContainer.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                                     self.alertContainer.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
                                     self.alertContainer.widthAnchor.constraint(equalToConstant: 280),
                                     
                                     mainStack.leadingAnchor.constraint(equalTo: alertContainer.leadingAnchor),
                                     mainStack.trailingAnchor.constraint(equalTo:  alertContainer.trailingAnchor),
                                     mainStack.topAnchor.constraint(equalTo:  alertContainer.topAnchor),
                                     mainStack.bottomAnchor.constraint(equalTo:  alertContainer.bottomAnchor)])
    }
    
    //动画
    func showWithAnimation() {
        self.alertContainer.transform = CGAffineTransformMakeScale(0.8, 0.8)
        UIView.animate(withDuration: 0.25, animations: {
            self.alertContainer.transform = CGAffineTransformIdentity
        })
    }
    
    func dismissWithAnimation() {
        UIView.animate(withDuration: 0.15,
                       animations: {
            self.alertContainer.transform = CGAffineTransformMakeScale(0.8, 0.8)
            self.view.alpha = 0
        }, completion: {_ in
            self.dismiss(animated: false, completion: nil)
        })
    }
    
    @objc func confirmTapped() {
        self.dismissWithAnimation()
        self.confirmAction?()
    }

    @objc func cancelTapped() {
        self.dismissWithAnimation()
        self.cancelAction?()
    }
    
    //点击URL
    func textView(textView: UITextView, URL: NSURL, characterRange: NSRange) ->Bool{
        if #available(iOS 10.0, *){
            if UIApplication.shared.canOpenURL(URL as URL){
                UIApplication.shared.open(URL as URL, options: [:], completionHandler: {_ in })
            }
        }else{
            if(UIApplication.shared.canOpenURL(URL as URL)){
                UIApplication.shared.openURL(URL as URL)
            }
        }
        return false
    }
    
}




