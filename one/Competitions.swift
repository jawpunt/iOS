//
//  Competitions.swift
//  one
//
//  Created by Dave Duprey on 2018-04-12.
//  Copyright © 2018 Dave Duprey. All rights reserved.
//
//  This is a model for the competition data.  It contains an
//  array of Competition objects.  Competition objects contain
//  info about the competition in question and also hold an
//  array of Match structs.  Match structs hold the data relating
//  to a particular match
//

import Foundation

class Competitions
  {
  var competitions:Array<Competition> = []  // the array that holds the Competition objects

  // returns the number of competitios being stored
  func competition_count() -> Int
    {
    return competitions.count
    }


  // returns a Competition object that has a particular title
  // returns nil if none found
  func get_competition_by_name(name: String) -> Competition?
    {
    if let i = competitions.index(where: { $0.name == name })
      {
      return competitions[i]
      }

    return nil
    }


  // returns a competition object with a particular dbid
  // returns nil if none found
  func get_competition_by_dbid(dbid: Int) -> Competition?
    {
    if let i = competitions.index(where: { $0.dbid == dbid })
      {
      return competitions[i]
      }

    return nil
    }


  // returns a Competition object given it's array index
  func get_competition(index: Int) -> Competition
    {
    return competitions[index]
    }


  // returns the number of matches in a particular
  // Competition, given the competition array index
  func match_count(index: Int) -> Int
    {
    return competitions[index].matches.count
    }


  // returns a particular match, given the array index for
  // the competition and the array index for the match
  func get_match(competition_index: Int, match_index: Int) -> Match
    {
    //let competition_name:String = self.competition_name(index: competition_index)
    //let matches:Array           = self.match_list(competition_name:competition_name)

    return competitions[competition_index].matches[match_index]
    }


  // sorts a competition array by the 'ordering' member of the Copetition object
  func sort_competitions_by_ordering()
    {
    competitions.sort(by: { $0.ordering < $1.ordering })
    }


  // sorts a competition array by the 'kickoff_time' member of the Copetition object
  func sort_matches_by_kickoff(competition:Competition)
    {
    competition.matches.sort(by: { $0.kickoff_time < $1.kickoff_time })
    }


  // sorts a matches array by the name of the home team
  func sort_matches_by_home_team(competition:Competition)
    {
    competition.matches.sort(by: { $0.home_team < $1.home_team })
    }


  // creates the data structure by reading in a json file
  // provided by the file_name
  func load(file_name: String)
    {
    if let path = Bundle.main.path(forResource: file_name, ofType: "json")
      {
      do
        {
        // get the json data into a data array
        let data       = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)

        // loop throug the json data and pull out the useful stuff
        for anItem in jsonResult as! [Dictionary<String, AnyObject>]  // or [[String:AnyObject]]
          {
          var match = Match()  // I could use the Memberwise Initializer here, but I find in non-performance critical passages, laying it out in several lines is easier to read

          // load up the match object
          match.kickoff_time = Date.init(timeIntervalSince1970: anItem["start"] as! Double / 1000.0)
          match.home_team    = anItem["homeTeam"]!["shortName"] as! String
          match.away_team    = anItem["awayTeam"]!["shortName"] as! String

          // get the competition info
          let name:String  = anItem["competition"]!["name"] as! String
          let ordering:Int = anItem["competition"]!["ordering"] as! Int
          let dbid:Int     = anItem["competition"]!["dbid"] as! Int
          print(name)

          // find a matching Competition object, and make one if none exists
          var competition = get_competition_by_dbid(dbid: dbid)  //var competition = get_competition_by_name(name: name)
          if (competition == nil)
            {
            // since no Competition object was found, we make a new one for this competition
            competition = Competition.init(name:name, ordering:ordering, dbid:dbid)
            competitions.append(competition!)
            }

          // add the match to this cometition
          competition?.add_match(match: match)
          }
        }
      catch
        {
        // handle error
        print("Something is wrong with the json data.  This is where we'd deal with it if this was a real world app")
        }

      // sort the competitions
      sort_competitions_by_ordering()

      // sort the matches in the competitions
      for c in competitions
        {
        sort_matches_by_kickoff(competition: c)
        }
      }



    }



  }
