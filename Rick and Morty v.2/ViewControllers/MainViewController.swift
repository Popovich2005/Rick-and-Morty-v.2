//
//  MainViewController.swift
//  Rick and Morty v.2
//
//  Created by Алексей Попов on 19.03.2024.
//

import UIKit

final class MainViewController: UITableViewController {
    
    private var charactersResult: [Character] = []
//    private let networkManager = NetworkManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 180
        
        fetchCharacter()
        setNavigationTitle()
    }
    
// MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        charactersResult.count
    }
    
    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath)
        guard let cell = cell as? CharacterCell else { return UITableViewCell() }
        
        let character = charactersResult[indexPath.row]
        cell.configure(with: character)
        
        return cell
    }
    
// MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let characterVC = segue.destination as? CharacterViewController
        characterVC?.characterResult = charactersResult[indexPath.row]
    }
    
// MARK: - Private Metods
    private func setNavigationTitle() {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "1")
        self.navigationItem.titleView = imageView
    }
}

// MARK: - Networking
extension MainViewController {
    private func fetchCharacter() {
        URLSession.shared.dataTask(
            with: Link.characterURL.url
        ) { [unowned self] (data, _, error) in
            guard let data = data else { return }
            do {
                let characters = try JSONDecoder().decode(AllCharacter.self, from: data)
                charactersResult = characters.results
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    print(characters.results)
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
//    private func fetchCharacter() {
//        networkManager.fetchAllCharacter(from: Link.characterURL.url) {[unowned self] result in
//            switch result {
//            case .success(let result):
//                charactersResult = result.results
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
}










