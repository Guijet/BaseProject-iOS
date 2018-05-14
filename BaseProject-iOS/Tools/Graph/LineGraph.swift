//
//  LineGraph.swift
//  InfluenceMe
//
//  Created by Guillaume Jette on 2018-03-03.
//  Copyright © 2018 Guillaume Jette. All rights reserved.
//

import UIKit

enum GraphInterval{
    case
    OneMonth,
    ThreeMonth,
    SixMonth
}

struct GraphData{
    var data:Float
    var date:String
    var isNull:Bool
    
    init(data:Float,date:String){
        self.data = data
        self.date = date
        self.isNull = false
    }
    
    init(){
        self.data = 0
        self.date = ""
        self.isNull = true
    }
}


struct GraphDataByWeek{
    
    var weekStartDate:String
    var weekEndDate:String
    var weekIndex:Int
    
    init(weekStartDate:String,weekEndDate:String,weekIndex:Int){
        self.weekStartDate = weekStartDate
        self.weekEndDate = weekEndDate
        self.weekIndex = weekIndex
    }
}



class LineGraph: UIView {
    
    private var control:UIViewController!
    var graphData:[GraphData]!
    private var MaxValue:Float!
    private var arrayAllDates = [GraphDataByWeek]()
    private var fullData:[Float]!
    
    let shapeLayer = CAShapeLayer()
    let maskLayer = CAShapeLayer()
    
    init(frame:CGRect,control:UIViewController,graphData:[GraphData]) {
        super.init(frame:frame)
        self.control = control
        self.graphData = graphData
        self.fullData = self.getGraphData(graphInterval: .ThreeMonth)
        self.MaxValue = self.fullData.count > 0 ? self.fullData.max() : 0
        self.setPointsOnGraph(graphData:graphData)
    }

    override func draw(_ rect: CGRect) {
        self.joinPointsWithLine()
        self.removePoints()
    }
    

    private func setPointsOnGraph(graphData:[GraphData]){
        if(graphData.count > 0){
            
            let spacing = getSpacing(graphData:graphData)
            var toX:CGFloat = 0
            var index:Int = 0
            
            for x in fullData{
                
                let point = UIView()
                point.frame = CGRect(x: 0, y: 0, width: self.control.rw(8), height: self.control.rw(8))
                point.accessibilityIdentifier = "point\(index)"
                point.layer.cornerRadius = self.control.rw(4)
                point.layer.borderWidth = 1
                point.layer.borderColor = UIColor().hex("#188DC2").cgColor
                point.backgroundColor = UIColor.white
                point.center.x = toX
                point.center.y = getPointValueY(value:x)
                if(x == 0){ point.center.y -= rh(16) }
                self.addSubview(point)
                
                index += 1
                toX += spacing
            }
        }
        else{
            //NO DATA
        }
    }
    
    
    private func getGraphData(graphInterval:GraphInterval)->[Float]{
        var result = [Float]()
        if(graphInterval == .OneMonth){
            for x in 0...30{
                let dateFromDay = String(describing: Date().fromNow(nbDays: x)).substring(from: 0, to: 10)
                result.append(getDataByDayInterval(date:dateFromDay))
            }
        }
        else if(graphInterval == .ThreeMonth){
            
            let weekInterval = getIntervalOfDataByWeek(nbWeeks: 12)
            for x in weekInterval{
                result.append(getDataByWeekInterval(graphDataByWeek: x))
            }
            
        }
        else if(graphInterval == .SixMonth){
            let weekInterval = getIntervalOfDataByWeek(nbWeeks: 24)
            for x in weekInterval{
                result.append(getDataByWeekInterval(graphDataByWeek: x))
            }
        }
        return result
    }
    
    private func getDataByDayInterval(date:String)->Float{
        var result:Float = 0
        if(graphData.count > 0){
            if(graphData.map({$0.date}).contains(where: {$0 == date})){
                result = (graphData.filter({$0.date == date}).first?.data)!
            }
        }
        return result
    }
    
    private func getIntervalOfDataByWeek(nbWeeks:Int)->[GraphDataByWeek]{
        var arrayDateWeeks = [GraphDataByWeek]()
        for x in 1...nbWeeks{
            let lastWeekStartDate = Calendar.current.date(byAdding: .weekOfYear, value: -x, to: Date())!
            let lastWeekEndDate = Calendar.current.date(byAdding: .weekOfYear, value: -(x - 1), to: Date())!
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let lastWeekStartDateString = dateFormatter.string(from: lastWeekStartDate)
            let lastWeekEndDateString = dateFormatter.string(from: lastWeekEndDate)
            
            arrayDateWeeks.append(GraphDataByWeek(weekStartDate: lastWeekStartDateString, weekEndDate: lastWeekEndDateString, weekIndex: x))
        }
        return arrayDateWeeks
    }
    
    private func getDataByWeekInterval(graphDataByWeek:GraphDataByWeek)->Float{
        var result:Float = 0
        if(graphData.contains(where: {$0.date.isBetweeenInclusive(date1: graphDataByWeek.weekStartDate, date2: graphDataByWeek.weekEndDate)})){
            result = graphData.filter({$0.date.isBetweeenInclusive(date1: graphDataByWeek.weekStartDate, date2: graphDataByWeek.weekEndDate)}).map({$0.data}).reduce(0, +)
        }
        
        return result
    }
    
    private func getSpacing(graphData:[GraphData])->CGFloat{
        if(fullData.count > 0){
            return self.frame.width/CGFloat(fullData.count - 1)
        }
        else{
            return 0
        }
    }
    
    private func getPointValueY(value:Float)->CGFloat{
        let result = ((self.frame.height + self.control.rw(4)) - (CGFloat(value) * self.frame.height) / CGFloat(MaxValue))
        if(result.isNaN){
            return self.frame.height
        }
        else{
            return result
        }
    }
    
    private func joinPointsWithLine(){
        var index = 0
        let arrPoints = getPointsArray()
        if(arrPoints.count > 0){
            repeat{
                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
                    self.drawLine(p1:CGPoint(x:arrPoints[index].center.x,y:arrPoints[index].center.y),p2:CGPoint(x:arrPoints[index + 1].center.x,y:arrPoints[index + 1].center.y))
                }, completion: nil)
                
                index += 1
            }while(index != arrPoints.count - 1)
        }
    }
    
    private func drawLine(p1:CGPoint,p2:CGPoint){
        let aPath = UIBezierPath()
        aPath.lineWidth = 2.5
        aPath.move(to: p1)
        aPath.addLine(to: p2)
        aPath.close()
        UIColor().hex("#188DC2").set()
        aPath.stroke()
        aPath.fill()
    }
    
    private func getPointsArray()->[UIView]{
        var arrPointView = [UIView]()
        if(self.subviews.count > 0){
            for x in self.subviews{
                if(x.accessibilityIdentifier?.contains("point"))!{
                    arrPointView.append(x)
                }
            }
        }
        return arrPointView
    }
    
    private func removePoints(){
        if(self.subviews.count > 0){
            for x in self.subviews{
                if(x.accessibilityIdentifier?.contains("point"))!{
                    x.removeFromSuperview()
                }
            }
        }
    }
    
    private func emptyView(){
        if(self.subviews.count > 0){
            for x in self.subviews{
                x.removeFromSuperview()
            }
        }
    }
    
    func reloadGraph(interval:GraphInterval){
        self.emptyView()
        self.fullData = self.getGraphData(graphInterval: interval)
        self.MaxValue = self.fullData.max()
        self.setPointsOnGraph(graphData: graphData)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
