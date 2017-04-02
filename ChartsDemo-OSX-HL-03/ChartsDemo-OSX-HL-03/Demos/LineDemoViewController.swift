//
//  LineDemoViewController.swift
//  ChartsDemo-OSX
//
//  Copyright 2015 Daniel Cohen Gindi & Philipp Jahoda
//  A port of MPAndroidChart for iOS
//  Licensed under Apache License 2.0
//
//  https://github.com/danielgindi/ios-charts

import Foundation
import Cocoa
import Charts

open class LineDemoViewController: NSViewController, ChartViewDelegate
{
    @IBOutlet var combinedChartView: CombinedChartView!
    
    @IBOutlet var lineChartView: LineChartView!
    
    override open func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        combinedChartView.delegate = self
        lineChartView.delegate = self
        
        var xValues = [String]()
        var yValues: [[Double]] = []
        
        var prices = [Double]() //Temp array container
        
        for i in 0..<9 {
            xValues.append(String(i))
            prices.append( (Double(arc4random_uniform(9))+1.0) )
            prices.append( (Double(arc4random_uniform(9))-5.0) )
            prices.append( (Double(arc4random_uniform(6))) )
            prices.append( (Double(arc4random_uniform(6))) )
            yValues.append(prices)
            prices = [] //Empty the temp array
            
        }
        
        let combinedChartData: CombinedChartData = CombinedChartData()
        
        //Candle chart combined
        
        var yValsCandleChart : [CandleChartDataEntry] = []
        for i in 0..<yValues.count {
            let high = yValues[i][0]
            let low = yValues[i][1]
            let open = yValues[i][2]
            let close = yValues[i][3]
            yValsCandleChart.append(CandleChartDataEntry(x: Double(i), shadowH: high, shadowL: low, open: open, close: close))
        }
        let candleChartDataSet = CandleChartDataSet(values: yValsCandleChart, label: "Candles")
        
        candleChartDataSet.decreasingColor = NSColor.red
        candleChartDataSet.increasingColor = NSColor.green
        candleChartDataSet.neutralColor = NSColor.blue
        candleChartDataSet.shadowColorSameAsCandle = true
        
        //Line chart in combined
        
        let ys1 = Array(1..<10).map { x in return sin(Double(x) / 2.0 / 3.141 * 1.5) }
        
        let yse1 = ys1.enumerated().map { x, y in return ChartDataEntry(x: Double(x), y: y) }
        
        var lineChartDataSet: [LineChartDataSet] = []
        
        lineChartDataSet.append(LineChartDataSet(values: yse1, label: "Line Combined"))
        
        lineChartDataSet[0].colors = [NSUIColor.magenta]
        
        combinedChartData.candleData = CandleChartData(dataSets: [candleChartDataSet])
        combinedChartData.lineData = LineChartData(dataSets: lineChartDataSet)
        combinedChartView.data = combinedChartData

        //Line lower
        
        let ys2 = Array(1..<10).map { x in return cos(Double(x) / 2.0 / 3.141) }
        
        let yse2 = ys2.enumerated().map { x, y in return ChartDataEntry(x: Double(x), y: y) }
        
        let data = LineChartData()

        let ds2 = LineChartDataSet(values: yse2, label: "Line Lower")
        ds2.colors = [NSUIColor.red]
        data.addDataSet(ds2)
        self.lineChartView.data = data
        
        self.lineChartView.gridBackgroundColor = NSUIColor.white

        self.lineChartView.chartDescription?.text = "Combined Demo"
    }
   
    public func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        
        if chartView == combinedChartView {
            print(highlight)
            lineChartView.highlightValue(highlight)
        } else {
            print(highlight)
            combinedChartView.highlightValue(highlight)
        }
    }
   
}
