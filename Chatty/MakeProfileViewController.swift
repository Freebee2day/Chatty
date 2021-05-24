//
//  MakeProfileViewController.swift
//  Chatty
//
//  Created by Phoebe Zhong  on 4/12/21.
//  Copyright © 2021 Phoebe Zhong . All rights reserved.
//

import UIKit
import Parse
import AlamofireImage
import DropDown

class MakeProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var tfFirst: UITextField!
    
    @IBOutlet weak var tfLast: UITextField!
    
    @IBOutlet weak var tfStatus: UITextField!
    
    @IBOutlet weak var tfStory: UITextField!
    
    @IBOutlet weak var imgProfilePic: UIImageView!
    
    @IBOutlet weak var menuView: UIView!
    
    @IBOutlet weak var emoji: UIImageView!
    
    @IBOutlet weak var moodLabel: UILabel!
    
    
    
    let moodMenu: DropDown = {
        let moodMenu = DropDown()
        moodMenu.dataSource = [
            "Studying",
            "Partying",
            "Exercising",
            "Eating",
        ]
        return moodMenu
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapMenu))
        gesture.numberOfTouchesRequired = 1
        gesture.numberOfTapsRequired = 1
        menuView.addGestureRecognizer(gesture)
        moodMenu.anchorView = menuView
        menuView.layer.borderWidth = 1
        menuView.layer.borderColor = UIColor.lightGray.cgColor

        moodMenu.selectionAction = {index, title in
            //print("index \(index) and \(title)")
            self.moodLabel.text = title
            self.emoji.image = UIImage(named: title)
        }
    }
    
    @objc func didTapMenu(){
        moodMenu.show()
    }
    
    
    
    
    
    @IBAction func btnSubmitProfile(_ sender: Any) {
        
//      Create a Profile Class (for the new user who just signed up)
        let addedProfile = PFObject(className: "Profile")
        addedProfile["FirstN"] = tfFirst.text!
        addedProfile["LastN"] = tfLast.text!
        addedProfile["Status"] = tfStatus.text!
        addedProfile["Mood"] = moodLabel.text!
        addedProfile.add(tfStory.text!,forKey: "Stories")   //the story field is an array
        addedProfile["owner"] = PFUser.current()!

        let myImageData = imgProfilePic.image?.pngData()
        let myImageFile = PFFileObject(name: "Picture.png", data: myImageData!)
        addedProfile["Picture"] = myImageFile

        addedProfile.saveInBackground { (success, error) in
        if success{
//            print("profile saved successfully")
//            self.performSegue(withIdentifier: "ProfileToMainSegue", sender: self)
            
            //show the next viewController on the "same page"
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let secondVC = storyboard.instantiateViewController(identifier: "CenterNavigationController") //storyboardID

            secondVC.modalPresentationStyle = .fullScreen
            secondVC.modalTransitionStyle = .crossDissolve

            self.present(secondVC, animated: true, completion: nil)

            
            
        } else {
            print("Error saving profile: \(error?.localizedDescription)")
        }
    }
        
    }
    
    
    //the following fxns are for picking pictures and displaying new picture on the image view.
    @IBAction func btnSelectPicture(_ sender: Any) {
        //a gesture listener btn that allow user to pick new image upon tapping.
        let myCameraPicker = UIImagePickerController()
        myCameraPicker.delegate = self
        myCameraPicker.allowsEditing = true

        if UIImagePickerController.isSourceTypeAvailable(.camera){
            myCameraPicker.sourceType = .camera
            //check if there a camera feature in phone
        }else{
            myCameraPicker.sourceType = .photoLibrary
            //if not, pick a photo from gallery
        }

        present(myCameraPicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //display the newly selected image in image view.
        
        let myimg = info[.editedImage] as! UIImage
        
        //resize image
        let size = CGSize(width: 300, height: 300)
        
        //let scaled_myimg = myimg.af.imageScaled(to: size)
        let scaled_myimg = myimg.af.imageAspectScaled(toFill: size)
        
        imgProfilePic.image = scaled_myimg
        
        dismiss(animated: true, completion: nil)    //leaving the gallery selector && going back to the post composing view
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

