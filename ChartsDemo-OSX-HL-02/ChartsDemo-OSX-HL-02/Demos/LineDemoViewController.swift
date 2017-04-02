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
    @IBOutlet var lineChartView: LineChartView!
    
    @IBOutlet var barChartView: BarChartView!
    
    
    override open func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        barChartView.delegate = self
        lineChartView.delegate = self
        
        let ys1 = Array(1..<10).map { x in return sin(Double(x) / 2.0 / 3.141 * 1.5) }
        
        let yse1 = ys1.enumerated().map { x, y in return ChartDataEntry(x: Double(x), y: y) }
        
        let data = LineChartData()
        let ds1 = LineChartDataSet(values: yse1, label: "Hello")
        ds1.colors = [NSUIColor.red]
        data.addDataSet(ds1)

        self.lineChartView.data = data
        
        self.lineChartView.gridBackgroundColor = NSUIColor.white

        self.lineChartView.chartDescription?.text = "Linechart Demo"
        
        let yse1Bar = ys1.enumerated().map { x, y in return BarChartDataEntry(x: Double(x), y: y) }
        
        let dataBar = BarChartData()
        let ds1Bar = BarChartDataSet(values: yse1Bar, label: "Hello")
        ds1Bar.colors = [NSUIColor.red]
        dataBar.addDataSet(ds1Bar)
        
        
        self.barChartView.data = dataBar
        
        self.barChartView.gridBackgroundColor = NSUIColor.white
        
        self.barChartView.chartDescription?.text = "Barchart Demo"
        
        print("loaded")

    }
    
    public func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {

        if  chartView == lineChartView {
            print(highlight)
            barChartView.highlightValues([highlight])
        }else {
            print(highlight)
            lineChartView.highlightValues([highlight])
        }
        
    }
}
