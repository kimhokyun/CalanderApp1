import Foundation

func makeTimeFormat(format:String,date:Date) -> String{
    //https://formestory.tistory.com/6
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format // "a hh:mm", "yyyy-mm-dd a hh:mm:ss" etc...
    dateFormatter.locale = Locale(identifier:"ko_KR")
    return dateFormatter.string(from: date)
    
    // 사용 예제
//    let dateFormat:String = "yyyy-mm-dd a hh:mm:ss EEEEE"
//    currentDate = makeTimeFormat(format:dateFormat,date:Date.now)
}

//// 날짜의 구성요소 한 개 가져오기
//let components1 = calendar.component(.year, from: now)
//// 2023
//
//// 날짜의 구성요소 여러 개 가져오기
//let components2 = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: now)


func weekday(year: Int, month: Int, day: Int) -> String? {
    let calendar = Calendar(identifier: .gregorian)
    
    guard let targetDate: Date = {
        let comps = DateComponents(calendar:calendar, year: year, month: month, day: day)
        return comps.date
        }() else { return nil }
    
    let day = Calendar.current.component(.weekday, from: targetDate) - 1
    
    return Calendar.current.shortWeekdaySymbols[day] // ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
//    return Calendar.current.standaloneWeekdaySymbols[day] // ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday",
//    return Calendar.current.veryShortWeekdaySymbols[day] // ["S", "M", "T", "W", "T", "F", "S"]
}
