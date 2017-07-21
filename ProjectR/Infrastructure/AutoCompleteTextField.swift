//
//  AutoCompleteTextField.swift
//  ProjectR
//
//  Created by Wesley Buck on 2017/07/21.
//  Copyright © 2017 Retro Rabbit Professional Services. All rights reserved.
//

import Material
import RxCocoa
import RxSwift

@objc protocol AutoCompleteProvider {
    // for async
    func provideSuggestionsForAutoCompleteTextField(_ textField: AutoCompleteTextField, forString string: String, toCallback callback: @escaping ([AutoCompleteTextField.Suggestion]) -> Void)
    @objc optional func disposeFetchForAutoCompleteTextField(_ textField: AutoCompleteTextField)
}

class AutoCompleteTextField: ProjectRTextField, UITableViewDelegate, UITableViewDataSource {
    class Suggestion: NSObject {
        let text: String
        let subtext: String
        
        init(text: String, subtext: String) {
            self.text = text
            self.subtext = subtext
        }
    }
    
    // public interface
    var autocompleteDelay: TimeInterval = 0.5
    weak var autoCompleteProvider: AutoCompleteProvider?
    
    var autoCompleteFont: UIFont = ProjectRFont.AvenirLightOblique(with: Style.font.font_medium)
    var autoCompleteSubfont: UIFont = ProjectRFont.AvenirLightOblique(with: Style.font.font_small)
    var autoCompleteTextColor: UIColor = Style.color.white
    var autoCompleteBackgroundColor: UIColor = Style.color.grey_dark
    var autoCompleteSeparatorsEnabled: Bool = false
    var autoCompleteMaxHeight: CGFloat = 200
    var viewToBringAutoCompleteToFront: UIView?
    var autoCompleteShadowOpacity: Float = 0
    var autoCompleteShadowRadius: CGFloat = 2
    
    // ui
    fileprivate let completionsTableView = UITableView(forAutoLayout: ())
    fileprivate var tableViewHeightConstraint: NSLayoutConstraint?
    
    // data
    fileprivate var suggestions: [Suggestion] = []
    fileprivate let reuseIdentifier = "cell"
    fileprivate let disposeBag = DisposeBag()
    
    // call this! in like viewDidLoad or whatever
    func setupAutoComplete() {
        completionsTableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        completionsTableView.separatorStyle = autoCompleteSeparatorsEnabled ? .singleLine : .none
        completionsTableView.backgroundColor = autoCompleteBackgroundColor
        completionsTableView.delegate = self
        completionsTableView.dataSource = self
        rx.textInput.text
            .skip(1) // an event always fires at startup and it is useless
            .do(onNext: { [weak self] (text) in
                if text == "" {
                    self?.dismissAutoCompleteSuggestions()
                }
                
                if let this = self,
                    let provider = this.autoCompleteProvider,
                    let dispose = provider.disposeFetchForAutoCompleteTextField {
                    dispose(this)
                }
            })
            .throttle(autocompleteDelay, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] (text) in
                if text == "" {
                    self?.dismissAutoCompleteSuggestions()
                } else if let this = self
                    , this.isFirstResponder,
                    let provider = this.autoCompleteProvider {
                    provider.provideSuggestionsForAutoCompleteTextField(this, forString: text!, toCallback: this.presentAutoCompleteSuggestions)
                }
            })
            .addDisposableTo(disposeBag)
        
        completionsTableView.isUserInteractionEnabled = true
        // Activate Accessibility
        completionsTableView.isAccessibilityElement = true
        completionsTableView.accessibilityIdentifier = "completionsTableView"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return suggestions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: reuseIdentifier)
        cell.backgroundColor = autoCompleteBackgroundColor
        let suggestion = suggestions[(indexPath as IndexPath).row]
        if let label = cell.textLabel {
            label.text = suggestion.text
            label.font = autoCompleteFont
            label.textColor = autoCompleteTextColor
        }
        
        if let label = cell.detailTextLabel {
            label.text = suggestion.subtext
            label.font = autoCompleteSubfont
            label.textColor = autoCompleteTextColor
        }
        
        cell.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(didSelectSuggestion(_:))))
        cell.isUserInteractionEnabled = true
        return cell
    }
    
    func presentAutoCompleteSuggestions(_ suggestions: [Suggestion]) {
        self.suggestions = suggestions
        completionsTableView.reloadData()
        completionsTableView.isAccessibilityElement = true
        completionsTableView.accessibilityIdentifier = "completionsTableView"
        
        // Add popup to top viewcontroller
        if let topView = AppDelegate.topViewController().view {
            topView.addSubview(completionsTableView)
            
            //get converted frame when auto complete is added to subviews of top controller.
            if let convertedFrame = self.superview?.convert(self.frame, to: topView) {
                completionsTableView.autoPinEdge(.top, to: .top, of: topView, withOffset: convertedFrame.bottom + 2)
            } else {
                completionsTableView.autoPinEdge(.top, to: .bottom, of: self, withOffset: 2)
            }
            
            completionsTableView.autoPinEdge(.left, to: .left, of: self, withOffset: 0)
            completionsTableView.autoMatch(.width, to: .width, of: self)
            completionsTableView.autoSetDimension(.height, toSize: min(completionsTableView.contentSize.height, autoCompleteMaxHeight))
        }
    }
    
    func didSelectSuggestion(_ sender: AnyObject!) {
        guard let tap = sender as? UIGestureRecognizer,
            let cell = tap.view as? UITableViewCell,
            let cellLabel = cell.textLabel,
            let suggestion = cellLabel.text
            else { return }
        text = suggestion
        dismissAutoCompleteSuggestions()
    }
    
    func dismissAutoCompleteSuggestions() {
        suggestions = []
        completionsTableView.reloadData()
        
        completionsTableView.removeFromSuperview()
        completionsTableView.removeConstraints(completionsTableView.constraints)
    }
    
    /*
     This allows the suggestion cells to capture touch events
     even though the table view is entirely outside the text view's frame
     */
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return super.point(inside: point, with: event) ||
            completionsTableView.point(
                inside: convert(point, to: completionsTableView),
                with: event)
    }
    
    override func resignFirstResponder() -> Bool {
        dismissAutoCompleteSuggestions()
        return super.resignFirstResponder()
    }
}
