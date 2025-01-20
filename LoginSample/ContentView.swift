//
//  LoginScreen.swift
//  LoginSample
//
//  Created by Luis Alejandro Ramirez Suarez on 20/01/25.
//

import SwiftUI
import AuthenticationServices

struct LoginScreen: View {
    var body: some View {
        VStack {
            Spacer()
            
            // App logo or title
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.blue)
                .padding(.bottom, 20)
            
            Text("Welcome Back")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 10)
            
            Text("Sign in to continue")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.bottom, 40)
            
            // Sign in with Apple button
            SignInWithAppleButton(
                .signIn,
                onRequest: { request in
                    request.requestedScopes = [.fullName, .email]
                },
                onCompletion: { result in
                    switch result {
                    case .success(let authorization):
                        handleAuthorization(authorization)
                    case .failure(let error):
                        print("Sign in with Apple failed: \(error.localizedDescription)")
                    }
                }
            )
            .frame(height: 50)
            .padding(.horizontal, 40)
            .cornerRadius(10)
            
            Spacer()
            
            // Footer
            Text("By signing in, you agree to our Terms and Privacy Policy.")
                .font(.footnote)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
        .padding()
    }
    
    private func handleAuthorization(_ authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let userID = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            
            // Process user data (e.g., save userID to Keychain, register user, etc.)
            print("User ID: \(userID)")
            if let fullName = fullName {
                print("Full Name: \(fullName)")
            }
            if let email = email {
                print("Email: \(email)")
            }
        }
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}
