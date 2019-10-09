//
//  ViewController.swift
//  StackOverflowGurus
//
//  Created by Suman Chatterjee on 07/10/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import UIKit

class HomeViewController: UITableViewController {

    let cellId = "cellId"

    private let viewModel: HomeViewModelUseCase!
    private var users = [CellViewModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    fileprivate func setup() {
        tableView?.register(HomeViewCell.self, forCellReuseIdentifier: cellId)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.separatorStyle = .none
        fetchUser()
    }

    fileprivate func fetchUser() {
        viewModel.fetchUsers { (result) in
            switch result {
            case .success(let cellViewModels):
                self.users = cellViewModels
                self.tableView.reloadData()
            case .failure(let error):
                //Should show a alert view for the error (Not implemented)
                print(error.localizedDescription)
            }
        }
    }
}



extension HomeViewController
{
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = HomeViewHeader(frame: CGRect.zero)
        header.cellViewModel = users[section]
        header.onButtonTapHandler {
            print("tapped: \(section)")
        }
        return header
    }

    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return users.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if !users[section].isExpanded {
            return 0
        }

        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! HomeViewCell
        //       cell.cellViewModel = users[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 140
    }

}

