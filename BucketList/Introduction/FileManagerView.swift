//
//  FileManagerView.swift
//  BucketList
//
//  Created by Fauzan Dwi Prasetyo on 12/07/23.
//

import SwiftUI

extension FileManager {
    func encode<T: Codable>(_ dataCodable: T, _ file: String) {
        let url = getDocumentsDirectory().appendingPathComponent(file)
        
        guard let data = try? JSONEncoder().encode(dataCodable) else {
            fatalError("Failed to encode data")
        }
        
        do {
            try data.write(to: url)
        } catch {
            fatalError("Failed to write \(file): \(error.localizedDescription)")
        }
    }
    
    func decode<T: Codable>(_ file: String) -> T {
        let url = getDocumentsDirectory().appendingPathComponent(file)
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file)")
        }
        
        do {
            let decoded = try JSONDecoder().decode(T.self, from: data)
            return decoded
        } catch {
            fatalError("Failed to decode \(file): \(error.localizedDescription)")
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        return paths[0]
    }
}

struct Astronaut: Identifiable, Codable {
    let id: String
    let name: String
}

struct FileManagerView: View {
    @State private var astronauts: [Astronaut] = [Astronaut(id: "tap", name: "Tap to load astronauts")]
    
    var body: some View {
        List(astronauts) { astronaut in
            Text(astronaut.name)
        }
        .onAppear {
            var astronauts = [Astronaut]()
            astronauts.append(Astronaut(id: "grissom", name: "Virgil I. \"Gus\" Grissom"))
            astronauts.append(Astronaut(id: "white", name: "Edward H. White II"))
            astronauts.append(Astronaut(id: "chaffee", name: "Roger B. Chaffee"))
            
            FileManager.default.encode(astronauts, "astronauts.json")
        }
        .onTapGesture {
            self.astronauts = FileManager.default.decode("astronauts.json")
        }
    }
}

struct FileManagerView_Previews: PreviewProvider {
    static var previews: some View {
        FileManagerView()
    }
}
