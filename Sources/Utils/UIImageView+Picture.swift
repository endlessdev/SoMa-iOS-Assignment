//
//  UIImageViewExtension.swift
//  My Friends
//
//  Created by Jade Yeom on 2017. 10. 31..
//  Copyright © 2017년 Narin. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func getImageFromURL(link:String, contentMode: UIViewContentMode) {
        URLSession.shared.dataTask( with: NSURL(string:link)! as URL, completionHandler: {
            (data, response, error) -> Void in
            DispatchQueue.main.async {
                self.contentMode =  contentMode
                if let data = data { self.image = UIImage(data: data) }
            }
        }).resume()
    }
}
