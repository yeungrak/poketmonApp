//
//  PhoneBookViewController.swift
//  poketmonApp
//
//  Created by 최영락 on 4/21/25.
//

import SnapKit
import UIKit


class PhoneBookViewController: UIViewController {
    private var currentImageUrl: String?
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
        textField.placeholder = "이름을 입력하세요"
        textField.textColor = .black
        textField.font = .systemFont(ofSize: 16)
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private var numberTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "전화번호를 입력하세요"
        textField.textColor = .black
        textField.font = .systemFont(ofSize: 16)
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configure()
        navigationItem()
        navigationController?.navigationBar.isHidden = false
        
        randomImage.addTarget(self, action: #selector(randomImageTapped), for: .touchDown)
    }
    
    //뷰가 감춰질때마다
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func fetchData(pokemonID: Int) {
        
        
        guard let url: URL = URL(string: "https://pokeapi.co/api/v2/pokemon/\(pokemonID)") else {
            print("URL is not correct")
            return
        }
        
        var request: URLRequest = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session: URLSession = URLSession(configuration: .default)
        
        session.dataTask(with: request) { (data, response, error) in
            let successRange: Range = (200..<300)
            guard let data, error == nil else {
                print("에러 발생: \(String(describing: error))")
                return}
            
            if let response: HTTPURLResponse = response as? HTTPURLResponse{
                print("status code: \(response.statusCode)")
                
                // 요청 성공 (StatusCode가 200번대)
                if successRange.contains(response.statusCode){
                    
                    // decode
                    guard let poketmonInfo: PoketApi = try? JSONDecoder().decode(PoketApi.self, from: data) else {
                        print("디코딩 실패")
                        return
                    }
                    
                    print("포켓몬 이름: \(poketmonInfo.name)")
                    print("포켓몬 키: \(poketmonInfo.height)")
                    print("포켓몬 몸무게: \(poketmonInfo.weight)")
                    print("포켓몬 이미지 URL: \(poketmonInfo.sprites.front_default)")
                    
                    
                    DispatchQueue.main.async {
                        self.currentImageUrl = poketmonInfo.sprites.front_default
                        self.profileImage.loadImage(from: poketmonInfo.sprites.front_default)
                    }
                    
                } else { // 요청 실패 (Status code가 200대 아님)
                    print("요청 실패")
                }
            }
            
        }.resume()
    }
    
    func navigationItem() {
        self.title = "연락처 추가"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "적용", style: .plain, target: self, action: #selector(saveFriend))
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
    @objc func randomImageTapped() {
        let randomID = Int.random(in: 1...1000)
        fetchData(pokemonID: randomID)
    }
    
    @objc func saveFriend() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let newFriend = PhoneBook(context: context)
        newFriend.name = nameTextField.text
        newFriend.phoneNumber = numberTextField.text
        newFriend.imageUrl = currentImageUrl // 여기!
        
        do {
            try context.save()
            print("저장 성공!")
            navigationController?.popViewController(animated: true)
        } catch {
            print("저장 실패: \(error.localizedDescription)")
        }
    }
}

extension UIImageView {
    func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
    }
}
