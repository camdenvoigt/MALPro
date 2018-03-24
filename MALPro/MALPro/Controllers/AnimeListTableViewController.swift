//
//  AnimeListTableViewController.swift
//  MALPro
//
//  Created by Logan Heitz on 3/23/18.
//  Copyright © 2018 MALPro. All rights reserved.
//

import UIKit

enum AnimeListType: String {
    case watching = "Watching"
    case onHold = "On Hold"
    case dropped = "Dropped"
    case planToWatch = "Plan to Watch"
    case completed = "Completed"
}

class AnimeListTableViewController: UITableViewController {
    
    let ROW_HEIGHT = 60.0
    
    var animeList: AnimeList?
    var listType: AnimeListType?
    
    init(animeList: AnimeList, listType: AnimeListType) {
        self.animeList = animeList
        self.listType = listType
        super.init(style: .plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = 60.0
        self.tableView.register(UINib(nibName: "AnimeTableViewCell", bundle: nil), forCellReuseIdentifier: "AnimeTableViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.navigationItem.title = listType?.rawValue
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getAnimeArray().count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnimeTableViewCell", for: indexPath) as! AnimeTableViewCell
        let anime = getAnimeArray()[indexPath.row]

        cell.setUpCellForAnime(anime: anime)

        return cell
    }
    
    // MARK: - Private Helper Methods

    private func getAnimeArray() -> [Anime] {
        switch listType! {
        case .watching:
            return animeList!.watching
        case .onHold:
            return animeList!.onHold
        case .dropped:
            return animeList!.dropped
        case .planToWatch:
            return animeList!.planToWatch
        case .completed:
            return animeList!.completed
        }
    }
}
