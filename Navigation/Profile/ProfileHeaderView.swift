//
//  ProfileHeaderView.swift
//  Navigation
//

import UIKit
import SnapKit

final class ProfileHeaderView: UITableViewHeaderFooterView {
    
    // MARK: Visual objects
    
    var fullNameLabel = UILabel()
    var avatarImageView = UIImageView()
    var statusLabel = UILabel()
    var statusTextField = UITextField()
    var setStatusButton = UIButton()
    var returnAvatarButton = UIButton()
    var avatarBackground = UIView()
    
    private var statusText = "Ready to help"
    private var avatarOriginPoint = CGPoint()
    
    // MARK: - Setup section
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupNameLabel()
        setupStatusLabel()
        setupStatusTextField()
        setupAvatarImage()
        setupStatusButton()
        
        
        statusTextField.delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("lol")
    }
    
    private func setupNameLabel() {
        //fullNameLabel.translatesAutoresizingMaskIntoConstraints = false
        fullNameLabel.text = "Teo West"
        fullNameLabel.font = .boldSystemFont(ofSize: 18)
        fullNameLabel.textColor = .black
        addSubview(fullNameLabel)
        fullNameLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(safeAreaLayoutGuide).offset(16)
            make.leading.equalTo(safeAreaLayoutGuide).offset(156)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-16)
            make.height.equalTo(28)
            
        }
//        NSLayoutConstraint.activate([
//            fullNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
//            fullNameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 156),
//            fullNameLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
//            fullNameLabel.heightAnchor.constraint(equalToConstant: 28),
//        ])
    }
    
    private func setupStatusLabel() {
        //statusLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.text = statusText
        statusLabel.font = .systemFont(ofSize: 17)
        statusLabel.textColor = .black
        addSubview(statusLabel)
        
        statusLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(fullNameLabel.snp_bottomMargin).offset(16)
            make.leading.equalTo(fullNameLabel)
            make.trailing.equalTo(fullNameLabel)
            make.height.equalTo(fullNameLabel)
            
        }
        
//        NSLayoutConstraint.activate([
//            statusLabel.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: 16),
//            statusLabel.leadingAnchor.constraint(equalTo: fullNameLabel.leadingAnchor),
//            statusLabel.trailingAnchor.constraint(equalTo: fullNameLabel.trailingAnchor),
//            statusLabel.heightAnchor.constraint(equalTo: fullNameLabel.heightAnchor),
//        ])
    }
    
    private func setupStatusTextField() {
        //statusTextField.translatesAutoresizingMaskIntoConstraints = false
        statusTextField.textColor = .darkGray
        statusTextField.backgroundColor = .white
        
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        statusTextField.leftView = paddingView
        statusTextField.leftViewMode = .always
        statusTextField.layer.cornerRadius = 8
        statusTextField.layer.borderWidth = 1
        statusTextField.layer.borderColor = UIColor.gray.cgColor
        statusTextField.attributedPlaceholder = NSAttributedString.init(string: "Ready...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        statusTextField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        addSubview(statusTextField)
        
        statusTextField.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(statusLabel.snp_bottomMargin).offset(16)
            make.leading.equalTo(fullNameLabel)
            make.trailing.equalTo(fullNameLabel)
            make.height.equalTo(32)
            
        }
        
//        NSLayoutConstraint.activate([
//            statusTextField.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 16),
//            statusTextField.leadingAnchor.constraint(equalTo: fullNameLabel.leadingAnchor),
//            statusTextField.trailingAnchor.constraint(equalTo: fullNameLabel.trailingAnchor),
//            statusTextField.heightAnchor.constraint(equalToConstant: 32),
//        ])
    }
    
    private func setupStatusButton() {
       // setStatusButton.translatesAutoresizingMaskIntoConstraints = false
        setStatusButton.backgroundColor = .systemBlue
        setStatusButton.layer.cornerRadius = LayoutConstants.cornerRadius
        setStatusButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        setStatusButton.layer.shadowColor = UIColor.black.cgColor
        setStatusButton.layer.shadowRadius = 4
        setStatusButton.layer.shadowOpacity = 0.7
        setStatusButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        setStatusButton.setTitle("Show status", for: .normal)
        setStatusButton.setTitleColor(.white, for: .normal)
        setStatusButton.addTarget(self, action: #selector(statusButtonPressed), for: .touchUpInside)
        addSubview(setStatusButton)
        
        setStatusButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(avatarImageView.snp_bottomMargin).offset(16)
            make.leading.equalTo(safeAreaLayoutGuide).offset(16)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-16)
            make.height.equalTo(48)
            
        }
        
