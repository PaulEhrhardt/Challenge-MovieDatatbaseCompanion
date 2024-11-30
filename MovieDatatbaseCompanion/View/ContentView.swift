//
//  ContentView.swift
//  MovieDatatbaseCompanion
//
//  Created by Paul Ehrhardt on 29/11/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    @State var selection: MenuItem?
    
    
    var body: some View {
        NavigationSplitView {
            List(selection: $selection) {
                Section {
                    ForEach(MenuItem.menuItems, id: \.self) { item in
                        NavigationLink(value: item) {
                            Label(item.title, systemImage: item.symbol)
                        }
                    }
                }
            }
        } detail: {
            if let selection = selection {
                NavigationStack {
                    switch selection.type {
                    case .trending:
                        TrendingView()
                    case .search:
                        SearchView()
                    }
                }
            } else {
                Text("Please select a menu item.")
            }
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
