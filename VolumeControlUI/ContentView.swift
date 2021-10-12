//
//  ContentView.swift
//  VolumeControlUI
//
//  Created by AndreyP on 12/10/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct Home: View{
    
    @State var maxHeight : CGFloat = UIScreen.main.bounds.height / 3
        
        // slider properties
        @State var slideProgress : CGFloat = 0
        @State var slideHeigh : CGFloat = 0
        @State var lastDragValue : CGFloat = 0
    
    
    
    var body: some View{
        
        NavigationView{
            
            VStack{
                
        // Volume button..
                HStack{
                    
                                  Text("    \(Int(slideProgress * 100))%")
                                    .underline()
        
                                Spacer ()
                    
                                        Button("SET VOLUME") {
                                                        if slideProgress < 100 {
                                                            slideProgress += 0.1
                                                        }
                                                    }
              
                                        .padding()
                                        .frame(width: 150, height: 40, alignment: .center)
                                        .background(Color.gray.opacity(0.2))
                                        .cornerRadius(10)
                              }
        // Lines button
                    
                HStack{
                  
                                  Text("    Lines \(Int(slideHeigh))")
                                      .underline()
                              
                                  Spacer()
                                  
                                  Button("SET LINES") {
                                                  if slideHeigh < 270 {
                                                      slideHeigh += 10
                                                  }
                                              }
                                  .padding()
                                  .frame(width: 150, height: 40, alignment: .center)
                                  .background(Color.gray.opacity(0.2))
                                  .cornerRadius(10)
                              }
                    
                Spacer ()
                
                
                
                
                
                
                
        //Slider
                ZStack(alignment: .bottom, content: {
                    Rectangle()
                        .fill(Color.gray.opacity(0.15))
                    Rectangle()
                        .fill(Color.blue)
                        .frame(height:slideHeigh)
                })
                    .frame(width: 100, height: maxHeight)
                    .cornerRadius(10)
                
        // Container...
                    Text("Volume set at \(Int(slideProgress * 100))%")
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                    
        //Slider gesture...
                    .gesture(DragGesture(minimumDistance: 0) .onChanged({ (value) in
                        
        // getting drag value
                        let translation = value.translation
                        
                        slideHeigh = -translation.height + lastDragValue
                        
        // limiting slider height volume
                        
                        slideHeigh = slideHeigh > maxHeight
                        ? maxHeight : slideHeigh
            
                        slideHeigh = slideHeigh >= 0 ?
                        slideHeigh : 0
        // updating progress
                                        let progress = slideHeigh / maxHeight
                                        slideProgress = progress <= 1.0 ?
                                        progress : 1
                        
                    }).onEnded({ (value) in
                        
        // storing last drag value for restoration
                        
                        slideHeigh = slideHeigh > maxHeight
                        ? maxHeight : slideHeigh
                        
        // negative height
                        slideHeigh = slideHeigh >= 0 ?
                        slideHeigh : 0
                        lastDragValue = slideHeigh
                    }))
                Spacer ()
            }
     
        }
    }
    
}

