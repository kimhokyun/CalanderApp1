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
