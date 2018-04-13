//
//  Competition.swift
//  one
//
//  Created by Dave Duprey on 2018-04-12.
//  Copyright © 2018 Dave Duprey. All rights reserved.
//
//  This class holds info related to a competition
//  It contains an array that holds Match structs
//

import Foundation

class Competition
  {
  var name:     String       = ""  // name for the competition
  var dbid:     Int          = 0   // dbid
  var ordering: Int          = 0   // a field used to order the competitions
  var matches:  Array<Match> = []  // an array of matches in the competition


  // initializes a competition, this creates an empty array for the matches
  init(name:String, ordering:Int, dbid:Int)
    {
    self.name      = name
    self.dbid      = dbid
    self.ordering  = ordering
    self.matches   = []
    }


  // this adds a match to the competition
  func add_match(match: Match)
    {
    self.matches.append(match)
    }


  }
