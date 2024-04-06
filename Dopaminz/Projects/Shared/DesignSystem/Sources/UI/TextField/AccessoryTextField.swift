//
//  AccessoryTextField.swift
//  DesignSystem
//
//  Created by 이승기 on 4/6/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import SwiftUI

public struct AccessoryTextField: View {
    
    // MARK: - Properties
    
    @Binding var text: String
    private var headerText: String
    private var placeholder: String
    private var validText: String
    private var inValidText: String
    private var validationHandler: (() -> Bool)?
    
    
    // MARK: - Initializers
    
    public init(
        text: Binding<String>,
        headerText: String = "",
        placeholder: String = "",
        validText: String = "",
        inValidText: String = "",
        validationHandler: (() -> Bool)? = nil
    ) {
        _text = text
        self.headerText = headerText
        self.placeholder = placeholder
        self.validText = validText
        self.inValidText = inValidText
        self.validationHandler = validationHandler
    }
    
    
    // MARK: - Views
    
    public var body: some View {
        VStack(spacing: 8) {
            HStack {
                Text(headerText)
                    .font(.pretendardFontFamily(family: .SemiBold, size: 16))
                    .foregroundStyle(.black)
                
                Spacer()
            }
            
            TextField(
                "",
                text: $text,
                prompt: Text(placeholder).foregroundColor(.gray)
            )
            .font(.pretendardFontFamily(family: .Regular, size: 15))
            .frame(height: 48)
            .padding(.horizontal, 16)
            .padding(.trailing, validationHandler != nil ? 32 : 0)
            .overlay {
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color.gray)
            }
            .overlay {
                if let isValid = validationHandler {
                    HStack {
                        Spacer()
                        
                        if isValid() {
                            Image(asset: .circle_check)
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundStyle(Color.black)
                        } else {
                            Image(asset: .circle_exclamanation)
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundStyle(Color.red)
                        }
                    }
                    .padding(.horizontal, 14)
                }
            }
            
            if let isValid = validationHandler {
                HStack {
                    if isValid() {
                        Text(validText)
                            .font(.pretendardFontFamily(family: .Regular, size: 12))
                            .foregroundStyle(Color.black)
                    } else {
                        Text(inValidText)
                            .font(.pretendardFontFamily(family: .Regular, size: 12))
                            .foregroundStyle(Color.red)
                    }
                    
                    Spacer()
                }
            }
        }
    }
}

