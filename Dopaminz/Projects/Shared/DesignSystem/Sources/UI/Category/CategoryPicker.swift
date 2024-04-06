//
//  CategoryPicker.swift
//  DesignSystem
//
//  Created by 이승기 on 4/6/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import SwiftUI
import Model

public struct CategoryPicker: View {
    
    // MARK: - Properties
    
    @Binding var categories: [PollCategory]
    private var columns: [GridItem] = Array(repeating: .init(.adaptive(minimum: 138, maximum: .infinity), spacing: 14), count: 2)
    
    
    // MARK: - Initializer
    
    public init(categories: Binding<[PollCategory]>) {
        _categories = categories
    }
    
    
    // MARK: - Views
    
    public var body: some View {
        LazyVGrid(columns: columns, spacing: 14) {
            ForEach(PollCategory.allCases, id: \.self) { category in
                CategoryItem(
                    category: category,
                    isSelected: categories.contains(category)) { isSelected in
                        if isSelected {
                            categories.append(category)
                        } else {
                            if let index = categories.firstIndex(of: category) {
                                categories.remove(at: index)
                            }
                        }
                    }
            }
        }
    }
}
