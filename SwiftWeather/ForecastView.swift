//
//  ForecastView.swift
//  SwiftWeather
//
//  Created by Joselyn on 7/21/23.
//

import SwiftUI

struct ForecastView: View {
    @StateObject var viewModel: ForeCastViewModel
    var body: some View {
        NavigationStack {
            LazyVStack {
                ForEach(viewModel.MultiDay, id: \.date) { forecast in
                    DayForecastView(forecast: forecast)
                }.padding(8)
            }
            .navigationTitle("16–Day Forecast")
            .toolbarBackground(Color.teal, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
    
}

struct DayForecastView: View {
    let forecast : DayForecast
    let dateFormatter = DateFormatter()
    let timeFormatter = DateFormatter()
    
    var body: some View {
        dateFormatter.dateFormat = "MMM d"
        timeFormatter.dateFormat = "H:mma"
        
        return HStack {
            Image(uiImage: forecast.icon)
            Spacer()
            Text(dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(integerLiteral: forecast.date))))
            Spacer()
            VStack(alignment: .leading) {
                Text("Temp: " + String(Int(forecast.dayTemp)) + "ºF")
                HStack{
                    Text("Low: " + String(Int(forecast.minTemp)) + "ºF")
                    Text("High: " + String(Int(forecast.maxTemp)) + "ºF")
                }
                 
             }
            Spacer()
            VStack(alignment: .leading) {
                Text("Sunrise: " + timeFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(integerLiteral: forecast.sunrise))))
                Text("Sunset: " + timeFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(integerLiteral: forecast.sunset))))
            }
            
        }
    }
    
    
}

struct ForecastView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastView(viewModel: ForeCastViewModel())
    }
}
