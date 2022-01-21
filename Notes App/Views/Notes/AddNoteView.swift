//
//  AddEditNoteView.swift
//  Notes App
//
//  Created by Simran Preet Singh Narang on 2022-01-19.
//

import SwiftUI

struct AddNoteView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var notesViewModel: NotesViewModel
    
    var body: some View {
        ZStack {
            VStack {
                Form {
                    TextField("Enter your note here...", text: $notesViewModel.noteText)
                }
                
                CCButton(action:saveNote, text: "Save")
                    .padding()
                
                Spacer()
            }
            
            if notesViewModel.isLoading {
                CCLoadingView(message: "")
            }
        }
        .navigationTitle("Save Note")
    }
    
    private func saveNote() {
        Task {
            await notesViewModel.saveNote()
            presentationMode.wrappedValue.dismiss()
        }
    }
}

struct AddEditNoteView_Previews: PreviewProvider {
    static var previews: some View {
        AddNoteView(notesViewModel: NotesViewModel())
    }
}
