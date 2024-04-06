//
//  CraatePollView.swift
//  Feature
//
//  Created by 서원지 on 4/7/24.
//  Copyright © 2024 Wonji suh. All rights reserved.
//

import SwiftUI
import DesignSystem
import Model

public struct CraatePollView: View {
    @State var showSelectCateogry: Bool = false
    @State private var showingDatePicker = false
    @State private var selectedCategory: PollCategory?
    @State private var title: String = ""
    @State private var content: String = ""
    @State private var vote1content: String = ""
    @State private var vote2content: String = ""
    @State private var selectedDate: Date = Date()
    @State private var selectedTime: Date = Date()
    @Environment(\.dismiss) var dismiss
    var viewModel: HomeRepository = HomeRepository()
    public init() {}
    public var body: some View {
        VStack {
            ScrollView {
                VStack {
                    Spacer()
                        .frame(height: 16)
                    
                  NavigationTitleButton(title: "한문장 법정") {
                    dismiss()
                  }
                    
                    Spacer()
                        .frame(height: 20)
                    
                    HStack {
                        Text("카테고리")
                            .pretendardFont(family: .SemiBold, size: 16)
                            .foregroundColor(Color.basicBlack)
                        
                        Spacer()
                        
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.gray50)
                            .frame(width: 54, height: 30)
                            .overlay {
                                if selectedCategory == selectedCategory {
                                    Text(selectedCategory?.desc ?? "")
                                        .pretendardFont(family: .SemiBold, size: 15)
                                        .foregroundColor(Color.basicBlack)
                                } else {
                                    Text("")
                                        .pretendardFont(family: .SemiBold, size: 15)
                                        .foregroundColor(Color.basicBlack)
                                }
                            }
                            .onTapGesture {
                                showSelectCateogry.toggle()
                            }
                        
                        Image(systemName: "chevron.right")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .foregroundColor(Color.gray50)
                    }
                    .padding(.horizontal, 20)
                    
                    HStack {
                        Text("내용")
                            .pretendardFont(family: .SemiBold, size: 16)
                            .foregroundColor(Color.basicBlack)
                        
                    Spacer()
                    }
                    .padding(.horizontal, 20)
                    
                    Spacer()
                        .frame(height: 8)
                    
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray200, style: .init(lineWidth: 1))
                        .frame(height: 70)
                        .padding(.horizontal, 20)
                        .overlay {
                            TextEditor(text: $title)
                                .pretendardFont(family: .SemiBold, size: 16)
                                .foregroundColor(.gray) // Adjust the color as needed
                                .padding(.horizontal, 30)
                                .frame(height: 60) // Specify a fixed height or use dynamic sizing
                                .multilineTextAlignment(.leading)
                                       
                        }
                    
                    
                    Spacer()
                        .frame(height: 16)
                    
                    HStack {
                        Text("내용")
                            .pretendardFont(family: .SemiBold, size: 16)
                            .foregroundColor(Color.basicBlack)
                        
                    Spacer()
                    }
                    .padding(.horizontal, 20)
                    
                    Spacer()
                        .frame(height: 8)
                    
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray200, style: .init(lineWidth: 1))
                        .frame(height: 197)
                        .padding(.horizontal, 20)
                        .overlay {
                            TextEditor(text: $content)
                                .pretendardFont(family: .SemiBold, size: 16)
                                .foregroundColor(.gray) // Adjust the color as needed
                                .padding(.horizontal, 30)
                                .frame(height: 187) // Specify a fixed height or use dynamic sizing
                                .multilineTextAlignment(.leading)
                                       
                        }
                    
                    Spacer()
                        .frame(height: 16)
                    
                    HStack {
                        Text("투표")
                            .pretendardFont(family: .SemiBold, size: 16)
                            .foregroundColor(Color.basicBlack)
                        
                    Spacer()
                    }
                    .padding(.horizontal, 20)
                    
                    Spacer()
                        .frame(height: 8)
                    
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray200, style: .init(lineWidth: 1))
                        .frame(height: 84)
                        .padding(.horizontal, 20)
                        .overlay {
                            TextEditor(text: $vote1content)
                                .pretendardFont(family: .SemiBold, size: 16)
                                .foregroundColor(.gray) // Adjust the color as needed
                                .padding(.horizontal, 30)
                                .frame(height: 74) // Specify a fixed height or use dynamic sizing
                                .multilineTextAlignment(.leading)
                                       
                        }
                    
