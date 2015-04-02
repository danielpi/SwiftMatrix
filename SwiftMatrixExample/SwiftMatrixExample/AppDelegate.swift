//
//  AppDelegate.swift
//  SwiftMatrixExample
//
//  Created by Daniel Pink on 30/08/2014.
//  Copyright (c) 2014 Electronic Innovations. All rights reserved.
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
                            
    @IBOutlet weak var window: NSWindow!


    func applicationDidFinishLaunching(aNotification: NSNotification?) {
        // Insert code here to initialize your application
        
        /*
        data = load('ex1data1.txt');       % read comma separated data
        X = data(:, 1); y = data(:, 2);
        m = length(y);                     % number of training examples
        */
        //NSURL *baseURL = [NSURL URLWithString:@""];
        let dataURL = NSURL(fileURLWithPath:"/Users/danielpi/repos/SwiftMatrix/ex1data1.txt")
        //let text = NSString.stringWithContentsOfURL(dataURL!, encoding: NSUTF8StringEncoding, error: nil)
        let text = NSString(contentsOfURL: dataURL!, encoding: NSUTF8StringEncoding, error: nil)
        
        var data: [[Double]] = []
        for line in text!.componentsSeparatedByString("\n") {
            var row: [Double] = []
            for value in line.componentsSeparatedByString(",") {
                row.append(value.doubleValue)
            }
            data.append(row)
        }
        let matrix = Matrix(data)
        println(matrix)
    }

    func applicationWillTerminate(aNotification: NSNotification?) {
        // Insert code here to tear down your application
    }


}

