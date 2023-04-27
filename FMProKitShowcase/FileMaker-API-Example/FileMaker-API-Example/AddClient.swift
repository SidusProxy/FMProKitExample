//
//  AddClient.swift
//  FileMaker-API-Example
//
//  Created by Gianluca Annina on 20/04/23.
//

import SwiftUI

struct AddClient: View {
    @State var name = ""
    @State var surname = ""
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack{
            
            TextField("Name", text: $name).textFieldStyle(.roundedBorder).padding()
            TextField("Lastname", text: $surname).textFieldStyle(.roundedBorder).padding()
            
        }
        .navigationTitle("Add Client")
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    Task{
                        do{
                            try await ModelFetcher.shared.addClient(client: Client(clientID: nil, firstName: name, lastName: surname))
                            presentationMode.wrappedValue.dismiss()
                        }catch {
                            print(error)
                        }
                    }
                }, label: {Text("Done")})
            }
        }
    }
}
