//
//  HomeView.swift
//  Notes App
//
//  Created by Simran Preet Singh Narang on 2022-01-08.
//

import SwiftUI

struct NotesView: View {
    
    @StateObject var notesViewModel = NotesViewModel()
    
    var body: some View {
        ZStack {
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
            
            if notesViewModel.isLoading && notesViewModel.notes.count == 0  {
                CCLoadingView(message: "")
            }
        }
        .toolbar(content: {
            ToolbarItem(placement: .bottomBar) {
                CCRoundedButton(text: "+") {
                    notesViewModel.presentAddNoteView = true
                }.offset(y: 10)
            }
        })
        .sheet(isPresented: $notesViewModel.presentAddNoteView, content: {
            NavigationView {
                AddNoteView(notesViewModel: notesViewModel)
            }
        })
        .onAppear(perform: getNotes)
    }
    
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
