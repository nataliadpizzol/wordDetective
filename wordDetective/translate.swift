import Foundation

//variables to create colored squares
var green: String = "  ".onGreen()
var yellow: String = "  ".onYellow()
var red: String = "  ".onRed()


enum Languages {
    case pt
    case en
}

enum Text { // defines enum the prints used
    case errorLength
    case okLetsPlay
    case errorMessage
    case errorReading
    case gameDescription
    case tutorialGuess
    case tutorialFeedback
    case tutorialTurns
    case gameOver
    case victory
    case youHave
    case turnsLeft
    case word
}

// dict with portuguese translations
let ptTranslations = [
    Text.errorLength: "A palavra precisa ter 5 caractéres",
    Text.okLetsPlay: "\nOk, vamos jogar! Escreva uma palavra: \n",
    
    
    Text.errorReading: "Aconteceu um erro na leitura, tente novamente!",
    
    Text.gameDescription: "\nVocê terá a oportunidade de testar seu vocabulário e habilidades de adivinhação tentando adivinhar uma palavra secreta de cinco letras.\n",
    
    Text.tutorialGuess: "Veja como jogar: \n1. Adivinhe uma palavra de cinco letras. Por exemplo: \n",
    
    Text.tutorialFeedback:"\n2. Após cada palpite, você receberá um feedback sobre quais letras estão:\n\(green) na posição correta \n\(yellow) presentes na palavra, mas não na posição correta \n\(red) não estão presentes na palavra. \nPor exemplo: \n",
    
    Text.tutorialTurns: "\n3. Continue adivinhando até identificar corretamente a palavra ou até esgotar as tentativas.\nVocê tem seis tentativas para adivinhar a palavra secreta.\n",
    
    Text.victory: "\nParabéns, você adivinhou a palavra secreta! 🕵️ 🥳",
    Text.gameOver: "\nFim de jogo 😭.\nA palavra secreta era '",
    Text.youHave: "Você tem mais ",
    Text.turnsLeft: " tentativas.\n",
    Text.word: "livro"
]

//dict with english translations
let enTranslations = [
    Text.okLetsPlay: "\nOk, let's play! Guess a word:\n",
    Text.errorLength: "The word must be exactly 5 characters",
    Text.errorReading: "An error occurred while reading, please try again!",
    
    Text.gameDescription: "\nYou will have the opportunity to test your vocabulary and guessing skills by attempting to guess a secret five-letter word.\n",
    
    Text.tutorialGuess: "Here's how to play: \n1.Guess a five-letter word. For example:\n",
    
    Text.tutorialFeedback: "\n2. After each guess, you will receive feedback about which letters are: \n\(green) in the correct position \n\(yellow) present in the word but not in the correct position \n\(red) not present in the word at all. \nFor example:\n",
    
    Text.tutorialTurns: "\n3. Keep guessing until you have correctly identified the word or until you run out of attempts.\nYou have six attempts to guess the word correctly.\n",
    
    Text.victory: "\nCongrats, you guesses the secret word! 🕵️ 🥳",
    Text.gameOver: "\nGame Over 😭.\nThe secret word was '",
    Text.youHave: "You have ",
    Text.turnsLeft: " tries left.",
    Text.word: "short"
]


struct Translation { //return text translatuion based on user prefered language
    let language: Languages
    
    func translate(text: Text) -> String {
        switch language {
        case .pt: return ptTranslations[text] ?? ""
        case .en: return enTranslations[text] ?? ""
        }
    }
}

func selectLanguage() -> Languages { //ask user to select language
    var language: Languages = .en
    print("Welcome! Type 1 to play in English or 2 for Portuguese.")
    print("Bem-vindo! Digite 1 para jogar em Inglês ou 2 para Português.")
    var inputLanguage = readLine()
            
    while inputLanguage != "1" && inputLanguage != "2" {
        print("An error occurred, please type 1 to play in English or 2 for Portuguese. \nAconteceu um erro, por favor digite 1 para jogar em Inglês ou 2 para Português.")
        inputLanguage = readLine()
    }
    
    if inputLanguage == "1" {
        language = .en
    } else if inputLanguage == "2" {
        language = .pt
    }
    return language
}
