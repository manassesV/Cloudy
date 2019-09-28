import UIKit
import CoreLocation

protocol AddLocationViewControllerDelegate {
    func controller(_ controller: AddLocationViewController, didAddLocation location: Location)
}

class AddLocationViewController: UIViewController {

    // MARK: - Properties

    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    
    var viewModel: AddLocationViewModel!
    
    


    // MARK: -

    private var locations: [Location] = []

 

    // MARK: -

    var delegate: AddLocationViewControllerDelegate?

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Add Location"
        
        viewModel = AddLocationViewModel(locationService: Geocoder())
        viewModel.locationDidChange = {
            (locations) in
            self.tableView.reloadData()
        }
        viewModel.queryingDidChange = {
            (querying) in
            if querying {
               self.activityIndicator.startAnimating()
            }else{
               self.activityIndicator.stopAnimating()
            }
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // Show Keyboard
        searchBar.becomeFirstResponder()
    }

    // MARK: - View Methods

    private func setupView() {

    }

    private func updateView() {

    }

   


}

extension AddLocationViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfLocations
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LocationTableViewCell.reuseIdentifier, for: indexPath) as? LocationTableViewCell else { fatalError("Unexpected Table View Cell") }

        if let viewModel = viewModel.viewModelForLocation(at: indexPath.row){
            cell.configure(withViewModel: viewModel)
        }
        return cell
    }

}

extension AddLocationViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Fetch Location
        guard let location = viewModel.location(at: indexPath.row) else { return }

        // Notify Delegate
        delegate?.controller(self, didAddLocation: location as! Location)

        // Pop View Controller From Navigation Stack
        navigationController?.popViewController(animated: true)
    }

}

extension AddLocationViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // Hide Keyboard
        searchBar.resignFirstResponder()

        // Forward Geocode Address String
        viewModel.query = searchBar.text!
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // Hide Keyboard
        searchBar.resignFirstResponder()

        // Clear Locations
          viewModel.query = searchBar.text!

        // Update Table View
        tableView.reloadData()
    }

}