//        NSLayoutConstraint.activate([
//            setStatusButton.topAnchor.constraint(equalTo: statusTextField.bottomAnchor, constant: 16),
//            setStatusButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
//            setStatusButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
//            setStatusButton.heightAnchor.constraint(equalToConstant: 48),
//        ])
    }
    
    private func setupAvatarImage() {
       // avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.image = UIImage(named: "teo")
        avatarImageView.layer.cornerRadius = 64
        avatarImageView.layer.borderWidth = 3
        avatarImageView.layer.borderColor = UIColor.white.cgColor
        avatarImageView.clipsToBounds = true
        
        // add a tap gesture
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapOnAvatar))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        avatarImageView.isUserInteractionEnabled = true
        avatarImageView.addGestureRecognizer(tapGesture)
        
        // cancel an animation mode
        //returnAvatarButton.translatesAutoresizingMaskIntoConstraints = false
        returnAvatarButton.alpha = 0
        returnAvatarButton.backgroundColor = .clear
        returnAvatarButton.contentMode = .scaleToFill
        returnAvatarButton.setImage(UIImage(systemName: "xmark", withConfiguration: UIImage.SymbolConfiguration(pointSize: 22))?.withTintColor(.black, renderingMode: .automatic), for: .normal)
        returnAvatarButton.tintColor = .black
        returnAvatarButton.addTarget(self, action: #selector(returnAvatarToOrigin), for: .touchUpInside)
        
        // translucent background for the modal animation mode
        avatarBackground = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        avatarBackground.backgroundColor = .darkGray
        avatarBackground.isHidden = true
        avatarBackground.alpha = 0
        
        addSubviews(avatarBackground, avatarImageView, returnAvatarButton)
        
        avatarImageView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(safeAreaLayoutGuide).offset(16)
            make.leading.equalTo(safeAreaLayoutGuide).offset(16)
            make.width.equalTo(128)
            make.height.equalTo(128)
            
        }
        
        returnAvatarButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(safeAreaLayoutGuide).offset(16)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-16)

        }
        
        
//        NSLayoutConstraint.activate([
//            avatarImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
//            avatarImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
//            avatarImageView.widthAnchor.constraint(equalToConstant: 128),
//            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
//            
//            returnAvatarButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
//            returnAvatarButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
//        ])
    }
    
    // MARK: - Event handlers
    
    @objc private func statusTextChanged(_ textField: UITextField) {
        statusText = textField.text ?? ""
    }
    
    @objc private func statusButtonPressed() {
        statusLabel.text = statusText
    }
    
    @objc private func didTapOnAvatar() {
        // create an animation
        avatarImageView.isUserInteractionEnabled = false
        
        ProfileViewController.postTableView.isScrollEnabled = false
        ProfileViewController.postTableView.cellForRow(at: IndexPath(row: 0, section: 0))?.isUserInteractionEnabled = false
        
        avatarOriginPoint = avatarImageView.center
        let scale = UIScreen.main.bounds.width / avatarImageView.bounds.width
        
        UIView.animate(withDuration: 0.5) {
            self.avatarImageView.center = CGPoint(x: UIScreen.main.bounds.midX,
                                                  y: UIScreen.main.bounds.midY - self.avatarOriginPoint.y)
            self.avatarImageView.transform = CGAffineTransform(scaleX: scale, y: scale)
            self.avatarImageView.layer.cornerRadius = 0
            self.avatarBackground.isHidden = false
            self.avatarBackground.alpha = 0.7
        } completion: { _ in
            UIView.animate(withDuration: 0.3) {
                self.returnAvatarButton.alpha = 1
            }
        }
    }
    
    @objc private func returnAvatarToOrigin() {
        UIImageView.animate(withDuration: 0.5) {
            UIImageView.animate(withDuration: 0.5) {
                self.returnAvatarButton.alpha = 0
                self.avatarImageView.center = self.avatarOriginPoint
                self.avatarImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.avatarImageView.layer.cornerRadius = self.avatarImageView.frame.width / 2
                self.avatarBackground.alpha = 0
            }
        } completion: { _ in
            ProfileViewController.postTableView.isScrollEnabled = true
            ProfileViewController.postTableView.cellForRow(at: IndexPath(row: 0, section: 0))?.isUserInteractionEnabled = true
            self.avatarImageView.isUserInteractionEnabled = true
        }
    }
}

// MARK: - Extension

extension ProfileHeaderView: UITextFieldDelegate {
    
    // tap 'done' on the keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
