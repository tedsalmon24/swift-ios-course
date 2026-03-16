//
//  ViewController.swift
//  assignment6
//
//  Created by Ted Salmon on 2/18/26.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {
    
    // Data source: array of genre names from Models
    var genres: [String] = []
    
    @IBOutlet weak var tableView: UITableView!  // displays book list
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Safety check: ensure tableView outlet is connected
        guard tableView != nil else {
            print("ERROR: tableView outlet is not connected in Interface Builder!")
            return
        }
        
        // Load all genres from the Data model
        genres = Data.getAllGenres()
        
        // Set up table view
        tableView.dataSource = self
        tableView.delegate = self
        
        // Set navigation title
        self.title = "Book Genres"
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showBooksSegue",
           let booksVC = segue.destination as? booksPageViewController,
           let selectedIndexPath = sender as? IndexPath {
            // Pass the selected genre to the books page
            booksVC.selectedGenre = genres[selectedIndexPath.row]
        }
    }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    // One row per genre
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genres.count
    }
    
    // Build/reuse a cell and populate it with genre data
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseID = "myCell"
        
        // Dequeue existing cell or create a new .subtitle style cell
        let cell: UITableViewCell
        if let dequeued = tableView.dequeueReusableCell(withIdentifier: reuseID) {
            cell = dequeued
        } else {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: reuseID)
        }
        
        let genre = genres[indexPath.row]
        cell.textLabel?.text = genre  // main label
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ViewController {
    
    // Handle row selection
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Deselect the row for better UX
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Perform the segue
        performSegue(withIdentifier: "showBooksSegue", sender: indexPath)
    }
}
