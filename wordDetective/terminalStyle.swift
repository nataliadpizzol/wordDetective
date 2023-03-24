// code based on the implementation by @ColorizeSwift available at: https://github.com/mtynior/ColorizeSwift

import Foundation

public typealias TerminalStyleCode = (open: String, close: String)

public struct TerminalStyle {
    public static let bold: TerminalStyleCode            = ("\u{001B}[1m", "\u{001B}[22m")
    public static let reset: TerminalStyleCode           = ("\u{001B}[0m", "")
    public static let green: TerminalStyleCode           = ("\u{001B}[32m", "\u{001B}[0m")
    public static let onRed: TerminalStyleCode           = ("\u{001B}[41m", "\u{001B}[0m")
    public static let onGreen: TerminalStyleCode         = ("\u{001B}[42m", "\u{001B}[0m")
    public static let onYellow: TerminalStyleCode        = ("\u{001B}[43m", "\u{001B}[0m")
}

extension String {
    public static var isColorizationEnabled = true // Enables/disables colorization

    public func bold() -> String {
        return applyStyle(TerminalStyle.bold)
    }

    public func reset() -> String {
        guard String.isColorizationEnabled else { return self }
        return  "\u{001B}[0m" + self
    }
    
    public func foregroundColor(_ color: TerminalColor) -> String {
        return applyStyle(color.foregroundStyleCode())
    }
    
    public func backgroundColor(_ color: TerminalColor) -> String {
        return applyStyle(color.backgroundStyleCode())
    }
    
    public func colorize(_ foreground: TerminalColor, background: TerminalColor) -> String{
        return applyStyle(foreground.foregroundStyleCode()).applyStyle(background.backgroundStyleCode())
    }
    
    public func uncolorized() -> String {
        guard let regex = try? NSRegularExpression(pattern: "\\\u{001B}\\[([0-9;]+)m") else { return self }
        
        return regex.stringByReplacingMatches(in: self, options: [], range: NSRange(0..<self.count), withTemplate: "")
    }
    
    private func applyStyle(_ codeStyle: TerminalStyleCode) -> String {
        guard String.isColorizationEnabled else { return self }
        let str = self.replacingOccurrences(of: TerminalStyle.reset.open, with: TerminalStyle.reset.open + codeStyle.open)
        
        return codeStyle.open + str + TerminalStyle.reset.open
    }
}

extension String {
    public func green() -> String {
        return applyStyle(TerminalStyle.green)
    }

    public func onRed() -> String {
        return applyStyle(TerminalStyle.onRed)
    }
    
    public func onGreen() -> String {
        return applyStyle(TerminalStyle.onGreen)
    }
    
    public func onYellow() -> String {
        return applyStyle(TerminalStyle.onYellow)
    }
}

public enum TerminalColor: UInt8 {
    case black = 0
    
    public func foregroundStyleCode() -> TerminalStyleCode {
        return ("\u{001B}[38;5;\(self.rawValue)m", TerminalStyle.reset.open)
    }
    
    public func backgroundStyleCode() -> TerminalStyleCode {
        return ("\u{001B}[48;5;\(self.rawValue)m", TerminalStyle.reset.open)
    }
}
