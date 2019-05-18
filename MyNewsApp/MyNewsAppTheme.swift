//
//  MyNewsAppTheme.swift
//  MyNewsApp
//
//  Created by Ashish Tripathi on 11/5/19.
//  Copyright © 2019 Ashish Tripathi. All rights reserved.
//

import UIKit

class MyNewsAppTheme: Appearance {
    var color: Colors = MyNewsColors()
    var font: Font = MyNewsFonts()
}

struct MyNewsColors: Colors {
    var basicColor: BasicColors = MyNewsBasicColors()
}

struct MyNewsFonts: Font {
    var basicFont: BasicFonts = MyNewsBasicFont()
}

struct MyNewsBasicColors: BasicColors {
    var title = UIColor.black
    var body = UIColor.blue
}

struct MyNewsBasicFont: BasicFonts {
    var footer = UIFont.preferredFont(forTextStyle: .footnote)
    var title = UIFont.preferredFont(forTextStyle: .title3)
    var body = UIFont.preferredFont(forTextStyle: .body)
}