                    Spacer()
                        .frame(height: 8)
                    
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray200, style: .init(lineWidth: 1))
                        .frame(height: 84)
                        .padding(.horizontal, 20)
                        .overlay {
                            TextEditor(text: $vote2content)
                                .pretendardFont(family: .SemiBold, size: 16)
                                .foregroundColor(.gray) // Adjust the color as needed
                                .padding(.horizontal, 30)
                                .frame(height: 74) // Specify a fixed height or use dynamic sizing
                                .multilineTextAlignment(.leading)
                                       
                        }
                    
                    HStack {
                        Text("마감")
                            .pretendardFont(family: .SemiBold, size: 15)
                            .foregroundColor(Color.basicBlack)
                        
                        Spacer()
                        
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.gray50)
                            .frame(width: 120, height: 30)
                            .overlay {
                                Text("\(formatDate(selectedDate: selectedDate))")
                                    .pretendardFont(family: .SemiBold, size: 15)
                                    .foregroundColor(Color.basicBlack)
                            }
                        
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.gray50)
                            .frame(width: 67, height: 30)
                            .overlay {
                                Text("\(formatTime(selectedTime: selectedTime))")
                                    .pretendardFont(family: .SemiBold, size: 15)
                                    .foregroundColor(Color.basicBlack)
                            }
                            .onTapGesture {
                                showingDatePicker.toggle()
                            }
                        
                    }
                    .padding(.horizontal, 20)
                    
                    Spacer()
                        .frame(height: 34)
                    
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.gray50)
                        .frame(height: 52)
                        .overlay {
                            Text("판결 요청하기")
                                .pretendardFont(family: .SemiBold, size: 18)
                                .foregroundColor(Color.basicBlack)
                        }
                        .padding(.horizontal, 20)
                        .onTapGesture {
                            let calendar = Calendar.current
                            Task {
                                if let oneMinuteLater = calendar.date(byAdding: .minute, value: 5, to: selectedDate) {
                                    await viewModel.createPoll(type: .quick,
                                                               title: title,
                                                               content: content,
                                                               endDate: oneMinuteLater
                                                               , // Use Date directly
                                                               vote1: vote1content,
                                                               vote2: vote2content,
                                                               category: selectedCategory ?? .all)
                                }
                                
                                
                                
                                
                                
                            }
                        }
                    
                    Spacer()
                    
                }
            }
        }
        .sheet(isPresented: $showSelectCateogry) {
            VStack {
                Spacer()
                    .frame(height: 28)
                
                ForEach(PollCategory.allCases, id: \.self) { item in
                    VStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(selectedCategory == item ? Color.blue100 : Color.gray50)
                            .frame(height: 48)
                            .padding(.horizontal, 20)
                            .overlay {
                                HStack {
                                    
                                    Spacer()
                                        .frame(width: 26)
                                    
                                    Image(asset: item.imageAsset)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 31, height: 31)
                                    
                                    Spacer()
                                        .frame(width: 8)
                                    
                                    Text(item.desc)
                                        .pretendardFont(family: .SemiBold, size: 18)
                                        .foregroundColor(selectedCategory == item ? Color.basicWhite : Color.basicBlack)
                                    
                                    Spacer()
                                    
                                }
                            }
                        
                        Spacer()
                            .frame(height: 13)
                    }
                    .onTapGesture {
                        selectedCategory = item // 선택된 항목 저장
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            showSelectCateogry = false
                        }
                    }
                    
                }
            }
            .onAppear {
                selectedCategory = nil
            }
            .presentationCornerRadius(20)
            .presentationDetents([.height(UIScreen.screenHeight*0.7)])
        }
        .sheet(isPresented: $showingDatePicker) {
            VStack {
                HStack{
                    Spacer()
                    DatePicker("",selection: $selectedTime, displayedComponents: .hourAndMinute)
                        .datePickerStyle(WheelDatePickerStyle())
                    Spacer()
                }
            }
                .presentationCornerRadius(20)
                .presentationDetents([.height(UIScreen.screenHeight*0.4)])
        }
    }
}


func formatTime(selectedTime: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm" // 24-hour format
    return formatter.string(from: selectedTime)
}

func formatDate(selectedDate: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy:MM:dd" // Year:Month:Day format
    return formatter.string(from: selectedDate)
}

