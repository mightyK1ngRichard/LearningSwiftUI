//
//  ContentView.swift
//  Notes
//
//  Created by Дмитрий Пермяков on 19.03.2023.
//

import SwiftUI

struct NoteItem: Identifiable, Codable {
    var id = UUID()
    var title: String?
    var text: String?
    var date: Date
}

class NoteInfo: ObservableObject {
    @Published var title: String?
    @Published var text: String?
    @Published var date: Date
    
    init(title: String? = nil, text: String? = nil, date: Date = Date()) {
        self.title = title
        self.text = text
        self.date = date
    }
}

class Notes: ObservableObject {
    @Published var notes: [NoteItem] = [] {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(notes) {
                UserDefaults.standard.set(encoded, forKey: "notes")
            }
        }
    }
    
    init() {
        if let notes = UserDefaults.standard.data(forKey: "notes") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([NoteItem].self, from: notes) {
                self.notes = decoded
                return
            }
        }
    }
}

struct ContentView: View {
    @ObservedObject var notes = Notes()
    @ObservedObject var currentNode = NoteInfo()
    @State var openAddView = false
    
    var body: some View {
        NavigationView {
            Form {
                List {
                    ForEach(notes.notes) { note in
                        HStack {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("\(note.title ?? "Без заголовка")")
                                        .font(.title3)
                                    Text("\(note.date)")
                                        .font(.caption)
                                }
                                Spacer()
                                
                            }
                            NavigationLink(destination: ReviewNoteView(note: currentNode)) {
                                EmptyView()
                            }
                        }
                        .onTapGesture {
                            self.currentNode.title = note.title
                            self.currentNode.text = note.text
                            self.currentNode.date = note.date
                        }
                    }
                    .onDelete(perform: DeleteNote)
                }
            }
            .navigationBarTitle("Мои долги")
            .navigationBarItems(trailing: Button(action: {
                self.openAddView = true
            }) {
                Image(systemName: "plus")
            }
            ) .sheet(isPresented: $openAddView) {
                // Открываем другое окно.
                AddingNote(notes: self.notes)
            }
        }
    }
    
    func DeleteNote(at offsets: IndexSet) {
        notes.notes.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
