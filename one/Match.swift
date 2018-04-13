//
//  Match.swift
//  one
//
//  Created by Dave Duprey on 2018-04-12.
//  Copyright © 2018 Dave Duprey. All rights reserved.
//
//  This struct holds the data needed for a match
//

import Foundation

struct Match
  {
  var kickoff_time: Date    = Date.init()  // time the game starts
  var home_team:    String  = ""           // the name of the home team
  var away_team:    String  = ""           // the name of the away team
  }
