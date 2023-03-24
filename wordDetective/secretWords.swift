import Foundation

struct SecretWords {
    
    // function that returns a random word from the english words list
    func randomWordEn() -> String {
        return wordListEn.randomElement()!
    }
    
    // function that returns a random word from the portuguese words list
    func randomWordPt() -> String {
        return wordListPt.randomElement()!
    }
}

