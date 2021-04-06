//
//  OnBoardScreen.swift
//  thirtywears
//
//  Created by Penelope Labram on 6/4/21.
//

import SwiftUI

struct OnBoardScreen: View {
    
    @State var maxWidth = UIScreen.main.bounds.width - 100
    @State var offset: CGFloat = 0
    
    var body: some View {
        ZStack{
            Color(.purple)
                .ignoresSafeArea(.all, edges: .all)
            
            VStack{
                Spacer(minLength: 0)
                Text("30 Wears")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(.purple)
                Text("The 30 wears rule: 'To work off the clothes’ carbon emissions created during production, you need to wear it 30 times' - Georgina Wilson-Powell")
                    .fontWeight(.semibold)
                    .foregroundColor(.purple)
                    .padding()
                    .fixedSize(horizontal: false, vertical: true)
                Image("clothes")
                    .padding()
                Spacer(minLength: 0)
                
                
                ZStack {
                    Capsule()
                        .fill(Color.white.opacity(0.5))
                    
                    Text("SWIPE TO START")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.leading,30)
                   
                    HStack {
                    Capsule()
                        .fill(Color(.blue))
                        .frame(width: calculateWidth()+65)
                        Spacer(minLength: 0)
                    }
                    
                    HStack{
                        ZStack{
                            Image(systemName: "chevron.right")
                            Image(systemName: "chevron.right")
                                .offset(x: -10)
                        }
                        .foregroundColor(.white)
                        .offset(x: 5)
                        .frame(width: 65, height: 65)
                        .background(Color(.blue))
                        .clipShape(Circle())
                        .offset(x: offset)
                        .gesture(DragGesture().onChanged(onChanged(value:)).onEnded(onEnd(value:)))
                        Spacer()
                        
                    }
                }
                .frame(width: maxWidth, height: 65)
                .padding(.bottom)
            }

        
            
        }
    }

    func calculateWidth()->CGFloat{
        let percent = offset / maxWidth
        return percent * maxWidth
    }
    func onChanged(value: DragGesture.Value) {
        if value.translation.width > 0 && offset <= maxWidth - 65 {
            offset = value.translation.width
        }
        
    }
    
    func onEnd(value: DragGesture.Value) {
        withAnimation(Animation.easeOut(duration: 0.3)) {
        
        if offset > 180 {
            offset = maxWidth - 65
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                NotificationCenter.default.post(name: NSNotification.Name("Success"), object: nil)
            }
        }
            else {
            offset = 0
            }
        }
    
    }
    
}

