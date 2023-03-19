//
//  AddingNote.swift
//  Notes
//
//  Created by Дмитрий Пермяков on 19.03.2023.
//

import SwiftUI

struct AddingNote: View {
    @Environment(\.presentationMode) var presentationMode
    @State var title = ""
    @State var text = ""
    @State var selectedDate = Date()
    @ObservedObject var notes: Notes
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Введите заголовок", text: $title)
                    TextField("Введите текст заметки", text: $text)
                }
                DatePicker("Выберите дату", selection: $selectedDate, displayedComponents: [.date])
            }
            .navigationTitle("Добавление")
            .navigationBarItems(trailing: Button(action: {
                let resultTitle = self.title == "" ? nil : self.title
                self.notes.notes.append(NoteItem(title: resultTitle, text: self.text, date: self.selectedDate))
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Добавить")
            }))
        }
    }
}

struct AddingNote_Previews: PreviewProvider {
    static var previews: some View {
        AddingNote(notes: Notes())
    }
}
