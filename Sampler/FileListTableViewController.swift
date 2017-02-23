//
//  FileListTableViewController.swift
//  Sampler
//
//  Created by Daniel Song on 8/7/16.
//  Copyright © 2016 Daniel Song. All rights reserved.
//

import UIKit

class FileListTableViewController: UITableViewController {

    var RecordedURLs = AudioURL()
    var trackURL: URL!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        RecordedURLs.listRecordingsURLs()
        tableView.reloadData()
    }

    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        RecordedURLs.listRecordingsNames()

        return RecordedURLs.recordings!.count
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        trackURL = RecordedURLs.recordingsURLs![indexPath.row] as URL
        print(trackURL)
        performSegue(withIdentifier: "fileSelected", sender: trackURL)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Configure the cell...
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FileCell")!
        
        cell.textLabel!.text = RecordedURLs.recordings![indexPath.row].lastPathComponent
        return cell
    }

     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "fileSelected"){
            let playerVC = segue.destination as! PlayerViewController
            
            let trackURLToLoad = sender as! URL
            playerVC.trackURLToLoad = trackURLToLoad
            print("does prepare for segue ever get called")

        }
    
    }
    
  
    
    
}
