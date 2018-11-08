//
//  ChartViewController.swift
//  PROJNAME
//
//  Created by Brenden Vogt on 11/4/18.
//  Copyright © 2018 ORGNAME. All rights reserved.
//

import UIKit
import Charts


class ChartViewController: BaseUIViewController {
    
    static let itemSpacing: CGFloat = 20
    static let itemHeight: CGFloat = 30
    private let navHeight : CGFloat = 70.0
    private let inset : CGFloat = 30.0
    
    let stackView : UIStackView = UIFactory.stack(spacing: LoginViewController.itemSpacing, axis: .vertical, alignment: .fill, distribution: .equalSpacing)()
    let stackNav : UIStackView = UIFactory.stack(spacing: 0, axis: .horizontal, alignment: .center, distribution: .equalSpacing)()
    
    let scrollView : UIScrollView = {
        let s = UIScrollView(frame: .zero)
        return s
    }()
    
    let chartView : () -> LineChartView = {
        let c = LineChartView(frame: .zero)
        return c
    }

    let barChartView : () -> BarChartView = {
        let c = BarChartView(frame: .zero)
        return c
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.init(hex: "1E1E1E")
//        self.view.backgroundColor = .white
        
        let blue = UIColor.init(hex: "00CCFF")!
        let green = UIColor.init(hex: "00FF00")!
        let red = UIColor.init(hex: "FF0000")!
        
        setupNav()
        setupScrollingStackView()
        
        let colors : [UIColor] = [blue, green, red]
        
        for _ in 0...10 {
            let color = colors.randomElement()!
            let lChart = addChartView(color: color)
            self.stackView.addArrangedSubview(lChart)
            lChart.setHeight(150)
            
            let bChart = addBarChartView()
            self.stackView.addArrangedSubview(bChart)
            bChart.setHeight(50)
        }
    }
    
