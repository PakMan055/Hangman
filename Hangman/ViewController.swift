//
//  ViewController.swift
//  Hangman
//
//  Created by Roman Pak on 30.05.2023.
//

import Foundation


var words: [String: String] = ["apple": "Всеми нами любимый бренд", "cupertino": "Где находится штаб квартира компании Apple" , "wayne": "Один из основателей Apple computers", "pixar": "Какую компанию приобрел Стив Джобс в 1986", "macintosh": "Персональный компьютер компании Apple выпущенный 1984г", "motorola": "Процессоры какой компании использовались первое время в компьютерах Apple"]

func randomWord() -> [String: String]? {
    if let randomKey = Array(words.keys).randomElement(),  let randomHint = words[randomKey] {
        return [randomKey: randomHint]
    }
    return nil
}

func hideWord(word: String, symbols: [String]) -> String {
    return String(word.map { element in
        if symbols.contains(String(element)) {
            return element
        } else {
            return "_"
        }
    })
}

func drawHangman() {
        let hangmanParts = ["   ___", "  |   |", "  |   O", "  |  /|\\", "  |  / \\", " _|_"]
        for i in 0..<incorrectGuesses {
            print(hangmanParts[i])
        }
    }
// Programm starts here
var guessWord = randomWord()!
var incorrectGuesses = 0
var maxIncorrectGuesses = 6
var guessedLetters = [String]() //пустой массиф
var word = guessWord.keys.first!
var hint = guessWord.values.first!



print("Отгадайте слово из \(word.count) букв. \nПодсказка:",hint)

while incorrectGuesses < maxIncorrectGuesses {
    let hiddenWord = hideWord(word: word, symbols: guessedLetters)

    if !hiddenWord.contains("_") {
        print("Поздравляем, вы отгадали слово — \(word)!")
        break
    }
    print(hiddenWord)
    print("Введите букву: ")
    let inputLetter = readLine()?.lowercased() ?? "_"
    guessedLetters.append(inputLetter)

    if word.contains(inputLetter) {
        print("Вы угадали, есть такая буква!")
    } else {
        incorrectGuesses += 1
        let triesLeft = maxIncorrectGuesses - incorrectGuesses

        if triesLeft == 0 {
            print()
            print("Ну все, братишь, тебя повесили. Загаданное слово: \(word)")
            print(drawHangman())
            break
        }
        print()
        print("Такой буквы нет. У вас осталось \(triesLeft) попыток")
        print(drawHangman())
    }
}
