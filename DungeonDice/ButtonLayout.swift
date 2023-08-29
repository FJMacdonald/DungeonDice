//
//  ButtonLayout.swift
//  DungeonDice
//
//  Created by Francesca MACDONALD on 2023-08-24.
//

import SwiftUI

struct ButtonLayout : View {
    enum Dice: Int, RawRepresentable, CaseIterable {
        case four = 4
        case six = 6
        case eight = 8
        case ten = 10
        case twelve = 12
        case twenty = 20
        case hundred = 100
        
        func roll() -> Int {
            return Int.random(in: 1...self.rawValue)
        }
    }
    
    let horizontalPadding: CGFloat = 16
    let spacing: CGFloat = 10
    let buttonWidth: CGFloat = 102
    
    @State private var buttonsLeftover = 0
    @Binding var messageString: String
    
    struct DeviceWidthPreferenceKey: PreferenceKey {
        static var defaultValue: CGFloat = 0
        
        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
            value = nextValue()
        }
        
        typealias Value = CGFloat
        
        
    }
    var body: some View {
        VStack {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 102))], spacing: spacing) {
                
                ForEach(Dice.allCases.dropLast(buttonsLeftover), id: \.self) { die in
                    Button("\(die.rawValue)-sided") {
                        messageString = "You rolled a \(die.roll()) on a \(die.rawValue)-sided dice"
                    }
                }
                
                .font(.title3)
                .buttonStyle(.borderedProminent)
                .tint(.red)
            }
            HStack {
                ForEach(Dice.allCases.suffix(buttonsLeftover), id: \.self) { die in
                    Button("\(die.rawValue)-sided") {
                        messageString = "You rolled a \(die.roll()) on a \(die.rawValue)-sided dice"
                    }
                }
                
                .font(.title3)
                .buttonStyle(.borderedProminent)
                .tint(.red)
            }
            
        }
        .overlay{
            GeometryReader { geo in
                Color.clear
                    .preference(key: DeviceWidthPreferenceKey.self, value: geo.size.width)
            }
        }
        .onPreferenceChange(DeviceWidthPreferenceKey.self) { deviceWidth in
            arrangeGridItems(width: deviceWidth)
        }
        
    }
    func arrangeGridItems(width: CGFloat) {
        var screenWidth = width - 2*horizontalPadding
        if Dice.allCases.count > 1 {
            screenWidth += spacing
        }
        let numberOfButtonsPerRow = Int(screenWidth) / Int(buttonWidth + spacing)
        buttonsLeftover = Dice.allCases.count % numberOfButtonsPerRow
    }
    
}
struct ButtonLayout_Previews: PreviewProvider {
    static var previews: some View {
        ButtonLayout(messageString: .constant(""))
    }
}
