//
//  ViewController.swift
//  poketmonApp
//
//  Created by 최영락 on 4/21/25.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let names = ["name", "name", "name", "name", "name"]
    let numbers = ["010-0000-0000", "010-0000-0000", "010-0000-0000", "010-0000-0000", "010-0000-0000"]
    let imageNames = ["pikacu","pikacu","pikacu","pikacu","pikacu"]
    
    
    var friendsListLabel:UILabel = {
        let label = UILabel()
        label.text = "친구 목록"
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    lazy var addButton:UIButton = {
        let button = UIButton()
        button.setTitle("추가", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(UIColor.darkGray, for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchDown)
        return button
    }()
    
    var tableView:UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        configure()
        navigationController?.navigationBar.isHidden = true
    }
    
    
    func configure() {
        [friendsListLabel,
         tableView,
         addButton
        ].forEach {view.addSubview($0)}
        
        friendsListLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(80)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(friendsListLabel.snp.bottom).offset(50)
            make.height.equalTo(600)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        addButton.snp.makeConstraints { make in
            make.centerY.equalTo(friendsListLabel.snp.centerY)
            make.trailing.equalToSuperview().inset(15)}
    }
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        
        cell.nameLabel.text = names[indexPath.row]
        cell.numberLabel.text = numbers[indexPath.row]
        cell.profileImage.image = UIImage(named: imageNames[indexPath.row])
        return cell
    }
    
    @objc func buttonTapped() {
        print("Tap")
        let vc = PhoneBookViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

// 첫번째 뷰에서 네비게이션바를 없애고
// 두번째 뷰에서는 네베게션 바를 생겨야됌
// 네비게션바는 제일 마지막에 한 설정을 따라감
// 라이프사이클 고려
