//
//  MSViewController.swift
//  Minesweeper
//
//  Created by 谭凯文 on 2018/3/4.
//  Copyright © 2018年 Tan Kevin. All rights reserved.
//

import UIKit

class MSViewController: UIViewController {
    
    var tiles = [UIButton]()
    var indiceOfMines = [Int]()
    var controlButton = UIButton()
    var steppers = [UIStepper]()
    var numberLabels = [UILabel]()
    var themeColor = UIColor(red: CGFloat(144)/255, green: CGFloat(0)/255, blue: CGFloat(33)/255, alpha: 1.0)
    
    var scale: Int {
        return 9
    }
    
    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = themeColor
        
        
        createNet()
    }

    
    // MARK: - Creation methods
    
    func createNet() {
        
        // Create the tiles
        let size = Double(view.bounds.size.width) / Double(scale)
        for row in 0...scale - 1 {
            for column in 0...scale - 1 {
                let button = UIButton(frame: CGRect(x: Double(column) * size, y: Double(row) * size + 44, width: size, height: size))
                button.setTitle("⚪️", for: .normal)
                button.backgroundColor = themeColor
                button.addTarget(self, action: #selector(setSafeTile(sender:)), for: .touchUpInside)
                button.addTarget(self, action: #selector(setMine(sender:)), for: .touchDragOutside)
                
                tiles.append(button)
                view.addSubview(button)
            }
        }
        
        // Refresh the net of tiles to set mines
        initializeNet(ofRowsAndColumns: scale)
        
        // Create the control button
        controlButton.frame = CGRect(x: 5, y: Double(scale + 1) * size, width: Double(view.bounds.width) - 10, height: 40)
        controlButton.setTitle("重新开局", for: .normal)
        controlButton.backgroundColor = .darkGray
        controlButton.layer.cornerRadius = 20
        controlButton.addTarget(self, action: #selector(restartGame(sender:)), for: .touchUpInside)
        self.view.addSubview(controlButton)
        
        
    }
    
    
//     Create the steppers and views to determine the scale of tiles
//    private func createControls() {
//
//        for index in 0...1 {
//            let nameLabel = UILabel()
//            nameLabel.frame = CGRect(x: 5, y: 30 + index * 30, width: 20, height: 20)
//            nameLabel.text = index == 0 ? "row" : "column"
////            self.addConstraint(NSLayoutConstraint(item: self.view, attribute: .topMargin, relatedBy: .equal, toItem: nameLabel, attribute: .top, multiplier: 1, constant: 0))
//            view.addSubview(nameLabel)
//
//            let stepper = UIStepper()
////            stepper.frame = CGRect(x: 5, y: Double(scale + 1) * size + 60 + Double(index) * 40, width: Double(stepper.frame.width), height: Double(stepper.frame.height))
//            stepper.addTarget(self, action: #selector(setScaleValue(sender:)), for: .valueChanged)
//            stepper.maximumValue = 10
//            view.addSubview(stepper)
//            steppers.append(stepper)
//
//            numberLabels.append(UILabel())
//            numberLabels[index].frame = CGRect(x: stepper.frame.maxX + 10, y: stepper.frame.minY, width: stepper.frame.height, height: stepper.frame.height)
//            numberLabels[index].text = "\(Int(stepper.value))"
//            view.addSubview(numberLabels[index])
//        }
//    }
    
    private func initializeNet(ofRowsAndColumns scale: Int) {
        indiceOfMines = [0, 1, 6, 19, 20, 25, 39, 60, 70, 71]
        
    }
    
    // MARK: - Action
    @objc func setSafeTile(sender: UIButton) {
        sender.isEnabled = false
        
        // To avoid loop check
        if sender.title(for: .normal)! == "✅" {
            return
        }
        
        guard let index = tiles.index(of: sender) else {
            fatalError()
        }
        
        if indiceOfMines.contains(index) {
            for i in indiceOfMines {
                tiles[i].setTitle("💀", for: .normal)
            }
            for button in tiles {
                button.isEnabled = false
            }
            
            return
        }
        
        let indiceOfMinesNearby = minesNearby(ofIndex: index)
        switch indiceOfMinesNearby.count {
        case 0:
            sender.setTitle("✅", for: .normal)
            let coordinate = Coordinate(fromIndex: index, ofScale: scale)
            for m in -1...1 {
                for i in -1...1 {
                    if let index = Coordinate.indexFromCoordinate(row: coordinate.row + i, column: coordinate.column + m, ofScale: scale) {
                        setSafeTile(sender: tiles[index])
                    }
                }
            }
        case 1:
            sender.setTitle("1️⃣", for: .normal)
        case 2:
            sender.setTitle("2️⃣", for: .normal)
        case 3:
            sender.setTitle("3️⃣", for: .normal)
        case 4:
            sender.setTitle("4️⃣", for: .normal)
        case 5:
            sender.setTitle("5️⃣", for: .normal)
        case 6:
            sender.setTitle("6️⃣", for: .normal)
        case 7:
            sender.setTitle("7️⃣", for: .normal)
        case 8:
            sender.setTitle("8️⃣", for: .normal)
        default:
            fatalError()
        }
    }
    
    @objc func setMine(sender: UIButton) {
        sender.setTitle("💣", for: .normal)
        // TODO: - Modify the number observer
    }
    
    @objc func restartGame(sender: UIButton) {
        
        
        // Refresh the net
        for button in tiles {
            button.setTitle("⚪️", for: .normal)
            button.isEnabled = true
        }
        initializeNet(ofRowsAndColumns: scale)
    }
    
//    @objc func setScaleValue(sender: UIStepper) {
//        if let index = steppers.index(of: sender) {
//            numberLabels[index].text = "\(Int(sender.value))"
//        }
//
//    }
    
    // MARK: - Methods
    func minesNearby(ofIndex index: Int) -> [Int] {
        var indiceOfMinesNearby = [Int]()
        let coordinate = Coordinate(fromIndex: index, ofScale: scale)
        for m in -1...1 {
            for i in -1...1 {
                if let index = Coordinate.indexFromCoordinate(row: coordinate.row + i, column: coordinate.column + m, ofScale: scale), indiceOfMines.contains(index) {
                    indiceOfMinesNearby.append(index);
                }
            }
        }
        return indiceOfMinesNearby
    }
    
    // MARK: - Status bar settings
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }


}
