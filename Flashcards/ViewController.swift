//
//  ViewController.swift
//  Flashcards
//
//  Created by Jalen Springfield on 10/13/18.
//  Copyright © 2018 Jalen Springfield. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        
        let creationController = navigationController.topViewController as! CreationViewController
        
        creationController.flashcardsController = self
        
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
    func updateFlashcard(question: String, answer: String) {
        frontLabel.text = question
        backLabel.text = answer
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

