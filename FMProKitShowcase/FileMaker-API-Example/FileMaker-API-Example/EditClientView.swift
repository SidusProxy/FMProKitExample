//
//  EditClientView.swift
//  FileMaker-API-Example
//
//  Created by Gianluca Annina on 24/04/23.
//

import SwiftUI


struct EditClientView_Previews: PreviewProvider {
    static var previews: some View {
        EditClientView(client: Client(clientID: 0, firstName: "", lastName: ""))
    }
}

import SwiftUI

struct EditClientView: View {
    var client:Client
    @State var name = ""
    @State var surname = ""
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        VStack{
            
            TextField("Name", text: $name).textFieldStyle(.roundedBorder).padding()
            TextField("Lastname", text: $surname).textFieldStyle(.roundedBorder).padding()
           
        }.navigationTitle("Edit Client")
        .onAppear(){
            name = client.firstName ?? ""
            surname = client.lastName ?? ""
        }
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    Task{
                        do{
                            try await ModelFetcher.shared.editClient(client: Client(clientID: client.clientID, firstName: name, lastName: surname), id: client.clientID ?? 0)
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
