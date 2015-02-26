//
//  ViewController.swift
//  2 pickerViews - inclass
//
//  Created by YG on 2/19/15.
//  Copyright (c) 2015 YuryGitman. All rights reserved.
//
//   Project Show how to work with 2 UIPickerView's, addressing them individually in one ViewController. 
//

//  Two switches, and their switch state, also demostrated here.  
//  Two NStimers, are demo'ed.  Showing

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //  UI Lables & PickerView Outlets
    @IBOutlet weak var labelTop: UILabel!
    @IBOutlet weak var labelBottom: UILabel!
    @IBOutlet weak var pickerViewTop: UIPickerView!
    @IBOutlet weak var pickerBottom: UIPickerView!
    
    //  NSTimers
    var myTimer1 = NSTimer()  // init Timer That Goes Down
    var myTimer2 = NSTimer() //  init Timer That Goes Up
    
    var timeSecondesUserSelected = 0
    var taskTimerSecondsCount = 0
    
    
    //  UISwitch Top
    @IBAction func switchedTop(sender: UISwitch) {
        if (sender.on){
            
            // The key line to start the timer.
                myTimer1 = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("myTimer1Func"), userInfo: nil, repeats: true)
            
            // UI Stuff
            labelTop.textColor = UIColor.blackColor()

        } else {   // Else we know the switch will be OFF.  It's only ON or OFF....
          
        // Double Check Timer is Running Here
            if (myTimer1.valid){     // house-keeping to avoid occasional buggy behavior. 
                
                // UI Stuff
                labelTop.textColor = UIColor.blackColor()
                labelTop.text = "Set Kitchen Timer"
                
                //  Key Line to Shut Off Timer
                myTimer1.invalidate()   // Turn Off Timer
                
                }
            
        }
    }
    
    
    //  UISwitch Bottom
    @IBAction func switchedBottom(sender: UISwitch) {
        
          if (sender.on){
            // Ditto Above
                myTimer2 = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("myTimer2Func"), userInfo: nil, repeats: true)
                labelBottom.textColor = UIColor.blackColor()
                        }
          else {
    
                // Double Check Timer is Running Here
                if (myTimer2.valid){
                    
                    // UI Stuff
                    labelBottom.text = "Task Length: \(taskTimerSecondsCount) seconds"
                    labelBottom.textColor = UIColor.orangeColor()

                    
                    myTimer2.invalidate()   // Turn Off Timer
                    taskTimerSecondsCount = 0   // Reset our counter variable

                }
            }
        }


    
    //  Function called by Timer1, as set by it's interval
    func myTimer1Func(){
        
        if (timeSecondesUserSelected > 0)  // If user selected a time
            {
            timeSecondesUserSelected--   //  Count Down
            println("timeSecondsUserSelected \(timeSecondesUserSelected)")
            labelTop.text = "\(timeSecondesUserSelected) seconds have passed"
            pickerViewTop.selectRow(timeSecondesUserSelected, inComponent: 0, animated: true)
            }
        
        else if (timeSecondesUserSelected <= 0)
            {
                labelTop.text = "Timer Done !"
                labelTop.textColor = UIColor.orangeColor()
            }
        
    }
    
    
    //  Function called by Timer2, as set by it's interval
    func myTimer2Func(){
        
        
        if (taskTimerSecondsCount < 360)  // If user selected a time
        {
            taskTimerSecondsCount++   //  Count Up
            println("taskTimerSecondsCount \(taskTimerSecondsCount)")
            labelBottom.text = "\(taskTimerSecondsCount) seconds have passed"

            pickerBottom.selectRow(taskTimerSecondsCount, inComponent: 0, animated: true)
        }
            
        if (taskTimerSecondsCount >= 360 )  // max seconds in picker
        
        {
            labelTop.text = "Maxed Out Timer!"
            labelTop.textColor = UIColor.orangeColor()
            myTimer2.invalidate()
            taskTimerSecondsCount = 0

        }
        
    }
    
    
    
    //  Project Starter Code
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    // UIPicker Delegate & DataSource Required Methods
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if (pickerView == pickerViewTop)
        {
            return 61
            
        } else {
            
        return 361
    }
    }
    
    
    // UIPicker Optional Method, Sets (or returns) Title Text for each component & row in picker.
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return "\(row)"
    }
    
    //  UIPicker Optional Method, Does the cool animation of programatically dialing the UiPicker Position.
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if (pickerView == pickerViewTop){
            labelTop.text = "Set for \(row) seconds"
            labelTop.textColor = UIColor.blackColor()
            timeSecondesUserSelected = row
            
        } else{
            labelBottom.text = "\(row) seconds have passed"
        }
        
        
    }
    
    
}

