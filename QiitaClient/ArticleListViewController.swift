import UIKit
import SafariServices

class ArticleListViewController: UIViewController {

    let tableView = UITableView()
    let client: ArticleListAPIClientProtocol
    
    var items: [Article] = []
    
    init(client: ArticleListAPIClientProtocol = ArticleListAPIClient()) {
        self.client = client
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        tableView.register(ArticleListCell.self, forCellReuseIdentifier: "ArticleListCell")
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        client.fetch { [weak self] (articleList) in
            guard let articleList = articleList else { return }
            
            self?.items = articleList
            self?.tableView.reloadData()
        }
    }
}

extension ArticleListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleListCell") as! ArticleListCell
        
        let article = items[indexPath.row]
        cell.titleLabel.text = article.title

        return cell
    }
}

extension ArticleListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = URL(string: items[indexPath.row].url) else { return }
        
        let safariViewController = SFSafariViewController(url: url)
        present(safariViewController, animated: true, completion: nil)
    }
    
}
