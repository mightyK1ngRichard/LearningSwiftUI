//
//  ReviewNoteView.swift
//  Notes
//
//  Created by Дмитрий Пермяков on 19.03.2023.
//

import SwiftUI

struct ReviewNoteView: View {
    @ObservedObject var note: NoteInfo
    
    var body: some View {
        Text("\(self.note.text ?? "Пусто")")
    }
    
}

struct ReviewNoteView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewNoteView(note: NoteInfo())
    }
}
