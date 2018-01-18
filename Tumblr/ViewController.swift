//
//  ViewController.swift
//  Tumblr
//
//  Created by Nikhil Iyer on 1/8/18.
//  Copyright © 2018 Nikhil Iyer. All rights reserved.
//

import UIKit
import AlamofireImage

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    var posts: [[String: Any]] = [];
    @IBOutlet weak var TumblrTableView: UITableView!
    let refreshController = UIRefreshControl();
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        refreshController.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        TumblrTableView.insertSubview(refreshController, at: 0)
        
        TumblrTableView.delegate = self
        TumblrTableView.dataSource = self
        
        loadPosts()
    }
    
    func loadPosts() {
        let url = URL(string: "https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV")!
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        session.configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data,
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                let responseDictionary = dataDictionary["response"] as! [String: Any]
                self.posts = responseDictionary["posts"] as! [[String: Any]]
                self.TumblrTableView.reloadData()
                self.refreshController.endRefreshing()
            }
        }
        task.resume()

    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count;
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TumblrCell") as! TumblrCell
        let picturePost = posts[indexPath.row]
        if let photos = picturePost["photos"] as? [[String: Any]] {
            let photo = photos[0]
            let originalSize = photo["original_size"] as! [String: Any]
            let urlString = originalSize["url"] as! String
            let url = URL(string: urlString)
            cell.PhotosView.af_setImage(withURL: url!)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        TumblrTableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func refreshControlAction(_ refreshControl: UIRefreshControl) {
        loadPosts()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! TumblrCell
        let vc = segue.destination as! PhotoViewController
        vc.image = cell.PhotosView.image
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}

