//
//  ViewController.swift
//  Flashcards
//
//  Created by Jalen Springfield on 10/13/18.
//  Copyright © 2018 Jalen Springfield. All rights reserved.
//

import UIKit

struct Flashcard {
    var question: String
    var answer: String
}
class ViewController: UIViewController {

    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    //Array to hold flashcards
    var flashcards = [Flashcard]()
    var currentIndex = 0
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        
        let creationController = navigationController.topViewController as! CreationViewController
        
        creationController.flashcardsController = self
        
    }
    @IBAction func didTapOnPrev(_ sender: Any) {
        currentIndex = currentIndex - 1
        updateLabels()
        updateNextPrevButtons()
    }
    
    @IBAction func didTapOnNext(_ sender: Any) {
        currentIndex = currentIndex + 1
        updateLabels()
        updateNextPrevButtons()
    }
    
    @IBAction func didTapOnFlashcard(_ sender: Any) {
        if(frontLabel.isHidden)
        {
            frontLabel.isHidden = false
        }
        else if(!frontLabel.isHidden)
        {
        frontLabel.isHidden = true
        }
        print(frontLabel.isHidden)
    }
    func updateLabels() {
        let currentFlashcard = flashcards[currentIndex]
        frontLabel.text = currentFlashcard.question
        backLabel.text = currentFlashcard.answer
    }
    func updateNextPrevButtons() {
        if currentIndex == flashcards.count - 1
        {
            nextButton.isEnabled = false
        }
        else
        {
            nextButton.isEnabled = true
        }
        if currentIndex == 0
        {
            prevButton.isEnabled = false
        }
        else
        {
            prevButton.isEnabled = true
        }
    }
    func saveAllFlashcardsToDisk() {
        //from flashcard array to dictionary array
        let dictionaryArray = flashcards.map { (card) -> [String: String] in
            return ["question": card.question, "answer": card.answer]
        }
        //Save array on disk using UserDefaults
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        //log it
        print("✅ Flashcards saved to UserDefaults")
    }
    func readSavedFlashcards() {
        //Read dictionary array from disk (if any)
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String: String]] {
            //in here we know for sure we have a dictionary array
            let savedCards = dictionaryArray.map {dictionary -> Flashcard in
                return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!)
            }
            //put all cards in flashcards array
            flashcards.append(contentsOf: savedCards)
        }
    }
    func updateFlashcard(question: String, answer: String) {
        let flashcard = Flashcard(question: question, answer: answer)
        flashcards.append(flashcard)
        
        //logging to console
        print("😄 added new flashcard")
        print("😎 We now have \(flashcards.count) flashcards")
        //get current index
        currentIndex = flashcards.count - 1
        print("🤓 Our current index is \(currentIndex)")
        //update buttons
        updateNextPrevButtons()
        //update labels
        updateLabels()
        //save current array of flashcards to disk
        saveAllFlashcardsToDisk()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        readSavedFlashcards()
        //adding initial flashcard if needed
        if flashcards.count == 0
        {
        updateFlashcard(question: "What's the capital of Brazil?", answer: "Brasilia")
        }
        else
        {
            updateLabels()
            updateNextPrevButtons()
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

