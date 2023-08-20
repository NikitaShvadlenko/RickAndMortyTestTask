//
//  TitleModifier.swift
//  RickAndMortyTestTask
//
//  Created by Nikita Shvad on 20.08.2023.
//  Copyright © 2023 Nikita Shvadlenko. All rights reserved.
//

import SwiftUI

struct TitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 17, weight: .semibold))
            .foregroundColor(Color(asset: Asset.white))
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(TitleModifier())
    }
}
