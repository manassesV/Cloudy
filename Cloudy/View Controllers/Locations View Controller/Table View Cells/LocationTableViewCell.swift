import UIKit

class LocationTableViewCell: UITableViewCell {

    // MARK: - Type Properties

    static let reuseIdentifier = "LocationCell"

    // MARK: - Properties

    @IBOutlet var mainLabel: UILabel!

    // MARK: - Initialization

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    // MARK: - Configuration

    func configure(withViewModel viewModel: LocationRepresentable) {
        mainLabel.text = viewModel.text
    }

}
