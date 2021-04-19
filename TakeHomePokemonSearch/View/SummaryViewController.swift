//
//  SummaryViewController.swift
//  TakeHomePokemonSearch
//
//  Created by Christian Lorenzo on 4/18/21.
//

import UIKit

class SummaryViewController: UIViewController {
    
    //MARK: - Properties:
    var resultsViewController = ResultsViewController()
    var customerName: String?
    var customerLastN: String?
    var customerCurrentBal = 0.00
    var pokemonActlPrice = 0.00
    var customerRemBal = 0.00
    //var pokemonProtocol: PokemonProtocol?
    
    //MARK:- IBOutlets:
    @IBOutlet weak var customerFName: UILabel!
    @IBOutlet weak var customerLName: UILabel!
    @IBOutlet weak var customerCurrentBalance: UILabel!
    @IBOutlet weak var pokemonActualPrice: UILabel!
    @IBOutlet weak var customerRemainingBal: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelsUpdate()
    }
    
    //MARK: - Methods:
    func labelsUpdate() {
        guard let customerName = customerName else { return }
        guard let customerLastN = customerLastN else { return }
        
        customerFName.text = "First Name:  " + customerName
        customerLName.text = "Last Name:   " + customerLastN
        customerCurrentBalance.text = "Your Current Balance =  " + String(customerCurrentBal)
        pokemonActualPrice.text = "Pokemon's price =  " + String(pokemonActlPrice)
        customerRemainingBal.text = "Your balance after purchase =  " + String(format: "$%.2f", customerRemBal)
    }
}

