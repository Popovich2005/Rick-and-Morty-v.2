//
//  MainViewController.swift
//  Rick and Morty v.2
//
//  Created by Алексей Попов on 19.03.2024.
//

import UIKit

final class MainViewController: UITableViewController {
    
    private var charactersResult: AllCharacter?
    private let networkManager = NetworkManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 100
        
        fetchAllCharacter()
        setNavigationTitle()
    }
    
// MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        charactersResult?.results.count ?? 0
    }
    
    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath)
        guard let cell = cell as? CharacterCell else { return UITableViewCell() }
        let character = charactersResult?.results[indexPath.row] ?? Character(characterDetails: [:])
        cell.configure(with: character)
        
        return cell
    }
    
// MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let characterVC = segue.destination as? CharacterViewController
        characterVC?.characterResult = charactersResult?.results[indexPath.row]
    }
    
// MARK: - Private Metods
    private func setNavigationTitle() {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "1")
        self.navigationItem.titleView = imageView
    }
    
    private func showAlert(withTitle title: String, andMessage message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

// MARK: - Networking
extension MainViewController {
    private func fetchAllCharacter() {
        networkManager.fetchAllCharacter(from: Link.characterURL.url) { [unowned self] result in
            switch result {
            case .success(let result):
                charactersResult = result
                tableView.reloadData()
            case .failure(let error):
                showAlert(withTitle: "Oops...", andMessage: error.localizedDescription)
            }
        }
    }
}









