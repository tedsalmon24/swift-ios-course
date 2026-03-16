//
//  booksPageViewController.swift
//  assignment6
//
//  Created by Ted Salmon on 2/18/26.
//

import UIKit

class booksPageViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    // Property to receive the selected genre from ViewController
    var selectedGenre: String?
    
    // Array to hold the books for the selected genre
    var books: [Book] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register the custom cell
        let cellNib = UINib(nibName: "BookTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "BookTableViewCell")
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // Load books for the selected genre
        if let genre = selectedGenre {
            title = genre
            books = Data.getBooks(forGenre: genre)
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showBookDetails",
           let detailsVC = segue.destination as? BookDetailsViewController,
           let selectedIndexPath = sender as? IndexPath {
            // Pass the selected book to the details page
            detailsVC.selectedBook = books[selectedIndexPath.row]
        }
    }

}
extension booksPageViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookTableViewCell", for: indexPath) as! BookTableViewCell
        
        // Get the book for this row
        let book = books[indexPath.row]
        
        // Populate the cell with book data
        cell.bookTitle.text = book.title
        cell.authorName.text = book.author
        cell.genreName.text = book.genre
        cell.yearDate.text = "\(book.year)"
        
        return cell
    }
}

extension booksPageViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Deselect the row for better UX
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Perform the segue to show book details
        performSegue(withIdentifier: "showBookDetails", sender: indexPath)
    }
}
