//
//  BooksAPI.swift
//  ReadingInPixels
//
//  Created by Наталья Жерлова on 15.04.2024.
//
import Alamofire
import Foundation
import SwiftUI

struct BookCreateParams: Encodable, Sendable {
    let title: String
    let author: String
    let genre: String
    let rating: Int
    let format: String
    let gender: String
    let language: String
    let year: String
    let page: Int
}

struct BookCreateResponse: Decodable, Sendable {
    let id: UUID
}

func bookCreateHTTP(input: BookCreateParams) async throws -> UUID {
    let response = try await AF.request(
        "\(API.baseURL)/books",
        method: .post,
        parameters: input,
        encoder: JSONParameterEncoder.default
    )
        .response { response in
            debugPrint(response)
        }
        .serializingDecodable(BookCreateResponse.self)
        .value
    
    return response.id
}

struct GetBooks: Decodable, Sendable {
    let items: [BookItem]
}

struct BookItem: Identifiable, Decodable, Sendable, Hashable {
    let id: UUID
    let title: String
    let author: String
    let genre: String
    let rating: Int
    let format: String
    let gender: String
    let language: String
    let year: String
    let page: Int
}

func booksGetHTTP() async throws -> [BookItem] {
    let response = try await AF.request("\(API.baseURL)/books")
        .response { response in
            debugPrint(response)
        }
        .serializingDecodable(GetBooks.self)
        .value
    
    return response.items
}

func bookGetHTTP(id: UUID) async throws -> [BookItem] {
    let response = try await AF.request("\(API.baseURL)/books/\(id)")
        .serializingDecodable(GetBooks.self)
        .value
    return response.items
}

func bookDeleteHTTP(id: UUID) async throws -> Void {
    let _ = try await AF.request("\(API.baseURL)/books/\(id)", method: .delete)
        .serializingDecodable(Empty.self, emptyResponseCodes: [200])
        .response
}
