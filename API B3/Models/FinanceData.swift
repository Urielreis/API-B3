//
//  FinanceData.swift
//  API B3
//
//

import Foundation

// Estrutura principal que representa a resposta da API de finanças
struct FinanceResponse: Codable {
    // Contém apenas os resultados conforme especificado no parâmetro da API (fields=only_results)
    let currencies: Currencies
    
    // Chaves de codificação para mapear os campos JSON para as propriedades Swift
    enum CodingKeys: String, CodingKey {
        case currencies
    }
}

// Estrutura que contém as diferentes moedas e suas informações
struct Currencies: Codable {
    // Informações sobre o dólar americano
    let usd: CurrencyInfo
    // Informações sobre o euro
    let eur: CurrencyInfo
    // Informações sobre a libra esterlina
    let gbp: CurrencyInfo
    // Informações sobre o peso argentino
    let ars: CurrencyInfo
    // Informações sobre o dólar canadense
    let cad: CurrencyInfo
    // Informações sobre o dólar australiano
    let aud: CurrencyInfo
    // Informações sobre o iene japonês
    let jpy: CurrencyInfo
    // Informações sobre o bitcoin
    let btc: CurrencyInfo
    
    // Chaves de codificação para mapear os campos JSON para as propriedades Swift
    enum CodingKeys: String, CodingKey {
        case usd = "USD"
        case eur = "EUR"
        case gbp = "GBP"
        case ars = "ARS"
        case cad = "CAD"
        case aud = "AUD"
        case jpy = "JPY"
        case btc = "BTC"
    }
}

// Estrutura que contém informações detalhadas sobre uma moeda específica
struct CurrencyInfo: Codable {
    // Nome da moeda
    let name: String
    // Valor de compra da moeda
    let buy: Double?
    // Valor de venda da moeda
    let sell: Double?
    // Variação do valor da moeda
    let variation: Double
    
    // Chaves de codificação para mapear os campos JSON para as propriedades Swift
    enum CodingKeys: String, CodingKey {
        case name
        case buy
        case sell
        case variation
    }
}
