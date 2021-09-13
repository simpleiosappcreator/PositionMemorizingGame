//
//  ContentView.swift
//  LocationMemorize
//
//  Created by HAHA on 9/9/2021.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm: ViewModel = ViewModel()
    var body: some View {
        GeometryReader {geometry in
            VStack{
                ProgressionBarView()
                
                Spacer()
                
                Image(systemName: vm.north == true ? "arrow.up.square.fill" : "arrow.up.square")
                    .resizable()
                    .frame(width: geometry.size.width / 4, height: geometry.size.height / 4)
                    .onTapGesture(perform: {
                        if let loadingAnimation = vm.loadingAnimation{
                            if !loadingAnimation{
                                vm.playerLocations(num: 1)
                            }
                        }
                    })
                
                HStack(){
                    Image(systemName: vm.west == true ? "arrow.left.square.fill" : "arrow.left.square")
                        .resizable()
                        .frame(width: geometry.size.width / 4, height: geometry.size.height / 4)
                        .onTapGesture(perform: {
                            if let loadingAnimation = vm.loadingAnimation{
                                if !loadingAnimation{
                                    vm.playerLocations(num: 4)
                                }
                            }
                        })
                    
                    Spacer()
                    
                    if vm.start{
                        VStack{
                            Text("Status:")
                            
                            if let loadingAnimation = vm.loadingAnimation{
                                Text(loadingAnimation ? "Carrying out" : "Your turn")
                            }
                        }
                    }else{
                        Button(action: {
                            vm.start = true
                            vm.genLocations()
                        }, label: {
                            Text("Start")
                                .font(.title)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.red.cornerRadius(25))
                        })
                    }
                    
                    Spacer()
                    
                    Image(systemName: vm.east == true ? "arrow.right.square.fill" : "arrow.right.square")
                        .resizable()
                        .frame(width: geometry.size.width / 4, height: geometry.size.height / 4)
                        .onTapGesture(perform: {
                            if let loadingAnimation = vm.loadingAnimation{
                                if !loadingAnimation{
                                    vm.playerLocations(num: 2)
                                }
                            }
                        })
                }
                
                Image(systemName: vm.south == true ? "arrow.down.square.fill" : "arrow.down.square")
                    .resizable()
                    .frame(width: geometry.size.width / 4, height: geometry.size.height / 4)
                    .onTapGesture(perform: {
                        if let loadingAnimation = vm.loadingAnimation{
                            if !loadingAnimation{
                                vm.playerLocations(num: 3)
                            }
                        }
                    })
            }
            .alert(isPresented: $vm.showResult, content: {
                if vm.gameCompleted{
                    return Alert(title: Text("Game completed!"), message: nil, dismissButton: .default(Text("Play again"), action: {
                        vm.reset()
                        vm.gameCompleted = false
                    }))
                }
                if vm.fail{
                    return Alert(title: Text("Wrong answer"), message: nil, dismissButton: .default(Text("Try again"), action: {
                        vm.genLocations()
                    }))
                }else{
                    return Alert(title: Text("Correct"), message: nil, dismissButton: .default(Text("Next"), action: {
                        vm.genLocations()
                    }))
                }
            })
            .padding()
            .environmentObject(vm)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
