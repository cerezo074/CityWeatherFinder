//
//  View+.swift
//  WeatherApp
//
//  Created by Eli Pacheco Hoyos on 20/01/25.
//

import SwiftUI

extension View {
    func customFont(_ font: PoppinsFont, size: CGFloat) -> some View {
        self.modifier(PoppinsFontModifier(font: font, size: size))
    }
}
