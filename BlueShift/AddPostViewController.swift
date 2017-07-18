//
//  AddPostViewController.swift
//  BlueShift
//
//  Created by Akul Joshi on 6/28/17.
//  Copyright © 2017 Nebula. All rights reserved.
//

import UIKit

class AddPostViewController: UIViewController
{

    var currentPosts: [Post]!
    @IBOutlet weak var addPostTextField: UITextView!
    @IBOutlet weak var addPostButton: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        addPostTextField.layer.borderWidth = 0.5
        addPostButton.layer.cornerRadius = 10.0
        navigationItem.hidesBackButton = true
        self.automaticallyAdjustsScrollViewInsets = false
        navigationItem.title = "Add Post"
    }
    
    @IBAction func addPostButtonTapped(_ sender: Any)
    {
        addPostTextField.endEditing(true)
        let postToBeAdded = Post(Content: addPostTextField.text!)
        currentPosts.insert(postToBeAdded, at: 0)
        rootRef.child("posts").child("post\(count)").child("name").setValue(postToBeAdded.nameUsing)
        rootRef.child("posts").child("post\(count)").child("image").setValue(postToBeAdded.imageString)
        rootRef.child("posts").child("post\(count)").child("content").setValue(postToBeAdded.content)
        rootRef.child("posts").child("post\(count)").child("likesCount").setValue(postToBeAdded.likesCount)
        rootRef.child("posts").child("post\(count)").child("commentCount").setValue(postToBeAdded.commentCount)
        count += 1
        rootRef.child("count").setValue(count)
        if currentPosts.count > 100
        {
            currentPosts.remove(at: currentPosts.count - 1)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let vc = segue.destination as! ViewController
        
        posts = currentPosts
        //savePosts()
    }
}
