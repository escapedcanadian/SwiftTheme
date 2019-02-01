//
//  ThemeManager+Plist.swift
//  SwiftTheme
//
//  Created by Gesen on 16/9/18.
//  Copyright © 2016年 Gesen. All rights reserved.
//

import UIKit

@objc extension ThemeManager {
    
    public class func value(for keyPath: String, depth: Int = 1) -> Any? {
        guard depth < 10 else {
            print("SwiftTheme WARNING: Possible recursive reference for: \(keyPath)")
            return nil
        }
        var searchString: String?
        if keyPath.hasPrefix("$") {
            searchString = String(keyPath.dropFirst())
        } else {
            searchString = keyPath
        }
        guard searchString != nil else {
            print("SwiftTheme WARNING: Did not find value at key path: \(keyPath)")
            return nil
        }
        let firstFound = currentTheme?.value(forKeyPath: searchString!)
        if let firstFoundString = firstFound as? String {
            if firstFoundString.hasPrefix("$") {
                return value(for: String(firstFoundString.dropFirst()), depth: (depth + 1))
            }
        }
        return firstFound
    }
    
    public class func string(for keyPath: String) -> String? {
        guard let string = ThemeManager.value(for: keyPath) as? String else {
            print("SwiftTheme WARNING: Did not find a string at key path: \(keyPath)")
            return nil
        }
        return string
    }
    
    public class func number(for keyPath: String) -> NSNumber? {
        
        guard let number = ThemeManager.value(for: keyPath) as? NSNumber else {
            print("SwiftTheme WARNING: Not found number key path: \(keyPath)")
            return nil
        }
        return number
    }
    
    public class func dictionary(for keyPath: String) -> NSDictionary? {
        guard let dict = ThemeManager.value(for: keyPath) as? NSDictionary else {
            print("SwiftTheme WARNING: Not found dictionary key path: \(keyPath)")
            return nil
        }
        return dict
    }
    
    public class func color(for keyPath: String) -> UIColor? {
        var rgba: String?
        if keyPath.hasPrefix("#") {
            rgba = keyPath
        } else {
            rgba = string(for: keyPath)
        }
        guard rgba != nil else {return nil}
        guard let color = try? UIColor(rgba_throws: rgba!) else {
            print("SwiftTheme WARNING: Not convert rgba \(rgba!) at key path: \(keyPath)")
            return nil
        }
        return color
    }
    
    public class func image(for keyPath: String) -> UIImage? {
        guard let imageName = string(for: keyPath) else { return nil }
        if let filePath = currentThemePath?.URL?.appendingPathComponent(imageName).path {
            guard let image = UIImage(contentsOfFile: filePath) else {
                print("SwiftTheme WARNING: Not found image at key path: \(keyPath)")
                return nil
            }
            return image
        } else {
            guard let image = UIImage(named: imageName) else {
                print("SwiftTheme WARNING: Not found image name at main bundle: \(imageName)")
                return nil
            }
            return image
        }
    }
    
    public class func textAttributes(for keyPath: String) -> [NSAttributedString.Key : AnyObject]? {
        guard let rawAttributes = dictionary(for: keyPath) else {
            print("SwiftTheme WARNING: Did not find attributes dictionary at key path: \(keyPath)")
            return nil
        }
        
        return ThemeManager.textAttributes(from: rawAttributes as! [String: Any])
    }
    
    public class func textAttributes(from rawAttributes: [String: Any]) -> [NSAttributedString.Key : AnyObject]? {

        var titleTextAttributes = [NSAttributedString.Key : AnyObject]()
        for (keyString, value) in rawAttributes {
               switch keyString {
                case "foregroundColor":
                    if let colorString = value as? String {
                        if let color = color(for: colorString) {
                            titleTextAttributes[NSAttributedString.Key.foregroundColor] = color
                        }
                    } else {
                        print("SwiftTheme WARNING: Could not decode foreground color from source: \(String(describing: rawAttributes))")
                    }
                case "backgroundColor":
                    if let colorString = value as? String {
                        if let color = color(for: colorString) {
                            titleTextAttributes[NSAttributedString.Key.backgroundColor] = color
                        }
                    } else {
                        print("SwiftTheme WARNING: Could not decode background color from source: \(String(describing: rawAttributes))")
                    }
              case "fontSize":
                    var fontSize: NSNumber?
                    if let directSize = value as? NSNumber {
                        fontSize = directSize
                    }
                    if let fontString = value as? String {
                        fontSize = ThemeManager.number(for: fontString)
                    }
                    if fontSize == nil {
                        print("SwiftTheme WARNING: Unable to detect font size from source: \(String(describing: rawAttributes))")
                    } else {
                        titleTextAttributes[NSAttributedString.Key.font] = UIFont.systemFont(ofSize: CGFloat.init(truncating: fontSize!))
                    }
                default:
                    print("SwiftTheme WARNING: unrecognized text attribute key: \(keyString) from source: \(String(describing: rawAttributes))")
                }

        }
         return titleTextAttributes
    }
    
}
