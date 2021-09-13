//
//  ProgressionBarView.swift
//  LocationMemorize
//
//  Created by HAHA on 9/9/2021.
//

import SwiftUI

struct ProgressionBarView: View {
    @EnvironmentObject var vm: ViewModel
    var body: some View {
        GeometryReader {geometry in
            ZStack(alignment: .leading){
                Color.gray
                    .frame(maxWidth: .infinity)
                    .frame(height: UIScreen.main.bounds.height / 15)
                    .cornerRadius(10)
                
                Color.green
                    .frame(width: geometry.size.width * CGFloat(vm.lv) / 6)
                    .frame(height: UIScreen.main.bounds.height / 15)
                    .cornerRadius(10)
                    .animation(.spring())
                
                Text(vm.gameCompleted == true ? "Completed!" : "Level: \(vm.lv)/6")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.leading)
            }
        }
        .padding(.horizontal)
    }
}

struct ProgressionBarView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressionBarView()
    }
}
