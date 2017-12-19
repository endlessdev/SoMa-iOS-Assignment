//
//  BestFriendsViewController.swift
//  My Friends
//
//  Created by Jade Yeom on 2017. 10. 29..
//  Copyright © 2017년 Narin. All rights reserved.
//

import UIKit

class BestFriendsViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var bestFriendsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bestFriendsTable.dataSource = self
        bestFriendsTable.delegate = self
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.didReceiveUpdateFriendsNotification(_:)),
                                               name: didUpdateFriendsNotification,
                                               object: nil)
    }

    @IBAction func onClickEdit(_ sender: UIBarButtonItem) {
        self.bestFriendsTable.isEditing = !self.bestFriendsTable.isEditing
        
        if self.bestFriendsTable.isEditing {
            sender.title = "Done"
        } else {
            sender.title = "Edit"
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: Receive Notification
    @objc func didReceiveUpdateFriendsNotification(_ notification: Notification) {
//        DetailViewController.
        self.bestFriendsTable.reloadData()
    }
    // MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: UITableViewDataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "bestFriendCell", for: indexPath)

        let friend:Friend = friends[indexPath.row]
        
        cell.textLabel?.text = "\(friend.name.title!). \(friend.name.first!) \(friend.name.last!)".capitalized
        cell.detailTextLabel?.text = friend.email!
        cell.imageView?.image = UIImage(named:"default-thumbnail")
        cell.imageView?.getImageFromURL(link: friend.picture.medium, contentMode: UIViewContentMode.scaleAspectFill)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            friends.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        default:
            return
        }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        friends.swapAt(sourceIndexPath.row, destinationIndexPath.row)
        saveCurrentFriends()
    }
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailViewController: DetailViewController = segue.destination as? DetailViewController else {
            return
        }
        
        guard let cell: UITableViewCell = sender as? UITableViewCell else {
            return
        }
        
        guard let cellIndex: IndexPath = self.bestFriendsTable.indexPath(for: cell) else {
            return
        }
        
//        detailViewController.isAdded = true;
        detailViewController.friendInfo = friends[cellIndex.row]
    }

}
