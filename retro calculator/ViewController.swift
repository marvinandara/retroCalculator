//
//  ViewController.swift
//  retro calculator
//
//  Created by Marvin Andara on 7/11/16.
//  Copyright © 2016 MarvinAndara. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum Operation: String {
        case Divide = "/";
        case Multiply = "*";
        case Subtract = "-";
        case Add = "+";
        case Empty = "Empty";
        case Clear = "Clear";
    }
    
    @IBOutlet weak var outputLbl: UILabel!;

    var btnSound: AVAudioPlayer!
    
    var runningNumber = "";
    var leftValStr = "";
    var rightValStr = "";
    var currentOperation: Operation = Operation.Empty;
    var result = "";
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav");
        
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do{
            
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl);
            btnSound.prepareToPlay();
        }catch let err as NSError {
            print(err.debugDescription)
        }
        
    }
    
    @IBAction func numberPressed(btn: UIButton!){
        playSound();
        runningNumber += "\(btn.tag)";
        outputLbl.text = runningNumber;
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
        if checkRunningNumber(){
           processOperation(Operation.Divide);
        }
    }

    @IBAction func onMultiplyPressed(sender: AnyObject) {
        if checkRunningNumber(){
            processOperation(Operation.Multiply);
        }
    }
    @IBAction func onSubtractPressed(sender: AnyObject) {
        if checkRunningNumber(){
            processOperation(Operation.Subtract);
        }
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        if checkRunningNumber(){
            processOperation(Operation.Add);
        }
    }
    
    @IBAction func onEqualsPressed(sender: AnyObject) {
        processOperation(currentOperation);
    }
    
    @IBAction func onClearPressed(sender: AnyObject){
        runningNumber = "";
        leftValStr = "";
        rightValStr = "";
        currentOperation = Operation.Empty;
        result = "";
        outputLbl.text = "0";
    }
    func checkRunningNumber() -> Bool{
        if(runningNumber != ""){
            return true;
        }
        return false;
    }
    func processOperation(op: Operation){
        btnSound.play();
        
        if currentOperation != Operation.Empty {
            //Run some math
            
            //A user selected an operator, but then selected another operator without 
            //first entering a number
            if runningNumber != "" {
                rightValStr = runningNumber;
                runningNumber = "";
                
                if currentOperation == Operation.Multiply{
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)";
                }
                else if currentOperation == Operation.Divide{
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)";
                }
                else if currentOperation == Operation.Add{
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)";
                }
                else if currentOperation == Operation.Subtract{
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)";
                }
                
                leftValStr = result;
                outputLbl.text = result;
            }
            
            currentOperation = op;
 
            
        }
        else{
            //This is the first time an operator has been pressed
            leftValStr = runningNumber;
            runningNumber = "";
            currentOperation = op;
        }
    }
    
    func playSound(){
        if(btnSound.playing){
            btnSound.stop();
        }
        
        btnSound.play();
    }
    
}

