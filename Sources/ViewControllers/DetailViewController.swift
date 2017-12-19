//
//  DetailViewController.swift
//  My Friends
//
//  Created by Jade Yeom on 2017. 10. 29..
//  Copyright © 2017년 Narin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var friendInfo: Friend!
    var addedIndex : Int!

    @IBOutlet weak var nationalityLabel: UILabel!
    @IBOutlet weak var telNumLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    @IBAction func onClickAdd(_ sender: UIBarButtonItem) {
        
        if(addedIndex != -1) {
            friends.remove(at: addedIndex)
            addedIndex = -1
            addButton.title = "Add"
        } else {
            friends.append(friendInfo)
            addedIndex = friends.count - 1
            addButton.title = "Remove"
        }
        
        saveCurrentFriends()
        NotificationCenter.default.post(name: didUpdateFriendsNotification, object: nil)
    }
    
    @IBAction func onClickSearch(_ sender: Any) {
        let webViewController = self.storyboard?.instantiateViewController(withIdentifier: "webViewController") as! WebViewController
        webViewController.url = "https://www.google.com/search?q=\(self.friendInfo.nat.rawValue)"
        self.present(webViewController, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.addedIndex = getIndexByCell(cell: friendInfo.cell)
        
        self.title = "\(friendInfo.name.title!). \(friendInfo.name.last!)".capitalized
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addedIndex = getIndexByCell(cell: friendInfo.cell)
        
        print(addedIndex)
        
        if addedIndex != -1 {
            addButton.title = "Remove"
        } else {
            addButton.title = "Add"
        }

        fullNameLabel.text? = "\(friendInfo.name.title!). \(friendInfo.name.first!) \(friendInfo.name.last!)".capitalized
        emailLabel.text? = friendInfo.email
        telNumLabel.text? = friendInfo.cell
        nationalityLabel.text? = friendInfo.nat!.rawValue
        profileImage.image = UIImage(named:"default-thumbnail")
        profileImage.getImageFromURL(link: friendInfo.picture.large, contentMode: UIViewContentMode.scaleAspectFit)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
