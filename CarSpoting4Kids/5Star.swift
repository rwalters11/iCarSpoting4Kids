//
//  5Star.swift
//  CarSpoting4Kids
//
//  Created by Richard Walters on 01/08/2017.
//  Copyright © 2017 Example. All rights reserved.
//

import UIKit

@IBDesignable class FiveStar: UIStackView {
    
    //MARK: - Properties
    private var starButtons = [UIButton]()
    
    var rating = 3 {
        didSet {
            updateButtonSelectionStates()
        }
    }
    
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0) {
        didSet {
            setupButtons()
        }
    }
    
    @IBInspectable var starCount: Int = 5 {
        didSet {
            setupButtons()
        }
    }

    //MARK: - Initialisation
    
    // Programatic init
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        setupButtons()
    }
    
    // Storyboard init
    required init(coder: NSCoder) {
        
        super.init(coder: coder)
        
        setupButtons()
    }
    
    //MARK: - Button Action
    
    func ratingButtonTapped(button: UIButton) {
        
        print ("Button pressed")
    }
    
    //MARK: - Private Methods
    
    // Function to setup the Star Buttons
    private func setupButtons() {
        
        // Cear any existing buttons
        for button in starButtons {
            
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        
        starButtons.removeAll()
        
        // Load Button Images from Assets Catalogue
        let bundle = Bundle(for: type(of: self))
        let emptyStar = UIImage(named: "emptyStar", in: bundle, compatibleWith: self.traitCollection)
        let highlightedStar = UIImage(named: "highlightedStar", in: bundle, compatibleWith: self.traitCollection)
        
        // Create 5 buttons
        for _ in 0..<starCount {
        
            // Create the button
            let button = UIButton()
            
            // Set the button images
            button.setImage(emptyStar, for: .normal)
            button.setImage(highlightedStar, for: .highlighted)
            button.setImage(highlightedStar, for: [.highlighted, .selected])
            
            // Add constraints
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            // Setup the button action
            button.addTarget(self, action: #selector(FiveStar.ratingButtonTapped(button:)), for: .touchUpInside)
            
            // Add the button to the stack
            addArrangedSubview(button)
            
            // Add the new button to the array
            starButtons.append(button)
            
        }
        
        updateButtonSelectionStates()
    }
    
    // Function to Update a button's selection state
    private func updateButtonSelectionStates() {
        
        for (index, button) in starButtons.enumerated() {
            
            // If the index of a button is less than the rating, that button should be highlighted
            button.isHighlighted = index < rating
            
        }
    }

}
