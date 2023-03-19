//
//  ReviewNoteView.swift
//  Notes
//
//  Created by Дмитрий Пермяков on 19.03.2023.
//

import SwiftUI

struct ReviewNoteView: View {
    @Binding var text: String
    var body: some View {
        Text("\(self.text)")
    }
    
}

//struct ReviewNoteView_Previews: PreviewProvider {
//    static var previews: some View {
//        ReviewNoteView()
//    }
//}
