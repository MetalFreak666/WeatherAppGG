//
//  ForecastView.swift
//  WeatherAppGG
//
//  Created by Dariusz Orasinski on 09/03/2024.
//

import SwiftUI

struct ForecastScrollView: View {
    let conditions: [ConditionLight]
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 20) {
                ForEach(conditions, id: \.id) { weatherCondition in
                    weatherConditionRow(condition: weatherCondition)
                        .frame(maxWidth: .infinity)
                }
            }
        }
    }
    
    @ViewBuilder
    private func weatherConditionRow(condition: ConditionLight) -> some View {
        VStack(alignment: .leading) {
            iconRowContent(iconName: "mappin", title: "LAT:", text: String(condition.lat))
            iconRowContent(iconName: "mappin", title: "LON:", text: String(condition.lon))
            iconRowContent(iconName: "calendar", title: "Start date:", text: condition.period.dateStart)
            iconRowContent(iconName: "calendar", title: "End date:", text: condition.period.dateEnd)
            iconRowContent(iconName: "humidity.fill", title: "Humidity", text: String(condition.relativeHumidity))
        }
        .padding()
        .background(Rectangle().stroke(Color.black, lineWidth: 1))
    }
    
    @ViewBuilder
    private func iconRowContent(iconName: String, title: String, text: String) -> some View {
        HStack {
            Image(systemName: iconName)
            Text(title)
                .lineLimit(1)
            Text(text)
                .lineLimit(1)
        }
    }
}

#Preview {
    ForecastScrollView(conditions: .init(
        [.init(id: UUID(), 
               period: .init(dateEnd: "2022-10-12", dateStart: "2022-10-12"),
               lon: 21.343424,
               lat: 30.3940939403,
               relativeHumidity: 3)
        ]
    ))
}
