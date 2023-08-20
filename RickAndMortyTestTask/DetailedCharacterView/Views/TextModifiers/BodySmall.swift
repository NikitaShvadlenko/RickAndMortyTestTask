//
//  BodySmall.swift
//  RickAndMortyTestTask
//
//  Created by Nikita Shvad on 20.08.2023.
//  Copyright © 2023 Nikita Shvadlenko. All rights reserved.
//

import SwiftUI

struct BodySmallModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 13))
            .foregroundColor(Color(asset: Asset.primary))
    }
}

extension View {
    func bodyStyle() -> some View {
        modifier(BodySmallModifier())
    }
}