    func setupNav(){
        ///nav bar view
        view.addSubview(stackNav)
        stackNav.snapToSuperTop(withInsets:.init(top: 0, left: inset, bottom: 0, right: inset))
        stackNav.setHeight(navHeight)
    }
    func setupScrollingStackView(){
        ///add stack view
        view.addSubview(scrollView)
        scrollView.snapToSuper(withInsets: .init(top: navHeight + 20, left: 0, bottom: 0, right: 0), override: true)
        
        scrollView.addSubview(stackView)
        stackView.snapToSuper(withInsets: .init(top: 0, left: inset, bottom: inset, right: inset), override: true)
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -2.0 * inset).isActive = true
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.contentSize = CGSize(width: stackView.frame.width, height: max(stackView.frame.height, view.frame.height-navHeight))
    }
    
    func addChartView(color : UIColor) -> LineChartView{
        let lineChart = self.chartView()
        let yVals1 = (0..<self.stockData3.count).map { (i) -> ChartDataEntry in
            return ChartDataEntry(x: Double(i), y: self.stockData3[i])
        }

        let color1 = color.withAlphaComponent(0.3)
        let color2 = color.withAlphaComponent(0.05)
        
        let set1 = LineChartDataSet(values: yVals1, label: "DataSet 1")
        
        set1.axisDependency = .left
        set1.setColor(color)
        set1.lineWidth = 1.5
        
        ///bezier curve
        set1.mode = .cubicBezier
        set1.cubicIntensity = 0.055
        
        ///remove circles
        set1.circleRadius = 3
        set1.drawCirclesEnabled = false
        set1.drawCircleHoleEnabled = false
        set1.setCircleColor(color)
        
        ///fill color
        set1.fillAlpha = 1.0
        set1.drawFilledEnabled = true
        let gradientColors = [color1.cgColor, color2.cgColor] as CFArray
        let colorLocations:[CGFloat] = [0.4, 0.0]
        let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations)
        set1.fill = Fill.fillWithLinearGradient(gradient!, angle: 90.0)
        set1.fillFormatter = DefaultFillFormatter { _,_  -> CGFloat in
            return CGFloat(lineChart.leftAxis.axisMinimum)
        }
        
        ///data
        let data = LineChartData(dataSets: [set1])
        data.setDrawValues(false)
        
        ///indicator
        set1.setDrawHighlightIndicators(true)
        set1.highlightLineWidth = 1.0
        set1.drawHorizontalHighlightIndicatorEnabled = false
        //set1.highlightLineDashLengths = [5.0]
    
        ///indicator color
        //set1.highlightColor = .init(white: 0.75, alpha: 1.0)//gray
        set1.highlightColor = color
        
        ///legend
        lineChart.legend.enabled = false
        lineChart.rightAxis.enabled = false
        lineChart.leftAxis.enabled = false
        
        ///animate
        lineChart.animate(xAxisDuration: TimeInterval.init(exactly: 1.5)!, easingOption: .easeInOutCubic)
        
        ///set data
        lineChart.data = data
        
        return lineChart
    }

    func addBarChartView() -> BarChartView{
        
        let chart = self.barChartView()
        
        let yVals1 = (0..<self.stockData3.count).map { (i) -> BarChartDataEntry in
            return BarChartDataEntry(x: Double(i), y: self.stockData3[i])
        }
        
        let color = UIColor.init(white: 0.4, alpha: 1.0)
        
        let set1 = BarChartDataSet(values: yVals1, label: "Volume")
        set1.colors = [color]
        set1.drawValuesEnabled = false
        set1.drawIconsEnabled = false
        
        let data = BarChartData(dataSet: set1)
        data.setValueFont(UIFont(name: "HelveticaNeue-Light", size: 10)!)
        data.barWidth = 0.8
        chart.data = data
        
        ///legend
        chart.legend.enabled = false
        chart.rightAxis.enabled = false
        chart.leftAxis.enabled = false
        chart.xAxis.enabled = false
        
        ///animate
        //chart.animate(xAxisDuration: TimeInterval.init(exactly: 1.5)!, easingOption: .easeInOutCubic)
        
        chart.data = data
        return chart
    }
    

    let data : [Double] = [
        -0.0656306821859696,
        -0.0656306821859696,
        -0.0645488577543327,
        -0.0649094658982117,
        -0.0663518984737275,
        -0.0688761554808802,
        -0.0692367636247592,
        -0.0739246694951856,
        -0.0728428450635487,
        -0.0638276414665748,
        -0.0667125066176065,
        -0.0656306821859696,
        -0.0677943310492434,
        -0.062745817034938,
        -0.0667125066176065,
        -0.0663518984737275,
        -0.0631064251788169,
        -0.0699579799125171,
        -0.0674337229053644,
        -0.0724822369196698,
        -0.0667125066176065,
        -0.0714004124880329,
        -0.0663518984737275,
        -0.0616639926033011,
        -0.0681549391931223,
        -0.0692367636247592,
        -0.0681549391931223,
        -0.0652700740420907,
        -0.0677943310492434,
        -0.062385208891059,
        -0.0634670333226959,
        -0.0605821681716643,
        -0.0634670333226959,
        -0.0634670333226959,
        -0.062745817034938,
        -0.0584185193083905,
        -0.0638276414665748,
        -0.0663518984737275,
        -0.0645488577543327,
        -0.062745817034938,
        -0.0616639926033011,
        -0.0659912903298486,
        -0.0555336541573589,
        -0.0685155473370013,
        -0.0659912903298486,
        -0.0674337229053644,
        -0.0645488577543327,
        -0.0663518984737275,
        -0.0699579799125171,
        -0.0631064251788169,
        -0.0681549391931223,
        -0.0613033844594222,
        -0.0695973717686381,
        -0.0670731147614854,
        -0.0681549391931223,
        -0.0670731147614854,
        -0.0681549391931223,
        -0.0631064251788169,
        -0.0670731147614854,
        -0.0631064251788169,
        -0.0616639926033011,
        -0.0645488577543327,
        -0.0677943310492434,
        -0.0674337229053644,
        -0.062745817034938,
        -0.0591397355961484,
        -0.0613033844594222,
        -0.0638276414665748,
        -0.0602215600277853,
        -0.0638276414665748,
        -0.0638276414665748,
        -0.0609427763155432,
        -0.062745817034938,
        -0.0645488577543327,
        -0.0681549391931223,
        -0.0681549391931223,
        -0.0638276414665748,
        -0.0602215600277853,
        -0.0677943310492434,
        -0.0667125066176065,
        -0.0591397355961484,
        -0.0631064251788169,
        -0.0663518984737275,
        -0.0649094658982117,
        -0.0634670333226959,
        -0.0620246007471801,
        -0.0645488577543327,
        -0.0659912903298486,
        -0.0602215600277853,
        -0.062745817034938,
        -0.0616639926033011,
        -0.0641882496104538,
        -0.0652700740420907,
        -0.062385208891059,
        -0.0605821681716643,
        -0.0620246007471801,
        -0.0616639926033011,
        -0.0613033844594222,
        -0.0641882496104538,
        -0.0667125066176065,
        -0.0613033844594222,
        -0.0735640613513066,
        -0.070679196200275,
        -0.0710398043441539,
        -0.062745817034938,
        -0.0674337229053644,
        -0.0692367636247592,
        -0.0616639926033011,
        -0.0652700740420907,
        -0.0663518984737275,
        -0.062385208891059,
        -0.0645488577543327,
        -0.0685155473370013,
        -0.0598609518839064,
        -0.0695973717686381,
        -0.0631064251788169,
        -0.0616639926033011,
        -0.0681549391931223,
        -0.0631064251788169,
        -0.0652700740420907,
        -0.0649094658982117,
        -0.0649094658982117,
        -0.0681549391931223,
        -0.0620246007471801,
        -0.0667125066176065,
        -0.070679196200275,
        -0.0681549391931223,
        -0.0710398043441539,
        -0.0757277102145803,
        -0.0728428450635487,
        -0.078251967221733,
        -0.0800550079411278,
        -0.0735640613513066,
        -0.0739246694951856,
        -0.0753671020707014,
        -0.0778913590778541,
        -0.078612575365612,
        -0.0800550079411278,
        -0.0757277102145803,
        -0.0811368323727646,
        -0.0833004812360384,
        -0.0807762242288857,
        -0.0746458857829435,
        -0.0681549391931223,
        -0.0674337229053644,
        -0.0663518984737275,
        -0.0645488577543327,
        -0.0692367636247592,
        -0.0714004124880329,
        -0.0681549391931223,
        -0.0645488577543327,
        -0.0710398043441539,
        -0.070318588056396,
        -0.0699579799125171,
        -0.0670731147614854,
        -0.0714004124880329,
        -0.0659912903298486,
        -0.0638276414665748,
        -0.0732034532074277,
        -0.0641882496104538,
        -0.0656306821859696,
        -0.0667125066176065,
        -0.0656306821859696,
        -0.0721216287757908,
        -0.0742852776390645,
        -0.0771701427900961,
        -0.0753671020707014,
        -0.0804156160850067,
        -0.0764489265023382,
        -0.078251967221733,
        -0.0746458857829435,
        -0.0732034532074277,
        -0.0717610206319118,
        -0.0750064939268224,
        -0.0768095346462172,
        -0.0735640613513066,
        -0.0732034532074277,
        -0.070318588056396,
        -0.0634670333226959,
        -0.0652700740420907,
        -0.0681549391931223,
        -0.0652700740420907,
        -0.0634670333226959,
        -0.0573366948767537,
        -0.0634670333226959,
        -0.0602215600277853,
        -0.0613033844594222,
        -0.0537306134379641,
        -0.0598609518839064,
        -0.0526487890063273,
        -0.0508457482869325,
        -0.0526487890063273,
        -0.0558942623012379,
        -0.0490427075675377,
        -0.0501245319991746,
        -0.0497639238552956,
        -0.0490427075675377,
        -0.0494033157114167,
        -0.0432729772654745,
        -0.0421911528338376,
        -0.0443548016971113,
        -0.0403881121144428,
        -0.0421911528338376,
        -0.0357002062440164,
        -0.0385850713950481,
        -0.0382244632511691,
        -0.0400275039705639,
        -0.0328153410929848,
        -0.0331759492368638,
        -0.0299304759419532,
        -0.0328153410929848,
        -0.0324547329491059,
        -0.0364214225317744,
        -0.0302910840858321,
        -0.0317335166613479,
        -0.03101230037359,
        -0.0331759492368638,
        -0.0284880433664374,
        -0.0212758804888583,
        -0.0245213537837689,
        -0.0216364886327372,
        -0.0140637176112792,
        -0.0194728397694635,
        -0.0176697990500687,
        -0.0198334479133425,
        -0.0205546642011004,
        -0.015866758330674,
        -0.0093758117408528,
        -0.00757277102145803,
        -0.0122606768918844,
        -0.0198334479133425,
        -0.0198334479133425,
        -0.0230789212082531,
        -0.0147849338990371,
        -0.0147849338990371,
        -0.0137031094674003,
        -0.0180304071939477,
        -0.023800137496011,
        -0.0270456107909215,
        -0.0216364886327372,
        -0.0302910840858321,
        -0.0292092596541953,
        -0.0259637863592847,
        -0.0209152723449793,
        -0.0281274352225584,
        -0.0263243945031636,
        -0.0284880433664374,
        -0.0302910840858321,
        -0.0328153410929848,
        -0.0411093284022008,
        -0.0429123691215955,
        -0.0382244632511691,
        -0.0385850713950481,
        -0.0411093284022008,
        -0.046879058704264,
        -0.0479608831359009,
        -0.0436335854093534,
        -0.0421911528338376,
        -0.0494033157114167,
        -0.05517304601348,
        -0.062385208891059,
        -0.0710398043441539,
        -0.0645488577543327,
        -0.0641882496104538,
        -0.0663518984737275,
        -0.070318588056396,
        -0.0717610206319118,
        -0.0771701427900961,
        -0.0699579799125171,
        -0.0760883183584593,
        -0.0742852776390645,
        -0.0789731835094909,
        -0.0742852776390645,
        -0.0753671020707014,
        -0.0829398730921594,
        -0.078251967221733,
        -0.0865459545309489,
        -0.0959217662718018,
        -0.0905126441136174,
        -0.0901520359697385,
        -0.0923156848330122,
        -0.102052104717744,
        -0.0948399418401649,
        -0.094118725552407,
        -0.0977248069911965,
        -0.0984460232789544,
        -0.101330888429986,
        -0.100970280286107,
        -0.0905126441136174,
        -0.104576361724897,
        -0.100249063998349,
        -0.0955611581279228,
        -0.0991672395667123,
        -0.0995278477105913,
        -0.0998884558544703,
        -0.102412712861623,
        -0.105658186156534,
        -0.102052104717744,
        -0.100249063998349,
        -0.0980854151350755,
        -0.105297578012655,
        -0.105297578012655,
        -0.104215753581018,
        -0.10349453729326,
        -0.108182443163686,
        -0.102052104717744,
        -0.104576361724897,
        -0.102412712861623,
        -0.101691496573865,
        -0.101330888429986,
        -0.105297578012655,
        -0.103133929149381,
        -0.102412712861623,
        -0.104936969868776,
        -0.100609672142228,
        -0.100970280286107,
        -0.102412712861623,
        -0.11034609202696,
        -0.110706700170839,
        -0.102052104717744,
        -0.105297578012655,
        -0.104936969868776,
        -0.103133929149381,
        -0.108182443163686,
        -0.117558254904539,
        -0.112509740890234,
        -0.11034609202696,
        -0.109264267595323,
        -0.108903659451444,
        -0.103855145437139,
        -0.108543051307565,
        -0.100970280286107,
        -0.109624875739202,
        -0.104936969868776,
        -0.106379402444291,
        -0.105658186156534,
        -0.12080372819945,
        -0.12404920149436,
        -0.127294674789271,
        -0.130179539940302,
        -0.131982580659697,
        -0.138473527249518,
        -0.138834135393397,
        -0.14135839240055,
        -0.146767514558734,
        -0.155422110011829,
        -0.160831232170013,
        -0.170207043910866,
        -0.162634272889408,
        -0.164076705464924,
        -0.167322178759835,
        -0.166600962472077,
        -0.167322178759835,
        -0.157946367018982,
        -0.152537244860798,
        -0.135228053954608,
        -0.126573458501513,
        -0.101330888429986,
        -0.0865459545309489,
        -0.0562548704451168,
        -0.0216364886327372,
        0.00396668958266849,
        0.0504851401430536,
        0.0814974405166436,
        0.116115822329023,
        0.153979677436313,
        0.196892046557909,
        0.22754373878762,
        0.271177324196973,
        0.302910840858321,
        0.329956451649243,
        0.354838413576891,
        0.380802199936175,
        0.389096187245391,
        0.413256932885281,
        0.432008556366987,
        0.426960042352682,
        0.43453281337414,
        0.423714569057771,
        0.416502406180192,
        0.391981052396423,
        0.373229428914717,
        0.343659561116643,
        0.30687753044099,
        0.274062189348005,
        0.235837726096836,
        0.182107112658872,
        0.137031094674003,
        0.104936969868776,
        0.0674337229053644,
        0.0306516922297111,
        -0.00288486515103163,
        -0.0259637863592847,
        -0.0486820994236588,
        -0.0645488577543327,
        -0.0778913590778541,
        -0.0991672395667123,
        -0.107100618732049,
        -0.104936969868776,
        -0.10349453729326,
        -0.118640079336176,
        -0.121524944487207,
        -0.116837038616781,
        -0.120082511911692,
        -0.11719764676066,
        -0.119000687480055,
        -0.121885552631086,
        -0.12765528293315,
        -0.121524944487207,
        -0.122246160774965,
        -0.123327985206602,
        -0.123688593350481,
        -0.113591565321871,
        -0.109624875739202,
        -0.115394606041265,
        -0.108543051307565,
        -0.111067308314718,
        -0.104215753581018,
        -0.094118725552407,
        -0.0915944685452543,
        -0.0840216975237963,
        -0.0721216287757908,
        -0.0757277102145803,
        -0.0764489265023382,
        -0.0714004124880329,
        -0.0613033844594222,
        -0.0659912903298486,
        -0.070318588056396,
        -0.0609427763155432,
        -0.0670731147614854,
        -0.0638276414665748,
        -0.0620246007471801,
        -0.0674337229053644,
        -0.0732034532074277,
        -0.0685155473370013,
        -0.0670731147614854,
        -0.0695973717686381,
        -0.0634670333226959,
        -0.0714004124880329,
        -0.0800550079411278,
        -0.0793337916533699,
        -0.0768095346462172,
        -0.0714004124880329,
        -0.0717610206319118,
        -0.0721216287757908,
        -0.0757277102145803,
        -0.0714004124880329,
        -0.0800550079411278,
        -0.0814974405166436,
        -0.0840216975237963,
        -0.078251967221733,
        -0.0847429138115542,
        -0.08618534638707,
        -0.0876277789625858,
        -0.0829398730921594,
        -0.0750064939268224,
        -0.0800550079411278,
        -0.0818580486605226,
        -0.0771701427900961,
        -0.0760883183584593,
        -0.0775307509339751,
        -0.0764489265023382,
        -0.0811368323727646,
        -0.0793337916533699,
        -0.0836610893799173,
        -0.0634670333226959,
        -0.0569760867328747,
        -0.0638276414665748,
        -0.0685155473370013,
        -0.0634670333226959,
        -0.062745817034938,
        -0.0587791274522695,
        -0.062745817034938,
        -0.0591397355961484,
        -0.0573366948767537,
        -0.0555336541573589,
        -0.0620246007471801,
        -0.0573366948767537,
        -0.0540912215818431,
        -0.0595003437400274,
        -0.0540912215818431,
        -0.0530093971502062,
        -0.0522881808624483,
        -0.0429123691215955,
        -0.0501245319991746,
        -0.0494033157114167,
        -0.0364214225317744,
        -0.0335365573807427,
        -0.0331759492368638,
        -0.0346183818123796,
        -0.0331759492368638,
        -0.0421911528338376,
        -0.0328153410929848,
        -0.0306516922297111,
        -0.0248819619276478,
        -0.0284880433664374,
        -0.0281274352225584,
        -0.0320941248052269,
        -0.0248819619276478,
        -0.0256031782154057,
        -0.0209152723449793,
        -0.0173091909061898,
        -0.0151455420429161,
        -0.0241607456398899,
        -0.0169485827623108,
        -0.0147849338990371,
        -0.0129818931796423,
        -0.0129818931796423,
        -0.0162273664745529,
        -0.0129818931796423,
        -0.00721216287757908,
        -0.00649094658982117,
        -0.0046879058704264,
        -0.00396668958266849,
        0.00216364886327372,
        -0.00288486515103163,
        -0.00180304071939477,
        0.000721216287757908,
        0.00108182443163686,
        0.00649094658982117,
        0.0119000687480055,
        0.00829398730921594,
        0.0119000687480055,
        0.00865459545309489,
        0.0209152723449793,
        0.0227183130643741,
        0.0263243945031636,
        0.0288486515103163,
        0.0295698677980742,
        0.0342577736685006,
        0.0357002062440164,
        0.0403881121144428,
        0.0432729772654745,
        0.0414699365460797,
        0.0479608831359009,
        0.0490427075675377,
        0.0494033157114167,
        0.046879058704264,
        0.0530093971502062,
        0.0494033157114167,
        0.0544518297257221,
        0.062385208891059,
        0.0652700740420907,
        0.0638276414665748,
        0.0739246694951856,
        0.070318588056396,
        0.0663518984737275,
        0.078251967221733,
        0.0764489265023382,
        0.0800550079411278,
        0.0836610893799173,
        0.0836610893799173,
        0.0887096033942227,
        0.0933975092646491,
        0.0930369011207701,
        0.0912338604013754,
        0.0948399418401649,
        0.0984460232789544,
        0.0988066314228334,
        0.103855145437139,
        0.105658186156534,
        0.109264267595323,
        0.11034609202696,
        0.114312781609628,
        0.115755214185144,
        0.11719764676066,
        0.120443120055571,
        0.122967377062723,
        0.124770417782118,
        0.125852242213755,
        0.127294674789271,
        0.125852242213755,
        0.128737107364787,
        0.130540148084181,
        0.127294674789271,
        0.130540148084181,
        0.138112919105639,
        0.138473527249518,
        0.140997784256671,
        0.143882649407703,
        0.140997784256671,
        0.140637176112792,
        0.141719000544429,
        0.145685690127097,
        0.14496447383934,
        0.14820994713425,
        0.147849338990371,
        0.148570555278129,
        0.148570555278129,
        0.145685690127097,
        0.145325081983218,
        0.150012987853645,
        0.143882649407703,
        0.144603865695461,
        0.140637176112792,
        0.137031094674003,
        0.138834135393397,
        0.133064405091334,
        0.139194743537276,
        0.140637176112792,
        0.138112919105639,
        0.134867445810729,
        0.129458323652544,
        0.126934066645392,
        0.122967377062723,
        0.120082511911692,
        0.112149132746355,
        0.113230957177992,
        0.113230957177992,
        0.108182443163686,
        0.102412712861623,
        0.0995278477105913,
        0.094118725552407,
        0.0843823056676752,
        0.0771701427900961,
        0.0771701427900961,
        0.0717610206319118,
        0.0652700740420907,
        0.0638276414665748,
        0.062385208891059,
        0.0584185193083905,
        0.0544518297257221,
        0.054812437869601,
        0.038945679538927,
        0.0360608143878954,
        0.0302910840858321,
        0.0277668270786795,
        0.0144243257551582,
        0.0126212850357634,
        0.0162273664745529,
        0.0176697990500687,
        0.0151455420429161,
        0.0133425013235213,
        0.00649094658982117,
        -0.0046879058704264,
        -0.0176697990500687,
        -0.0180304071939477,
        -0.0256031782154057,
        -0.0342577736685006,
        -0.0317335166613479,
        -0.0382244632511691,
        -0.0403881121144428,
        -0.0501245319991746,
        -0.0429123691215955,
        -0.0432729772654745,
        -0.0486820994236588,
        -0.0497639238552956,
        -0.0522881808624483,
        -0.0591397355961484,
        -0.0595003437400274,
        -0.0659912903298486,
        -0.0695973717686381,
        -0.0825792649482804,
        -0.0746458857829435,
        -0.0735640613513066,
        -0.0721216287757908,
        -0.0750064939268224,
        -0.0793337916533699,
        -0.0771701427900961,
        -0.0825792649482804,
        -0.0778913590778541,
        -0.0822186568044015,
        -0.0851035219554331,
        -0.0825792649482804,
        -0.0883489952503437,
        -0.0970035907034386,
        -0.093758117408528,
        -0.0905126441136174,
        -0.0933975092646491,
        -0.0847429138115542,
        -0.0970035907034386,
        -0.0984460232789544,
        -0.0966429825595597,
        -0.101691496573865,
        -0.0966429825595597,
        -0.104215753581018,
        -0.102412712861623,
        -0.0966429825595597,
        -0.0977248069911965,
        -0.0973641988473176,
        -0.100609672142228,
        -0.0995278477105913,
        -0.107100618732049,
        -0.0977248069911965,
        -0.0991672395667123,
        -0.101691496573865,
        -0.0984460232789544,
        -0.0984460232789544,
        -0.0991672395667123,
        -0.0955611581279228,
        -0.0930369011207701,
        -0.0988066314228334,
        -0.0984460232789544,
        -0.0998884558544703,
        -0.0970035907034386,
        -0.0973641988473176,
        -0.0991672395667123,
        -0.0973641988473176,
        -0.0966429825595597,
        -0.0919550766891333,
        -0.0933975092646491,
        -0.0926762929768912,
        -0.0919550766891333,
        -0.0962823744156807,
        -0.0962823744156807,
        -0.0966429825595597,
        -0.0908732522574964,
        -0.0952005499840438,
        -0.0908732522574964,
        -0.093758117408528,
        -0.0915944685452543,
        -0.0959217662718018,
        -0.0915944685452543,
        -0.0977248069911965,
        -0.0970035907034386,
        -0.0883489952503437,
        -0.0894308196819806,
        -0.0912338604013754,
        -0.0894308196819806,
        -0.0901520359697385,
        -0.0869065626748279,
        -0.0883489952503437,
        -0.0833004812360384,
        -0.0930369011207701,
        -0.0865459545309489,
        -0.0872671708187069,
        -0.0919550766891333,
        -0.0912338604013754,
        -0.0926762929768912,
        -0.0887096033942227,
        -0.0952005499840438,
        -0.0926762929768912,
        -0.0908732522574964,
        -0.0869065626748279,
        -0.0919550766891333,
        -0.0901520359697385,
        -0.0793337916533699,
        -0.0710398043441539,
        -0.0753671020707014,
        -0.0778913590778541,
        -0.070679196200275,
        -0.0753671020707014,
        -0.0692367636247592,
        -0.0695973717686381,
        -0.070679196200275,
        -0.0724822369196698,
        -0.070679196200275,
        -0.0746458857829435,
        -0.0764489265023382,
        -0.078251967221733,
        -0.070679196200275,
        -0.0753671020707014,
        -0.0724822369196698,
        -0.0688761554808802,
        -0.0674337229053644,
        -0.0721216287757908
    ]
    
    let stockData : [Double] = [
        224.289993,
        224.289993,
        224.289993,
        224.289993,
        224.289993,
        224.289993,
        224.289993,
        224.289993,
        224.289993,
        224.289993,
        223.770004,
        226.869995,
        216.360001,
        214.449997,
        222.110001,
        217.360001,
        222.149994,
        221.190002,
        216.020004,
        219.309998,
        220.649994,
        222.729996,
        215.089996,
        221.190002,
        216.020004,
        219.309998,
        220.649994,
        222.729996,
        215.089996,
        221.190002,
        216.020004,
        219.309998,
        220.649994,
        222.729996,
        215.089996,
        219.800003,
        216.300003,
        212.240005,
        213.300003,
        218.860001,
        222.220001,
        207.479996,
        207.479996,
        207.479996,
        207.479996,
        207.479996,
        207.479996,
        207.479996,
        207.479996,
        207.479996,
        207.479996,
        207.479996,
        207.479996,
        207.479996,
        207.479996,
        207.479996,
        207.479996,
        207.479996,
        207.479996,
        207.479996,
        207.479996,
        207.479996,
        207.479996,
        207.479996,
        207.479996,
        207.479996
    ]
    
    let stockData2 : [Double] = [
        140.8367,
        140.651016,
        140.387177,
        140.426254,
        141.471878,
        140.738983,
        140.387177,
        140.074463,
        139.908325,
        138.403427,
        138.56955,
        137.836624,
        138.598862,
        137.9832,
        137.475052,
        139.194962,
        139.028854,
        140.36763,
        141.23735,
        140.406723,
        140.514191,
        140.37738,
        143.240646,
        144.149475,
        143.709702,
        143.191772,
        145.566422,
        149.524139,
        150.481842,
        149.768448,
        151.063705,
        153.173401,
        152.780899,
        152.555237,
        147.433075,
        149.680145,
        150.190384,
        151.102982,
        150.916519,
        150.465149,
        150.985199,
        150.730072,
        150.788956,
        149.896011,
        150.308136,
        152.535599,
        151.044067,
        151.554321,
        152.457092,
        152.084213,
        146.186874,
        142.693649,
        143.84169,
        142.438507,
        141.584808,
        139.602707,
        143.596375,
        142.291321,
        143.135193,
        142.899704,
        143.537506,
        143.086136,
        141.035309,
        143.095947,
        140.986252,
        141.319901,
        140.809631,
        141.388565,
        140.054062,
        141.476883,
        142.340378,
        142.801575,
        143.007645,
        144.999573,
        146.245743,
        146.756012,
        147.266281,
        148.188644,
        147.521393,
        147.452713,
        149.238586,
        149.876404,
        150.582916,
        147.737274,
        146.697144,
        145.941574,
        147.236847,
        154.193909,
        152.65332,
        153.457947,
        155.832596,
        157.078781,
        158.040405,
        153.006531,
        155.134338,
        157.46907,
        159.192978,
        158.552673,
        155.508698,
        155.154068,
        154.868378,
        157.400101,
        157.597107,
        156.89769,
        157.478897,
        159.064911,
        160.48349,
        160.916916,
        161.557236,
        161.606491,
        159.665848,
        159.498367,
        158.858032,
        156.267227,
        159.094467,
        158.46402,
        157.272018,
        155.92244,
        157.498611,
        156.306625,
        156.365723,
        153.745377,
        151.10527,
        149.627625,
        148.307571,
        150.859009,
        151.93277,
        150.996918,
        151.824387,
        151.519028,
        152.179031,
        151.193924,
        153.07547,
        152.986816,
        153.518768,
        153.577866,
        154.218216,
        153.676392,
        154.651642,
        157.498611,
        158.079819,
        157.380386,
        153.656693,
        153.922668,
        153.843857,
        154.76001,
        154.080307,
        155.065399,
        160.621384,
        164.236725,
        166.522171,
        164.40419,
        165.606018,
        169.930634,
        171.654556,
        172.206223,
        173.614929,
        173.2603,
        172.686859,
        171.994812,
        169.394669,
        167.160339,
        169.15741,
        168.218185,
        168.05011,
        171.174255,
        172.973587,
        172.983475,
        172.113464,
        171.105042,
        167.555801,
        169.898895,
        169.107971,
        167.872177,
        167.713974,
        167.091141,
        167.397629,
        167.447037,
        170.709595,
        169.750595,
        170.314117,
        170.264694,
        171.994812,
        174.417007,
        172.55835,
        172.370514,
        173.023026,
        173.023026,
        168.633423,
        168.663101,
        169.13765,
        167.30864,
        170.30423,
        170.274567,
        171.065506,
        173.013123,
        172.370514,
        172.350739,
        172.311188,
        173.289948,
        175.079391,
        174.189636,
        177.066589,
        177.224762,
        176.433853,
        174.990433,
        175.029968,
        172.241974,
        169.167297,
        169.562744,
        166.053055,
        165.074295,
        165.529068,
        165.875092,
        158.67775,
        154.713287,
        161.179016,
        157.728638,
        153.388489,
        155.264664,
        161.518524,
        163.136581,
        166.144394,
        171.723251,
        171.167343,
        170.591599,
        169.817307,
        171.236832,
        174.214859,
        177.659454,
        177.08371,
        176.815674,
        173.718521,
        174.919678,
        175.525208,
        175.376297,
        173.748306,
        175.644318,
        178.662048,
        180.389313,
        178.65213,
        177.133331,
        177.341782,
        176.716415,
        174.016342,
        173.956772,
        170.015839,
        167.613556,
        163.732193,
        171.504868,
        167.1073,
        165.26091,
        166.551392,
        165.459442,
        167.156921,
        170.353363,
        171.534637,
        167.147018,
        168.804779,
        171.981339,
        171.177277,
        172.864822,
        173.4505,
        174.532532,
        176.934799,
        176.53772,
        171.534637,
        164.50647,
        164.029999,
        161.746841,
        162.45163,
        163.017471,
        161.131378,
        164.049835,
        167.861725,
        175.277039,
        175.594681,
        182.483856,
        183.804123,
        184.687607,
        185.988022,
        188.648392,
        187.930908,
        187.492432,
        185.788422,
        187.522324,
        186.336502,
        185.658875,
        186.974258,
        186.505905,
        187.701706,
        187.492432,
        187.920944,
        187.243317,
        186.844711,
        186.216904,
        189.57515,
        191.159576,
        192.634399,
        193.302063,
        192.78389,
        191.030029,
        190.561676,
        191.608002,
        190.033524,
        190.133179,
        188.180023,
        188.080383,
        185.041046,
        185.848206,
        184.811844,
        184.273727,
        181.53334,
        183.785431,
        183.516388,
        184.8517,
        184.463074,
        186.525818,
        183.277222,
        184.752045,
        187.31308,
        189.913956,
        189.684753,
        187.223389,
        190.362381,
        190.661331,
        190.242798,
        190.780899,
        189.734573,
        191.209412,
        190.77095,
        190.940353,
        192.325485,
        194.139145,
        193.531265,
        190.312546,
        189.246292,
        189.624954,
        200.795792,
        206.665207,
        207.263107,
        208.33934,
        206.386185,
        206.525696,
        208.149994,
        207.529999,
        208.869995,
        209.75,
        210.240005,
        213.320007,
        217.580002,
        215.460007,
        215.039993,
        215.050003,
        215.490005,
        216.160004,
        217.940002,
        219.699997,
        222.979996,
        225.029999,
        227.630005,
        228.360001,
        226.869995,
        223.100006,
        221.300003,
        218.330002,
        223.850006,
        221.070007,
        226.410004,
        223.839996,
        217.880005,
        218.240005,
        218.369995,
        220.029999,
        217.660004,
        220.789993,
        222.190002,
        220.419998,
        224.949997,
        225.740005,
        227.259995,
        229.279999,
        232.070007,
        227.990005,
        224.289993,
        223.770004,
        226.869995,
        216.360001,
        214.449997,
        222.110001,
        217.360001,
        222.149994,
        221.190002,
        216.020004,
        219.309998,
        220.649994,
        222.729996,
        215.089996,
        219.800003,
        216.300003,
        212.240005,
        213.300003,
        218.860001,
        222.220001,
        207.479996,
        201.589996
    ]
    
    let stockData3 : [Double] = [
    
        186.844711,
        186.216904,
        189.57515,
        191.159576,
        192.634399,
        193.302063,
        192.78389,
        191.030029,
        190.561676,
        191.608002,
        190.033524,
        190.133179,
        188.180023,
        188.080383,
        185.041046,
        185.848206,
        184.811844,
        184.273727,
        181.53334,
        183.785431,
        183.516388,
        184.8517,
        184.463074,
        186.525818,
        183.277222,
        184.752045,
        187.31308,
        189.913956,
        189.684753,
        187.223389,
        190.362381,
        190.661331,
        190.242798,
        190.780899,
        189.734573,
        191.209412,
        190.77095,
        190.940353,
        192.325485,
        194.139145,
        193.531265,
        190.312546,
        189.246292,
        189.624954,
        200.795792,
        206.665207,
        207.263107,
        208.33934,
        206.386185,
        206.525696,
        208.149994,
        207.529999,
        208.869995,
        209.75,
        210.240005,
        213.320007,
        217.580002,
        215.460007,
        215.039993,
        215.050003,
        215.490005,
        216.160004,
        217.940002,
        219.699997,
        222.979996,
        225.029999,
        227.630005,
        228.360001,
        226.869995,
        223.100006,
        221.300003,
        218.330002,
        223.850006,
        221.070007,
        226.410004,
        223.839996,
        217.880005,
        218.240005,
        218.369995,
        220.029999,
        217.660004,
        220.789993,
        222.190002,
        220.419998,
        224.949997,
        225.740005,
        227.259995,
        229.279999,
        232.070007,
        227.990005,
        224.289993,
        223.770004,
        226.869995,
        216.360001,
        214.449997,
        222.110001,
        217.360001,
        222.149994,
        221.190002,
        216.020004,
        219.309998,
        220.649994,
        222.729996,
        215.089996,
        219.800003,
        216.300003,
        212.240005,
        213.300003,
        218.860001,
        222.220001,
        207.479996,
        201.589996
    ]
}
