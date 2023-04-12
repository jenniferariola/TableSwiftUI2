//
//  ContentView.swift
//  TableSwiftUI2
//
//  Created by Ariola, Jennifer M on 4/12/23.
//

import SwiftUI
       import MapKit
       
       let data = [
        Item(name: "Zelick's Icehouse", neighborhood: "Downtown", desc: "An outdoor bar located near Gumby's Pizza. Events such as drag shows, trivia, and karaoke are offered weekly here! Great spot to spend time and get some fresh air with friends! Try their delicious Dos-a-Rita's!", lat: 29.882480, long: -97.945410, imageName: "Image"),
        Item(name: "The Taproom", neighborhood: "The Square", desc: "If you like beer, Taproom is a great choice of venue for you! Also with a nice selection of food, Taproom is one of the original bars in San Marcos. ", lat: 29.883390, long: -97.940650, imageName: "Image 3"),
        Item(name: "The Marc", neighborhood: "The Square", desc: "Recently reopened, The Marc is a great venue for a fun night ut! This venue has live DJ's and artists perform often. Check their website for their event schedule!", lat: 29.882030, long: -97.940540, imageName: "Image 1"),
        Item(name: "Mayloo's", neighborhood: "The Square", desc: "Mayloo's is a fan favorite here in San Marcos. A great bar for college students and to bring friends. Make sure to try to the classic gameface.", lat: 29.883070, long: -97.939840, imageName: "Image 3"),
        Item(name: "Chance's R", neighborhood: "Downtown", desc: "A great hole in the wall located just off the square in San Marcos. This bar has the friendliest staff and cheap drinks! Join on Wednesday's for Karaoke with host Brandon Summers.", lat: 29.875260, long: -97.938850, imageName: "Image 4")
          
       ]
       struct Item: Identifiable {
             let id = UUID()
             let name: String
             let neighborhood: String
             let desc: String
             let lat: Double
             let long: Double
             let imageName: String
         }
       
       struct ContentView: View {
           @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 29.883390, longitude: -97.940650), span: MKCoordinateSpan(latitudeDelta: 0.04, longitudeDelta: 0.04
                                                                                                                                                            ))
           
           var body: some View {
               NavigationView {
                   VStack {
                       List(data, id: \.name) { item in
                           NavigationLink(destination: DetailView(item: item)) {
                               HStack {
                                   Image(item.imageName)
                                       .resizable()
                                       .frame(width: 50, height: 50)
                                       .cornerRadius(10)
                                   VStack(alignment: .leading) {
                                       Text(item.name)
                                           .font(.headline)
                                       Text(item.neighborhood)
                                           .font(.subheadline)
                                   }
                               }
                           }
                       }
                       Map(coordinateRegion: $region, annotationItems: data) { item in
                                       MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)) {
                                           Image(systemName: "mappin.circle.fill")
                                               .foregroundColor(.red)
                                               .font(.title)
                                               .overlay(
                                                   Text(item.name)
                                                       .font(.subheadline)
                                                       .foregroundColor(.black)
                                                       .fixedSize(horizontal: true, vertical: false)
                                                       .offset(y: 25)
                                               )
                                       }
                                   }
                                   .frame(height: 300)
                                   .padding(.bottom, -30)
                   }
                   .listStyle(PlainListStyle())
                           .navigationTitle("San Marcos Bars")
               }
           }
       }
       
       struct DetailView: View {
           @State private var region: MKCoordinateRegion
                 
                 init(item: Item) {
                     self.item = item
                     _region = State(initialValue: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long), span: MKCoordinateSpan(latitudeDelta: 0.20, longitudeDelta: 0.20)))
                 }
           
               let item: Item
           
                       
               var body: some View {
                   VStack {
                       Image(item.imageName)
                           .resizable()
                           .aspectRatio(contentMode: .fit)
                           .frame(maxWidth: 200)
                       Text("Neighborhood: \(item.neighborhood)")
                           .font(.subheadline)
                       Text("Description: \(item.desc)")
                           .font(.subheadline)
                           .padding(10)
                           }
                            .navigationTitle(item.name)
                   Map(coordinateRegion: $region, annotationItems: [item]) { item in
                           MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)) {
                               Image(systemName: "mappin.circle.fill")
                                   .foregroundColor(.red)
                                   .font(.title)
                                   .overlay(
                                       Text(item.name)
                                           .font(.subheadline)
                                           .foregroundColor(.black)
                                           .fixedSize(horizontal: true, vertical: false)
                                           .offset(y: 25)
                                   )
                           }
                       }
                       .frame(height: 300)
                       .padding(.bottom, -30)
                }
             }
           
       
       struct ContentView_Previews: PreviewProvider {
           static var previews: some View {
               ContentView()
           }
       }
                   
   
