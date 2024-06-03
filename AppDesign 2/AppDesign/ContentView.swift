//
//  ContentView.swift
//  AppDesign
//
//  Created by Tech on 2024-05-30.
//

import SwiftUI

struct ContentView: View {
    
    @State private var board = [
        ["", "", ""],
        ["", "", ""],
        ["", "", ""]
    ]
    @State private var player : Bool = true //true: X , false : O
    @State private var showAlert : Bool = false
    @State private var message : String = ""
    @State private var attempts = 9
    
    var body: some View {
        
        NavigationStack{
            
            VStack() {
                
//                Text("Tic Tac Toe")
//                    .bold()
//                    .font(.largeTitle)
                
                ForEach(0..<3){ row in
                    
                    HStack(){
                        
                        ForEach(0..<3){ col in
                            
                            Button{
                                //                            print(#function, "Button clicked")
                                self.playGame(r: row, c: col)
                            }label: {
                                Text("\(self.board[row][col])")
                                    .foregroundColor(Color("TileTextColor"))
//                                    .foregroundColor(.yellow)
                                    .bold()
                                    .font(.largeTitle)
                                    .frame(minWidth: 60, minHeight: 60)
                                    .background(Color("TileColor"))
//                                    .background(Color(.blue))
                            }//Button
                            .alert(isPresented: self.$showAlert){
                                Alert(title: Text("Result"),
                                      message: Text(self.message),
                                      dismissButton: .default(Text("Dismiss")){
                                    self.resetGame()
                                })
                            }//.alert
                            
                        }//ForEach
                        
                    }//HStack
                    //                .padding()
                    //                .background(.green)
                    
                }//ForEach
                
                Text("Who's turn ? \(self.player ? "X" : "O" )")
                
                Spacer()
            }//VStack
            .padding()
            //        .background(.yellow)
            
            //            menu on the navigation bar
            .toolbar{
                ToolbarItem(placement: .topBarTrailing){
                    Menu{
                        Button{
                            self.resetGame()
                        }label: {
                            Text("Reset Game")
                        }
                        
                        Button{
                            //show the score
                        }label: {
                            Text("Show Score")
                        }
                        
                        Button{
                            //show the score
                        }label: {
                            Text("Profile")
                        }
                        
                    }label:{
                        Image(systemName: "gear")
                            .foregroundColor(.blue)
                    }
                }
            } //toolbar
            
            //            just one button on navigation bar
            //            .toolbar{
            //                ToolbarItem(placement: .topBarTrailing){
            //                    Button{
            //                        self.resetGame()
            //                    }label: {
            //                        Image(systemName: "gear")
            //                            .foregroundStyle(.blue)
            //
            //                    }
            //                }
            //            } //toolbar
            
            
            .navigationTitle(Text("Tic Tac Toe"))
            .navigationBarTitleDisplayMode(.inline)		
        }//NavigationStack
        
    }//body
    
    private func playGame(r : Int, c : Int){
        
        if (self.board[r][c].isEmpty){
            //check the player variable to identify X or O
            self.board[r][c] = self.player ? "X" : "O"
            self.player.toggle()
            self.attempts -= 1
            
            //check for row winner
            if ( !self.board[r][c].isEmpty &&
                 self.board[r][0] == self.board[r][1] &&
                 self.board[r][0] == self.board[r][2]
            ){
                print(#function, "\(self.board[r][c]) wins")
                self.message = "\(self.board[r][c]) \(NSLocalizedString("wins on row", comment: "win row message")) \(r)"
                self.showAlert = true
//                self.resetGame()
            }
            
            //check for column winner
            if ( !self.board[r][c].isEmpty &&
                 self.board[0][c] == self.board[1][c] &&
                 self.board[0][c] == self.board[2][c]
            ){
                print(#function, "\(self.board[r][c]) wins")
                self.message = "\(self.board[r][c]) \(NSLocalizedString("wins on column", comment: "win column message")) \(c)"
                self.showAlert = true
//                self.resetGame()
            }
            
            //check for diagonal winner
            if ( !self.board[1][1].isEmpty &&
                 (( self.board[0][0] == self.board[1][1] &&
                    self.board[0][0] == self.board[2][2] ) ||
                  
                  ( self.board[0][2] == self.board[1][1] &&
                    self.board[0][2] == self.board[2][0] ))
            ){
                print(#function, "\(self.board[r][c]) wins")
                self.message = "\(self.board[r][c]) \(NSLocalizedString("wins on diagonal", comment: "win diagonal message"))"
                self.showAlert = true
//                self.resetGame()
            }
            
            //check for game over
            if (self.attempts <= 0){
                self.message = "Game Over ! Better luck next time !"
                self.showAlert = true
//                self.resetGame()
            }
            
            //reset the game
            //self.resetGame()
        }
    }//playGame()
        
    private func resetGame(){
        self.board = [
            ["", "", ""],
            ["", "", ""],
            ["", "", ""]
        ]
        
        self.player = Bool.random()
        self.attempts = 9
    }
    
    
}//ContentView

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
        ContentView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
            .previewDisplayName("iPhone 14")
            .environment(\.colorScheme, .dark)
        
        ContentView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro"))
            .previewDisplayName("iPhone 14 Pro")
            .environment(\.colorScheme, .light)
        
        ContentView()
            .previewDevice(PreviewDevice(rawValue: "iPad Air (5th generation)"))
            .previewDisplayName("iPad Air")
    }
}
