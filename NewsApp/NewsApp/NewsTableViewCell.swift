//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by Jervy Umandap on 5/25/21.
//

import UIKit

class NewsTableViewCellViewModel {
    let title: String
    let subtitle: String?
    let imageURL: URL?
    var imageData: Data? = nil
    
    init(title: String,
         subtitle: String?,
         imageURL: URL?
    ) {
        self.title = title
        self.subtitle = subtitle
        self.imageURL = imageURL
    }
    
}

class NewsTableViewCell: UITableViewCell {
    
    static let identifier = "NewsTableViewCell"
    
    private let newsTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.numberOfLines = 0
        label.layer.masksToBounds = true
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.numberOfLines = 0
        label.layer.masksToBounds = true
        return label
    }()
    
    private let newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "xmark.rectangle.portrait")
        imageView.tintColor = .systemGray
        imageView.backgroundColor = .systemRed
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 5.0
        imageView.backgroundColor = .secondarySystemBackground
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(newsTitleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(newsImageView)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        newsTitleLabel.sizeToFit()
        newsTitleLabel.frame = CGRect(
            x: 10,
            y: 0,
            width: contentView.frame.size.width-170,
            height: contentView.frame.size.height*0.70)
//        newsTitleLabel.backgroundColor = .systemBlue
        
        subtitleLabel.sizeToFit()
        subtitleLabel.frame = CGRect(
            x: 10,
            y: newsTitleLabel.frame.size.height,
            width: contentView.frame.size.width-170,
            height: contentView.frame.size.height*0.30)
//        subtitleLabel.backgroundColor = .systemPink
        
        
        newsImageView.frame = CGRect(
            x: contentView.frame.size.width-150,
            y: 5,
            width: contentView.frame.size.height-10,
            height: contentView.frame.size.height-10)
//        newsImageView.backgroundColor = .systemRed
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        newsTitleLabel.text = nil
        subtitleLabel.text = nil
        newsImageView.image = nil
        
    }
    
    func configure(withViewModel model: NewsTableViewCellViewModel) {
        newsTitleLabel.text = model.title
        subtitleLabel.text = model.subtitle
//        newsImageView.image
        
        // image
        if let data = model.imageData {
            newsImageView.image = UIImage(data: data)
        } else if let url = model.imageURL {
            // fetch image
            URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
                guard let data = data, error == nil else {
                    return
                }
                
                model.imageData = data
                
                DispatchQueue.main.async {
                    self?.newsImageView.image = UIImage(data: data)
                }
            }.resume()
            
        }
    }

}
