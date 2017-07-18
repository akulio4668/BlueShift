//
//  CommentViewController.swift
//  BlueShift
//
//  Created by Akul Joshi on 7/8/17.
//  Copyright © 2017 Nebula. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell
{
    @IBOutlet weak var commentNameLabel: UILabel!
    @IBOutlet weak var commentImageView: UIImageView!
    @IBOutlet weak var commentContent: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likesCountLabel: UILabel!
    
    @IBAction func likeButtonClicked(_ sender: UIButton)
    {
        for comment in checkPost.comments
        {
            if comment.content == commentContent.text! && comment.nameUsing == commentNameLabel.text!
            {
                if !comment.isClicked
                {
                    likeButton.setImage(UIImage(named: "likeIconFull"), for: .normal)
                    comment.likesCount += 1
                    likesCountLabel.text = String(comment.likesCount)
                } else {
                    likeButton.setImage(UIImage(named: "likeIcon"), for: .normal)
                    comment.likesCount -= 1
                    likesCountLabel.text = String(comment.likesCount)
                }
                comment.isClicked = !comment.isClicked
                rootRef.child("posts").child("post\((posts.count - posts.index(of: checkPost)! - 1))").child("comments").child("comment\((checkPost.comments.count - checkPost.comments.index(of: comment)! - 1))").child("likesCount").setValue(comment.likesCount)
            }
        }
    }

}

class CommentViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{

    var postComments: [Comment]!
    @IBOutlet weak var commentsTableView: UITableView!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        commentsTableView.rowHeight = UITableViewAutomaticDimension
        commentsTableView.estimatedRowHeight = 1000.0
        navigationItem.hidesBackButton = true
        navigationItem.title = "Comments"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return postComments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = commentsTableView.dequeueReusableCell(withIdentifier: "comment", for: indexPath) as! CommentTableViewCell
        let comment = postComments[indexPath.row]
        cell.commentNameLabel!.text = comment.nameUsing
        cell.commentImageView!.image = comment.imageUsing
        cell.commentContent!.text = comment.content
        if comment.isClicked
        {
            cell.likeButton.setImage(UIImage(named: "likeIconFull"), for: .normal)
        } else {
            cell.likeButton.setImage(UIImage(named: "likeIcon"), for: .normal)
        }
        cell.likesCountLabel!.text = String(comment.likesCount)
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "addComment"
        {
            let acvc = segue.destination as! AddCommentViewController
            acvc.addedComments = postComments
        }
        if segue.identifier == "backToPosts"
        {
            let vc = segue.destination as! ViewController
            checkPost.comments = postComments
            checkPost.commentCount = postComments.count
        }
    }
}
