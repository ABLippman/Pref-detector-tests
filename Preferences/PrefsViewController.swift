//
//  PrefsViewController.swift
//  Preferences
//
//  Created by lip on 3/8/19.
//  Copyright © 2019 Andrew Lippman. All rights reserved.
//  Can detect phone numbers and linkify them, but not enabled
//  And not URLs
//

import Cocoa
extension NSTextField{ func controlTextDidChange(obj: NSNotification){} }
class PrefsViewController: NSViewController,NSTextFieldDelegate {

    @IBOutlet weak var prefText: NSTextField!
    @IBOutlet var linkView: NSTextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        let styles: NSTextCheckingResult.CheckingType = [.phoneNumber, .link]
//        prefText.delegate = self
        if let prefText = prefText {  // more complicated delegate assign
            prefText.delegate = self
        }
//        prefText.stringValue = "This is the starter text"
//        prefText.isEditable = false;
        
        linkView.isEditable = false
//        linkView.dataDetectorTypes = .all  //UITextView only...
//        linkView.string = "This is me, 6179011065"
    }
    
    override func controlTextDidChange(_ obj: Notification)
    {
        let object = obj.object as! NSTextField
        let value = object.stringValue
 //       print(value)
        let styles: NSTextCheckingResult.CheckingType = [.phoneNumber, .link]
        let detector = try! NSDataDetector(types: styles.rawValue)
        let matches = detector.matches(in: value, options: [], range: NSRange(location: 0, length: value.count))
        
        for match in matches {
            guard let range = Range(match.range, in: value) else { continue }
            switch match.resultType {
            case .phoneNumber:
                print ("Phone Number: ",match.phoneNumber!)
            case .link:
                print ("URL: ", match.url!)  // prints attribute http://
            default:
                print ("Neither")
            }
 
            let url = value[range] + ", "
            print(url)  //  prints the raw match
            linkView.string = "Data Detector found: " + url
        }
    }
    
    @IBAction func doPrefs(_ sender: Any) {
        print("Hit Prefs!")
    }
    
        @IBAction func textEntered(_ sender: Any) {
//            linkView.string = prefText.stringValue
            print("Text Changed\n")
        }
}
