//
//  ViewController.swift
//  Coats_WordGuess
//
//  Created by Logan Coats on 10/16/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var wordsGuessedLabel: UILabel!
    @IBOutlet weak var wordsRemainingLabel: UILabel!
    @IBOutlet weak var wordsMissedLabel: UILabel!
    @IBOutlet weak var totalWordsLabel: UILabel!
    @IBOutlet weak var userGuessLabel: UILabel!
    @IBOutlet weak var guessLetterField: UITextField!
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var guessCountLabel: UILabel!
    @IBOutlet weak var guessLetterButton: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    
    var words = [["APPLE","fruit"],["DOG","animal"],["SATURN","planet"],["CATFISH","aquatic"],["INSTANBUL","not constantinople"]]
    var count = 0
    var word = ""
    var lettersguessed = ""
    var missed = 0
    var guessed  = 0
    var wrongguessed = 0
    var guesses = 0
    let maxWrongGuesses = 10
    
    func wordTransition(){
        //change to next word, hint, update labels. update wrongguessed to 0
        count += 1
        wordsGuessedLabel.text =  "Words Guessed: \(guessed)"
        wordsRemainingLabel.text  = "Words Remaining: \(words.count-guessed-missed)"
        wordsMissedLabel.text = "Words Missed: \(missed)"
        guessLetterButton.isEnabled = false
        userGuessLabel.text = ""
        if(count == words.count){
            missed = 0
            guessed = 0
            wrongguessed = 0
            lettersguessed = ""
            guesses = 0
            guessCountLabel.text = "You have finished all words, please play again."
            count = -1
        }else{
            for letter  in words[count][0]{
                userGuessLabel.text! += "_ "
            }
            hintLabel.text = "Hint: " + words[count][1]
            playAgainButton.isHidden = true
            wrongguessed = 0
            guesses = 0
            lettersguessed = ""
            guessCountLabel.text = "You have guessed \(guesses) times."
        }
        
        
    }
    
    @IBAction func guessChanged(_ sender: UITextField) {
        //enable button if there is text in text box, if empty, disable.
        var text = guessLetterField.text!
                text = String(text.last ?? " ").trimmingCharacters(in: .whitespaces)
                guessLetterField.text = text
                
                if text.isEmpty{
                    guessLetterButton.isEnabled = false
                }
                else{
                    guessLetterButton.isEnabled = true
                }
    }
    @IBAction func guessLetterButtonPressed(_ sender: Any) {
        //if word complete, transition words and display congrats in guesscountlabel
        guesses += 1
        var olduserguess = userGuessLabel.text
        var letter = guessLetterField.text!
        lettersguessed = lettersguessed + letter
        var revealedWord = ""
        for l in words[count][0]{
            if lettersguessed.contains(l){
                revealedWord += "\(l)"
            }
            else{
                revealedWord += "_ "
            }
        }
        userGuessLabel.text = revealedWord
        if olduserguess == userGuessLabel.text{
            wrongguessed += 1
        }
        if wrongguessed == maxWrongGuesses{
            missed += 1
            playAgainButton.isHidden = false
            guessLetterButton.isEnabled = false
            guessLetterField.isEnabled = false
            guessCountLabel.text = "You have used all the available guesses, Please start again."
        }
        
        guessLetterField.text = ""
        guessLetterButton.isEnabled = false
        guessCountLabel.text = "You have guessed \(guesses) times."
        if userGuessLabel.text!.contains("_") == false{
            //maybe a timer? then call transitionwords
            guessed += 1
            //wordTransition()
            guessLetterButton.isEnabled = false
            guessLetterField.isEnabled = false
            playAgainButton.isHidden = false
            guessCountLabel.text = "You got it! You used \(guesses) to get the word."
        }
        
    }
    @IBAction func playAgainButtonPressed(_ sender: Any) {
        guessLetterButton.isEnabled = true
        guessLetterField.isEnabled = true
        wordTransition()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        wordsGuessedLabel.text =  "Words Guessed: \(guessed)"
        wordsRemainingLabel.text  = "Words Remaining: \(words.count)"
        wordsMissedLabel.text = "Words Missed: \(missed)"
        guessLetterButton.isEnabled = false
        userGuessLabel.text = ""
        for letter  in words{
            userGuessLabel.text! += "_ "
        }
        hintLabel.text = "Hint: " + words[count][1]
        playAgainButton.isHidden = true
        
        // Do any additional setup after loading the view.
    }


}

