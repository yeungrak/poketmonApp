//
//  ViewController.swift
//  poketmonApp
//
//  Created by 최영락 on 4/21/25.
//

import UIKit
import SnapKit
import CoreData

class ViewController: UIViewController {
    
    
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
        fetchFriends()
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchFriends()
    }
    
    var savedFriends: [PhoneBook] = []
    
    func fetchFriends() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request: NSFetchRequest<PhoneBook> = PhoneBook.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        
        do {
            savedFriends = try context.fetch(request)
            tableView.reloadData()
        } catch {
            print("불러오기 실패: \(error.localizedDescription)")
        }
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
        savedFriends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        
        let phoneBook = savedFriends[indexPath.row]  // 타입은 PhoneBook!
        
        cell.nameLabel.text = phoneBook.name
        cell.numberLabel.text = phoneBook.phoneNumber
        
        if let urlString = phoneBook.imageUrl {
            cell.profileImage.loadImage(from: urlString)
        } else {
            cell.profileImage.image = UIImage(named: "defaultImage")
        }
        
        return cell
    }
    
    @objc func buttonTapped() {
        print("Tap")
        let vc = PhoneBookViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
