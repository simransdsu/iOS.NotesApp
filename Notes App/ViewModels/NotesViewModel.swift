//
//  HomeViewModel.swift
//  Notes App
//
//  Created by Simran Preet Singh Narang on 2022-01-08.
//

import Foundation
import Resolver


@MainActor
class NotesViewModel: ObservableObject, ErrorHandler {
    
    @Injected private var notesController: NotesController
    
    @Published var errorOccurred: Bool = false
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = false
    
    @Published var presentAddNoteView: Bool = false
    @Published var notes: [Note] = []
    @Published var noteText: String = ""
    
    func getNotes() async {
        
        isLoading = true
        errorOccurred = false
        
        do {
            notes = try await notesController.getNotes()
        } catch  {
            errorOccurred = true
            errorMessage = handleError(error: error)
        }
        isLoading = false
    }
    
    func saveNote() async {
        
        isLoading = true
        errorOccurred = false
        
        do {
            try await notesController.saveNote(noteText)
            await getNotes()
            noteText = ""
        } catch {
            errorOccurred = true
            errorMessage = handleError(error: error)
        }
        isLoading = false
    }
    
    func deleteNote(withId id: Int) async {
        
        isLoading = true
        errorOccurred = false
        
        do {
            try await notesController.deleteNote(withId: id)
            await getNotes()
            noteText = ""
        } catch {
            errorOccurred = true
            errorMessage = handleError(error: error)
        }
        isLoading = false
    }
}
