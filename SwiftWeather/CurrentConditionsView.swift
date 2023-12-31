//
//  ContentView.swift
//  SwiftWeather
//
//  Created by Joselyn on 7/17/23.
//

import SwiftUI
import CoreData

struct CurrentConditionsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject var viewModel: CurrentConditionsViewModel

    var body: some View {
        NavigationStack {
            VStack(){
                HStack(alignment: .center) {
                    Text("ZIP Code:").font(.title).padding(8)
                    Spacer()
                    TextField("ZIP Code:",
                              text: Binding(get:
                                                { return viewModel.userZip! },
                                            set:
                                                { zip in
                        viewModel.userZip = zip;
                    }
                                           )
                    ).font(.title).padding(8)
                    Button(action: {Task {await viewModel.getCurrentConditions()}},
                           label: {Text("Update")}).foregroundColor(Color.black)
                        .frame(width: 100, height: 50).background(Color.teal).containerShape(RoundedRectangle(cornerRadius: 20)).padding(8)
                }
                .alert(isPresented: $viewModel.showInvalidZipWarning, content: {Alert(title: Text("Invalid ZIP Code"),
                                    message: Text("Please enter a valid US ZIP Code (5-digits)"),
                                    dismissButton: .default(Text("Okay")))}
                )
                Text(viewModel.currentConditions.locationName).font(.largeTitle).italic().fontWeight(.light).padding(16)
                Divider()
                HStack{
                    VStack{
                        Text(String(Int(viewModel.currentConditions.weatherData.currentTemp)) + "ºF").font(.system(size: 64))
                        HStack {
                            Text("Feels Like:")
                            Text(String(Int(viewModel.currentConditions.weatherData.feelsLike)) + "ºF")
                        }
                    }
                    
                   Image(uiImage: viewModel.currentConditionsIcon!).resizable().aspectRatio(contentMode: .fit).frame(width: 200, height: 200)
                }
                HStack {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Low:")
                            Text(String(Int(viewModel.currentConditions.weatherData.minTemp)) + "ºF")
                        }
                        HStack {
                            Text("High:")
                            Text(String(Int(viewModel.currentConditions.weatherData.maxTemp)) + "ºF")
                        }
                        HStack {
                            Text("Humidity:")
                            Text(String((viewModel.currentConditions.weatherData.humidity)) + "%")
                        }
                        HStack {
                            Text("Pressure:")
                            Text(String((viewModel.currentConditions.weatherData.pressure)) + "hPa")
                        }
                    }.padding(16)
                    Spacer()
                }
                Spacer()
                NavigationLink(destination: ForecastView(viewModel: ForeCastViewModel())) {
                    Text("Daily Forecast").foregroundColor(Color.black)
                        .frame(width: 150, height: 50).background(Color.teal)
                }.containerShape(RoundedRectangle(cornerRadius: 20))
                Spacer()
            }
            .navigationTitle("SwiftWeather")
            .toolbarBackground(Color.teal, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .task {
                do {
                    await viewModel.getCurrentConditions()
                }
            }
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
    /*
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
    } */
}
/*
private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()
*/
struct CurrentConditionsView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentConditionsView(viewModel: CurrentConditionsViewModel()).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
