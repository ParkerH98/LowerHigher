//
//  ViewController.swift
//  NumberGuesser
//
//  Created by Parker Hague on 5/16/19.
//  Copyright © 2019 Parker Hague. All rights reserved.b
//

import UIKit
import Foundation
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // used to exit out of numberpad with tap
        
        enableTapToExit()
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        
        view.addGestureRecognizer(tap)
        
        randomNumber = Int.random(in: lowerBound ... upperBound)
        divideNumber = randomNumber
        guessedNumber?.text = String(randomNumber)
        guessedNumber?.isHidden = true
    }


    @IBOutlet weak var gameInstructions: UILabel!
    @IBOutlet weak var attemptsLabel: UILabel!
    @IBOutlet weak var attemptsCount: UILabel!
    @IBOutlet weak var guessedNumber: UILabel! // random generated number to eval. against
    @IBOutlet weak var userGuess: UITextField! // what the user types
    

        var attemptsCounter = 0
        var upperBound = 100
        var lowerBound = 0
        var randomNumber = 0
        var divideNumber = 0
        var audioPlayer : AVAudioPlayer!
        
    
    // executes code for main 'higher' button in game
    @IBAction func higherButton(_ sender: Any) {
        playSound()
        
        let userGuessNum = Int(userGuess.text!) ?? 0
        let randomNum = Int(guessedNumber.text!) ?? 0
        
        // stops users from entering wrong lower vs higer evaluation
        if (userGuessNum < randomNum){
            
            displayAlert(title: "DRUNK IDIOT", message: "Take a drink because \(userGuessNum) is not higher than \(randomNum)")
        }
        
        if (attemptsCounter < 1){
            lowerBound = randomNumber + 1
        }
        
        else{
            lowerBound = divideNumber + 1
        }
            
        divideNumber = ((upperBound - lowerBound) / 2) + lowerBound
            
            
        guessedNumber.text = String(divideNumber)
        
        attemptsCounter += 1
        attemptsCount.text = String(attemptsCounter) + " / 5"
        
        if (userGuess.text == guessedNumber.text){
                   correctNumberButton(nil)
        }
    }
    
    // executes code for main 'lower' button in game
    @IBAction func lowerButton(_ sender: Any) {
        playSound()
        let userGuessNum = Int(userGuess.text!) ?? 0
        let randomNum = Int(guessedNumber.text!) ?? 0
        
        // stops users from entering wrong lower vs higer evaluation
        if (userGuessNum > randomNum){
            
            displayAlert(title: "DRUNK IDIOT", message: "Take a drink because \(userGuessNum) is not lower than \(randomNum)")
        }
        
        if (attemptsCounter < 1){
             upperBound = randomNumber - 1
        }
        
        else{
            upperBound = divideNumber - 1
        }
            
        divideNumber = ((upperBound - lowerBound) / 2) + lowerBound
            
        guessedNumber.text = String(divideNumber)
        
        attemptsCounter += 1
        attemptsCount.text = String(attemptsCounter) + " / 5"
        
        if (userGuess.text == guessedNumber.text){
            correctNumberButton(nil)
        }
    }
    
    
    // executed when correctNumberButton is pressed.
    // button is automatically pressed when game guesses correct user number
    @IBAction func correctNumberButton(_ sender: UIButton?) {
        
        let numberOfDrinks = abs(5 - attemptsCounter) + 1
        
        if (attemptsCounter <= 5){
            displayAlert(title: "DRINK UP!", message: "You must take \(numberOfDrinks) drink(s)")
        }
        
        else{
            displayAlert(title: "YOU WIN", message: "Pick someone to take \(numberOfDrinks) drink(s) and pass the phone")
        }
    }
    
    
    // resets many aspects about the game when the reset button is pressed
    @IBAction func resetButton(_ sender: Any) {
        
        // resets all values
        attemptsCounter = 0
        upperBound = 100
        lowerBound = 0
        divideNumber = 0
        randomNumber = Int.random(in: lowerBound ... upperBound)
        
        
        // resets text fields
        guessedNumber.text = String(randomNumber)
        attemptsCount.text = String(attemptsCounter) + " / 5"
        userGuess.becomeFirstResponder()
        userGuess.text = "Play Again"
        userGuess.isUserInteractionEnabled = true
        guessedNumber.isHidden = true
    }
    

    // displays a pop up alert onto the screen
    // with title and message as arguments
    func displayAlert (title:String, message:String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction.init(title: "OK", style: .default , handler: resetButton(_:)))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    // method to play sound when called upon
    func playSound(){
        
        // sounds can be changed by editing this code block
        let soundURL = Bundle.main.url(forResource: "stoneSound", withExtension: "mp3")
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL!)
        }
        catch{
            print(error)
        }
        
        audioPlayer.play()
    }
    
    // used with userGuess textField to execute actions when
    // user begins editing text field
    @IBAction func startedEditing(_ sender: UITextField) {
        
        userGuess.text = ""
        SetDoneToolbar(field: userGuess)
    }
    
    
    // used with userGuess textField to execute actions when
    // user is done editing text field
    @IBAction func editingDidEnd(_ sender: Any) {
        
        if (userGuess.text != ""){
            
            userGuess.isUserInteractionEnabled = false
            guessedNumber.isHidden = false
        }
    }
    
    
    // adds "done" button to numberpad
    func SetDoneToolbar(field:UITextField) {
        
        let doneToolbar:UIToolbar = UIToolbar()

        doneToolbar.items=[
            UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(ViewController.dismissKeyboard))
        ]

        doneToolbar.sizeToFit()
        field.inputAccessoryView = doneToolbar
    }
    
    // helper method used with SetDoneToolbar method
    @objc func dismissKeyboard (){
        userGuess.resignFirstResponder()
    }
    
    
    // enables functionality to tap screen to exit number pad
    func enableTapToExit (){
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        
        view.addGestureRecognizer(tap)
    }
}
