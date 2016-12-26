//
//  StatusMenuController.swift
//  ShortcutMenu
//
//  Created by Nate Thompson on 12/26/16.
//  Copyright © 2016 Nate Thompson. All rights reserved.
//

import Cocoa


class StatusMenuController: NSObject {
    @IBOutlet weak var statusMenu: NSMenu!
    
    let statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
    
    override func awakeFromNib(){
        
        statusItem.menu = statusMenu
        
        let icon = NSImage(named: "statusIcon")
        icon?.isTemplate = true
        statusItem.image = icon
        statusItem.menu = statusMenu
    }
    
    @IBAction func helloWorld(_ sender: NSMenuItem) {
        let task = Process()
        task.launchPath = "/usr/bin/say"
        task.arguments = ["hello world!"]
        task.launch()
        task.waitUntilExit()
    }


    
    @IBAction func quitClicked(_ sender: NSMenuItem) {
        NSApplication.shared().terminate(self)
    }
    
    
}
