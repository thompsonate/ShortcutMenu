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
        
        hiddenFilesCheck()
    }
    
    @IBAction func helloWorld(_ sender: NSMenuItem) {
        let task = Process()
        task.launchPath = "/usr/bin/say"
        task.arguments = ["hello world!"]
        task.launch()
        task.waitUntilExit() //locks app and keeps icon highlighted until finished
    }
    
    var showAllFiles = false
    var showAllFilesArguments = ["write", "com.apple.finder", "AppleShowAllFiles", "TRUE"]
    
    func  hiddenFilesCheck() {
        let task = Process()
        task.launchPath = "/usr/bin/defaults"
        task.arguments = ["read", "com.apple.finder", "AppleShowAllFiles"]
        
        let pipe = Pipe()
        task.standardOutput = pipe
        task.standardError = pipe
        task.launch()
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(data: data, encoding: .utf8)
        
        if output == "TRUE\n" {
            showAllFiles = true
            showAllFilesButton.title = "Hide Hidden Files"
            showAllFilesArguments = ["write", "com.apple.finder", "AppleShowAllFiles", "FALSE"]
        } else {
            showAllFiles = false
            showAllFilesButton.title = "Show Hidden Files"
            showAllFilesArguments = ["write", "com.apple.finder", "AppleShowAllFiles", "TRUE"]
        }
    }
    
    @IBOutlet weak var showAllFilesButton: NSMenuItem!

    @IBAction func showAllFiles(_ sender: NSMenuItem) {
        let task = Process()
        task.launchPath = "/usr/bin/defaults"
        task.arguments = showAllFilesArguments
        task.launch()
        task.waitUntilExit()
        
        let task2 = Process()
        task2.launchPath = "/usr/bin/killall"
        task2.arguments = ["Finder"]
        task2.launch()
        
        if showAllFiles == false {
            showAllFiles = true
            showAllFilesButton.title = "Hide Hidden Files"
            showAllFilesArguments = ["write", "com.apple.finder", "AppleShowAllFiles", "FALSE"]
        } else {
            showAllFiles = false
            showAllFilesButton.title = "Show Hidden Files"
            showAllFilesArguments = ["write", "com.apple.finder", "AppleShowAllFiles", "TRUE"]
        }
        
    }
    
    @IBAction func showAllFilesFalse(_ sender: NSMenuItem) {
        let task = Process()
        task.launchPath = "/usr/bin/defaults"
        task.arguments = ["write", "com.apple.finder", "AppleShowAllFiles", "FALSE"]
        task.launch()
        task.waitUntilExit()
        
        let task2 = Process()
        task2.launchPath = "/usr/bin/killall"
        task2.arguments = ["Finder"]
        task2.launch()
    }

    @IBAction func killallDock(_ sender: NSMenuItem) {
        let task = Process()
        task.launchPath = "/usr/bin/killall"
        task.arguments = ["Dock"]
        task.launch()
        task.waitUntilExit()
    }
    
    @IBAction func quitClicked(_ sender: NSMenuItem) {
        NSApplication.shared().terminate(self)
    }
    
    
}
