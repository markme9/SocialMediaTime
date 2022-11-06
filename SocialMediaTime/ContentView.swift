//
//  ContentView.swift
//  SocialMediaTime
//
//  Created by zoya me on 11/6/22.
//

import SwiftUI

struct Person: Identifiable, Codable {
    var id = UUID()
    var name: String
    var address: String
    var date: Date
}

class ViewModel: ObservableObject {
    @Published var person: [Person] = [] {
        
        didSet {
            incodeDate()
        }
    }
    init() {
        decodedData()
    }
    func incodeDate() {
        if let data = try? JSONEncoder().encode(person) {
            UserDefaults.standard.set(data, forKey: "key")
        }
    }
    func decodedData() {
        guard let decode = UserDefaults.standard.data(forKey: "key") else { return }
        guard let savedIt = try? JSONDecoder().decode([Person].self, from: decode) else { return }
        self.person = savedIt
    }
}

struct ContentView: View {
    
    @StateObject var vm = ViewModel()
    @State var isPresented: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(vm.person) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.title2.bold())
                            Text(item.address)
                                .font(.headline.bold())
                                .foregroundColor(Color.green)
                        }
                        Spacer()
                        Text("\(item.date.timeAgo())")
                            .font(.headline)
                            .foregroundColor(Color(UIColor.magenta))
                    }
                }
                .onDelete { index in
                    withAnimation {
                        vm.person.remove(atOffsets: index)
                    }
                }
            }
            .navigationTitle(Text("Add New Things"))
            .navigationBarItems(trailing: Button(action: {
                isPresented.toggle()
            }, label: {
                Image(systemName: "plus")
                    .font(.headline.bold())
            }))
            .sheet(isPresented: $isPresented) {
                PersonDetails(person: { person in
                    self.vm.person.append(person)
                })
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension Date {
    
    func timeAgo() -> String {
        
        let secondsAgo = Int(Date().timeIntervalSince(self))
        
        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day
        let month = 4 * week
        
        let number: Int
        let unit: String
        
        if secondsAgo < minute {
            number = secondsAgo
            unit = "second"
        } else if secondsAgo < hour {
            number = secondsAgo / minute
            unit = "min"
        } else if secondsAgo < day {
            number = secondsAgo / hour
            unit = "hour"
        } else if secondsAgo < week {
            number = secondsAgo / day
            unit = "day"
        } else if secondsAgo < month {
            number = secondsAgo / week
            unit = "week"
        } else {
            number = secondsAgo / month
            unit = "month"
        }
        return "\(number) \(unit)\(number == 1 ? "" : "s") ago"
    }
}
