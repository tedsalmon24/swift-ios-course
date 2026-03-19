//ted salmon
//  TasksViewController.swift
//  Assignment09
//
//  Created by Mohamed Shehab on 3/18/26.
//

import UIKit
import FirebaseAuth
import Firebase

class TasksViewController: UIViewController {
    var tasks = [Task]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //fetch notes with real-time updates
        setupSnapshotListener()
        self.tableView.register(UINib(nibName: "TaskTableViewCell", bundle: nil), forCellReuseIdentifier: "TaskTableViewCell")
        
    }
    
    func setupSnapshotListener() {
        let db = Firestore.firestore()
        db.collection("note").whereField("createdByUID", isEqualTo: Auth.auth().currentUser!.uid).addSnapshotListener { snapshot, error in
            if let error = error {
                print("Error fetching tasks: \(error.localizedDescription)")
                return
            }
            self.tasks.removeAll()
            guard let snapshot = snapshot, !snapshot.isEmpty else {
                DispatchQueue.main.async { self.tableView.reloadData() }
                return
            }
            for doc in snapshot.documents {
                let data = doc.data()
                let task = Task()
                task.title = data["title"] as? String
                task.createdAt = data["createdAt"] as? Timestamp
                task.docID = doc.documentID
                task.category = data["category"] as? String
                task.priority = data["priority"] as? String
                self.tasks.append(task)
            }
            DispatchQueue.main.async { self.tableView.reloadData() }
        }
    }
    
    func fetchNotes() {
        let db = Firestore.firestore()
        db.collection("note").whereField("createdByUID", isEqualTo: Auth.auth().currentUser!.uid).getDocuments { (snapshot, error) in
            if let error = error { print(error); return }
            self.tasks = snapshot?.documents.compactMap { doc -> Task? in
                let data = doc.data()
                let task = Task()
                task.title = data["title"] as? String
                task.createdAt = data["createdAt"] as? Timestamp
                task.docID = doc.documentID
                task.category = data["category"] as? String
                task.priority = data["priority"] as? String
                return task
            } ?? []
            DispatchQueue.main.async { self.tableView.reloadData() }
        }
    }
    
    @IBAction func logoutClicked(_ sender: Any) {
            do {
                try Auth.auth().signOut()
                SceneDelegate.showLogin()
            } catch let signOutError as NSError {
              print("Error signing out: %@", signOutError)
            }
    }
    }

extension TasksViewController: TaskTableViewCellDelegate {
    func didClickDelete(_ task: Task) {
        guard let docID = task.docID else { return }
        
        let db = Firestore.firestore()
        db.collection("note").document(docID).delete { error in
            if let error = error {
                print("Error deleting task: \(error)")
            } else {
                print("Task deleted successfully")
            }
        }
    }
}


extension TasksViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath) as! TaskTableViewCell
        let task = tasks[indexPath.row]
        cell.bind(task: task, delegate: self)
        
        
        
        return cell
    }

    
}
