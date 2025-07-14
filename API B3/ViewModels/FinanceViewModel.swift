//
//  FinanceViewModel.swift
//  API B3
//
//

import Foundation
import SwiftUI

// Classe que gerencia o estado da aplicação e faz a ponte entre a UI e o serviço de API
@MainActor // Garante que todas as atualizações de estado aconteçam na thread principal
class FinanceViewModel: ObservableObject {
    // Propriedade publicada que notifica a UI quando os dados financeiros são atualizados
    @Published var financeData: FinanceResponse?
    // Propriedade publicada que indica se os dados estão sendo carregados
    @Published var isLoading = false
    // Propriedade publicada que armazena mensagens de erro, se houver
    @Published var errorMessage: String?
    
    // Referência ao serviço que faz as requisições à API
    private let service = FinanceService.shared
    
    // Inicializador que carrega os dados financeiros automaticamente
    init() {
        // Carrega os dados financeiros quando o ViewModel é inicializado
        Task {
            await loadFinanceData()
        }
    }
    
    // Função que carrega os dados financeiros da API
    func loadFinanceData() async {
        // Indica que o carregamento está em andamento
        isLoading = true
        // Limpa qualquer mensagem de erro anterior
        errorMessage = nil
        
        do {
            // Tenta buscar os dados financeiros usando o serviço
            financeData = try await service.fetchFinanceData()
        } catch {
            // Captura e armazena qualquer erro que ocorra durante a requisição
            errorMessage = "Erro ao carregar dados: \(error.localizedDescription)"
            print("Erro ao carregar dados financeiros: \(error)")
        }
        
        // Indica que o carregamento foi concluído
        isLoading = false
    }
    
    // Função que formata o valor de uma moeda para exibição
    // Esta função é responsável por converter um valor Double opcional em uma string formatada para exibição
    // Parâmetros:
    //   - value: Um valor Double opcional que representa o valor da moeda (pode ser nulo)
    // Retorno:
    //   - Uma string formatada com o símbolo da moeda e o valor, ou "N/A" se o valor for nulo ou zero
    // Exemplo de uso:
    //   let formattedValue = viewModel.formatCurrency(5.75) // Retorna "R$ 5,75"
    //   let formattedNullValue = viewModel.formatCurrency(nil) // Retorna "N/A"
    func formatCurrency(_ value: Double?) -> String {
        // Verifica se o valor é nulo ou zero
        // Em algumas moedas, o valor de venda pode não estar disponível (nil) ou ser zero
        guard let value = value, value > 0 else { 
            return "N/A" // Retorna "N/A" (Not Available) para valores nulos ou zero
        }
        
        // Cria um formatador de número para valores monetários
        // NumberFormatter é uma classe que permite formatar números de acordo com convenções locais
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency // Define o estilo como moeda
        formatter.currencySymbol = "R$" // Define o símbolo da moeda como Real brasileiro
        formatter.minimumFractionDigits = 2 // Garante pelo menos 2 casas decimais
        formatter.maximumFractionDigits = 2 // Limita a no máximo 2 casas decimais
        
        // Formata o valor usando o formatador e retorna o resultado
        // Se a formatação falhar por algum motivo, usa uma formatação básica como fallback
        return formatter.string(from: NSNumber(value: value)) ?? "R$ \(value)"
    }
    
    // Função que formata a variação percentual para exibição
    // Esta função converte um valor Double que representa uma variação percentual em uma string formatada
    // Parâmetros:
    //   - variation: Um valor Double que representa a variação percentual da moeda
    // Retorno:
    //   - Uma string formatada com o símbolo de percentual e o valor
    // Exemplo de uso:
    //   let formattedVariation = viewModel.formatVariation(0.0575) // Retorna "5,75%"
    //   let formattedNegativeVariation = viewModel.formatVariation(-0.0325) // Retorna "-3,25%"
    func formatVariation(_ variation: Double) -> String {
        // Cria um formatador de número para valores percentuais
        // NumberFormatter é uma classe que permite formatar números de acordo com convenções locais
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent // Define o estilo como percentual
        formatter.minimumFractionDigits = 2 // Garante pelo menos 2 casas decimais
        formatter.maximumFractionDigits = 2 // Limita a no máximo 2 casas decimais
        formatter.multiplier = 1 // A variação já está em formato decimal (0.05 = 5%)
        
        // Formata o valor usando o formatador e retorna o resultado
        // Se a formatação falhar por algum motivo, usa uma formatação básica como fallback
        // multiplicando por 100 para converter de decimal para percentual
        return formatter.string(from: NSNumber(value: variation)) ?? "\(variation * 100)%"
    }
    
    // Função que determina a cor para exibir a variação (verde para positiva, vermelha para negativa)
    // Esta função analisa o valor da variação e retorna uma cor apropriada para representá-la visualmente
    // Parâmetros:
    //   - variation: Um valor Double que representa a variação percentual da moeda
    // Retorno:
    //   - Uma cor (Color) que representa visualmente a direção da variação
    // Exemplo de uso:
    //   let color = viewModel.variationColor(0.0575) // Retorna Color.green
    //   let negativeColor = viewModel.variationColor(-0.0325) // Retorna Color.red
    func variationColor(_ variation: Double) -> Color {
        // Aplica lógica condicional para determinar a cor baseada no valor da variação
        if variation > 0 {
            return .green  // Verde para variações positivas (alta)
        } else if variation < 0 {
            return .red    // Vermelho para variações negativas (queda)
        } else {
            return .gray   // Cinza para variações neutras (sem mudança)
        }
    }
}
