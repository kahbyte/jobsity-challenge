//
//  JSONReader.swift
//  Jobsity-Challenge
//
//  Created by Kauê Sales on 03/03/24.
//

import Foundation

final class JSONReader {
    static func load<T: Decodable>(_ filename: String, as type: T.Type = T.self) -> T {
        let data: Data

        guard let file = Bundle.main.url(forResource: filename, withExtension: "json")
            else {
                fatalError("Não foi possível encontrar \(filename) no pacote principal.")
        }

        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Não foi possível carregar \(filename) do pacote principal:\n\(error)")
        }

        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Não foi possível decodificar \(filename) como \(T.self):\n\(error)")
        }
    }
}
