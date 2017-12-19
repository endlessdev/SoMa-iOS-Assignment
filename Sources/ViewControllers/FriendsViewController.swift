//
//  FriendsViewController.swift
//  My Friends
//
//  Created by Jade Yeom on 2017. 10. 28..
//  Copyright © 2017년 Narin. All rights reserved.
//

import UIKit

class FriendsViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    var friendList:[Friend]! = []
    let API_ENDPOINT: String = "https://randomuser.me/api/?results=20&inc=name,picture,nat,cell,email,id"

    @IBOutlet weak var friendsTable: UITableView!
    
    lazy var indicator : UIActivityIndicatorView = {
        let indicator: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        indicator.backgroundColor = UIColor.lightGray
        indicator.translatesAutoresizingMaskIntoConstraints = false
        
        return indicator
    }()
    
    
    func showActivityIndicator() {
        self.view.addSubview(self.indicator)
        
        let safeAreaLayoutGuide: UILayoutGuide = self.view.safeAreaLayoutGuide
        
        self.indicator.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
        self.indicator.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor).isActive = true
        
        indicator.startAnimating()
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func endActivityIndicator(){
        self.indicator.stopAnimating()
        self.indicator.removeFromSuperview()
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        friendsTable.dataSource = self
        friendsTable.delegate = self
        
        self.friendsTable.refreshControl = UIRefreshControl()
        self.friendsTable.refreshControl?.addTarget(self, action: #selector(self.startReloadTableContents(_:)), for: UIControlEvents.valueChanged)

        getDataFromURL(url: API_ENDPOINT)
    }
    
    func getDataFromURL(url: String) {
        self.showActivityIndicator()
        if let urlStr = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let url = URL(string: urlStr) {
            let task = URLSession.shared.dataTask(with: url) { (data, response , error) in
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    if let data = data, let friends = try?
                        decoder.decode(Friends.self, from: data)
                    {
                        self.friendList = friends.results
                        DispatchQueue.main.async {
                            self.friendsTable.reloadData()
                            self.endActivityIndicator()
                        }
                    } else {
                        print(error)
                    }
            }
            task.resume()
        }
    }
    
    @objc func startReloadTableContents(_ sender: UIRefreshControl) {
        self.friendsTable.reloadData()
        getDataFromURL(url: API_ENDPOINT)
        indicator.stopAnimating()
        sender.endRefreshing()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendList!.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath)  as UITableViewCell

        let friend:Friend = self.friendList![indexPath.row]
        
        cell!.textLabel?.text = "\(friend.name.title!). \(friend.name.first!) \(friend.name.last!)".capitalized
        cell!.detailTextLabel?.text = friend.email!
        
        cell!.imageView?.image = UIImage(named: "default-thumbnail")
        cell!.imageView?.getImageFromURL(link: friend.picture.medium, contentMode: UIViewContentMode.scaleAspectFit)
        
        return cell!
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let addViewController: DetailViewController = segue.destination as? DetailViewController else {
            return
        }
        
        guard let cell: UITableViewCell = sender as? UITableViewCell else {
            return
        }
        
        guard let cellIndex: IndexPath = self.friendsTable.indexPath(for: cell) else {
            return
        }
        
        addViewController.friendInfo = self.friendList[cellIndex.row]
    }
    

}
