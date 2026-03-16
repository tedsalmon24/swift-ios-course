//
//  data.swift
//  Assignment06
//
//  Created by Mohamed Shehab on 2/25/25.
//


class Data {
    static let allBooks = [
        Book(title: "The Lord of the Rings", author: "J.R.R. Tolkien", year: 1954, genre: "Fantasy"),
        Book(title: "Pride and Prejudice", author: "Jane Austen", year: 1813, genre: "Romance"),
        Book(title: "To Kill a Mockingbird", author: "Harper Lee", year: 1960, genre: "Southern Gothic"),
        Book(title: "The Great Gatsby", author: "F. Scott Fitzgerald", year: 1925, genre: "Classic"),
        Book(title: "One Hundred Years of Solitude", author: "Gabriel Garcia Marquez", year: 1967, genre: "Magical Realism"),
        Book(title: "War and Peace", author: "Leo Tolstoy", year: 1869, genre: "Historical Fiction"),
        Book(title: "Crime and Punishment", author: "Fyodor Dostoevsky", year: 1866, genre: "Psychological Thriller"),
        Book(title: "Hamlet", author: "William Shakespeare", year: 1603, genre: "Play"),
        Book(title: "The Odyssey", author: "Homer", year: 800, genre: "Adventure"),
        Book(title: "Moby Dick", author: "Herman Melville", year: 1851, genre: "Adventure"),
        Book(title: "The Adventures of Huckleberry Finn", author: "Mark Twain", year: 1885, genre: "Satire"),
        Book(title: "The Adventures of Tom Sawyer", author: "Mark Twain", year: 1876, genre: "Adventure"),
        Book(title: "The Catcher in the Rye", author: "J.D. Salinger", year: 1951, genre: "Coming-of-age"),
        Book(title: "The Handmaid's Tale", author: "Margaret Atwood", year: 1985, genre: "Dystopian"),
        Book(title: "The Book Thief", author: "Markus Zusak", year: 2005, genre: "Historical Fiction"),
        Book(title: "The Kite Runner", author: "Khaled Hosseini", year: 2003, genre: "Historical Fiction"),
        Book(title: "Little Women", author: "Louisa May Alcott", year: 1868, genre: "Coming-of-age"),
        Book(title: "Harry Potter and the Philosopher's Stone", author: "J.K. Rowling", year: 1997, genre: "Fantasy"),
        Book(title: "The Hunger Games", author: "Suzanne Collins", year: 2008, genre: "Dystopian"),
        Book(title: "Divergent", author: "Veronica Roth", year: 2011, genre: "Dystopian"),
        Book(title: "A Song of Ice and Fire", author: "George R.R. Martin", year: 1996, genre: "Fantasy"),
        Book(title: "The Martian", author: "Andy Weir", year: 2011, genre: "Science Fiction"),
        Book(title: "The Hitchhiker's Guide to the Galaxy", author: "Douglas Adams", year: 1979, genre: "Science Fiction"),
        Book(title: "Dune", author: "Frank Herbert", year: 1965, genre: "Science Fiction"),
        Book(title: "Foundation", author: "Isaac Asimov", year: 1951, genre: "Science Fiction"),
        Book(title: "Ender's Game", author: "Orson Scott Card", year: 1985, genre: "Science Fiction"),
        Book(title: "The Time Machine", author: "H.G. Wells", year: 1895, genre: "Science Fiction"),
        Book(title: "Neuromancer", author: "William Gibson", year: 1984, genre: "Cyberpunk"),
        Book(title: "Snow Crash", author: "Neal Stephenson", year: 1992, genre: "Cyberpunk"),
        Book(title: "The Left Hand of Darkness", author: "Ursula K. Le Guin", year: 1969, genre: "Science Fiction"),
        Book(title: "The Dispossessed", author: "Ursula K. Le Guin", year: 1974, genre: "Science Fiction"),
        Book(title: "The Three-Body Problem", author: "Cixin Liu", year: 2008, genre: "Science Fiction"),
        Book(title: "The Andromeda Strain", author: "Michael Crichton", year: 1969, genre: "Science Fiction"),
        Book(title: "Jurassic Park", author: "Michael Crichton", year: 1990, genre: "Science Fiction"),
        Book(title: "The Da Vinci Code", author: "Dan Brown", year: 2003, genre: "Mystery"),
        Book(title: "Angels & Demons", author: "Dan Brown", year: 2000, genre: "Mystery"),
        Book(title: "Gone Girl", author: "Gillian Flynn", year: 2012, genre: "Thriller"),
        Book(title: "The Girl with the Dragon Tattoo", author: "Stieg Larsson", year: 2005, genre: "Crime"),
        Book(title: "The Silence of the Lambs", author: "Thomas Harris", year: 1988, genre: "Thriller"),
        Book(title: "The Shining", author: "Stephen King", year: 1977, genre: "Horror"),
        Book(title: "Misery", author: "Stephen King", year: 1987, genre: "Psychological Horror"),
        Book(title: "It", author: "Stephen King", year: 1986, genre: "Horror"),
        Book(title: "The Stand", author: "Stephen King", year: 1978, genre: "Horror"),
        Book(title: "Pet Sematary", author: "Stephen King", year: 1983, genre: "Horror"),
        Book(title: "Salem's Lot", author: "Stephen King", year: 1975, genre: "Horror"),
        Book(title: "The Green Mile", author: "Stephen King", year: 1996, genre: "Magical Realism"),
        Book(title: "The Dark Tower", author: "Stephen King", year: 1982, genre: "Dark Fantasy"),
        Book(title: "The Drawing of the Three", author: "Stephen King", year: 1987, genre: "Dark Fantasy"),
        Book(title: "The Waste Lands", author: "Stephen King", year: 1991, genre: "Dark Fantasy"),
        Book(title: "Wizard and Glass", author: "Stephen King", year: 1997, genre: "Dark Fantasy"),
        Book(title: "The Lord of the Flies", author: "William Golding", year: 1954, genre: "Allegory"),
        Book(title: "Jane Eyre", author: "Charlotte Brontë", year: 1847, genre: "Gothic"),
        Book(title: "Frankenstein", author: "Mary Shelley", year: 1818, genre: "Gothic"),
        Book(title: "Wuthering Heights", author: "Emily Brontë", year: 1847, genre: "Gothic"),
        Book(title: "1984", author: "George Orwell", year: 1949, genre: "Dystopian"),
        Book(title: "Brave New World", author: "Aldous Huxley", year: 1932, genre: "Dystopian"),
        Book(title: "The Road", author: "Cormac McCarthy", year: 2006, genre: "Post-Apocalyptic"),
        Book(title: "The Remains of the Day", author: "Kazuo Ishiguro", year: 1989, genre: "Historical Fiction"),
        Book(title: "The Name of the Rose", author: "Umberto Eco", year: 1980, genre: "Historical Mystery"),
        Book(title: "Beloved", author: "Toni Morrison", year: 1987, genre: "Historical Fiction"),
        Book(title: "The Color Purple", author: "Alice Walker", year: 1982, genre: "Epistolary"),
        Book(title: "The God of Small Things", author: "Arundhati Roy", year: 1997, genre: "Family Saga"),
        Book(title: "Life of Pi", author: "Yann Martel", year: 2001, genre: "Adventure")
    ]
    
    static func getAllGenres() -> [String] {
        var genres = [String]()
        for book in Data.allBooks {
            if !genres.contains(book.genre) {
                genres.append(book.genre)
            }
        }
        return genres
    }
    
    static func getBooks(forGenre genre: String) -> [Book] {
        var books = [Book]()
        for book in Data.allBooks {
            if book.genre == genre {
                books.append(book)
            }
        }
        return books
    }
}

class Book{

    let title: String
    let author: String
    let year: Int
    let genre: String
    
    init(title: String, author: String, year: Int, genre: String) {
        self.title = title
        self.author = author
        self.year = year
        self.genre = genre
    }
}
