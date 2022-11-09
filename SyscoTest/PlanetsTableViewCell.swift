//
//  PlanetsTableViewCell.swift
//  SyscoTest
//
//  Created by ADL on 2022-06-06.
//

import UIKit
import SDWebImage

class PlanetsTableViewCell: UITableViewCell {
    
    var item : PlanetViewModel!{
        didSet{
            self.nameLabel.text = "Planet Name: " + item.planetsApiResultsModel.name!
            self.climateLabel.text = "Climate: " + item.planetsApiResultsModel.climate!
            let fileUrl = URL(string:"https://picsum.photos/200")
            self.iconImageView.sd_setImage(with: fileUrl, completed: nil)
            self.selectionStyle = .none
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    override func layoutSubviews(){
        super.layoutSubviews()
        self.shadowPath(cornerRadius: 10, view: holderView)
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))

    }
    
    lazy var holderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        
        return label
    }()
    
    lazy var climateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    lazy var iconImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func shadowPath(cornerRadius: CGFloat,view:UIView) {
        view.layer.cornerRadius = cornerRadius
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowOpacity = 0.4
    }
    
    func setup() {
        contentView.addSubview(holderView)
        holderView.addSubview(iconImageView)
        holderView.addSubview(nameLabel)
        holderView.addSubview(climateLabel)
        
        holderView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor,constant: 0).isActive = true
        holderView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor,constant: 0).isActive = true
        holderView.widthAnchor.constraint(equalTo: contentView.widthAnchor,multiplier: 1).isActive = true
        holderView.heightAnchor.constraint(equalTo: contentView.heightAnchor,constant: 0.9).isActive = true
        
        iconImageView.centerYAnchor.constraint(equalTo: holderView.centerYAnchor).isActive = true
        iconImageView.leadingAnchor.constraint(equalTo: holderView.leadingAnchor,constant: 10).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 90).isActive = true
        iconImageView.heightAnchor.constraint(equalTo: holderView.heightAnchor,multiplier: 0.75).isActive = true
        
        nameLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor,constant: 10).isActive = true
        nameLabel.topAnchor.constraint(equalTo: holderView.topAnchor,constant: 20).isActive = true
        climateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,constant: 5).isActive = true
        climateLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
        
    }
}
