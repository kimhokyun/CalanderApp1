
import UIKit

protocol SendDataProtocol {
    func receiveData(data:SampleData)
}

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var dayTitle:[String] = ["일","월","화","수","목","금","토"]
    var days:[Int] = []{
        didSet{
            for i in 0...(current.weekday ?? 0){
                days.insert(i, at: 0)
            }
        }
    }
    var cal:Calendar = Calendar.current
    var current:DateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .weekday], from: Date.now){
        didSet{
            guard let cy = current.year, let cm = current.month else {return}
            self.year = cy
            self.month = cm
            
            var firstDay = DateComponents(year: year, month: month, day: 1)
            var firstDay_Date = cal.date(from:DateComponents(year: year, month: month, day: 1))
            
            days = []
            while firstDay.month == self.month {
                var md = firstDay
                guard let apDay = md.day else {return}
                days.append(apDay)
                guard let fdd = firstDay_Date else {return}
                firstDay_Date = cal.date(byAdding: .day, value: 1, to: fdd)
                firstDay = cal.dateComponents([.year, .month, .day], from: firstDay_Date!)
            }
            
            updatePage()
            
        }
    }
    var year:Int = 0
    var month:Int = 0
    var sampleData = SampleData()
    var sampleDatas = [SampleData](){
        didSet{
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(self.sampleDatas) {
                UserDefaults.standard.setValue(encoded, forKey: "sampleDatas")
            }
            
            self.tableView.reloadData()
            
            //        let decoder: JSONDecoder = JSONDecoder()
            //        if let data = UserDefaults.standard.object(forKey: "SampleData") as? Data,
            //           let sampleDatas = try? decoder.decode([SampleData].self, from: data) {
            //            self.sampleDatas = sampleDatas
            //            tableView.reloadData()
            //        }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        

        guard let cy = current.year, let cm = current.month else {return}
        self.year = cy
        self.month = cm
        

        
        var firstDay = DateComponents(year: year, month: month, day: 1)
        var firstDay_Date = cal.date(from:DateComponents(year: year, month: month, day: 1))
        while firstDay.month == self.month {
            var md = firstDay
            guard let apDay = md.day else {return}
            days.append(apDay)
            guard let fdd = firstDay_Date else {return}
            firstDay_Date = cal.date(byAdding: .day, value: 1, to: fdd)
            firstDay = cal.dateComponents([.year, .month, .day], from: firstDay_Date!)
        }
        updatePage()


        
    }
    @IBAction func addMonth(_ sender: Any) {
        let date = cal.date(from: current)!
        let nextMonth = cal.date(byAdding: .month, value: 1, to: date)!
        current = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .weekday], from: nextMonth)
    }
    
    @IBAction func subMonth(_ sender: Any) {
        let date = cal.date(from: current)!
        let nextMonth = cal.date(byAdding: .month, value: -1, to: date)!
        current = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .weekday], from: nextMonth)
    }
    
    func updatePage(){
        self.titleLabel.text = "\(self.year)년 \(self.month)월"
        self.collectionView.reloadData()
    }
}




extension ViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return 7
        }else{
            //            return sampleDatas.count
            return days.count
        }
        

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell", for: indexPath) as! CustomCollectionViewCell
//        let celldata = self.sampleDatas[indexPath.row]
        
        if indexPath.section == 0 {
            cell.dayLabel.text = dayTitle[indexPath.row]
        }else {
            cell.dayLabel.text = String(days[indexPath.row])
        }
        
        if indexPath.row % 7 == 0 {
            cell.dayLabel.textColor = UIColor.red
        }else if indexPath.row % 7 == 6 {
            cell.dayLabel.textColor = UIColor.blue
        }else{
            cell.dayLabel.textColor = UIColor.black
        }
        return cell
    }
    
    // 셀 크기
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      
        let numberOfColumns: CGFloat = 7  // Number of columns in a week
        let cellWidth = collectionView.bounds.width / numberOfColumns
        let cellSize = CGSize(width: cellWidth, height: cellWidth)
        
        return cellSize
    }
    
    // 그리드의 항목 줄 사이에 사용할 최소 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    // 같은 행에 있는 항목 사이에 사용할 최소 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension ViewController:SendDataProtocol{
    func receiveData(data: SampleData) {
        self.sampleDatas.append(data)
    }
}
