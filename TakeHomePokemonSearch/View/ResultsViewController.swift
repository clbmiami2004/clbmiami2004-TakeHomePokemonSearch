//
//  ResultsViewController.swift
//  TakeHomePokemonSearch
//
//  Created by Christian Lorenzo on 4/18/21.
//

import UIKit


class ResultsViewController: UIViewController {
    
    //MARK: - Properties:
    var pokemon: MyPokemon? {
        didSet {
            updateViews()
        }
    }
    
    var apiController = APIController() {
        didSet {
            updateViews()
        }
    }
    
    var customerModel = Customer()
    var pokemonActlPrice = 0.00
    var customerCurrentBal = 0.00
    var customerRemBal = 0.00
    var customerName: String?
    var customerLastN: String?
    var isComplete = false
    
    //MARK: - IBOutlets:
    @IBOutlet weak var searchBarOutlet: UISearchBar!
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var pokemonPrice: UILabel!
    @IBOutlet weak var buyButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
        searchBarOutlet.delegate = self
        buyButtonOutlet.isHidden = true
    }
    
    //MARK: - Methods:
    func updateViews() {
        guard isViewLoaded else {
            return
        }
        
        guard let pokemonObject = pokemon else {
            title = "Pokemon Search"
            return
        }
        
        title = pokemonObject.name.capitalized
        pokemonName.text = pokemon?.name
        let calculatedPrice = Double(pokemonObject.base_experience * 6) * 0.01
        pokemonPrice.text = String(format: "$%.2f", calculatedPrice)
        pokemonActlPrice = Double(pokemonObject.base_experience * 6) * 0.01
        
        apiController.fetchImage(from: pokemonObject.sprites.imageUrl, completion: { (pokemonImage) in
            DispatchQueue.main.async {
                self.pokemonImageView.image = pokemonImage
            }
        })
    }
    
    func hideKeyboard() {
        searchBarOutlet.resignFirstResponder()
    }
    
    //MARK: - IBAction:
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if (identifier == "mySegueIdentifier") {
            return isComplete == true
        }
        return true
    }
    
    @IBAction func buyButtonAction(_ sender: UIButton) {
        
        if customerModel.balance >= pokemonActlPrice {
            
            DispatchQueue.main.async {
                let custAlert = UIAlertController(title: "Great!", message: "You currently have $\(self.customerModel.balance) on your balance to buy this Pokemon!", preferredStyle: .alert)
                custAlert.addAction(UIAlertAction(title: "Continue with Purchase", style: .default, handler: nil))
                self.present(custAlert, animated: true)
            }
            
            customerCurrentBal = customerModel.balance
            customerRemBal = customerCurrentBal - pokemonActlPrice
            customerName = customerModel.fName
            customerLastN = customerModel.lastN
        } else {
            let custAlert2 = UIAlertController(title: "We're Sorry...", message: "You currently have $\(customerModel.balance) on your balance, which is not enough to buy this Pokemon!", preferredStyle: .alert)
            custAlert2.addAction(UIAlertAction(title: "Go back", style: .default, handler: nil))
            present(custAlert2, animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToSummary" {
            let destinationVC = segue.destination as! SummaryViewController
            destinationVC.customerName = customerName
            destinationVC.customerLastN = customerLastN
            destinationVC.customerCurrentBal = customerCurrentBal
            destinationVC.pokemonActlPrice = pokemonActlPrice
            destinationVC.customerRemBal = customerRemBal
        }
    }
}

extension ResultsViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchType = searchBarOutlet.text else { return }
        
        apiController.fetchPokemon(pokemonName: searchType) { (pokemonObject) in
            
            guard let pokemon = try? pokemonObject.get() else {
                DispatchQueue.main.async {
                    let custAlert = UIAlertController(title: "Oops!", message: "Please check your spelling", preferredStyle: .alert)
                    custAlert.addAction(UIAlertAction(title: "Go Back to Search", style: .default, handler: nil))
                    self.present(custAlert, animated: true)
                }
                
                return
            }
            
            DispatchQueue.main.async {
                self.pokemon = pokemon
                self.buyButtonOutlet.isHidden = false
            }
        }
        
        guard let pokemonImageURL = pokemon?.sprites.imageUrl else {
            return
        }
        
        apiController.fetchImage(from: pokemonImageURL, completion: { (pokemonImage) in
            DispatchQueue.main.async {
                self.pokemonImageView.image = pokemonImage
            }
        })
    }
}
