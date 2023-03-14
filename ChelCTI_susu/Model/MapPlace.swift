//
//  MapPlace.swift
//  ChelCTI_susu
//
//  Created by Артем Васин on 18.07.2022.
//

import Foundation
import MapKit

struct Place: Identifiable, Equatable, Hashable {
    let name: String
    let index: Int
    let address: String
    let manager: String?
    let phoneNumbers: [String]?
    let graphic: String
    let coordinate: CLLocationCoordinate2D
    
    var id: Int {
        index
    }
}

extension Place {
    static let places: [Place] = [
        Place(name: "Сосновское подразделение", index: 456510, address: "с. Долгодеревенское, ул. Набережная, 1.", manager: "Старший менеджер управления Бушмина Елена Николаевна", phoneNumbers: ["8 (351-44) 3-20-21"], graphic: "пн-чт: с 8:30 до 17:00\nпт: с 8:30 до 16:00\nобед с 12:00 до 12:45", coordinate: CLLocationCoordinate2D(latitude: 55.347602, longitude: 61.347756)),
        Place(name: "Красноармейское подразделение", index: 456660, address: "с. Миасское,ул. Ленина, д. 29а", manager: nil, phoneNumbers: ["8 (351-50) 2-02-52"], graphic: "пн-чт: с 8:30 до 17:00\nпт: с 8:30 до 16:00\nобед с 12:00 до 12:45", coordinate: CLLocationCoordinate2D(latitude: 55.286348, longitude: 61.894705)),
        Place(name: "Аргаяшское подразделение", index: 456880, address: "с. Аргаяш,ул. Ленина, д. 16", manager: nil, phoneNumbers: ["8 (35131) 2-18-47"], graphic: "пн-чт: с 8:30 до 17:00\nпт: с 8:30 до 16:00\nобед с 12:00 до 12:45", coordinate: CLLocationCoordinate2D(latitude: 55.490733, longitude: 60.878809)),
        Place(name: "Копейское подразделение", index: 456618, address: "г. Копейск, ул. Борьбы, 23", manager: "Старший менеджер управления Кох Нелли Николаевна", phoneNumbers: ["8 (351-39) 3-33-83"], graphic: "пн-чт: с 8:30 до 17:00\nпт: с 8:30 до 16:00\nобед с 12:00 до 12:45", coordinate: CLLocationCoordinate2D(latitude: 55.11285, longitude: 61.623395)),
        Place(name: "Еманжелинское подразделение", index: 456580, address: "Еманжелинск, ул. Ленина, д. 4", manager: nil, phoneNumbers: ["8 (35138) 2-25-12"], graphic: "пн-чт: с 8:30 до 17:00\nпт: с 8:30 до 16:00\nобед с 12:00 до 12:45", coordinate: CLLocationCoordinate2D(latitude: 54.751767, longitude: 61.318363)),
        Place(name: "Еткульское подразделение", index: 456560, address: "с. Еткуль,ул. Первомайская, д. 1", manager: nil, phoneNumbers: ["8 (35145) 2-15-30", "8 (35145) 2-15-39"], graphic: "пн-чт: с 8:30 до 17:00\nпт: с 8:30 до 16:00\nобед с 12:00 до 12:45", coordinate: CLLocationCoordinate2D(latitude: 54.823958, longitude: 61.592718)),
        Place(name: "Усть-Катавское подразделение", index: 456043, address: "Усть-Катав, ул. 40 лет Октября, д. 4", manager: "Старший менеджер Андреева Елена Николаевна", phoneNumbers: ["8 (351-59) 3-16-83", "8 (351-59) 3-03-45"], graphic: "пн-чт: с 8:30 до 17:00\nпт: с 8:30 до 16:00\nобед с 12:00 до 12:45", coordinate: CLLocationCoordinate2D(latitude: 54.928189, longitude: 58.165861)),
        Place(name: "Ашинское подразделение", index: 456000, address: "г. Аша, ул. Озимина, д. 38", manager: "Директор Лосева Татьяна Михайловна", phoneNumbers: ["8 (351-59) 3-16-83", "8 (351-59) 3-03-45"], graphic: "пн-чт: с 8:30 до 17:00\nпт: с 8:30 до 16:00\nобед с 12:00 до 12:45", coordinate: CLLocationCoordinate2D(latitude: 54.984941, longitude: 57.280409)),
        Place(name: "Златоустовское подразделение", index: 456200, address: "г. Златоуст, ул. Скворцова, д. 18", manager: "Старший менеджер Татаринцева Анастасия Олеговна", phoneNumbers: ["8 (351-36) 2-07-78"], graphic: "пн-чт: с 8:30 до 17:00\nпт: с 8:30 до 16:00\nобед с 12:00 до 12:45", coordinate: CLLocationCoordinate2D(latitude: 55.174702, longitude: 59.669254)),
        Place(name: "Саткинское подразделение", index: 456910, address: "г. Сатка, ул. Солнечная, д. 27", manager: nil, phoneNumbers: ["8 (351-61) 4-35-13"], graphic: "пн-чт: с 8:30 до 17:00\nпт: с 8:30 до 16:00\nобед с 12:00 до 12:45", coordinate: CLLocationCoordinate2D(latitude: 55.037779, longitude: 58.976788)),
        Place(name: "Кусинское подразделение", index: 456940, address: "г. Куса, ул. Индустриальная, д. 49", manager: nil, phoneNumbers: ["8 (351-54) 3-37-74"], graphic: "пн-чт: с 8:30 до 17:00\nпт: с 8:30 до 16:00\nобед с 12:00 до 12:45", coordinate: CLLocationCoordinate2D(latitude: 55.341823, longitude: 59.445232)),
        Place(name: "Каслинское подразделение", index: 456835, address: "г. Касли, ул. Ленина, д. 27", manager: "старший менеджер Шмаков Иван Николаевич", phoneNumbers: ["8 (351-49) 2-15-53"], graphic: "пн-чт: с 8:30 до 17:00\nпт: с 8:30 до 16:00\nобед с 12:00 до 12:45", coordinate: CLLocationCoordinate2D(latitude: 55.905058, longitude: 60.743163)),
        Place(name: "Снежинское подразделение", index: 456770, address: "г. Снежинск, ул. Свердлова, д. 1", manager: nil, phoneNumbers: ["8 (351-46) 2-66-85"], graphic: "пн-чт: с 8:30 до 17:00\nпт: с 8:30 до 16:00\nобед с 12:00 до 12:45", coordinate: CLLocationCoordinate2D(latitude: 56.083687, longitude: 60.731261)),
        Place(name: "Нязепетровское подразделение", index: 456970, address: "г. Нязепетровск, ул. Мира, д. 5", manager: nil, phoneNumbers: ["8 (351-56) 3-19-02"], graphic: "пн-чт: с 8:30 до 17:00\nпт: с 8:30 до 16:00\nобед с 12:00 до 12:45", coordinate: CLLocationCoordinate2D(latitude: 56.05491, longitude: 59.601943)),
        Place(name: "Озерское подразделение", index: 456780, address: "г. Озерск, пр. Ленина, д. 62", manager: nil, phoneNumbers: nil, graphic: "пн-чт: с 8:30 до 17:00\nпт: с 8:30 до 16:00\nобед с 12:00 до 12:45", coordinate: CLLocationCoordinate2D(latitude: 55.763878, longitude: 60.708362)),
        Place(name: "Пункт приема Кыштым", index: 456870, address: "ул. Республики, д. 4", manager: nil, phoneNumbers: nil, graphic: "пн-чт: с 8:30 до 17:00\nпт: с 8:30 до 16:00\nобед с 12:00 до 12:45", coordinate: CLLocationCoordinate2D(latitude: 55.709530, longitude: 60.539641)),
        Place(name: "Пункт приема Верхний Уфалей", index: 456805, address: "ул. Ленина, д. 4", manager: nil, phoneNumbers: nil, graphic: "пн-чт: с 8:30 до 17:00\nпт: с 8:30 до 16:00\nобед с 12:00 до 12:45", coordinate: CLLocationCoordinate2D(latitude: 56.076950, longitude: 60.232633)),
        // Чебаркульское управление
        Place(name: "Чебаркульское подразделение", index: 456440, address: "г. Чебаркуль, ул. Дзержинского, д. 6А/1", manager: "Старший менеджер Смирнова Наталья Владимировна", phoneNumbers: ["8 (351) 2-07-33"], graphic: "пн-чт: с 8:30 до 17:00\nпт: с 8:30 до 16:00\nобед с 12:00 до 12:45", coordinate: CLLocationCoordinate2D(latitude: 54.974582, longitude: 60.380909)),
        Place(name: "Уйское подразделение", index: 456470, address: "с. Уйское, ул. Дорожников, д. 24", manager: nil, phoneNumbers: ["8 (351-65) 3-10-07"], graphic: "пн-чт: с 8:30 до 17:00\nпт: с 8:30 до 16:00\nобед с 12:00 до 12:45", coordinate: CLLocationCoordinate2D(latitude: 54.372691, longitude: 59.999789)),
        Place(name: "Миасское подразделение", index: 456317, address: "г. Миасс, ул. Академика Павлова, д. 32", manager: nil, phoneNumbers: ["8 (3513) 55-71-39", "Факс: 8 (3513) 55-64-44"], graphic: "пн-чт: с 8:30 до 17:00\nпт: с 8:30 до 16:00\nобед с 12:00 до 12:45", coordinate: CLLocationCoordinate2D(latitude: 55.037082, longitude: 60.110507)),
        Place(name: "Увельское подразделение", index: 457000, address: "пос. Увельский, ул. Октябрьская, д. 19", manager: "Старший менеджер Калинина Наталья Николаевна", phoneNumbers: ["8 (351-66) 3-20-12"], graphic: "пн-чт: с 8:30 до 17:00\nпт: с 8:30 до 16:00\nобед с 12:00 до 12:45", coordinate: CLLocationCoordinate2D(latitude: 54.443136, longitude: 61.355895)),
        Place(name: "Пластовское подразделение", index: 457020, address: "г. Пласт, ул. Строителей, д. 9", manager: nil, phoneNumbers: ["8 (351-60) 2-16-29", "8 (351-60) 2-12-16"], graphic: "пн-чт: с 8:30 до 17:00\nпт: с 8:30 до 16:00\nобед с 12:00 до 12:45", coordinate: CLLocationCoordinate2D(latitude: 54.35314, longitude: 60.812064)),
        Place(name: "Октябрьское подразделение", index: 457170, address: "с. Октябрьское, ул. Ленина, д. 36", manager: nil, phoneNumbers: ["8 (351-58) 5-19-84"], graphic: "пн-чт: с 8:30 до 17:00\nпт: с 8:30 до 16:00\nобед с 12:00 до 12:45", coordinate: CLLocationCoordinate2D(latitude: 54.405406, longitude: 62.727946)),
        Place(name: "Пункт приема Троицк", index: 457100, address: "г. Троицк, ул. Крахмалёва, д. 1", manager: nil, phoneNumbers: nil, graphic: "пн-чт: с 8:30 до 17:00\nпт: с 8:30 до 16:00\nобед с 12:00 до 12:45", coordinate: CLLocationCoordinate2D(latitude: 54.094935, longitude: 61.568077)),
        Place(name: "Карталинское подразделение", index: 457358, address: "г. Карталы, ул. Заводская, д.2", manager: "Старший менеджер Чернышова Татьяна Вячеславовна", phoneNumbers: ["8 (351-33) 2-09-09"], graphic: "пн-чт: с 8:30 до 17:00\nпт: с 8:30 до 16:00\nобед с 12:00 до 12:45", coordinate: CLLocationCoordinate2D(latitude: 53.064478, longitude: 60.634063)),
        Place(name: "Варненское подразделение", index: 457200, address: "с. Варна, ул. Советская, д. 139", manager: nil, phoneNumbers: ["8 (351-42) 2-20-65"], graphic: "пн-чт: с 8:30 до 17:00\nпт: с 8:30 до 16:00\nобед с 12:00 до 12:45", coordinate: CLLocationCoordinate2D(latitude: 53.376028, longitude: 60.979276)),
        Place(name: "Магнитогорское подразделение", index: 455001, address: "г. Магнитогорск, пр. Ленина, д. 12", manager: "Старший менеджер Иванов Владимир Иванович", phoneNumbers: ["8 (351-9) 22-19-77"], graphic: "пн-чт: с 8:30 до 17:00\nпт: с 8:30 до 16:00\nобед с 12:00 до 12:45", coordinate: CLLocationCoordinate2D(latitude: 53.431215, longitude: 58.98322)),
        Place(name: "Кизильское подразделение", index: 457610, address: "с. Кизильское, ул. Труда д. 11", manager: nil, phoneNumbers: ["8 (351-55) 3-00-33"], graphic: "пн-чт: с 8:30 до 17:00\nпт: с 8:30 до 16:00\nобед с 12:00 до 12:45", coordinate: CLLocationCoordinate2D(latitude: 52.725708, longitude: 58.88728)),
        Place(name: "Верхнеуральское подразделение", index: 457670, address: "г. Верхнеуральск, ул. Мира, д. 85", manager: nil, phoneNumbers: ["8 (351-43) 2-11-36"], graphic: "пн-чт: с 8:30 до 17:00\nпт: с 8:30 до 16:00\nобед с 12:00 до 12:45", coordinate: CLLocationCoordinate2D(latitude: 53.877619, longitude: 59.217842)),
    ]
}
