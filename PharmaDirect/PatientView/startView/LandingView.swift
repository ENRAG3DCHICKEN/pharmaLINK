//
//  ContentView.swift
//  TemplateApp
//
//  Created by ENRAG3DCHICKEN on 2020-09-29.
//  Copyright © 2020 ENRAG3DCHICKEN. All rights reserved.


import SwiftUI

struct LandingView: View {

    @Environment(\.colorScheme) var colorScheme
    
    @State var selection: Int? = nil
    @State var carouselPane: Int = 0
    
    var body: some View {
                VStack(alignment: .center) {
                    
                    Text("")
                        .navigationBarTitle("")
                        .navigationBarHidden(true)
                    
                    Text("pharmacie")
                        .bold()
                        .foregroundColor(colorScheme == .dark ? Color(UIColor.neonGreen) : (Color(UIColor.mainColor)))
                        .font(.largeTitle)
                        .padding()

//                    Image(systemName: "cross.fill")
//                        .foregroundColor(colorScheme == .dark ? Color(.green) : (Color(UIColor.mainColor)))
//                        .font(.largeTitle)
//                        .padding()
                    
                        GeometryReader { geometry in
                        CarouselView(geoemtry: geometry, carouselPane: carouselPane)
                    

                            .offset(CGSize(width: panOffset.width, height: 0))
                    }
                        .edgesIgnoringSafeArea(.horizontal)
                        .gesture(self.panGesture())
                        .animation(.easeInOut)

                            HStack {
                                Image(systemName: "circle.fill").foregroundColor(Color(((carouselPane == 0 && colorScheme != .dark) ? UIColor.mainColor : (carouselPane == 0 && colorScheme == .dark) ? UIColor.mainColor : .lightGray)))
                                Image(systemName: "circle.fill").foregroundColor(Color(((carouselPane == 1 && colorScheme != .dark) ? UIColor.mainColor : (carouselPane == 1 && colorScheme == .dark) ? UIColor.mainColor : .lightGray)))
                                Image(systemName: "circle.fill").foregroundColor(Color(((carouselPane == 2 && colorScheme != .dark) ? UIColor.mainColor : (carouselPane == 2 && colorScheme == .dark) ? UIColor.mainColor : .lightGray)))
                                Image(systemName: "circle.fill").foregroundColor(Color(((carouselPane == 3 && colorScheme != .dark) ? UIColor.mainColor : (carouselPane == 3 && colorScheme == .dark) ? UIColor.mainColor : .lightGray)))
                            }
                                .frame(maxHeight: 20)
                                .padding()
                    
                    VStack(alignment: .center) {
                        Text(text1[carouselPane])
                            .padding(6)
                            .font(.headline)
                            .multilineTextAlignment(.center)
                        Text(text2[carouselPane])
                            .padding(6)
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.08)
                            .font(.subheadline)
                            .multilineTextAlignment(.center)

                    }
                        

                    HStack {
                        NavigationLink(destination: SignUpView(), tag: 1, selection: $selection) {
                            Button(action: {
                                self.selection = 1
                            }, label: { Text("Sign Up").font(.body) })
                            
                                .frame(width: UIScreen.main.bounds.width / 2.5, height: 30)
                                .foregroundColor(Color(UIColor.mainColor))
                                .background(colorScheme == .light ? Color(.white) : Color(UIColor.shadedWhite))
                                .cornerRadius(10)
                                .background(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2))
                                .foregroundColor(Color(UIColor.mainColor))
                                .padding()
                                
                        }
                        NavigationLink(destination: LoginView(), tag: 2, selection: $selection) {
                            Button(action: {
                                self.selection = 2
                            }, label: { Text("Login").font(.body) })
                                .frame(width: UIScreen.main.bounds.width / 2.5, height: 30)
                                .foregroundColor(Color(UIColor.white))
                                .background(Color(UIColor.mainColor))
                                .cornerRadius(10)
                                .padding()
                        }
                    }
                    Spacer()
            }
        }
    @State var steadyStatePanOffset: CGSize = .zero
    @GestureState var gesturePanOffset: CGSize = .zero

    private var panOffset: CGSize {
        (steadyStatePanOffset + gesturePanOffset)
    }


    private func panGesture() -> some Gesture {
        DragGesture()
            .updating($gesturePanOffset) { latestDragGestureValue, gesturePanOffset, transaction in
                
                if carouselPane != 0 && latestDragGestureValue.translation.width > 0 || carouselPane != 3 && latestDragGestureValue.translation.width < 0 {
                    gesturePanOffset = latestDragGestureValue.translation
                }
        }
        .onEnded { finalDragGestureValue in
            print(finalDragGestureValue.translation)
            
            if carouselPane != 0 && finalDragGestureValue.translation.width > 0 && finalDragGestureValue.translation.width > (UIScreen.main.bounds.width * 0.3) {
                steadyStatePanOffset = steadyStatePanOffset + CGSize(width: UIScreen.main.bounds.width, height: 0)
                carouselPane -= 1
            }
            
            if carouselPane != 3 && finalDragGestureValue.translation.width < 0 && (finalDragGestureValue.translation.width * -1) > (UIScreen.main.bounds.width * 0.3) {
                steadyStatePanOffset = steadyStatePanOffset - CGSize(width: UIScreen.main.bounds.width, height: 0)
                carouselPane += 1
            }


            print(steadyStatePanOffset)
            print(UIScreen.main.bounds.width)
        }
    }
}





