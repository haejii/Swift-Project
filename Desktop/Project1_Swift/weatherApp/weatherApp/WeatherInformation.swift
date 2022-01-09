//
//  WeatherInformation.swift
//  weatherApp
//
//  Created by 양혜지 on 2022/01/08.
//

import Foundation
/*
 Codable이란?(프로토콜)
 자신을 변환하거나 외부표현으로 변환할 수 있는 타입을 의미함
 여기서 외부 표현이란 JSON과 같은 타입을 의미한다.
 public typealias Codable = Decodable & Encodable
 Decodable: 자신을 외부 표현에서 코딩할 수 있는 타입
 Encodable: 자신을 외부 표현에서 인코딩할 수 있는 타입
 */

struct WeatherInformation: Codable {
    let weather: [Weather]
    let temp: Temp
    let name : String
    
    enum Codingkeys: String, CodingKey {
        case weather
        case temp = "main"
        case name
    }
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

// JSON과 이름 다르게 하고 프로퍼티 이름이 달라도 매핑 시키기
struct Temp: Codable {
    let temp: Double
    let feelsLike: Double
    let minTemp: Double
    let maxTemp: Double
    
    // 매핑시키기
    enum Codingkeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case minTemp = "temp_min"
        case maxTemp = "temp_max"
    }
}
