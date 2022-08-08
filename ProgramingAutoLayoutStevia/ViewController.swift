//
//  ViewController.swift
//  ProgramingAutoLayoutStevia
//
//  Created by xhieu21 on 05/08/2022.
//

import UIKit
import Stevia

class ViewController: UIViewController {
    
    
    //MARK: - Create UI
    
    let btnBack: UIButton = {
        let btnBack = UIButton(type: .system)
        btnBack.setImage(UIImage(named: "btn_back"), for: .normal)
        btnBack.tintColor = .black
        btnBack.addTarget(self, action: #selector(btnBackTapped), for: .touchUpInside)
        return btnBack
    }()
    
    let stepView: UIView = {
       let stepView = UIView()
        stepView.backgroundColor = UIColor.systemGray6
        stepView.layer.cornerRadius = 10
        return stepView
    }()
    
    let stepLabel: UILabel = {
        let stepLabel = UILabel()
        stepLabel.text = "Bước 1/3"
        stepLabel.font = UIFont.systemFont(ofSize: 13)
        stepLabel.textAlignment = .center
        stepLabel.textColor = UIColor.darkGray
        return stepLabel
    }()
    
    let titleLabel: UILabel = {
       let titleLabel = UILabel()
        titleLabel.text = "Điền số điện thoại của bạn và tiếp tục"
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textAlignment = .left
        return titleLabel
    }()
    
    let inputPhoneNumberView: UIView = {
        let inputPhoneNumberView = UIView()
        inputPhoneNumberView.layer.cornerRadius = 15
        inputPhoneNumberView.layer.borderWidth = 1
        inputPhoneNumberView.layer.borderColor = UIColor.systemOrange.cgColor
        return inputPhoneNumberView
    }()
    
    let flagVN: UIImageView = {
        let flagVN = UIImageView()
        flagVN.image = UIImage(named: "flag_vn")
        return flagVN
    }()
    
    let lineView: UIView = {
       let lineView = UIView()
        lineView.backgroundColor = .systemGray3
        return lineView
    }()
    
    let phoneNumberTextFiled: UITextField = {
       let phoneNumberTextField = UITextField()
        phoneNumberTextField.placeholder = "Nhập số điện thoại"
        phoneNumberTextField.keyboardType = .numberPad
        phoneNumberTextField.font = UIFont.systemFont(ofSize: 15)
        phoneNumberTextField.addTarget(self, action: #selector(phoneNumberTextChanged), for: .editingChanged)
        return phoneNumberTextField
    }()
    
    let noteLabel: UILabel = {
       let noteLabel = UILabel()
        noteLabel.text = "Bạn nên sử dụng số điện thoại chính chủ để khoản vay được phê duyệt nhanh hơn !"
        noteLabel.numberOfLines = 0
        noteLabel.font = UIFont.systemFont(ofSize: 13)
        noteLabel.textAlignment = .left
        return noteLabel
    }()
    
    let bottomView: UIView = {
       let bottomView = UIView()
        return bottomView
    }()
    
    let noteLabel2: UILabel = {
       let noteLabel2 = UILabel()
        noteLabel2.text = "Bấm vào nút tiếp tục nếu bạn đồng ý với Điều khoản của Credita"
        noteLabel2.textAlignment = .center
        noteLabel2.font = UIFont.systemFont(ofSize: 13)
        noteLabel2.numberOfLines = 0
        return noteLabel2
    }()
    
    let btnNext: UIButton = {
        let btnNext = UIButton(type: .system)
        btnNext.setTitle("Tiếp tục", for: .normal)
        btnNext.setTitleColor(.white, for: .normal)
        btnNext.backgroundColor = UIColor.systemGray4
        btnNext.layer.cornerRadius = 15
        btnNext.addTarget(self, action: #selector(btnNextTapped), for: .touchUpInside)
        return btnNext
    }()
    
    //MARK: - viewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        dismissKeyboard()
        disableBtnNext()
        phoneNumberTextFiled.becomeFirstResponder()
        addConstraints()
    }
    
    //MARK: - func

    
    func dismissKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapOnView))
        view.addGestureRecognizer(tap)
    }
    
    func enableBtnNext() {
        btnNext.backgroundColor = .tintColor
        btnNext.isUserInteractionEnabled = true
    }
    
    func disableBtnNext() {
        btnNext.backgroundColor = .systemGray4
        btnNext.isUserInteractionEnabled = false
    }
    
    func validatePhoneNumber() -> Bool {
        if phoneNumberTextFiled.text?.first == "0" && phoneNumberTextFiled.text!.count == 10 {
            return true
        } else { return false }
    }

}


//MARK: - Add Constraints

extension ViewController {
    func addConstraints() {
        
        //MARK: - add sub view
        view.subviews(
            btnBack, stepView.subviews(stepLabel),
            titleLabel,
            inputPhoneNumberView.subviews(flagVN, lineView, phoneNumberTextFiled),
            noteLabel,
            bottomView.subviews(noteLabel2, btnNext)
        )
        
        //MARK: - add constraints
        
//        btnBack.top(60).left(16)
//        stepView.CenterY == btnBack.CenterY
//        stepView.right(16)
        
        view.layout(
            60,
            |-16-btnBack,
            stepView.CenterY == btnBack.CenterY,
            stepView-16-|,
            24,
            |-16-titleLabel-70-|,
            24,
            |-16-inputPhoneNumberView-16-|,
            8,
            |-16-noteLabel-16-|,
            inputPhoneNumberView.CenterX == view.CenterX,
            |-16-bottomView-16-|,
            32
        )
        
        stepView.layout(
            5,
            |-12-stepLabel-12-|,
            5
        )
        
        inputPhoneNumberView.layout(
            flagVN.width(28).height(28),
            flagVN.CenterY == inputPhoneNumberView.CenterY,
            lineView.height(30).width(1),
            16,
            |-16-flagVN-12-lineView-12-phoneNumberTextFiled-16-|,
            16
        )
        bottomView.layout(
            0,
            |-0-noteLabel2-0-|,
            24,
            |-0-btnNext-0-| ~ 44,
            0
        )
        
    }
}




//MARK: - objc func
extension ViewController {
    
    @objc func btnBackTapped() {
        print("Back")
    }
    
    @objc func tapOnView() {
        phoneNumberTextFiled.resignFirstResponder()
    }
    
    @objc func btnNextTapped() {
        print("Next")
    }
    
    @objc func phoneNumberTextChanged() {
        if phoneNumberTextFiled.text!.count > 10 {
            phoneNumberTextFiled.text?.removeLast()
        }
        
        if validatePhoneNumber() {
            enableBtnNext()
        } else { disableBtnNext() }
        
    }
    
    
}

