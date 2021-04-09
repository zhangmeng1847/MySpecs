//
//  LoginViewController.swift
//  MVVMExample
//
//  Created by zhangmeng3535 on 2021/3/29.
//

import Foundation
import UIKit
import SnapKit
import RxCocoa
import RxSwift

public class LoginViewController: UIViewController {
    public let disposeBag:DisposeBag = DisposeBag()
    
    public var accTextF:UITextField?
    public var pswTextF:UITextField?
    public var loginButton:UIButton?
    public var jumpVerifiButton:UIButton?
    
    public override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupUI()
        
        setupEvent()
    }
    
    public func setupUI() {
        view.backgroundColor = UIColor.white
        
        accTextF = UITextField.init()
        pswTextF = UITextField.init()
        loginButton = UIButton.init(type: .custom)
        jumpVerifiButton = UIButton.init(type: .custom)
        
        accTextF?.borderStyle = .roundedRect
        pswTextF?.borderStyle = .roundedRect
        loginButton?.layer.masksToBounds = true
        loginButton?.layer.cornerRadius = 5
        loginButton?.layer.borderWidth = 0.5
        loginButton?.layer.borderColor = UIColor.black.cgColor
        loginButton?.setTitleColor(UIColor.green, for: .normal)
        loginButton?.setTitleColor(UIColor.gray, for: .disabled)
        jumpVerifiButton?.layer.masksToBounds = true
        jumpVerifiButton?.layer.cornerRadius = 5
        jumpVerifiButton?.layer.borderWidth = 0.5
        jumpVerifiButton?.layer.borderColor = UIColor.blue.cgColor
        jumpVerifiButton?.setTitleColor(UIColor.blue, for: .normal)
        
        accTextF?.placeholder = "please input account"
        pswTextF?.placeholder = "please input password"
        loginButton?.setTitle("Login", for: .normal)
        jumpVerifiButton?.setTitle("Verification Code", for: .normal)
        
        view.addSubview(accTextF!)
        view.addSubview(pswTextF!)
        view.addSubview(loginButton!)
        view.addSubview(jumpVerifiButton!)
        
        accTextF?.snp.makeConstraints{(make) in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(100)
            make.height.equalTo(40)
        }
        
        pswTextF?.snp.makeConstraints{(make) in
            make.left.right.height.equalTo(accTextF!)
            make.top.lessThanOrEqualTo(accTextF!.snp.bottom).offset(20)
        }
        
        loginButton?.snp.makeConstraints{(make) in
            make.left.right.height.equalTo(pswTextF!)
            make.top.lessThanOrEqualTo(pswTextF!.snp.bottom).offset(30)
        }
        
        jumpVerifiButton?.snp.makeConstraints{(make) in
            make.left.right.height.equalTo(loginButton!)
            make.top.lessThanOrEqualTo(loginButton!.snp.bottom).offset(30)
        }
    }
    
    public  func setupEvent() {
       
        //listen
        Observable.combineLatest((accTextF?.rx.text.orEmpty)!, (pswTextF?.rx.text.orEmpty)!){ textValue1,textValue2 -> Bool in
            return textValue1.count > 0 && textValue2.count > 0
        }
        .map{ $0 }
        .bind(to: (loginButton?.rx.isEnabled)!)
        .disposed(by: disposeBag)
        
        
        //login event
        loginButton?.rx.tap.subscribe(onNext: {
            print("click login!!")
        }).disposed(by: disposeBag)
        
        //jump Verification Code page
        jumpVerifiButton?.rx.tap.subscribe(onNext: {[weak self] in
            self?.navigationController?.pushViewController(VerificationCodeViewController.init(), animated: true)
        }).disposed(by: disposeBag)
    }
}
