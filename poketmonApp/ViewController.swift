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
    
    var label:UILabel = {
        let label = UILabel()
        label.text = "친구 목록"
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    var addButton:UIButton = {
        let button = UIButton()
        button.setTitle("추가", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(UIColor.lightGray, for: .normal)
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
        
    }
    
    func configure() {
        [label,
         tableView,
         addButton
        ].forEach {view.addSubview($0)}
        
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(120)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(50)
            make.height.equalTo(400)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
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
    
    
}
