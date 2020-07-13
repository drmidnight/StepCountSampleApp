//
//  StepListTableViewController.swift
//  Steps
//
//  Created by Corey Morello on 7/13/20.
//  Copyright © 2020 Corey Morello. All rights reserved.
//

import UIKit

class StepListTableViewController: UITableViewController {
    private let provider: StepsProvider
    private var data = [StepData]()
    private var descending: Bool = true

    init(provider: StepsProvider) {
        self.provider = provider
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Steps"
        self.tableView.allowsSelection = false
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Date ↓", style: .done, target: self, action: #selector(sortData))
        self.tableView.register(StepItemTableViewCell.self, forCellReuseIdentifier: StepItemTableViewCell.reuseIdentifier)

        self.provider.dataUpdatedHandler = { [weak self] data in
            DispatchQueue.main.async {
                self?.data = data
                self?.tableView.reloadData()
            }
        }

        self.provider.fetchSteps()
    }

    @objc
    private func sortData() {
        self.data.reverse()
        // TODO: handle the sort button state elsewhere
        self.descending.toggle()
        let btnString = self.descending ?  "Date ↓" : "Date ↑"
        self.navigationItem.rightBarButtonItem?.title = btnString
        self.tableView.reloadData()
    }
}

// MARK: - Table view data source
extension StepListTableViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.endIndex > 0 ? self.data.count : 1
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StepItemTableViewCell.reuseIdentifier, for: indexPath)
        if self.data.endIndex > 0 {
            let stepData = self.data[indexPath.row]
            if let stepCell = cell as? StepItemTableViewCell {
                stepCell.date = stepData.date
                stepCell.stepValue = Int(stepData.count)
                return stepCell
            }
        } else {
            // TODO: make some sort of error cell, for now just use a default cell
            let errorCell = UITableViewCell(style: .default, reuseIdentifier: "errorCell")
            errorCell.textLabel?.textAlignment = .center
            errorCell.textLabel?.text = "No step data to display"
            return errorCell
        }

        return cell
    }

}
