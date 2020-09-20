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
class PrefsViewController: NSViewController,NSTextViewDelegate {

//    @IBOutlet weak var prefText: NSTextField!
    @IBOutlet var prefText: NSTextView!
    @IBOutlet var linkView: NSTextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        prefText.delegate = self
/*        if let prefText = prefText {  // more complicated delegate assign
            prefText.delegate = self
        } */
//        prefText.stringValue = "This is the starter text"  StingValue is fields..
        prefText.string = "README.md.edu"  //String is for textView
//
        linkView.isEditable = false
//        linkView.dataDetectorTypes = .all  //UITextView only...
    }
    
    func textDidChange(_ obj: Notification)
    {
        let object = obj.object as! NSTextView
        let value = object.string
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
    
    func textDidEndEditing(_ notification: Notification) {
        //  This works for textView when you make another view key
        guard (notification.object as? NSTextView) != nil else { return }
        
        print("Text Ended\n")
    }
    
    @IBAction func doPrefs(_ sender: Any) {
        print("Hit Prefs!")
    }
    
        @IBAction func textEntered(_ sender: Any) {
 //           linkView.string = prefText.stringValue
            print("Text Ended\n")
        }
}
