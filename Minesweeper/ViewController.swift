//
//  ViewController.swift
//  Minesweeper
//
//  Created by 谭凯文 on 2018/2/26.
//  Copyright © 2018年 Tan Kevin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // This stores the UI of the buttons, being fetched by index
    var buttons: [UIButton]!
    
    var indiceOfAllocatedMines = [Int]()
    
    var isVirgin = true
    
    /*
    When the user tap one of the buttons, this method is called and will do the following things:
    0. Get the index of the button in the buttons array
    1. If it is the first time, ensure the tapped button isn't on a mine and allocate the mines
    2. Find whether on a mine, if so, end the game
    3. Get the number of mines around the tapped button
    4. Refresh the UI of the button using the returned number
    5. If the number is 0, do additional refreshment by searching the nearby buttons and decide whether to refresh them
    */
    func tapOneButton(sender: UIButton) {
        guard let index = buttons.index(of: sender) else {
            fatalError()
        }
        if isVirgin {
            isVirgin = false
            allocateMines(withIndex: index)
        }
        if indiceOfAllocatedMines.contains(index) {
            gameOver(ofIndex: index)
            return
        }
        switch numberOfMinesAround(ofIndex: index) {
        case 0:
            sender.setTitle("", for: .normal)
        // - TODO: More code when 0
        case 1...7:
            sender.setTitle("\(numberOfMinesAround(ofIndex: index))", for: .normal)
        default:
            fatalError()
        }
    }
    
    func allocateMines(withIndex index: Int) {
        for _ in 0...9 {
            var i = Int(arc4random_uniform(81))
            while indiceOfAllocatedMines.contains(i) || i == index {
                i = Int(arc4random_uniform(81))
            }
            indiceOfAllocatedMines.append(i)
        }
    }
    
    func gameOver(ofIndex index: Int) {
        print("Game is over")
        // - TODO:
    }
    
    func numberOfMinesAround(ofIndex index: Int) -> Int {
        // - TODO:
        return 0
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

