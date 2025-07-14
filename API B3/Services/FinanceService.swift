//
//  FinanceService.swift
//  API B3
//
//

import SwiftUI

// Classe responsável por fazer requisições à API de finanças da HG Brasil
class FinanceService {
    // URL base da API de finanças
    private let baseURL = "https://api.hgbrasil.com/finance"
    // Chave de API fornecida para autenticação
    private let apiKey = "d79425ba"
    
    // Singleton para acesso global ao serviço
    static let shared = FinanceService()
    
    // Inicializador privado para garantir o padrão Singleton
    private init() {}
    
    // Função assíncrona que busca os dados financeiros da API
    func fetchFinanceData() async throws -> FinanceResponse {
        // Construção da URL completa com os parâmetros necessários
        // array_limit=1: Limita o tamanho dos arrays retornados
        // fields=only_results,currencies: Especifica quais campos devem ser retornados
        // key: Chave de API para autenticação
        guard let url = URL(string: "\(baseURL)?array_limit=1&fields=only_results,currencies&key=\(apiKey)") else {
            // Lança um erro se a URL for inválida
            throw URLError(.badURL)
        }
        
        // Cria uma requisição HTTP com a URL construída
        var request = URLRequest(url: url)
        // Define o método HTTP como GET
        request.httpMethod = "GET"
        // Define o cabeçalho Accept para indicar que esperamos uma resposta em JSON
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        // Executa a requisição HTTP e aguarda a resposta
        let (data, response) = try await URLSession.shared.data(for: request)
        
        // Verifica se a resposta HTTP tem o código de status 200 (OK)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            // Lança um erro se a resposta não for bem-sucedida
            throw URLError(.badServerResponse)
        }
        
        // Decodifica os dados JSON recebidos para o modelo FinanceResponse
        let decoder = JSONDecoder()
        return try decoder.decode(FinanceResponse.self, from: data)
    }
}
