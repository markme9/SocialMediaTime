//
//  PersonDetails.swift
//  SocialMediaTime
//
//  Created by zoya me on 11/6/22.
//

import SwiftUI

struct PersonDetails: View {
    
    var person: (Person) -> ()
    
    @Environment (\.presentationMode) var presentationMode
    
    @State var name: String = ""
    @State var address: String = ""
    @State var date: Date = Date()
    
    var body: some View {
        ZStack {
            Color.green.opacity(0.4)
                .ignoresSafeArea()
            VStack(alignment: .leading) {
                Text("User Info")
                    .font(.largeTitle.bold())
                    .padding(.leading)
                
                TextField("Name", text: $name)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding([.leading, .trailing])
                
                TextField("Address", text: $address)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding([.leading, .trailing])
                
                Button {
                    
                    self.person(.init(name: name, address: address, date: date))
                    
                    presentationMode.wrappedValue.dismiss()
                    
                } label: {
                    Text("Dismiss")
                        .font(.title.bold())
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.pink)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                        .padding([.leading, .trailing])
                        .padding(.top)
                }

            }
        }
    }
}

struct PersonDetails_Previews: PreviewProvider {
    static var previews: some View {
        PersonDetails(person: {_ in})
    }
}
