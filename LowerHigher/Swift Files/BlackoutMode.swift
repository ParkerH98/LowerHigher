//
//  MainMenu.swift
//  LowerHigher
//
//  Created by Parker Hague on 3/19/20.
//  Copyright © 2019 Parker Hague. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation


class BlackoutMode: UIViewController, AVAudioPlayerDelegate{
    
     
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        
        view.addGestureRecognizer(tap)
        
        randomNumber = Int.random(in: lowerBound ... upperBound)
        divideNumber = randomNumber
        randomGenNumber.text = String(randomNumber)
    }
    
    
    
    var attemptsCounter = 0
    var upperBound = 100
    var lowerBound = 0
    var randomNumber = 0
    var divideNumber = 0
    var audioPlayer : AVAudioPlayer!
    
    
    
    @IBOutlet weak var attemptsLabel: UILabel!
    @IBOutlet weak var attemptsCount: UILabel!
    @IBOutlet weak var randomGenNumber: UILabel! // random generated number to eval. against
    @IBOutlet weak var userNumber: UITextField! // what number the user picks
    
    /**
    
    
    @IBAction func higherButton(_ sender: Any) {
        
        playSound()
        
        let userGuessNum = Int(userNumber.text!) ?? 0
        let randomNum = Int(randomGenNumber.text!) ?? 0
        
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
            
        divideNumber = Int.random(in: lowerBound ... upperBound)
        //divideNumber = ((upperBound - lowerBound) / 2) + lowerBound
            
        randomGenNumber.text = String(divideNumber)
        
        attemptsCounter += 1
        attemptsCount.text = String(attemptsCounter) + " / 5"
        
        if (userNumber.text == randomGenNumber.text){
            
                   correctNumberButton(nil)
        }
    }
    
    
    @IBAction func lowerButton(_ sender: Any) {
        
        playSound()
        
        let userGuessNum = Int(userNumber.text!) ?? 0
        let randomNum = Int(randomGenNumber.text!) ?? 0
        
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
          
        divideNumber = Int.random(in: lowerBound ... upperBound)
        //divideNumber = ((upperBound - lowerBound) / 2) + lowerBound
            
        randomGenNumber.text = String(divideNumber)
        
        attemptsCounter += 1
        attemptsCount.text = String(attemptsCounter) + " / 5"
        
        if (userNumber.text == randomGenNumber.text){
            correctNumberButton(nil)
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
        randomGenNumber.text = String(randomNumber)
        attemptsCount.text = String(attemptsCounter) + " / 5"
        userNumber.becomeFirstResponder()
        userNumber.text = "Play Again"
        userNumber.isUserInteractionEnabled = true
    }
    
    
    func correctNumberButton(_ sender: UIButton?) {
        
        let drinkUpperBound = abs(5 - attemptsCounter) + 3
        
        let numberOfDrinks = Int.random(in: 3 ... drinkUpperBound)
        
        if (attemptsCounter <= 5){
            displayAlert(title: "DRINK UP!", message: "You must take \(numberOfDrinks) drink(s)")
        }
        
        else{
            displayAlert(title: "YOU WIN", message: "Pick someone to take \(numberOfDrinks) drink(s) and pass the phone")
        }
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
    
    
    @IBAction func editingDidBegin(_ sender: Any) {
        
        userNumber.text = ""
    }
    
    
    @IBAction func editingDidEnd(_ sender: Any) {
        
        userNumber.isUserInteractionEnabled = false
    }
 */
}
