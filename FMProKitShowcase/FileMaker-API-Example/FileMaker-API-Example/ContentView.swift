//
//  ContentView.swift
//  FileMaker-API-Example
//
//  Created by Francesco De Marco on 19/04/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var clients: [Client] = []
    @State var openAddClient = false

    var body: some View {
        NavigationStack{
            VStack {
                List{
                    ForEach(clients, id: \.self) { client in
                        NavigationLink(destination: {EditClientView(client: client)}, label: {Text(client.firstName ?? "" + (client.lastName ?? ""))})
                        
                    }
                }.listStyle(.inset)
                
                Button("Fetch Clients"){
                    Task{
                        do{
                            clients = try await ModelFetcher.shared.getClients()
                        }catch {
                            print(error)
                        }
                    }
                }
                
                
            }.navigationTitle("Shop")
                .toolbar{
                    ToolbarItem(placement: .navigationBarTrailing) {
                        
                        NavigationLink(destination: {AddClient()}, label: {
                            Image(systemName: "plus")
                        })
                    }
                }
                .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
