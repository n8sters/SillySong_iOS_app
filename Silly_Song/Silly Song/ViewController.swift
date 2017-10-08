//
//  ViewController.swift
//  Silly Song
//
//  Created by Nate Powers on 10/8/17.
//  Copyright © 2017 Nate Powers. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!

    @IBOutlet weak var lyricsView: UITextView!
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    // reset the text in our views
    @IBAction func reset(_ sender: Any) {
        lyricsView.text = ""
        nameField.text = ""
    }
    
    @IBAction func displayLyrics(_ sender: Any) {
        lyricsView.text! = lyricForName(bananaFanaTemplate, nameField.text!)
    }
    
}

// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}

// join an array of strings into a single template string:
let bananaFanaTemplate = [
    "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
    "Banana Fana Fo F<SHORT_NAME>",
    "Me My Mo M<SHORT_NAME>",
    "<FULL_NAME>"].joined(separator: "\n")

// returns a the substring of the name, split after the first vowel
func shortNameFromName(name : String ) -> String {
    
    var word = name.lowercased();
    // added special characteers for non-English names
    let vowels : [Character] = ["a","e","i","o","u","á","é","í", "ó", "ú","ä", "ë", "ï", "ö", "ü"]
    for ch in word.characters {
        if ( vowels.contains(ch)) {
            return word
        }
        word.removeFirst()
    }
    return name
}

// adds the name and short name to a lyrics template
func lyricForName(_ lyricsTemplate: String,_ fullName: String) -> String {
    let shortName = shortNameFromName(name: fullName)
    let lyrics = lyricsTemplate
        .replacingOccurrences(of: "<FULL_NAME>", with: fullName)
        .replacingOccurrences(of: "<SHORT_NAME>", with: shortName)
    return lyrics
}


