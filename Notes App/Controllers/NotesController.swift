//
//  HomeController.swift
//  Notes App
//
//  Created by Simran Preet Singh Narang on 2022-01-08.
//

import Foundation
import Resolver

class NotesController {
    
    @Injected var notesService: NotesService
    
    func getNotes() async throws -> [Note] {
        
        return try await notesService.getUserNotes()
    }
    
    func saveNote(_ text: String) async throws {
        
        try await notesService.saveNote(text)
    }
    
    func deleteNote(withId id: Int) async throws {
        
        try await notesService.deleteNote(id)
    }
}
