//
//  HomeCellTableView.swift
//  Chatty
//
//  Created by Phoebe Zhong  on 4/15/21.
//  Copyright © 2021 Phoebe Zhong . All rights reserved.
//

import UIKit
import Parse
import InputBarAccessoryView

class HomeCellTableView: UITableViewCell {
    
    //each cell displays a profile on the home page (table of profiles) 
    
    @IBOutlet weak var imgHomeCell: UIImageView!
    
    @IBOutlet weak var firstNHomeCell: UILabel!
    
    @IBOutlet weak var statusHomeCell: UILabel!
    
    @IBOutlet weak var storyHomeCell: UILabel!
    
    @IBOutlet weak var emoji: UIImageView!
    
    @IBOutlet weak var moodLabel: UILabel!
    
    @IBOutlet weak var ageCell: UILabel!
    
    @IBOutlet weak var chatBTN: UIButton!
    
   
    
    //noNeed!!
    //var userProfile = PFObject(className: "Profile")  //mine
    var cellProfile = PFObject(className: "Profile")  //friend's
    var homeVC: HomeViewController!
    var capturedTxt: String!
    
    
    
    
    @IBAction func clickedChatBTN(_ sender: Any) {
        //btn logic here
        print("btnclicked")
        homeVC.showMsgBar = true
        homeVC.becomeFirstResponder()
        homeVC.myMessageBar.inputTextView.becomeFirstResponder()
        homeVC.selectedProfile = cellProfile
        
        
        //MARK: Instruction
        //creat convo, add to convo list.
        //add msg to convo
        //show Toast
        //add to friend list -> remove profile (by reloading data).
        
        //need: Profile of both users, message txt.
    }
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
