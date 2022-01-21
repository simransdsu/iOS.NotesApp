//
//  HomeView.swift
//  Notes App
//
//  Created by Simran Preet Singh Narang on 2022-01-08.
//

import SwiftUI

struct NotesView: View {
    
    // MARK: - Property Wrappers
    @StateObject var notesViewModel = NotesViewModel()
    
    // MARK: - body
    var body: some View {
        ZStack {
            notesView
            if notesViewModel.isLoading && notesViewModel.notes.count == 0  {
                CCLoadingView(message: "")
            }
        }
        .toolbar(content: { addNoteToolbarItem })
        .sheet(isPresented: $notesViewModel.presentAddNoteView,
               content: { addNoteWithNavigationView })
        .alert(isPresented: $notesViewModel.errorOccurred) {
            Alert(title: Text(notesViewModel.errorMessage))
        }
        .onAppear(perform: getNotes)
    }
    
    // MARK: - UI Views
    private var addNoteToolbarItem: some ToolbarContent {
        ToolbarItem(placement: .bottomBar) {
            CCRoundedButton(text: "+") {
                notesViewModel.presentAddNoteView = true
            }.offset(y: 10)
        }
    }
    
    private var addNoteWithNavigationView: some View {
        NavigationView {
            AddNoteView(notesViewModel: notesViewModel)
        }
    }
    
    private var notesView: some View {
        VStack {
            List {
                ForEach(notesViewModel.notes, id: \.id) { note in
                    Text(note.text)
                }.onDelete { indexSet in
                    onDelete(indexSet: indexSet)
                }
            }
            .refreshable {
                getNotes()
            }
        }
    }
    
    // MARK: - Helper methods
    private func getNotes() {
        Task {
            await notesViewModel.getNotes()
        }
    }
    
    private func onDelete(indexSet: IndexSet) {
        for offset in indexSet {
            let note = notesViewModel.notes[offset]
            notesViewModel.notes.remove(atOffsets: indexSet)
            Task {
                await notesViewModel.deleteNote(withId: note.id)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NotesView()
    }
}
