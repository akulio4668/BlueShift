//
//  AddCommentViewController.swift
//  BlueShift
//
//  Created by Akul Joshi on 7/10/17.
//  Copyright © 2017 Nebula. All rights reserved.
//

import UIKit

class AddCommentViewController: UIViewController
{

    var addedComments: [Comment]!
    @IBOutlet weak var addCommentTextView: UITextView!
    @IBOutlet weak var addCommentButton: UIButton!
    var commentToBeAdded: Comment!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        addCommentTextView.layer.borderWidth = 0.5
        addCommentButton.layer.cornerRadius = 10.0
        navigationItem.hidesBackButton = true
        self.automaticallyAdjustsScrollViewInsets = false
        navigationItem.title = "Add Comment"
    }
    
    
    @IBAction func addCommentButtonTapped(_ sender: UIButton)
    {
        addCommentTextView.endEditing(true)
        commentToBeAdded = Comment(Content: addCommentTextView.text!)
        addedComments.insert(commentToBeAdded, at: 0)
        if addedComments.count > 100
        {
            addedComments.remove(at: addedComments.count - 1)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let cvc = segue.destination as! CommentViewController
        cvc.postComments = addedComments
        checkPost.comments = addedComments
        checkPost.commentCount = checkPost.comments.count
        rootRef.child("posts").child("post\((posts.count - posts.index(of: checkPost)! - 1))").child("commentCount").setValue(checkPost.commentCount)
        rootRef.child("posts").child("post\((posts.count - posts.index(of: checkPost)! - 1))").child("comments").child("comment\((checkPost.comments.count - checkPost.comments.index(of: commentToBeAdded)! - 1))").child("nameUsing").setValue(commentToBeAdded.nameUsing)
        rootRef.child("posts").child("post\((posts.count - posts.index(of: checkPost)! - 1))").child("comments").child("comment\((checkPost.comments.count - checkPost.comments.index(of: commentToBeAdded)! - 1))").child("image").setValue(commentToBeAdded.imageString)
        rootRef.child("posts").child("post\((posts.count - posts.index(of: checkPost)! - 1))").child("comments").child("comment\((checkPost.comments.count - checkPost.comments.index(of: commentToBeAdded)! - 1))").child("content").setValue(commentToBeAdded.content)
        rootRef.child("posts").child("post\((posts.count - posts.index(of: checkPost)! - 1))").child("comments").child("comment\((checkPost.comments.count - checkPost.comments.index(of: commentToBeAdded)! - 1))").child("likesCount").setValue(commentToBeAdded.likesCount)
    }
}
