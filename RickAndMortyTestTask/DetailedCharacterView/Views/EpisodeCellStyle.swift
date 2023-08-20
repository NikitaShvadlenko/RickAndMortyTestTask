//
//  CardStyle.swift
//  RickAndMortyTestTask
//
//  Created by Nikita Shvad on 20.08.2023.
//  Copyright © 2023 Nikita Shvadlenko. All rights reserved.
//

import SwiftUI

struct CellModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .fixedSize(horizontal: false, vertical: true)
            .background(Color(asset: Asset.blackCard))
            .cornerRadius(16)
    }
}

extension View {
    func cellStyle() -> some View {
        modifier(CellModifier())
    }
}
