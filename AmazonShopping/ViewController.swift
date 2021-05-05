//
//  ViewController.swift
//  AmazonShopping
//
//  Created by Ndayisenga Jean Claude on 05/05/2021.
//

import UIKit

struct textCellViewModel {
    let text: String
    let fontSize: UIFont
}

enum SectionType {
    case productPhotos(images:[UIImage])
    case productInfo(viewModels: [textCellViewModel])
    case relatedProducts(viewModels: [RelatedProductTableViewCellModel])
    
    var title: String? {
        switch self {
        case .relatedProducts:
            return "Related Products"
        default:
            return nil
        }
    }
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.register(PhotoCarouseTableViewCell.self, forCellReuseIdentifier: PhotoCarouseTableViewCell.identifier)
        table.register(RelatedProductTableViewCell.self, forCellReuseIdentifier: RelatedProductTableViewCell.identifier)
        
        return table
    }()
    
    private var sections = [SectionType]()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSections()
        title = "Alexa Echo Dot"
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func configureSections() {
        sections.append(.productPhotos(images: [
        UIImage(named: "photo1"),
        UIImage(named: "photo2"),
        UIImage(named: "photo3"),
        UIImage(named: "photo4")
        ].compactMap({$0 })))
        sections.append(.productInfo(viewModels: [
            textCellViewModel(
                text: "Echo Dotis a great home speakerDevice from Amazon to do stuff Echo Dotis a great home speakerDevice from Amazon to do stuffEcho Dotis a great home speakerDevice from Amazon to do stuffEcho Dotis a great home speakerDevice from Amazon to do stuffEcho Dotis a great home speakerDevice from Amazon to doo stuffEcho Dotis a great home speakerDevice from Amazon to doo stuff.", fontSize: .systemFont(ofSize: 18)
            ),
             textCellViewModel(
                text: "Price: $49.99",
                fontSize: .systemFont(ofSize: 22)
                )
        ]))
        sections.append(.relatedProducts(viewModels: [
            RelatedProductTableViewCellModel(image: UIImage(named: "related1"),
                                             title: "Echo Essantial"),
            RelatedProductTableViewCellModel(image: UIImage(named: "related2"),
                                             title: "Echo show"),
            RelatedProductTableViewCellModel(image: UIImage(named: "related3"),
                                             title: "Echo television"),
            RelatedProductTableViewCellModel(image: UIImage(named: "related4"),
                                             title: "Echo orginal"),
        
        ] ))
        
    }
    // Table
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionType = sections[section]
        switch sectionType {
        case .productPhotos:
            return 1
        case .productInfo(let viewModels):
            return viewModels.count
        case .relatedProducts(let viewModels):
            return viewModels.count
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionType = sections[section]
        return sectionType.title
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let sectionType = sections[indexPath.section]
        switch sectionType {
        case .productPhotos(let images):
            guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: PhotoCarouseTableViewCell.identifier,
                    for: indexPath
            ) as? PhotoCarouseTableViewCell  else {
                fatalError()
            }
            cell.configure(with: images)
            return cell
            
        case .productInfo(let viewModels):
            let viewModel = viewModels[indexPath.row]
             let cell = tableView.dequeueReusableCell(
                    withIdentifier: "cell",
                    for: indexPath
            )
            cell.configure(with: viewModel)
            return cell
            
        case .relatedProducts(let viewModels):
            
            guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: RelatedProductTableViewCell.identifier,
                    for: indexPath
            ) as? RelatedProductTableViewCell  else {
                fatalError()
            }
            cell.configure(with: viewModels[indexPath.row])
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sectionType = sections[indexPath.section]
        switch sectionType {
        case .productPhotos:
            return view.frame.size.width
        case .relatedProducts:
            return 150
        case .productInfo:
            
            return UITableView.automaticDimension
        }
    }
}
extension UITableViewCell {
    func configure(with viewModel:textCellViewModel) {
        textLabel?.text = viewModel.text
        textLabel?.numberOfLines = 0
        textLabel?.font = viewModel.fontSize
        
    }
}
