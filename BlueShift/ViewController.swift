//
//  ViewController.swift
//  BlueShift
//
//  Created by Akul Joshi on 6/21/17.
//  Copyright © 2017 Nebula. All rights reserved.
//

import UIKit
import Firebase

var posts: [Post] = []
var comments: [Comment] = []
var checkPost: Post!
var rootRef: DatabaseReference = Database.database().reference()
var count = 0

class PostTableViewCell: UITableViewCell
{
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postNameLabel: UILabel!
    @IBOutlet weak var postContent: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var commentCountLabel: UILabel!
    
    @IBAction func likeButtonClicked(_ sender: Any)
    {
        for post in posts
        {
            if post.content == postContent.text! && post.nameUsing == postNameLabel.text!
            {
                if !post.isClicked
                {
                    likeButton.setImage(UIImage(named: "likeIconFull"), for: .normal)
                    post.likesCount += 1
                    likeCountLabel.text = String(post.likesCount)
                } else {
                    likeButton.setImage(UIImage(named: "likeIcon"), for: .normal)
                    post.likesCount -= 1
                    likeCountLabel.text = String(post.likesCount)
                }
                post.isClicked = !post.isClicked
                
                rootRef.child("posts").child("post\((posts.count - posts.index(of: post)! - 1))").child("likesCount").setValue(post.likesCount)
            }
        }
    }
    
    @IBAction func cButtonPressed(_ sender: UIButton)
    {
        
        for post in posts
        {
            if post.content == postContent.text! && post.nameUsing == postNameLabel.text!
            {
                checkPost = post
                comments = post.comments
            }
        }
    }
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    
    @IBOutlet weak var postsTableView: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        navigationItem.hidesBackButton = true
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.barTintColor = UIColor.blue
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.tintColor = UIColor.white
        postsTableView.rowHeight = UITableViewAutomaticDimension
        postsTableView.estimatedRowHeight = 1000.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = postsTableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostTableViewCell
        let post = posts[indexPath.row]
        cell.postImageView!.image = post.imageUsing
        cell.postNameLabel!.text = post.nameUsing
        cell.postContent!.text = post.content
        cell.likeCountLabel!.text = String(post.likesCount)
        if post.isClicked
        {
            cell.likeButton.setImage(UIImage(named: "likeIconFull"), for: .normal)
        } else {
            cell.likeButton.setImage(UIImage(named: "likeIcon"), for: .normal)
        }
        cell.commentCountLabel!.text = String(post.commentCount)
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "addPost"
        {
            let apvc = segue.destination as! AddPostViewController
            apvc.currentPosts = posts
        }
        if segue.identifier == "commentsPage"
        {
            let cvc = segue.destination as! CommentViewController
            cvc.postComments = comments
        }
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        postsTableView.reloadData()
    }
}

