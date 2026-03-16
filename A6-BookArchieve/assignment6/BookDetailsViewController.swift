//
//  BookDetailsViewController.swift
//  assignment6
//
//  Created by Ted Salmon on 2/18/26.
//

import UIKit

class BookDetailsViewController: UIViewController {

    @IBOutlet weak var titleBook: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var yearDate: UILabel!
    
    // Property to receive the selected book
    var selectedBook: Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Display the book details
        if let book = selectedBook {
            titleBook.text = book.title
            author.text = "Author: \(book.author)"
            genre.text = "Genre: \(book.genre)"
            yearDate.text = "Year: \(book.year)"
            
            // Set navigation title
            self.title = book.title
        }
    }
    

}
