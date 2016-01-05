/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit
import Parse

//class ViewController: UIViewController, UINavigationControllerDelegate, 
//UIImagePickerControllerDelegate{

class ViewController: UIViewController{
    
    var signupActive = true
    
    @IBOutlet var username: UITextField!
    

    @IBOutlet var password: UITextField!
    
    
    @IBOutlet var signupButton: UIButton!
    
    @IBOutlet var registeredText: UILabel!
    
    @IBOutlet var loginButton: UIButton!
    
    
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    func displayAlert(title: String, message:String) {
        var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)

    }
    
    
    @IBAction func signUp(sender: AnyObject) {
        
        if username.text == "" || password.text == "" {
            
            displayAlert("Error in form", message: "Please enter a username and password")
            
        } else {
            
            activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            
            var errorMessage = "Please try again later"
            
            if signupActive == true {
            
            var user = PFUser()
            user.username = username.text
            user.password = password.text
            
            user.signUpInBackgroundWithBlock({ (success, error) -> Void in
                self.activityIndicator.stopAnimating()
                UIApplication.sharedApplication().endIgnoringInteractionEvents()
                
                if error == nil {
                    // sign up successful
                    
                    self.performSegueWithIdentifier("login", sender: self)
                }else {
                    if let errorString = error!.userInfo["error"] as? String {
                        errorMessage = errorString
                    }
                    
                    self.displayAlert("Failed sign up", message: errorMessage)
                }
            })
            } else {
                PFUser.logInWithUsernameInBackground(username.text!, password: password.text!, block: { (user, error) -> Void in
                    
                    self.activityIndicator.stopAnimating()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()

                    
                    if user != nil {
                        //log in
                        self.performSegueWithIdentifier("login", sender: self)
                        
                    } else {
                        if let errorString = error!.userInfo["error"] as? String {
                            errorMessage = errorString
                        }
                        
                        self.displayAlert("Failed log in", message: errorMessage)
                    }
                })
            }
        }
       
    }
    
    
    @IBAction func logIn(sender: AnyObject) {
        
        if signupActive == true {
            
            signupButton.setTitle("Log In", forState: UIControlState.Normal)
            registeredText.text = "Not registered?"
            loginButton.setTitle("Sign Up", forState: UIControlState.Normal)
            signupActive = false
            
        }else {
            
            signupButton.setTitle("Sign Up", forState: UIControlState.Normal)
            registeredText.text = "Already registered?"
            loginButton.setTitle("Log In", forState: UIControlState.Normal)
            signupActive = true

        }
        
    }
    /*

    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    @IBAction func pause(sender: AnyObject) {

        activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
       // UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        
    }
    
    @IBAction func restore(sender: AnyObject) {
        
        activityIndicator.stopAnimating()
       // UIApplication.sharedApplication().endIgnoringInteractionEvents()
    }
    @IBAction func createAlert(sender: AnyObject) {
        var alert = UIAlertController(title: "Hey there!", message: "Are you sure?", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
       
        print("image selected")
        self.dismissViewControllerAnimated(true, completion: nil)
        
        importedImage.image = image
        
        
    }

    @IBAction func importImage(sender: AnyObject) {
        
        var image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        image.allowsEditing = false
        
        self.presentViewController(image, animated: true, completion: nil)
    }
    @IBOutlet var importedImage: UIImageView!

    */

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationController?.navigationBarHidden = true
        

        
        /*

        var product = PFObject(className: "Products")
        
        product["name"] = "Ice Cream"
        
        product["description"] = "Tutti Fruiti"
        
        product["price"] = 4.99
        
        product.saveInBackgroundWithBlock { (success, error) -> Void in
            if success == true {
                print("Object saved with ID \(product.objectId)")
            }else {
                print("Failed")
                print(error)
            }
        }
        */
        
        /*

        var query = PFQuery(className: "Products")
        
        query.getObjectInBackgroundWithId("bZsKM9F8g4") { (object: PFObject?, error: NSError? ) -> Void in
            if error != nil {
                print(error)
            }else if let product = object{
                //print(object)
                //print(object?.objectForKey("description"))
                product["description"] = "Rocky Road"
                
                product["price"] = 5.99
                
                product.saveInBackground()
            }
        }
        
        */
        
    }
    
    override func viewDidAppear(animated: Bool) {
//        if PFUser.currentUser() != nil {
//            self.performSegueWithIdentifier("login", sender: self)
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
