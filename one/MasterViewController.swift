//
//  MasterViewController.swift
//  one
//
//  Created by Dave Duprey on 2018-04-11.
//  Copyright © 2018 Dave Duprey. All rights reserved.
//
//  This is almost entirely the stock code that is generated
//  by Xcode for a table view app.  I have added a Competitions
//  object that loads the json data and provides the info for the
//  view at critial points in this controller
//

import UIKit
import Foundation


class MasterViewController: UITableViewController {

  var detailViewController: DetailViewController? = nil
  var competitions:         Competitions          = Competitions() // this is the key data object

  override func viewDidLoad()
    {
    super.viewDidLoad()

    // load the json file into the Competitions model
    competitions.load(file_name: "matches")
    }

  override func viewWillAppear(_ animated: Bool) {
    clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
    super.viewWillAppear(animated)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


  // MARK: - Segues
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showDetail" {
        if let indexPath = tableView.indexPathForSelectedRow {
            let match = competitions.get_match(competition_index:indexPath.section, match_index:indexPath.row)
            let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
            controller.detailItem = match
            controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
            controller.navigationItem.leftItemsSupplementBackButton = true
        }
    }
  }

  // MARK: - Table View

  override func numberOfSections(in tableView: UITableView) -> Int {
    return competitions.competition_count() // number of competitions
  }

  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    let competition:Competition = competitions.get_competition(index: section) // get the ocmpetition so we can provide it's name
    return competition.name.uppercased()
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return competitions.match_count(index: section)  // number of competitions
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

    // get the Match struct corresponding to this display cell
    let match = competitions.get_match(competition_index:indexPath.section, match_index:indexPath.row)

    // format the date for display
    let date_formatter = DateFormatter()
    date_formatter.dateFormat = "E HH:mm"

    // simply concatinate the strings, as this is not specifically an exercise in layout
    cell.textLabel!.text = date_formatter.string(from: match.kickoff_time) + " " + match.home_team + " vs " + match.away_team
    return cell
  }

  override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return false
  }

//  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//    if editingStyle == .delete {
//        //objects.remove(at: indexPath.row)
//        tableView.deleteRows(at: [indexPath], with: .fade)
//    } else if editingStyle == .insert {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
//    }
//  }


}

