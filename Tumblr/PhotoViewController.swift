//
//  PhotoViewController.swift
//  Tumblr
//
//  Created by Nikhil Iyer on 1/15/18.
//  Copyright © 2018 Nikhil Iyer. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {

    @IBOutlet weak var BigPicView: UIImageView!
    
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.BigPicView.image = self.image;
        // Do any additional setup after loading the view.
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
