//
//  ReviewNoteView.swift
//  Notes
//
//  Created by Дмитрий Пермяков on 19.03.2023.
//

import SwiftUI

struct ReviewNoteView: View {
    @ObservedObject var notes: Notes
    @State private var newText: String = ""
    @State private var newTitle: String = ""
    let currentID: String
    
    var body: some View {
        if let currentIndex = notes.notes.firstIndex(where: {"\($0.id)" == currentID}) {
            VStack {
                
                if let title = notes.notes[currentIndex].title {
                    Text(title)
                        .font(.title2)
                }
                if let text = notes.notes[currentIndex].text {
                    GeometryReader { geometry in
                        Text(text)
                            .padding()
                            .offset(x: geometry.size.width * 0, y: 0)
                    }
                    Spacer()
                }
            }
        } else {
            Text("Запись отсутствует. Это невозможно")
        }
    }
}

struct ReviewNoteView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewNoteView(notes: Notes(), currentID: String())
    }
}
