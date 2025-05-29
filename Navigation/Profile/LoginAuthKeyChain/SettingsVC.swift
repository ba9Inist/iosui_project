//
//  SettingsVC.swift
//  Navigation
//
//  Created by Егор Голубев on 28.05.2025.
//

import UIKit
import SnapKit
import KeychainAccess

class SettingsVC: UIViewController {
    
    private lazy var options = ["По возврастанию", "По убыванию"]
    private lazy var keychain = Keychain(service: "only.one.Navigation")
    
    private lazy var pickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        return picker
    }()
    
    private lazy var regButton: UIButton = {
        let button = CustomButton(title: "Сменить пароль",
                                  titleColor: .white,
                                  backgroundColor: .blue,
                                  cornerRadius: LayoutConstants.cornerRadius)
        button.addTarget(nil, action: #selector(touchRegButton), for: .touchUpInside)
        button.clipsToBounds = true
        return button
    }()
    
    private var labelFilter: UILabel = {
        let label = UILabel()
        label.text = "Фильтр сортировки: "
        label.textColor = .black
        label.font = UIFont(name: "", size: 16)
        return label
        
    }()
    
    weak var delegate: RefreshTableViewProtocol?
    private lazy var alert = customAlert()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setubSubviews()
        let lastSelectedIndex = UserDefaults.standard.integer(forKey: "selectedIndex")
        pickerView.selectRow(lastSelectedIndex, inComponent: 0, animated: false)
        
    }
    
    private func setubSubviews() {
        
        view.addSubviews(pickerView, labelFilter, regButton)
        
        labelFilter.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(-30)
            $0.left.equalTo(view.snp.left).inset(30)
            $0.right.equalTo(view.snp.right)
            $0.height.equalTo(20)
        }
        
        pickerView.snp.makeConstraints {
            $0.top.equalTo(labelFilter.snp.bottom).inset(-10)
            $0.left.equalTo(view.snp.left).inset(10)
            $0.right.equalTo(view.snp.right).inset(10)
            $0.height.equalTo(50)
        }
        
        regButton.snp.makeConstraints {
            $0.top.equalTo(pickerView.snp.bottom).inset(-10)
            $0.left.equalTo(view.snp.left).inset(10)
            $0.right.equalTo(view.snp.right).inset(10)
        }
        
    }
    
    
    @objc private func touchRegButton() {
        
        let okAction = UIAlertAction(title: "Да", style: .default) { (_) in
            do {
                try self.keychain.remove("passUser")
                let vc = LoginKeyChainVC()
                vc.modalPresentationStyle = .popover
                self.present(vc, animated: true,completion: nil)
            } catch let error {
                print("error: \(error)")
            }
        }

        let cancelAction = UIAlertAction(title: "Нет", style: .cancel) { (_) in
            
        }
        var buttonAlert = [UIAlertAction]()
        buttonAlert.append(okAction)
        buttonAlert.append(cancelAction)
        
        alert.setubAlert(title: "Пароль", sms: "Сменить пароль?", type: .alert, buttonAlert: buttonAlert)
        
    }
    
}

extension SettingsVC: UIPickerViewDelegate {
    
}

extension SettingsVC: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return options.count
    }
    
    // MARK: - UIPickerView Delegate Method
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return options[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        UserDefaults.standard.set(row, forKey: "selectedIndex")
        delegate?.refreshTableView()
    }
    
    
}
