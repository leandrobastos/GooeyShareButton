//
//  ContentView.swift
//  GooeyShareButton
//
//  Created by Leandro Bastos on 13/06/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader {
            let size = $0.size
            Home(size: size)
        }
//        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundColor(.accentColor)
//            Text("Hello, world!")
//        }
//        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
