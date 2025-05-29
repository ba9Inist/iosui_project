//
//  DirectoryVC.swift
//  Navigation
//
//  Created by Егор Голубев on 22.05.2025.
//

import UIKit
import SnapKit
import Photos

class DirectoryVC: UIViewController, RefreshTableViewProtocol {
    
    private lazy var fileManager = FileManagerService(path: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])
    
    private lazy var buttonAddPhoto: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.image = UIImage(systemName: "photo.badge.plus")
        button.tintColor = UIColor.black
        button.style = .plain
        button.target = self
        button.action = #selector(tapAddPhoto)
        return button
    }()
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .lightGray
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CustomCellTableViewDirectory.self, forCellReuseIdentifier: "customCell")
        tableView.rowHeight = 300
        tableView.refreshControl = refreshControl
        return tableView
        
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
        return refresh
    }()
    
    private lazy var photoPicker: UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        return picker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fileManager.loadArray()
        
        navigationItem.rightBarButtonItem = buttonAddPhoto
        view.backgroundColor = .systemBackground
        setubSubviews()
    }
    
    private func setubSubviews() {
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.left.equalTo(view.snp.left)
            $0.right.equalTo(view.snp.right)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
    }
    
    @objc private func refreshTable() {
        refreshTableView()
        refreshControl.endRefreshing()
    }
    
    @objc private func tapAddPhoto(){
        let accessPhotoGallery = AccessPhoto()
        accessPhotoGallery.requestGalleryAccess { [weak self] access in
            guard let self = self else { return }
            if access {
                DispatchQueue.main.async {
                    self.present(self.photoPicker, animated: true)
                }
            }
            else {
                print("No")
            }
        }
    }
    
    func refreshTableView() {
        DispatchQueue.main.async {
            self.fileManager.loadArray()
            self.tableView.reloadData()
        }
    }

}

extension DirectoryVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fileManager.photoArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomCellTableViewDirectory
        let infoPhoto = fileManager.showPhotoCell(index: indexPath.row)
        cell.configure(name: infoPhoto.name, pathPhoto: infoPhoto.pathPhoto)
        return cell
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "Удалить") { action, view, completionHandler in
            self.fileManager.removePhoto(index: indexPath.row)
            self.tableView.reloadData()
            completionHandler(true)
        }
        editAction.backgroundColor = UIColor.red
        return UISwipeActionsConfiguration(actions: [editAction])
    }
    
    
}

extension DirectoryVC: UITableViewDelegate {
    
}


extension DirectoryVC: UINavigationControllerDelegate {
    
}

extension DirectoryVC: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        defer { dismiss(animated: true) }
        
        guard let image = info[.originalImage] as? UIImage else { return }
        
        let namePhoto = UUID().uuidString + ".jpg"
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsDirectory.appendingPathComponent(namePhoto)
        
        
        if let jpegData = image.jpegData(compressionQuality: 1.0) {
            do {
                try jpegData.write(to: fileURL)
                fileManager.loadArray()
                tableView.reloadData()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

protocol RefreshTableViewProtocol: AnyObject {
    func refreshTableView()
}
