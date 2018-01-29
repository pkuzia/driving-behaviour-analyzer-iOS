//
//  CollectTableViewDriveDataViewController.swift
//  Driving behaviour analyzer
//
//  Created by Przemysław Kuzia on 28.01.2018.
//Copyright © 2018 Pkuzia. All rights reserved.
//

import UIKit
import SwifterSwift

class CollectTableViewDriveDataViewController: BaseViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    let collectTableViewDriveDataViewModel = CollectTableViewDriveDataViewModel()
    
    // MARK: - View Lifecycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        collectTableViewDriveDataViewModel.fetchData { complete in
            if complete {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Appearance
    
    func initUI() {
        initNavBar()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
    }
    
    fileprivate func initNavBar() {
        title = collectTableViewDriveDataViewModel.screenTitle
        navigationController?.navigationBar.titleTextAttributes = StyleKit.navBarAttributes()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
        
//        let menuButton = UIButton(type: .custom)
//        menuButton.setImage(UIImage(named: "menu"), for: .normal)
//        menuButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
//        menuButton.addTarget(self, action: #selector(clickMenuButtonHandler), for: .touchUpInside)
//        let leftItems = UIBarButtonItem(customView: menuButton)
//
//        self.navigationItem.setLeftBarButtonItems([leftItems], animated: true)
    }
    
    // MARK: - User Interaction
    
    // MARK: - Additional Helpers
    
}

// MARK: - CollectTableViewDriveDataViewController

extension CollectTableViewDriveDataViewController: CollectTableViewDriveDataViewModelDelegate {
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension CollectTableViewDriveDataViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let driveItemData = collectTableViewDriveDataViewModel.driveItemData {
            return driveItemData.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: collectTableViewDriveDataViewModel.driveItemCellID,
                                                    for: indexPath) as? CollectDriveItemCell, let driveItemData = collectTableViewDriveDataViewModel.driveItemData {
            if let driveItemDataItem = driveItemData.item(at: indexPath.row) {
                cell.initCellWithData(driveItemDataItem)
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let cell = tableView.dequeueReusableCell(withIdentifier: collectTableViewDriveDataViewModel.driveItemHeaderCellID) as? CollectDriveItemHeader {
            cell.initCell()
            return cell
        }
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return collectTableViewDriveDataViewModel.driveItemCellSize
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return collectTableViewDriveDataViewModel.driveItemCellHeaderSize
    }
}