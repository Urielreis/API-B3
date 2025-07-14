//
//  ProfileMenuView.swift
//  API B3
//

import SwiftUI
import UIKit

/// Componente que exibe o menu de perfil do usuário
struct ProfileMenuView: View {
    // Binding para controlar a exibição do menu
    @Binding var showMenu: Bool
    
    // Opções do menu de perfil
    private let menuOptions = [
        ("person", "Perfil"),
        ("gear", "Configurações"),
        ("creditcard", "Cartões"),
        ("chart.bar", "Relatórios"),
        ("questionmark.circle", "Ajuda"),
        ("arrow.right.square", "Sair")
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Cabeçalho do menu
            HStack {
                Text("Menu")
                    .font(.headline)
                    .foregroundColor(.white)
                
                Spacer()
                
                // Botão para fechar o menu
                Button(action: {
                    // Feedback háptico ao fechar o menu
                    let impactLight = UIImpactFeedbackGenerator(style: .light)
                    impactLight.impactOccurred()
                    
                    // Fecha o menu com animação
                    withAnimation(.spring()) {
                        showMenu = false
                    }
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                        .font(.system(size: 22))
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color.black.opacity(0.6))
            
            // Linha separadora
            Divider()
                .background(Color.gray.opacity(0.3))
            
            // Lista de opções do menu
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(menuOptions, id: \.1) { option in
                        MenuOptionRow(icon: option.0, title: option.1) {
                            handleMenuAction(option.1)
                        }
                    }
                }
            }
            .background(Color.black.opacity(0.5))
        }
        .frame(width: 250)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color("AppPrimary").opacity(0.9),
                            Color("AppPrimary Variant").opacity(0.7)
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.white.opacity(0.1), lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.5), radius: 10, x: 0, y: 5)
        .padding(.top, 10)
    }
    
    // Função para lidar com as ações do menu
    private func handleMenuAction(_ option: String) {
        // Feedback háptico ao selecionar uma opção
        let impactMed = UIImpactFeedbackGenerator(style: .medium)
        impactMed.impactOccurred()
        
        // Fecha o menu
        withAnimation(.spring()) {
            showMenu = false
        }
        
        // Lógica específica para cada opção do menu
        switch option {
        case "Perfil":
            showProfileAlert("Perfil", "Visualize e edite suas informações pessoais.")
        case "Configurações":
            showProfileAlert("Configurações", "Ajuste as configurações do aplicativo.")
        case "Cartões":
            showProfileAlert("Cartões", "Gerencie seus cartões de crédito e débito.")
        case "Relatórios":
            showProfileAlert("Relatórios", "Visualize relatórios detalhados de suas finanças.")
        case "Ajuda":
            showProfileAlert("Ajuda", "Obtenha suporte e tire suas dúvidas.")
        case "Sair":
            showLogoutConfirmation()
        default:
            break
        }
    }
    
    // Função para exibir alertas de perfil
    private func showProfileAlert(_ title: String, _ message: String) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
        
        // Apresenta o alerta
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = windowScene.windows.first?.rootViewController {
            rootViewController.present(alertController, animated: true)
        }
    }
    
    // Função para exibir confirmação de logout
    private func showLogoutConfirmation() {
        let alertController = UIAlertController(
            title: "Sair",
            message: "Tem certeza que deseja sair da sua conta?",
            preferredStyle: .alert
        )
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel)
        let logoutAction = UIAlertAction(title: "Sair", style: .destructive) { _ in
            // Aqui seria implementada a lógica de logout
            print("Usuário realizou logout")
            
            // Feedback de notificação
            let notificationFeedback = UINotificationFeedbackGenerator()
            notificationFeedback.notificationOccurred(.success)
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(logoutAction)
        
        // Apresenta o alerta
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootViewController = windowScene.windows.first?.rootViewController {
            rootViewController.present(alertController, animated: true)
        }
    }
}

/// Componente que representa uma linha de opção no menu
struct MenuOptionRow: View {
    let icon: String
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 14) {
                Image(systemName: icon)
                    .font(.system(size: 18))
                    .foregroundColor(.white.opacity(0.8))
                    .frame(width: 24, height: 24)
                
                Text(title)
                    .font(.system(size: 16))
                    .foregroundColor(.white)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color.clear)
        }
        .buttonStyle(PlainButtonStyle())
        .contentShape(Rectangle())
        .overlay(
            Rectangle()
                .frame(height: 0.5)
                .foregroundColor(Color.gray.opacity(0.3))
                .offset(y: 24)
        )
    }
}

// Visualização de prévia para o componente
#Preview {
    ZStack {
        Color.black.edgesIgnoringSafeArea(.all)
        
        ProfileMenuView(showMenu: .constant(true))
            .padding(.leading, 20)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}