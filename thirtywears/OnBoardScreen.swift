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
            VStack(alignment: .center){
                Spacer()
                Text("30 Wears")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(.purple)
                Text("To work off clothes’ carbon emissions created during production, you need to wear them 30 times.")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                    .padding()
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
                Image("clothes")
                    .resizable()
                    .frame(width: maxWidth + 50, height: maxWidth + 50)
                Spacer()
                
                ZStack {
                    Capsule()
                        .fill(Color.purple.opacity(0.5))
                    
                    Text("START")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.leading,30)
                   
                    HStack {
                    Capsule()
                        .fill(Color(.purple))
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
                        .background(Color(.purple))
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

