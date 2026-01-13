//
//  FileStorage.swift
//  Flashcard App 1
//
//  Created by Ramone Hayes on 1/8/26.
//

import Foundation

enum FileStoreError: Error {
    case invalidCocumentsDirectory
    
}

struct FileStore {
    
    private let fileName: String
    
    init(fileName: String = "decks.json") {
        self.fileName = fileName
    }
    
   //Get file path
    
    private func fileURL()throws->URL{
        guard let docs = FileManager.default.urls(for:.documentDirectory, in: .userDomainMask).first else{
            throw FileStoreError.invalidCocumentsDirectory
        }
        return docs.appendingPathComponent(fileName)
        
    }
    // Swift File (Bytes)
    func load<T: Decodable>( type:T.Type) throws ->T{
        
        // Where is File?
        let url = try fileURL()
        
        //Read the file bytes
        let data = try Data(contentsOf: url)
        
        //Convert JSON bytes into Swift type T (Models)
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    // Save File
    
    func save<T: Encodable>(_ value: T) throws {
        // Where do I save
        let url = try fileURL()
        // Convert Swift to JSON bytes
        let data = try JSONEncoder().encode(value)
        // Write bytes to disk
        try data.write(to: url,options: [.atomic])
    }
    
    
    
    
}
