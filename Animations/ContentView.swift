//
//  ContentView.swift
//  Animations
//
//  Created by Rodrigo Cavalcanti on 25/11/20.
//

import SwiftUI

struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint //É um tipo que permite dizer a localização em X e Y, ou .topLeading, .bottomTrailing, .center

    func body(content: Content) -> some View {
        content.rotationEffect(.degrees(amount), anchor: anchor).clipped() //.clippped significa que qualquer coisa fora do retângulo original do frame, ficará de fora.
    }
}

struct giragiraJequiti: ViewModifier {
    let quantidadeGirar: Double
    func body(content: Content) -> some View {
        content.rotation3DEffect(.degrees(quantidadeGirar), axis: (x: 0, y: 1, z: 0))
    }
}


extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRotateModifier(amount: -90, anchor: .topLeading),
            identity: CornerRotateModifier(amount: 0, anchor: .topLeading)
        )
    }
}

extension AnyTransition {
    static var jequiti: AnyTransition {
        .modifier(
            active: giragiraJequiti(quantidadeGirar: -90),
            identity: giragiraJequiti(quantidadeGirar: 0)
        )
    }
}


struct ContentView: View {
    @State private var isShowingRed = false
    
    var body: some View {
        VStack {
            Button("Tap Me") {
                withAnimation {
                    self.isShowingRed.toggle()
                }
            }

            if isShowingRed {
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 200, height: 200)
                    .transition(.jequiti)
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
