//
//  ContentView.swift
//  Shared
//
//  Created by Saad Ata on 2/18/23.
//

import SwiftUI


struct ContentView: View {
    
    
    // MARK: PROPERTIES
    @StateObject var vm = ListViewModel()
    
    
    // MARK: BODY
    var body: some View {
        VStack {
            HStack {
                fetchButton
                Spacer()
                centerText
                Spacer()
                sortButton
            }.padding()
            itemsList
        }
    }
}


extension ContentView {
    
    // Returns the fetch button
    private var fetchButton: some View {
        VStack{
            RoundButtonView(imageName: "square.and.arrow.down.fill", colorStr: .orange)
                .onTapGesture {
                    vm.removeNullNames()
                }
            Text("Fetch!")
                .font(.headline)
                .foregroundColor(.black)
        }
    }
    
    // Returns the "Data Downloader" text
    private var centerText: some View {
        Text("Data Downlaoder")
            .font(.headline)
            .foregroundColor(.black)
    }
    
    // Returns the sort button
    private var sortButton: some View {
        VStack{
            RoundButtonView(imageName: "rectangle.grid.1x2", colorStr: .black)
                .onTapGesture {
                    vm.sort()
                }
            Text("Sort!")
                .font(.headline)
                .foregroundColor(.black)
        }
    }
    
    
    // Returns the list
    private var itemsList: some View {
        List {
            ForEach(vm.nullStringRemoved) {thing in
                HStack{
                    VStack(alignment: .leading){
                        Text("ListID: \(thing.listId)")
                            .font(.headline)
                        Text("ID: \(thing.id)")
                            .font(.subheadline)
                    }
                    Spacer()
                    Text(thing.name ?? "")
                        .foregroundColor(.orange)
                        .font(.headline)
                }
            }
        }
    }
}
    
    // MARK: PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
