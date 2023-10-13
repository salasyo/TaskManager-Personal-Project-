//
//  Color.swift
//  SwfiftfulCrypto
//
//  Created by Obi on 8/1/23.
//

import Foundation
import SwiftUI

extension Color {
    
    static let theme = ColorTheme() // change color theme # test multipple color schemes
    static let launch = LaunchTheme()
}

struct ColorTheme {
    
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let green = Color("GreenColor")
    let red = Color("RedColor")
    let secondaryText = Color("SecondaryTextColor")

}

// add multiple color schemes with structs and color literals
struct ColorTheme2 {
    
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let green = Color("GreenColor")
    let red = Color("RedColor")
    let secondaryText = Color("SecondaryTextColor")

}

struct LaunchTheme {
    
    let accent = Color("LaunchAccentColor")
    let background = Color("LaunchBackgroundColor")
    
}
