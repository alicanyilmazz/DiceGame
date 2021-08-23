//
//  ViewController.swift
//  DiceGame
//
//  Created by alican on 22.08.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblGamerOneScore: UILabel!
    
    @IBOutlet weak var lblGamerTwoScore: UILabel!
    
    @IBOutlet weak var lblGamerOnePuan: UILabel!
    
    @IBOutlet weak var lblGamerTwoPuan: UILabel!
    
    @IBOutlet weak var ImgGamerOneState: UIImageView!
    
    @IBOutlet weak var ImgGamerTwoState: UIImageView!
    
    @IBOutlet weak var ImgDiceOne: UIImageView!
    
    @IBOutlet weak var ImgDiceTwo: UIImageView!
    
    @IBOutlet weak var lblSetResult: UILabel!
    
    var gamerPoints = (firstGamerPoint : 0 , secondGamerPoint : 0)
    var gamerScores = (firstGamerScore : 0 , secondGamerScore : 0)
    var orderOfPlayers : Int = 1
    var numberOfMaxSet : Int = 5
    var currentSet : Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let background = UIImage(named: "background") {
            self.view.backgroundColor = UIColor(patternImage: background)
        }
        
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if currentSet > numberOfMaxSet   {
            return
        }
        generateDiceValues()
    }
    
    func setResult(dice1 : Int , dice2 : Int){
        if orderOfPlayers == 1{
            gamerPoints.firstGamerPoint = dice1 + dice2
            lblGamerOnePuan.text = String(gamerPoints.firstGamerPoint)
            ImgGamerOneState.image = UIImage(named: "wait")
            ImgGamerTwoState.image = UIImage(named: "accepted")
            lblSetResult.text = "waiting second player!"
            orderOfPlayers = 2
            lblGamerTwoPuan.text = "0"
        }else{
            gamerPoints.secondGamerPoint = dice1 + dice2
            lblGamerTwoPuan.text = String(gamerPoints.secondGamerPoint)
            ImgGamerTwoState.image = UIImage(named: "wait")
            ImgGamerOneState.image = UIImage(named: "accepted")
            orderOfPlayers = 1
            
            if gamerPoints.firstGamerPoint > gamerPoints.secondGamerPoint {
                gamerScores.firstGamerScore += 1
                lblSetResult.text = "\(currentSet). set was gained by first player."
                currentSet += 1
                lblGamerOneScore.text = String(gamerScores.firstGamerScore)
            }else if gamerPoints.secondGamerPoint > gamerPoints.firstGamerPoint{
                gamerScores.secondGamerScore += 1
                lblSetResult.text = "\(currentSet). set was gained by second player."
                currentSet += 1
                lblGamerTwoScore.text = String(gamerScores.secondGamerScore)
            }else{
                // Battle Equals
                lblSetResult.text = "\(currentSet). set ended with equality."
            }
            
            
        }
    }
    
    func generateDiceValues(){
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3){
            let dice1 = arc4random_uniform(6) + 1
            let dice2 = arc4random_uniform(6) + 1
            
            self.ImgDiceOne.image = UIImage(named: String(dice1))
            self.ImgDiceTwo.image = UIImage(named: String(dice2))
            
            self.setResult(dice1: Int(dice1), dice2: Int(dice2))
            
            if self.currentSet > self.numberOfMaxSet {
                if self.gamerScores.firstGamerScore > self.gamerScores.secondGamerScore{
                    self.lblSetResult.text = "Star of the game is First player!"
                }else{
                    self.lblSetResult.text = "Star of the game is Second player!"
                }
            }
        }
        lblSetResult.text = "\(orderOfPlayers). player rolls the dice..."
        ImgDiceOne.image = UIImage(named: "unknowndice")
        ImgDiceTwo.image = UIImage(named: "unknowndice")
    }

}

