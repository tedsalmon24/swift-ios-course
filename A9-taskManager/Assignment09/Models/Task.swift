//
//  Task.swift
//  Assignment09
//
//  Created by Mohamed Shehab on 3/18/26.
//
import Foundation
import FirebaseFirestore

class Task {
    var docID: String?
    var title: String?
    var priority: String?
    var category: String?
    var createdAt: Timestamp?
    var createdByUID: String?
}


