import Foundation

struct Game {
    let wordSize = 5
    let translation = Translation(language: selectLanguage())
    
    enum GuessFeedback { // returns a feedback for each letter the user input
        case correctPlacement
        case incorrectPlacement
        case incorrectLetter
    }
    
    func readInput() -> String {
        repeat {
            if let input = readLine()?.replacing(" ", with: "") { // excludes empty spaces from the 5 char limit, preventing empty space at the end of the line to cause an error
                if input.count == wordSize {
                    return input.lowercased()
                } else {
                    print(translation.translate(text: .errorLength))
                }
            } else {
                print(translation.translate(text: .errorReading))
            }
        } while true
    }

    func compareWords(secretWord: String, input: String) -> [GuessFeedback] { // Function that compares the secret word with the word entered by the user
        var result: [GuessFeedback] = []
        
        for (char1, char2) in zip(secretWord, input) { //checks if chars are equal
            result.append(char1 == char2 ? GuessFeedback.correctPlacement : GuessFeedback.incorrectLetter)
        }
        
        let inputArr = Array(input)
        let secretWordArr = Array(secretWord)
        let positions = secretWordArr.indices.filter { result[$0] ==  GuessFeedback.incorrectLetter } // indexes of secret word that did not have a match with the secret word
        let wrongLetters = positions.map {secretWordArr[$0]} // creates a list of words that did not have a match
        var ocurrences = Dictionary(zip(wrongLetters, repeatElement(1, count: Int.max)), uniquingKeysWith: +) // constructs a dict with letters without match and how many times they appeared on the word
        for i in 0 ..< input.count {
            if (result[i] == GuessFeedback.incorrectLetter && ocurrences.keys.contains(inputArr[i]) && ocurrences[inputArr[i]]! > 0 ) {
                result[i] = GuessFeedback.incorrectPlacement
                ocurrences[inputArr[i]]! -= 1
            }
        }
        
        return result
    }
    
    func printFeedback(word: String, feedback: [GuessFeedback]){
        for (char, charFeedback) in zip(word,feedback) {
            switch charFeedback {
            case .correctPlacement: print(" \(char) ".onGreen(),terminator: "")
            case .incorrectLetter: print(" \(char) ".onRed(),terminator: "")
            case .incorrectPlacement: print(" \(char) ".onYellow(),terminator: "")
            }
        }
        print("")
    }
    
    func onboarding() { // prints game onboarding and tutorial
        
        print(translation.translate(text: .gameDescription))
        print(translation.translate(text: .tutorialGuess))
        
        print(translation.translate(text: .word)) //print word
        
        print(translation.translate(text: .tutorialFeedback))
        printFeedback(word: translation.translate(text: .word), feedback: compareWords(secretWord: "truss", input: translation.translate(text: .word)))
        
        print(translation.translate(text: .tutorialTurns))
        if translation.language == .en {
            printFeedback(word: "short", feedback: compareWords(secretWord: "truss", input: "short"))
            printFeedback(word: "rests", feedback: compareWords(secretWord: "truss", input: "rests"))
            printFeedback(word: "turns", feedback: compareWords(secretWord: "truss", input: "turns"))
            printFeedback(word: "tours", feedback: compareWords(secretWord: "truss", input: "tours"))
            printFeedback(word: "truss", feedback: compareWords(secretWord: "truss", input: "truss"))
        } else {
            printFeedback(word: "livro", feedback: compareWords(secretWord: "jogar", input: "livro"))
            printFeedback(word: "forma", feedback: compareWords(secretWord: "jogar", input: "forma"))
            printFeedback(word: "juros", feedback: compareWords(secretWord: "jogar", input: "juros"))
            printFeedback(word: "lugar", feedback: compareWords(secretWord: "jogar", input: "lugar"))
            printFeedback(word: "jogar", feedback: compareWords(secretWord: "jogar", input: "jogar"))
        }
    }
    
    func playGame() {
        var turns: Int = 0
        var input: String
        let numMaxTentativa = 5
        let secretWord: String
        
        onboarding()
        
        if translation.language == .en {
            secretWord = SecretWords().randomWordEn()
        } else {
            secretWord = SecretWords().randomWordPt()
            
        }
        
        print(translation.translate(text: .okLetsPlay))
        
        repeat {
            input = self.readInput()
            let result = compareWords(secretWord: secretWord, input: input)
            printFeedback(word: input, feedback: result)
            if result.allSatisfy({ $0 == GuessFeedback.correctPlacement }) {
                print(translation.translate(text: .victory))
                return
            }
            print(translation.translate(text: .youHave) + "\(numMaxTentativa - turns)" + translation.translate(text: .turnsLeft))
            turns += 1
        } while turns < 6
        print(translation.translate(text: .gameOver) + "\(secretWord)'.".bold())
    }
}

