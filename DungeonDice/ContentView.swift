//
//  ContentView.swift
//  DungeonDice
//
//  Created by Francesca MACDONALD on 2023-08-23.
//

import SwiftUI

struct ContentView: View {
    @State private var messageString = ""
    
    var body: some View {
        VStack {
            titleView
            Spacer()
            
            resultMessageView
            Spacer()
            
            ButtonLayout(messageString: $messageString)
            
        }
        .padding()
        
    }
}


extension ContentView {
    private var titleView: some View {
        Text("Dungeon Dice!")
            .font(.largeTitle)
            .fontWeight(.black)
            .foregroundColor(.red)
    }
    private var resultMessageView: some View {
        Text(messageString)
            .font(.largeTitle)
            .fontWeight(.medium)
            .multilineTextAlignment(.center)
            .frame(height: 150)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
