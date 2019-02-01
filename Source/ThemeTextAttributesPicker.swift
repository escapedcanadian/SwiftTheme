//
//  ThemeTextAttributesPicker.swift
//  SwiftTheme
//
//  Created by David Brown on 1/31/19.
//  Copyright © 2019 Gesen. All rights reserved.
//


import Foundation

@objc public final class ThemeTextAttributePicker: ThemePicker {
    
    public convenience init(keyPath: String) {
        self.init(v: { ThemeManager.textAttributes(for: keyPath) })
    }
    
//    public convenience init(dicts: [String: Any]...) {
//        self.init(v: { ThemeManager.textAttributes(from: dicts) })
//    }
//
//    public required convenience init(arrayLiteral elements: [String: Any]...) {
//        self.init(v: { ThemeManager.element(for: elements) })
//    }
    
}

@objc public extension ThemeTextAttributePicker {
    
//    class func pickerWithKeyPath(_ keyPath: String, map: @escaping (Any?) -> [String: AnyObject]?) -> ThemeDictionaryPicker {
//        return ThemeTextAttributePicker(v: { map(ThemeManager.value(for: keyPath)) })
//    }
//
//    class func pickerWithKeyPath(_ keyPath: String, mapAttributes: @escaping (Any?) -> [NSAttributedString.Key: AnyObject]?) -> ThemeDictionaryPicker {
//        return ThemeTextAttributePicker(v: { mapAttributes(ThemeManager.value(for: keyPath)) })
//    }
//
//    class func pickerWithDicts(_ dicts: [[String: AnyObject]]) -> ThemeDictionaryPicker {
//        return ThemeTextAttributePicker(v: { ThemeManager.element(for: dicts) })
//    }
//
//    class func pickerWithAttributes(_ attributes: [[NSAttributedString.Key: AnyObject]]) -> ThemeDictionaryPicker {
//        return ThemeTextAttributePicker(v: { ThemeManager.element(for: attributes) })
//    }
    
}

//extension ThemeTextAttributePicker: ExpressibleByArrayLiteral {}
