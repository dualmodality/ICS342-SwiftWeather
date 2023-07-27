//
//  ContentView.swift
//  SwiftWeather
//
//  Created by Joselyn on 7/17/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    var body: some View {
        NavigationView {
            VStack(){
                Text("St. Paul, MN").font(.headline).italic().fontWeight(.light).padding(16)
                Divider()
                HStack{
                    VStack{
                        Text("76ºF").font(.system(size: 64))
                        HStack {
                            Text("Feels Like:")
                            Text("73ºF")
                        }
                    }
                    Image("CurrentConditionsIcons").resizable().aspectRatio(contentMode: .fit).frame(width: 200, height: 200)
                }
                HStack {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Low:")
                            Text("68ºF")
                        }
                        HStack {
                            Text("High:")
                            Text("81ºF")
                        }
                        HStack {
                            Text("Humidity:")
                            Text("68%")
                        }
                        HStack {
                            Text("Pressure:")
                            Text("1023 mBa")
                        }
                    }.padding(16)
                    Spacer()
                }
                Spacer()
            }
            .navigationTitle("SwiftWeather")
            /*.toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("SwiftWeather").font(.largeTitle)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            Text("Select an item")*/
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
