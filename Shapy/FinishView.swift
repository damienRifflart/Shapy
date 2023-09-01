//
//  FinishView.swift
//  Shapy V1
//
//  Created by Damien Rifflart on 27/08/2023.
//

import SwiftUI

struct FinishView: View {
    @State private var isLandingViewActive = false
    
    var body: some View {
        
        ZStack{
            // Background Color
            Color(hex: 0x0E0215)
                .ignoresSafeArea()
            
            VStack{
                // Serie Number
                HStack{
                    Text("Série")
                        .foregroundColor(Color(hex: 0xE6D2F7))
                        .font(.system(size: 50))
                        .padding(.leading, 10)
                    
                    Text("3")
                        .foregroundColor(Color.white)
                        .font(.system(size: 50))
                    
                    Spacer()
                }
                Spacer()
                
                Text("BRAVO !")
                    .foregroundColor(Color(hex: 0xF3705A))
                    .font(.system(size: 65))
                    .fontWeight(.semibold)
                
                Image("flame")
                    .resizable()
                    .frame(width: 200, height: 200)
                Spacer()
                
                // End Button
                Button(action: { isLandingViewActive.toggle()
                }) {
                    Text("Retourner")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(Color(hex: 0x0E0215))
                        .padding()
                        .frame(width: 300)
                        .background(Color(hex: 0xE6D2F7))
                        .cornerRadius(10)
                }
                .padding(.bottom, 30)
            }
            .fullScreenCover(isPresented: $isLandingViewActive) {
                LandingView(variables: DataManager())
                }
            }
        }
    }


struct FinishView_Previews: PreviewProvider {
    static var previews: some View {
        FinishView()
    }
}
