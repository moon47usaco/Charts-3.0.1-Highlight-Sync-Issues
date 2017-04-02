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

       let combinedChartData: CombinedChartData = CombinedChartData()
        
        //Line chart in combined
        
        let ys1 = Array(1..<10).map { x in return sin(Double(x) / 2.0 / 3.141 * 1.5) }
        
        let yse1 = ys1.enumerated().map { x, y in return ChartDataEntry(x: Double(x), y: y) }
        
        var lineChartDataSet: [LineChartDataSet] = []
        
        lineChartDataSet.append(LineChartDataSet(values: yse1, label: "Line Combined"))
        
        lineChartDataSet[0].colors = [NSUIColor.red]
        
        //Bar chart combined
        
        let yse1Bar = ys1.enumerated().map { x, y in return BarChartDataEntry(x: Double(x), y: y) }
        
        var barChartDataSet: [BarChartDataSet] = []
        
        barChartDataSet.append(BarChartDataSet(values: yse1Bar, label: "Bar Combined"))
        
        barChartDataSet[0].colors = [NSUIColor.green]
        
        //barChartDataSet
        
        combinedChartData.lineData = LineChartData(dataSets: lineChartDataSet)
        combinedChartData.barData = BarChartData(dataSets: barChartDataSet)
        combinedChartView.data = combinedChartData

        //Line lower
        
        let ys2 = Array(1..<10).map { x in return cos(Double(x) / 2.0 / 3.141) }
        
        let yse2 = ys2.enumerated().map { x, y in return ChartDataEntry(x: Double(x), y: y) }
        
        let data = LineChartData()

        let ds2 = LineChartDataSet(values: yse2, label: "Line Lower")
        ds2.colors = [NSUIColor.blue]
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
