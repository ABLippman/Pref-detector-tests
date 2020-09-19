//
//  ViewController.swift
//  Preferences
//
//  Created by lip on 3/8/19.
//  Copyright © 2019 Andrew Lippman. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var textField: NSTextField!
    @IBOutlet weak var outputField: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func doIt(_ sender: Any) {
        let styles: NSTextCheckingResult.CheckingType = [.phoneNumber, .link]
        let detector = try! NSDataDetector(types: styles.rawValue)
        let matches = detector.matches(in: textField.stringValue, options: [], range: NSRange(location: 0, length: textField.stringValue.count))
        
        for match in matches {
            guard let range = Range(match.range, in: textField.stringValue) else { continue }
            let url = textField.stringValue[range] + ", "
            print(url)
            outputField.stringValue += url

        }

//        outputField.stringValue = textField.stringValue
    }
    
    @IBAction func openPrefs(_ sender: Any) {
//        var myWindow: NSWindow? = nil
        let storyboard = NSStoryboard(name: NSStoryboard.Name(rawValue: "Main"),bundle: nil)
        let controller: PrefsViewController = storyboard.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "pvController")) as! PrefsViewController
 //       myWindow = NSWindow(contentViewController: controller)
        self.presentViewControllerAsModalWindow(controller)
//        myWindow?.makeKeyAndOrderFront(self)
//        let vc = NSWindowController(window: myWindow)
//        vc.showWindow(self)

    }
}

