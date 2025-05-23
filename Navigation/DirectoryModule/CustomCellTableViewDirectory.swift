//
//  CustomCellTableViewDirectory.swift
//  Navigation
//
//  Created by Егор Голубев on 23.05.2025.
//

import UIKit
import SnapKit

class CustomCellTableViewDirectory: UITableViewCell {
    
    private lazy var photoView: UIImageView = {
        let photo = UIImageView()
        return photo
    }()
    
    private lazy var namePhoto: UITextField = {
        let namePhoto = UITextField()
        return namePhoto
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setubSubviews()
        self.selectionStyle = .default
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    
    private func setubSubviews() {
        
        contentView.addSubviews(photoView, namePhoto)
        
        photoView.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top).inset(10)
            $0.bottom.equalTo(contentView.snp.bottom).inset(40)
            $0.left.equalTo(contentView.snp.left).inset(30)
            $0.right.equalTo(contentView.snp.right).inset(30)
        }
        
        namePhoto.snp.makeConstraints{
            $0.top.equalTo(photoView.snp.bottom).inset(10)
            $0.left.equalTo(contentView.snp.left).inset(30)
            $0.right.equalTo(contentView.snp.right).inset(30)
            $0.bottom.equalTo(contentView.snp.bottom)
        }
        
    }
    
    public func configure(name: String, pathPhoto: String) {
        namePhoto.text = name
        if let image = UIImage(contentsOfFile: pathPhoto) {
            photoView.image = image
        }
    }
    
}
