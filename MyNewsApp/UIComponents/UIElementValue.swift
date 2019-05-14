//
//  UIElementValue.swift
//  MyNewsApp
//
//  Created by Ashish Tripathi on 11/5/19.
//  Copyright © 2019 Ashish Tripathi. All rights reserved.
//

import UIKit

/// Used to create an object, which can be used to set value to a
/// UI object along with accessibility value and accessibility identifier.
public struct UIElementValue<T> {
    public var rawValue: T
    public var accessibilityValue: String?
    public var accessibilityIdentifier: String?
    public var accessibilityHint: String?
    public var accessibilityTraits: UIAccessibilityTraits?
    
    public init(rawValue: T,
                accessibilityValue: String? = nil,
                accessibilityIdentifier: String? = nil,
                accessibilityHint: String? = nil,
                accessibilityTraits: UIAccessibilityTraits? = nil) {
        self.rawValue = rawValue
        self.accessibilityValue = accessibilityValue
        self.accessibilityIdentifier = accessibilityIdentifier
        self.accessibilityHint = accessibilityHint
        self.accessibilityTraits = accessibilityTraits
    }
}
