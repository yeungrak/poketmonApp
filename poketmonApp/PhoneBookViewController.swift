//
//  PhoneBookViewController.swift
//  poketmonApp
//
//  Created by 최영락 on 4/21/25.
//

import SnapKit
import UIKit


class PhoneBookViewController: UIViewController {
    
    private var profileImage: UIImageView = {
        let profileImage = UIImageView()
        profileImage.contentMode = .scaleAspectFill
        profileImage.layer.cornerRadius = 100
        profileImage.clipsToBounds = true
        profileImage.layer.borderColor = UIColor.black.cgColor
        profileImage.layer.borderWidth = 1
        return profileImage
    }()
    
    private var randomImage: UIButton = {
        let randomImage = UIButton()
        randomImage.setTitle("랜덤 이미지 생성", for: .normal)
        randomImage.setTitleColor(.lightGray, for: .normal)
        return randomImage
    }()
    
    private var nameTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.font = .systemFont(ofSize: 16)
        textField.placeholder = "이름을 입력하세요"        // 안내 문구
            textField.textColor = .black                      // 글자 색
            textField.font = .systemFont(ofSize: 16)          // 글자 크기
            textField.borderStyle = .roundedRect              // 테두리 스타일
        return textField
    }()
    
    private var numberTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "전화번호를 입력하세요"        // 안내 문구
            textField.textColor = .black                      // 글자 색
            textField.font = .systemFont(ofSize: 16)          // 글자 크기
            textField.borderStyle = .roundedRect
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configure()
    }
    
    func configure() {
        [ profileImage,
          randomImage,
          nameTextField,
          numberTextField].forEach{view.addSubview($0)}
        
        profileImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(150)
            make.size.equalTo(200)
            make.centerX.equalToSuperview()
        }
        
        randomImage.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.bottom).offset(20)
            make.centerX.equalToSuperview()}
        
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(randomImage.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        numberTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        }
       }
