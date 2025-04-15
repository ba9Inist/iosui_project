//
//  CustomButton.swift
//  Navigation
//
//  Created by Егор Голубев on 09.04.2025.
//

import UIKit

class CustomButton: UIButton {

    var onTap: (() -> Void)?
    
    convenience init(title: String?, titleColor: UIColor = .black, backgroundColor: UIColor? = nil, cornerRadius: CGFloat = 0) {
        self.init(frame: .zero)
        
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
        
        if let bgColor = backgroundColor {
            self.backgroundColor = bgColor
        }
        
        layer.cornerRadius = cornerRadius

        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc private func buttonTapped() {
        onTap?()
    }
}
