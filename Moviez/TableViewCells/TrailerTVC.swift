//
//  TrailerTVC.swift
//  Moviez
//
//  Created by Punit Vaigankar on 12/03/21.
//

import UIKit

/*!
 * @typedef TrailerTVC
 * @brief UI to display trailers list
 */
class TrailerTVC: UITableViewCell {

    @IBOutlet weak var trailerNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    /*!
     * @discussion assigned data to UI cell
     * @param trailerName Name of the trailer
     */
    func configureCell(trailerName:String) {
        trailerNameLabel.text = trailerName
    }

}
