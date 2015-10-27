//
//  ViewController.swift
//  Hangman
//
//  Created by Gene Yoo on 10/13/15.
//  Copyright © 2015 cs198-ios. All rights reserved.
//

import UIKit

class HangmanViewController: UIViewController {
    @IBOutlet weak var hangmanState: UIImageView!
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var guessField: UITextField!
    @IBOutlet weak var guessButton: UIButton!
    @IBOutlet weak var guessesLabel: UILabel!
    @IBOutlet weak var wordLabel: UILabel!
    var game: Hangman!
    
    
    override func viewDidLoad() {
        game = Hangman()
        game.start()
        hangmanState.image = UIImage(named: "hangman1")
        wordLabel.text = game.knownString
        hangmanState.accessibilityHint = "0 incorrect guesses"
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func newGame(sender: AnyObject) {
        game = Hangman()
        game.start()
        hangmanState.image = UIImage(named: "hangman1")
        wordLabel.text = game.knownString
        game.incorrectGuesses = 0
        guessesLabel.text = ""
        hangmanState.accessibilityHint = "0 incorrect guesses"
    }
    
    func displayAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in }
        alertController.addAction(OKAction)
        self.presentViewController(alertController, animated: true) {}
    }
    
    @IBAction func makeGuess(sender: AnyObject) {
        if game.incorrectGuesses >= 6 {
            displayAlert("Game Over", message: "You've reached the maximum number of guesses. Please press New Game")
            return
        }
        if guessField.text!.characters.count != 1 {
            displayAlert("Invalid Entry", message: "Please only entred one character")
            return
        }
        if game.guessLetter((guessField.text?.uppercaseString)!) {
            guessesLabel.text = game.guesses()
            wordLabel.text = game.knownString
            if !game.knownString!.containsString("_") {
                displayAlert("You Won!", message: "To start a new game, press New Game")
            }
        } else {
            guessesLabel.text = game.guesses()
            var imageTitle = "hangman" + (game.incorrectGuesses+1).description
            hangmanState.accessibilityHint = game.incorrectGuesses.description + " incorrect guesses"
            if game.incorrectGuesses >= 6 {
                displayAlert("Game Over", message: "You've reached the maximum number of guesses. Please press New Game")
                imageTitle = "hangman7"
                hangmanState.accessibilityHint = "6 incorrect guesses"
            }
            hangmanState.image = UIImage(named: imageTitle)
        }
    }
}

