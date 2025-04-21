//
//  TableViewCell.swift
//  poketmonApp
//
//  Created by 최영락 on 4/21/25.
//

import SnapKit
import UIKit

class TableViewCell: UITableViewCell {
    let profileImage = UIImageView()
    let nameLabel = UILabel()
    let numberLabel = UILabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        cellConfigure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func cellConfigure() {
        [ profileImage,
          nameLabel,
          numberLabel].forEach{contentView.addSubview($0)}
        
       
        profileImage.contentMode = .scaleAspectFill
        profileImage.layer.cornerRadius = 30
        profileImage.clipsToBounds = true
        profileImage.layer.borderColor = UIColor.black.cgColor
        profileImage.layer.borderWidth = 1
        profileImage.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
            make.height.equalTo(60)
            make.width.equalTo(60)}
        
        nameLabel.font = .boldSystemFont(ofSize: 15)
        nameLabel.textColor = .black
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(profileImage.snp.trailing).offset(12)
            make.centerY.equalToSuperview()
        }
        
        numberLabel.font = .systemFont(ofSize: 15)
        numberLabel.textColor = .black
        numberLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
    }
}
