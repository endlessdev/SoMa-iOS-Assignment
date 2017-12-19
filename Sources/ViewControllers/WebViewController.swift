//
//  WebViewController.swift
//  My Friends
//
//  Created by Jade Yeom on 2017. 10. 29..
//  Copyright © 2017년 Narin. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    var url:String! = ""
    
    @IBOutlet weak var webView: WKWebView!


    @IBAction func onClickClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func onClickForward(_ sender: Any) {
        self.webView.goForward()
    }
    @IBAction func onClickStop(_ sender: Any) {
        self.webView.stopLoading()
    }
    @IBAction func onClickRefresh(_ sender: Any) {
        self.webView.reload()
    }
    @IBAction func onClickBack(_ sender: Any) {
        self.webView.goBack()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webView.load(URLRequest(url: URL(string: self.url)!))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
