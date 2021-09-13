//
//  ViewModel.swift
//  LocationMemorize
//
//  Created by HAHA on 9/9/2021.
//

import Foundation

class ViewModel: ObservableObject{
    @Published var north: Bool = false
    @Published var east: Bool = false
    @Published var south: Bool = false
    @Published var west: Bool = false
    
    @Published var start: Bool = false
    
    @Published var locationArr: [Int] = []
    @Published var loadingAnimation: Bool? = nil
    @Published var resultArr: [Int] = []
    @Published var showResult: Bool = false
    @Published var fail: Bool = false
    @Published var lv: Int = 0
    @Published var gameCompleted: Bool = false
    @Published var delayTime: Double = 1
    
    func repeatCode(num: Int){
        switch num{
        case 1:
            self.north = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.north = false
            }
        case 2:
            self.east = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.east = false
            }
        case 3:
            self.south = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.south = false
            }
        default:
            self.west = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.west = false
            }
        }
    }
    
    func genLocations(){
        loadingAnimation = true
        if !fail{
            for i in 0...lv{
                DispatchQueue.main.asyncAfter(deadline: .now() + delayTime*Double(i+1)) {[weak self] in
                    guard let self = self else{return}
                    let ranNum = Int.random(in: 1...4)
                    self.repeatCode(num: ranNum)
                    self.locationArr.append(ranNum)
                }
            }
        }else{
            for i in locationArr.indices{
                DispatchQueue.main.asyncAfter(deadline: .now() + delayTime*Double(i+1)) {[weak self] in
                    guard let self = self else{return}
                    self.repeatCode(num: self.locationArr[i])
                }
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(lv + 2)) {[weak self] in
            self?.loadingAnimation = false
        }
    }
    
    func playerLocations(num: Int){
        if locationArr.count != resultArr.count{
            resultArr.append(num)
            switch num{
            case 1:
                self.north = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    self.north = false
                }
            case 2:
                self.east = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    self.east = false
                }
            case 3:
                self.south = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    self.south = false
                }
            default:
                self.west = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    self.west = false
                }
            }
            
            if locationArr.count == resultArr.count{
                showResult = true
                if locationArr == resultArr{
                    lv += 1
                    locationArr = []
                    fail = false
                }else{
                    fail = true
                }
                resultArr = []
                loadingAnimation = nil
            }
        }
        
        if lv == 6{
            gameCompleted = true
        }
    }
    
    func reset(){
        start = false
        
        locationArr = []
        loadingAnimation = nil
        resultArr = []
        showResult = false
        fail = false
        lv = 0
    }
}