struct CarouselView: View {
    
    var passedCarouselPane: Int
    var passedGeometry: GeometryProxy
    
    init(geoemtry: GeometryProxy, carouselPane: Int){
        self.passedGeometry = geoemtry
        self.passedCarouselPane = carouselPane
    }
    
    var body: some View {
        

        CardView(geometry: passedGeometry, carouselPane: passedCarouselPane)
    }
}

struct CardView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var passedCarouselPane: Int
    var passedGeometry: GeometryProxy
    
    init(geometry: GeometryProxy, carouselPane: Int) {
        self.passedGeometry = geometry
        self.passedCarouselPane = carouselPane
    }
    var body: some View {
        
        Group {
            
            //
            if colorScheme == .dark {
                HStack(spacing: 0) {
                    ForEach(cardList1, id: \.id) { cards in
                        Image(cards.fileName).centerCropped()
                            .frame(width: passedGeometry.size.width, height: passedGeometry.size.height)
                            .opacity(cards.id == passedCarouselPane+1 ? 1 : 0.6)
                    }
                }
            }
            
            //
            if colorScheme == .light {
                HStack(spacing: 0) {
                    ForEach(cardList2, id: \.id) { cards in
                        Image(cards.fileName).centerCropped()
                            .frame(width: passedGeometry.size.width, height: passedGeometry.size.height)
                            
                    }
                }
            }
        }
        
    }
}


var cardList1: Array<Card> {
    [
        Card(id: 1, fileName: "pharmacy_florianOlivoUnsplash", label: "Euro Pharmacy at Night"),
        Card(id: 2, fileName: "stretching_Unsplash", label: "Female doing Yoga"),
        Card(id: 3, fileName: "coffee_Unsplash", label: "Modern Coffee"),
        Card(id: 4, fileName: "family_Unsplash", label: "Family Celebration")
    ]
}

var cardList2: Array<Card> {
    [
        Card(id: 1, fileName: "pharmacieWikimedia", label: "Parisian Pharmacy"),
        Card(id: 2, fileName: "stretching_Unsplash", label: "Female doing Yoga"),
        Card(id: 3, fileName: "coffee_Unsplash", label: "Modern Coffee"),
        Card(id: 4, fileName: "family_Unsplash", label: "Family Celebration")
    ]
}





struct Card {
    
    var id: Int
    var fileName: String
    var label: String
}

var text1 = ["Discover local independent pharmacies", "Find a pharmacist that's perfect for you", "Discuss your healthcare in confidence", "Get prescriptions delivered to your home"]

var text2 = ["""
            Fill your prescription with one of the many local independent pharmacies in your home city
            """,
            """
            Get information about local pharmacists and choose the service provider that meets your needs
            """,
            """
            Learn more about your healthcare and medication needs within a safe and private environment
            """,
            """
            With just a few taps, obtain personalized medicine delivered to your home quickly and easily
            """]








