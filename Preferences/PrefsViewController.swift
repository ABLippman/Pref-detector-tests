//
//  PrefsViewController.swift
//  Preferences
//
//  Created by lip on 3/8/19.
//  Copyright © 2019 Andrew Lippman. All rights reserved.
//

import Cocoa
extension NSTextField{ func controlTextDidChange(obj: NSNotification){} }
class PrefsViewController: NSViewController,NSTextFieldDelegate {

    @IBOutlet weak var prefText: NSTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        let styles: NSTextCheckingResult.CheckingType = [.phoneNumber, .link]
        prefText.delegate = self

        prefText.stringValue = "This is the starter text"
//        prefText.isEditable = false;
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
            let url = value[range] + ", "
            print(url)
            
        }

    }
    
    @IBAction func doPrefs(_ sender: Any) {
        print("Hit Prefs!")
    }
    
    @IBAction func textChanged(_ sender: Any) {
        print("Text Changed\n")
    }
    
}
