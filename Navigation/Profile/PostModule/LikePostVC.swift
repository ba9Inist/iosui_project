//
//  LikePostVC.swift
//  Navigation
//
//  Created by Егор Голубев on 03.06.2025.
//

import UIKit
import SnapKit

class LikePostVC: UIViewController {
    
    private lazy var arrayLikePost = [Post]()

    private lazy var postTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(PostTableViewCell.self, forCellReuseIdentifier: "likePost")
        table.dataSource = self
        table.delegate = self
        table.refreshControl = UIRefreshControl()
        table.refreshControl?.addTarget(self, action: #selector(reloadTableView), for: .valueChanged)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Like posts"
        addSubviews()
        //CoreDataManager.shared.resetCoreData()
        reloadTableView()
    }
    
    private func addSubviews() {
        view.addSubview(postTableView)
        
        postTableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.left.equalTo(view.snp.left)
            $0.right.equalTo(view.snp.right)
            $0.bottom.equalTo(view.snp.bottom)
        }
    }
    
    @objc func reloadTableView() {
        arrayLikePost = CoreDataManager.shared.loadLikedPosts()
        postTableView.reloadData()
        postTableView.refreshControl?.endRefreshing()
    }
}

extension LikePostVC: UITableViewDelegate {
    
}

extension LikePostVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayLikePost.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = postTableView.dequeueReusableCell(withIdentifier: "likePost", for: indexPath) as! PostTableViewCell
            cell.configure(with: arrayLikePost[indexPath.row])
            return cell
    }
    
}

