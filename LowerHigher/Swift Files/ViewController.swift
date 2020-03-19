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
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        
        view.addGestureRecognizer(tap)
        
        randomNumber = Int.random(in: lowerBound ... upperBound)
        divideNumber = randomNumber
        guessedNumber.text = String(randomNumber)
        
     
     
        
    }


    @IBOutlet weak var gameInstructions: UILabel!
    @IBOutlet weak var attemptsLabel: UILabel!
    @IBOutlet weak var attemptsCount: UILabel!
    @IBOutlet weak var guessedNumber: UILabel!
    @IBOutlet weak var userGuess: UITextField!
    
    
        var guessedNumberVar = 0
        var attemptsCounter = 0
        var upperBound = 100
        var lowerBound = 0
        var randomNumber = 0
        var divideNumber = 0
        var audioPlayer : AVAudioPlayer!
        
    
    @IBAction func higherButton(_ sender: Any) {
        playSound()
        
        // stops users from entering wrong lower vs higer evaluation
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
    
    
    @IBAction func correctNumberButton(_ sender: UIButton?) {
        
        let numberOfDrinks = abs(5 - attemptsCounter) + 1
        
        if (attemptsCounter <= 5){
            displayAlert(title: "DRINK UP!", message: "You must take \(numberOfDrinks) drink(s)")
        }
        
        else{
            displayAlert(title: "YOU WIN", message: "Pick someone to take \(numberOfDrinks) drink(s) and pass the phone")
        }
    }
    
    
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
    }
    

    func displayAlert (title:String, message:String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction.init(title: "OK", style: .default , handler: resetButton(_:)))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func playSound(){
        let soundURL = Bundle.main.url(forResource: "stoneSound", withExtension: "mp3")
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL!)
        }
        catch{
            print(error)
        }
        
        audioPlayer.play()
    }
    
    
    
    @IBAction func startedEditing(_ sender: UITextField) {
        
        userGuess.text = ""
        
    }
    
    
    @IBAction func setEditableOff(_ sender: UITextField) {
        
        
        userGuess.isUserInteractionEnabled = false
    }
}

