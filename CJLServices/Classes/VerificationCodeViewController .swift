//
//  VerificationCodeViewController .swift
//  MVVMExample
//
//  Created by zhangmeng3535 on 2021/3/29.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

class VerificationCodeViewController: UIViewController {
    
    let disposeBag:DisposeBag = DisposeBag()
    var verifiTextField:UITextField?
    var submitButton:UIButton?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupUI()
        
        setupEvent()
    }
    
    func setupUI() {
        view.backgroundColor = UIColor.white
        verifiTextField = UITextField.init()
        submitButton = UIButton.init(type: .custom)
        
        verifiTextField?.borderStyle = .roundedRect
        submitButton?.setTitle("Submit", for: .normal)

        submitButton?.layer.masksToBounds = true
        submitButton?.layer.cornerRadius = 5
        submitButton?.layer.borderWidth = 0.5
        submitButton?.layer.borderColor = UIColor.black.cgColor
        submitButton?.setTitleColor(UIColor.green, for: .normal)
        submitButton?.setTitleColor(UIColor.gray, for: .disabled)
        
        view.addSubview(verifiTextField!)
        view.addSubview(submitButton!)
        
        verifiTextField?.snp.makeConstraints{(make) in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(100)
            make.height.equalTo(40)
        }
        
        submitButton?.snp.makeConstraints{(make) in
            make.left.right.height.equalTo(verifiTextField!)
            make.top.lessThanOrEqualTo(verifiTextField!.snp.bottom).offset(30)
        }
        
    }
    
    func setupEvent(){
        //使用Rx对输入框内容进行监听，如果监听内容发生改变，按钮状态进行改变
        let verifiInput = verifiTextField?.rx.text.orEmpty.asDriver()
            .throttle(.milliseconds(300))    //当文本框内容改变（0.3秒内值若多次改变，取最后一次）

        //输入的内容绑定按钮的响应
        verifiInput?.map({ $0.count > 5 })
            .drive((submitButton?.rx.isEnabled)!)
            .disposed(by:disposeBag)
        
        //submit button action
        submitButton?.rx.tap.subscribe(onNext: {
            print("sumit verification code!!")
        }).disposed(by: disposeBag)
    }
    
}
