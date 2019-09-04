//
//  MembersViewController.swift
//  SwiftMiaTVOS
//
//  Created by Christian Romanelli on 8/8/19.
//  Copyright © 2019 3 Pixels Media. All rights reserved.
//

import UIKit

class MembersViewController: UIViewController, UISearchResultsUpdating, UITableViewDelegate, UITableViewDataSource  {

    
    let store = SMStore.shared
    var assitants : [String]!
    var filterAssist : [String]!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assitants = [
            "Alberto Camacho",
            "Andre",
            "Carla Chipana",
            "Christian Romanelli",
            "Dominique Miller",
            "Fortune Gregory",
            "Giovanni Noa",
            "Iván",
            "James Slusser",
            "JEREMY MARTINS",
            "Jonathan",
            "Kaue Ribeiro",
            "Matthew B",
            "Nilson Nascimento",
            "Ryan Stone",
            "Slavo Popovich",
            "William Castellano"
        ]
        filterAssist = assitants
        tableView.delegate = self
        tableView.dataSource = self
        self.view.backgroundColor = store.indexGray
        tableView.backgroundColor = store.indexGray
    }
    

    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        print(text)
        if text.count >= 3 {
            filterAssist = assitants.filter({$0.uppercased().contains("\(text)")})
            tableView.reloadData()
        } else {
            filterAssist = assitants
            tableView.reloadData()
        }

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterAssist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = filterAssist[indexPath.row].capitalized
        cell.textLabel?.textColor = store.lightGray
        cell.backgroundColor = store.indexGray
        
        return cell
    }

}
