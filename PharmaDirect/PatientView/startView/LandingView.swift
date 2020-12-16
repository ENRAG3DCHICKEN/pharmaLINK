//
//  ContentView.swift
//  TemplateApp
//
//  Created by ENRAG3DCHICKEN on 2020-09-29.
//  Copyright © 2020 ENRAG3DCHICKEN. All rights reserved.


import SwiftUI

struct LandingView: View {

    @State var selection: Int? = nil
    @State var carouselPane: Int = 0
    
    var body: some View {
                VStack(alignment: .center) {
                    
                    Text("")
                        .navigationBarTitle("")
                        .navigationBarHidden(true)
                    

                    HStack {
                        Image("yoga").resizable()
                                .frame(width: 100, height: 50)
                        
                        Text("AllTrails")
                            .foregroundColor(Color(.gray))
                            .font(.title)
                    }
                        .padding()


                        GeometryReader { geometry in
                        CarouselView(geoemtry: geometry, carouselPane: carouselPane)
                    

                            .offset(CGSize(width: panOffset.width, height: 0))
                    }
                        .edgesIgnoringSafeArea(.horizontal)
                        .gesture(self.panGesture())
                        .animation(.easeInOut)


                    GeometryReader { geometry in
                    
                        HStack {
                            Spacer(minLength: geometry.size.width/2.5)
                            HStack {
                                Circle().foregroundColor(Color(carouselPane == 0 ? .black : .lightGray))
                                Circle().foregroundColor(Color(carouselPane == 1 ? .black : .lightGray))
                                Circle().foregroundColor(Color(carouselPane == 2 ? .black : .lightGray))
                                Circle().foregroundColor(Color(carouselPane == 3 ? .black : .lightGray))
                            }
                            Spacer(minLength: geometry.size.width/2.5)
                        }
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.04)
                            
                    }
                        .frame(maxHeight: 20)
                    VStack(alignment: .leading) {
                        Text(text1[carouselPane])
                            .padding(6)
                            .font(.headline)
                        Text(text2[carouselPane])
                            .padding(6)
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.08)
                            .font(.subheadline)

                    }
                        

                    HStack {
                        NavigationLink(destination: SignUpView(), tag: 1, selection: $selection) {
                            Button(action: {
                                self.selection = 1
                            }, label: { Text("Sign Up").font(.body) })
                                .frame(width: UIScreen.main.bounds.width / 2.5, height: 30)
                                .background(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2))
                                .foregroundColor(Color(UIColor.mainColor))
                                .background(Color(.white))
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
    var passedCarouselPane: Int
    var passedGeometry: GeometryProxy
    
    init(geometry: GeometryProxy, carouselPane: Int) {
        self.passedGeometry = geometry
        self.passedCarouselPane = carouselPane
    }
    var body: some View {
        HStack(spacing: 0) {
                ForEach(cardList, id: \.id) { cards in
                    Image(cards.fileName).centerCropped()
                        

                        .frame(width: passedGeometry.size.width, height: passedGeometry.size.height)
                        .opacity(cards.id == passedCarouselPane+1 ? 1 : 0.6)
                        
                }
        }
    }
}

var cardList: Array<Card> {
    [
        Card(id: 1, fileName: "p1-1", label: "pikachu"),
        Card(id: 2, fileName: "p2-2", label: "bulbasaur"),
        Card(id: 3, fileName: "p3-3", label: "charmander"),
        Card(id: 4, fileName: "p4-4", label: "squirtle")
    ]
}

struct Card {
    
    var id: Int
    var fileName: String
    var label: String
}

var text1 = ["Discover 100,000+ trails around the world", "Find a trail that's perfect for you", "Hit the trail with confidence", "Get driving directions right to the trailhead"]

var text2 = ["""
            Explore the largest collection of trail maps anywhere, curated by millions of outdoor ethusiasts like you.
            """,
            """
            Find your perfect hike, bike ride, or run. FIlter by length, rating, and difficulty. Easily find dog and kid-friendly trails.
            """,
            """
            Browse hand-curated trail maps plus reviews, photos and recordings from the AllTrails community.
            """,
            """
            With just one tap, get detailed driving directions so you can quickly and easily get right to the trailhead
            """]







