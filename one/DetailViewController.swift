//
//  DetailViewController.swift
//  one
//
//  Created by Dave Duprey on 2018-04-11.
//  Copyright © 2018 Dave Duprey. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

  @IBOutlet weak var detailDescriptionLabel: UILabel!


  func configureView() {
    // Update the user interface for the detail item.
    if let detail = detailItem {
        if let label = detailDescriptionLabel {

          // format the date for display
          let date_formatter = DateFormatter()
          date_formatter.dateFormat = "EEEE, MMM d, yyyy"

          label.text = date_formatter.string(from: detail.kickoff_time) + " " + detail.home_team + " vs " + detail.away_team
        }
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    configureView()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  var detailItem: Match? {
    didSet {
        // Update the view.
        configureView()
    }
  }


}

