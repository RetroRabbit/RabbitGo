//
//  StyleHelper.swift
//  ProjectR
//
//  Created by Niell Agenbag on 2017/07/12.
//  Copyright © 2017 Retro Rabbit Professional Services. All rights reserved.
//

import Material

struct Style {
    struct color {
        static let green = UIColor(red: 171/255, green: 255/255, blue: 79/255, alpha: 1)
        static let grey_dark = UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1)
        static let grey_medium = UIColor(red: 65/255, green: 65/255, blue: 65/255, alpha: 1)
        static let grey_light = UIColor(red: 117/255, green: 117/255, blue: 117/255, alpha: 1)
        static let black = UIColor.black
        static let white = UIColor.white
    }
    
    struct font {
        static let font_mega: CGFloat = 85
        static let font_big: CGFloat = 55
        static let font_extra_large: CGFloat = 35
        static let font_large: CGFloat = 25
        static let font_medium: CGFloat = 18
        static let font_small: CGFloat = 14
        static let font_extra_small: CGFloat = 12
        
        static let xxs: CGFloat = 10.0
        static let xs: CGFloat = 12.0
        static let s: CGFloat = 14.0
        static let m: CGFloat = 16.0
        static let l: CGFloat = 18.0
        static let xl: CGFloat = 20.0
        static let xxl: CGFloat = 42.0
    }
    
    struct padding {
        static let xxs: CGFloat = 4.0
        static let xs: CGFloat = 8.0
        static let s: CGFloat = 12.0
        static let m: CGFloat = 16.0
        static let l: CGFloat = 20.0
        static let xl: CGFloat = 24.0
        static let xxl: CGFloat = 28.0
        static let special: CGFloat = 6.0
    }
    
    struct icon {
        static let medium: CGFloat = 20.0
    }
    
    struct image {
        static let s: CGFloat = 28.0
        static let m: CGFloat = 40.0
        static let l: CGFloat = 48.0
        static let xl: CGFloat = 88.0
    }
    
    static let image_small: CGFloat = 90.0
    static let image_medium: CGFloat = 100.0
    
    static let divider: CGFloat = 0.5
    static let radius: CGFloat = 2.0
    
    
    static let left: NSMutableParagraphStyle = {
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .left
        return paragraph
    }()
    
    static let center: NSMutableParagraphStyle = {
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        return paragraph
    }()
    
    static let right: NSMutableParagraphStyle = {
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .right
        return paragraph
    }()
    
    // Design Made This
    static let rhino_large_white = [NSForegroundColorAttributeName: Style.color.white, NSFontAttributeName: ProjectRFont.RhinoRocks(with: Style.font.font_large), NSParagraphStyleAttributeName: left]
    static let avenirl_medium_grey_light = [NSForegroundColorAttributeName: Style.color.grey_light, NSFontAttributeName: ProjectRFont.AvenirLightOblique(with: Style.font.font_medium), NSParagraphStyleAttributeName: left]
    static let avenirh_small_grey_light = [NSForegroundColorAttributeName: Style.color.grey_light, NSFontAttributeName: ProjectRFont.AvenirHeavy(with: Style.font.font_small), NSParagraphStyleAttributeName: left]
    static let avenir_medium_white = [NSForegroundColorAttributeName: Style.color.white, NSFontAttributeName: ProjectRFont.AvenirLightOblique(with: Style.font.font_medium), NSParagraphStyleAttributeName: left]
    static let avenirh_small_grey_dark_center = [NSForegroundColorAttributeName: Style.color.grey_dark, NSFontAttributeName: ProjectRFont.AvenirHeavy(with: Style.font.font_small), NSParagraphStyleAttributeName: center]
    static let avenirh_extra_large_grey_dark_center = [NSForegroundColorAttributeName: Style.color.grey_dark, NSFontAttributeName: ProjectRFont.AvenirHeavy(with: Style.font.font_extra_large), NSParagraphStyleAttributeName: center]
    static let avenirh_extra_large_white = [NSForegroundColorAttributeName: Style.color.white, NSFontAttributeName: ProjectRFont.AvenirHeavy(with: Style.font.font_extra_large), NSParagraphStyleAttributeName: left]
    static let avenirl_small_white = [NSForegroundColorAttributeName: Style.color.white, NSFontAttributeName: ProjectRFont.AvenirLightOblique(with: Style.font.font_small), NSParagraphStyleAttributeName: left]
    static let avenirh_medium_white = [NSForegroundColorAttributeName: Style.color.white, NSFontAttributeName: ProjectRFont.AvenirHeavy(with: Style.font.font_medium), NSParagraphStyleAttributeName: left]
    static let avenirl_extra_small_white = [NSForegroundColorAttributeName: Style.color.white, NSFontAttributeName: ProjectRFont.AvenirLightOblique(with: Style.font.font_extra_small), NSParagraphStyleAttributeName: left]
    static let avenirh_small_white = [NSForegroundColorAttributeName:Style.color.white, NSFontAttributeName: ProjectRFont.AvenirHeavy(with: Style.font.font_small), NSParagraphStyleAttributeName: left]
    static let avenirl_small_white_center = [NSForegroundColorAttributeName:Style.color.white, NSFontAttributeName: ProjectRFont.AvenirLightOblique(with: Style.font.font_small), NSParagraphStyleAttributeName: center]
    static let rhino_big_green_center = [NSForegroundColorAttributeName:Style.color.green, NSFontAttributeName: ProjectRFont.RhinoRocks(with: Style.font.font_big), NSParagraphStyleAttributeName: center]
    static let avenirh_small_grey_dark = [NSForegroundColorAttributeName:Style.color.grey_dark, NSFontAttributeName: ProjectRFont.AvenirHeavy(with: Style.font.font_small), NSParagraphStyleAttributeName: left]
    static let rhino_big_green = [NSForegroundColorAttributeName:Style.color.green, NSFontAttributeName: ProjectRFont.RhinoRocks(with: Style.font.font_big), NSParagraphStyleAttributeName: left]
    static let rhino_large_green = [NSForegroundColorAttributeName:Style.color.green, NSFontAttributeName: ProjectRFont.RhinoRocks(with: Style.font.font_large), NSParagraphStyleAttributeName: left]
    static let avenirh_large_white = [NSForegroundColorAttributeName:Style.color.white, NSFontAttributeName: ProjectRFont.AvenirHeavy(with: Style.font.font_large), NSParagraphStyleAttributeName: left]
    static let rhino_large_green_center = [NSForegroundColorAttributeName:Style.color.green, NSFontAttributeName: ProjectRFont.RhinoRocks(with: Style.font.font_large), NSParagraphStyleAttributeName: center]
    static let avenirh_extra_large_white_right = [NSForegroundColorAttributeName:Style.color.white, NSFontAttributeName: ProjectRFont.AvenirHeavy(with: Style.font.font_extra_large), NSParagraphStyleAttributeName: right]
    static let avenirh_extra_large_grey_dark_right = [NSForegroundColorAttributeName:Style.color.grey_dark, NSFontAttributeName: ProjectRFont.AvenirHeavy(with: Style.font.font_extra_large), NSParagraphStyleAttributeName: right]
    static let avenirh_large_grey_dark = [NSForegroundColorAttributeName:Style.color.grey_dark, NSFontAttributeName: ProjectRFont.AvenirHeavy(with: Style.font.font_large), NSParagraphStyleAttributeName: left]
    static let rhino_large_white_center = [NSForegroundColorAttributeName:Style.color.white, NSFontAttributeName: ProjectRFont.RhinoRocks(with: Style.font.font_large), NSParagraphStyleAttributeName: center]
    
    
    static let heading_2a = [NSForegroundColorAttributeName: Color.blueGrey.darken4, NSFontAttributeName: RobotoFont.light(with: Style.font.m), NSParagraphStyleAttributeName: left]
    static let heading_2b = [NSForegroundColorAttributeName: Color.blueGrey.darken4, NSFontAttributeName: RobotoFont.regular(with: Style.font.m), NSParagraphStyleAttributeName: left]
    static let heading_2b_center = [NSForegroundColorAttributeName: Color.blueGrey.darken4, NSFontAttributeName: RobotoFont.regular(with: Style.font.m), NSParagraphStyleAttributeName: center]
    static let heading_2a_white = [NSForegroundColorAttributeName: Color.white, NSFontAttributeName: RobotoFont.light(with: Style.font.m), NSParagraphStyleAttributeName: left]
    static let heading_2b_white = [NSForegroundColorAttributeName: Color.white, NSFontAttributeName: RobotoFont.regular(with: Style.font.m), NSParagraphStyleAttributeName: left]
    static let heading3 = [NSForegroundColorAttributeName: Color.blueGrey.darken4, NSFontAttributeName: RobotoFont.light(with: Style.font.xs), NSParagraphStyleAttributeName: left]
    static let heading3_center = [NSForegroundColorAttributeName: Color.blueGrey.darken4, NSFontAttributeName: RobotoFont.light(with: Style.font.xs), NSParagraphStyleAttributeName: center]
    static let heading4 = [NSForegroundColorAttributeName: Color.blueGrey.base, NSFontAttributeName: RobotoFont.regular(with: Style.font.s), NSParagraphStyleAttributeName: left]
    static let heading5 = [NSForegroundColorAttributeName: Color.blueGrey.lighten2, NSFontAttributeName: RobotoFont.light(with: Style.font.s), NSParagraphStyleAttributeName: left]
    static let heading5_center = [NSForegroundColorAttributeName: Color.blueGrey.lighten2, NSFontAttributeName: RobotoFont.light(with: Style.font.s), NSParagraphStyleAttributeName: center]
    static let blank_screen_heading = [NSForegroundColorAttributeName: Color.grey.lighten1, NSFontAttributeName: RobotoFont.regular(with: Style.font.m), NSParagraphStyleAttributeName: left]
    static let body = [NSForegroundColorAttributeName: Color.blueGrey.base, NSFontAttributeName: RobotoFont.light(with: Style.font.s), NSParagraphStyleAttributeName: left]
    static let body_center = [NSForegroundColorAttributeName: Color.blueGrey.base, NSFontAttributeName: RobotoFont.light(with: Style.font.s), NSParagraphStyleAttributeName: center]
    static let body_white = [NSForegroundColorAttributeName: Color.white, NSFontAttributeName: RobotoFont.light(with: Style.font.s), NSParagraphStyleAttributeName: left]
    static let body_white_center = [NSForegroundColorAttributeName: Color.white, NSFontAttributeName: RobotoFont.light(with: Style.font.s), NSParagraphStyleAttributeName: center]
    static let blank_screen_body = [NSForegroundColorAttributeName: Color.grey.lighten1, NSFontAttributeName: RobotoFont.light(with: Style.font.s), NSParagraphStyleAttributeName: left]
    static let body_highlight_1 = [NSForegroundColorAttributeName: Color.blueGrey.base, NSFontAttributeName: RobotoFont.regular(with: Style.font.s), NSParagraphStyleAttributeName: left]
    static let body_highlight_2 = [NSForegroundColorAttributeName: Color.orange.accent4, NSFontAttributeName: RobotoFont.light(with: Style.font.s), NSParagraphStyleAttributeName: left]
    static let body_highlight_3 = [NSForegroundColorAttributeName: Color.blueGrey.darken4, NSFontAttributeName: RobotoFont.light(with: Style.font.s), NSParagraphStyleAttributeName: left]
    static let body_highlight_4 = [NSForegroundColorAttributeName: Color.white, NSFontAttributeName: RobotoFont.regular(with: Style.font.s), NSParagraphStyleAttributeName: left]
    static let body_highlight_5 = [NSForegroundColorAttributeName: Color.blueGrey.darken4, NSFontAttributeName: RobotoFont.regular(with: Style.font.s), NSParagraphStyleAttributeName: left]
    static let button_1 = [NSForegroundColorAttributeName: Color.blueGrey.lighten2, NSFontAttributeName: RobotoFont.light(with: Style.font.s), NSParagraphStyleAttributeName: left]
    static let button_1_center = [NSForegroundColorAttributeName: Color.blueGrey.lighten2, NSFontAttributeName: RobotoFont.light(with: Style.font.s), NSParagraphStyleAttributeName: center]
    static let button_2 = [NSForegroundColorAttributeName: Color.blueGrey.base, NSFontAttributeName: RobotoFont.regular(with: Style.font.s), NSParagraphStyleAttributeName: left]
    static let button_3 = [NSForegroundColorAttributeName: Color.white, NSFontAttributeName: RobotoFont.light(with: Style.font.s), NSParagraphStyleAttributeName: left]
    static let button_3_center = [NSForegroundColorAttributeName: Color.white, NSFontAttributeName: RobotoFont.light(with: Style.font.s), NSParagraphStyleAttributeName: center]
    static let blank_screen_button = [NSForegroundColorAttributeName: Color.orange.accent4, NSFontAttributeName: RobotoFont.regular(with: Style.font.s), NSParagraphStyleAttributeName: left]
    static let subtext_1 = [NSForegroundColorAttributeName: Color.blueGrey.lighten3, NSFontAttributeName: RobotoFont.light(with: Style.font.xs), NSParagraphStyleAttributeName: left]
    static let subtext_1_center = [NSForegroundColorAttributeName: Color.blueGrey.lighten3, NSFontAttributeName: RobotoFont.light(with: Style.font.xs), NSParagraphStyleAttributeName: center]
    static let subtext_2 = [NSForegroundColorAttributeName: Color.blueGrey.base, NSFontAttributeName: RobotoFont.light(with: Style.font.xs), NSParagraphStyleAttributeName: left]
    static let subtext_2_center = [NSForegroundColorAttributeName: Color.blueGrey.base, NSFontAttributeName: RobotoFont.light(with: Style.font.xs), NSParagraphStyleAttributeName: center]
    static let subtext_3 = [NSForegroundColorAttributeName: Color.orange.accent4, NSFontAttributeName: RobotoFont.light(with: Style.font.xs), NSParagraphStyleAttributeName: left]
    static let subtext_3_center = [NSForegroundColorAttributeName: Color.orange.accent4, NSFontAttributeName: RobotoFont.light(with: Style.font.xs), NSParagraphStyleAttributeName: center]
    static let subtext_4 = [NSForegroundColorAttributeName: Color.orange.accent4, NSFontAttributeName: RobotoFont.regular(with: Style.font.xs), NSParagraphStyleAttributeName: left]
    static let subtext_4_center = [NSForegroundColorAttributeName: Color.orange.accent4, NSFontAttributeName: RobotoFont.regular(with: Style.font.xs), NSParagraphStyleAttributeName: center]
    static let subtext_5 = [NSForegroundColorAttributeName: Color.amber.accent4, NSFontAttributeName: RobotoFont.light(with: Style.font.xs), NSParagraphStyleAttributeName: left]
    static let subtext_5_center = [NSForegroundColorAttributeName: Color.amber.accent4, NSFontAttributeName: RobotoFont.light(with: Style.font.xs), NSParagraphStyleAttributeName: center]
    static let subtext_6 = [NSForegroundColorAttributeName: Color.blueGrey.lighten2, NSFontAttributeName: RobotoFont.light(with: Style.font.xs), NSParagraphStyleAttributeName: left]
    static let subtext_6_center = [NSForegroundColorAttributeName: Color.blueGrey.lighten2, NSFontAttributeName: RobotoFont.light(with: Style.font.xs), NSParagraphStyleAttributeName: center]
    static let subtext_7 = [NSForegroundColorAttributeName: Color.white, NSFontAttributeName: RobotoFont.light(with: Style.font.xxs), NSParagraphStyleAttributeName: left]
    static let subtext_7_center = [NSForegroundColorAttributeName: Color.white, NSFontAttributeName: RobotoFont.light(with: Style.font.xxs), NSParagraphStyleAttributeName: center]
    static let subtext_7_link = [NSForegroundColorAttributeName: Color.blueGrey.lighten3, NSFontAttributeName: RobotoFont.light(with: Style.font.xxs), NSParagraphStyleAttributeName: left]
    static let subtext_highlight_1 = [NSForegroundColorAttributeName: Color.blueGrey.base, NSFontAttributeName: RobotoFont.regular(with: Style.font.xs), NSParagraphStyleAttributeName: left]
    static let subtext_highlight_1_center = [NSForegroundColorAttributeName: Color.blueGrey.base, NSFontAttributeName: RobotoFont.regular(with: Style.font.xs), NSParagraphStyleAttributeName: center]
    static let timestamps = [NSForegroundColorAttributeName: Color.grey.lighten1, NSFontAttributeName: RobotoFont.light(with: Style.font.xs), NSParagraphStyleAttributeName: left]
    static let chat_receipt_heading = [NSForegroundColorAttributeName: Color.blueGrey.darken2, NSFontAttributeName: RobotoFont.light(with: Style.font.s), NSParagraphStyleAttributeName: left]
    static let chat_receipt_body = [NSForegroundColorAttributeName: Color.blueGrey.darken2, NSFontAttributeName: RobotoFont.light(with: Style.font.xs), NSParagraphStyleAttributeName: left]
    static let subtext_white = [NSForegroundColorAttributeName: Color.white, NSFontAttributeName: RobotoFont.light(with: Style.font.xs), NSParagraphStyleAttributeName: left]
    static let subtext_8 = [NSForegroundColorAttributeName: Color.blueGrey.darken4, NSFontAttributeName: RobotoFont.light(with: Style.font.xxs), NSParagraphStyleAttributeName: left]
    static let subtext_error = [NSForegroundColorAttributeName: Color.red.darken3, NSFontAttributeName: RobotoFont.light(with: Style.font.xs), NSParagraphStyleAttributeName: left]
    static let heading_2c = [NSForegroundColorAttributeName: Color.blueGrey.base, NSFontAttributeName: RobotoFont.light(with: Style.font.m), NSParagraphStyleAttributeName: left]
    static let timestamps_small = [NSForegroundColorAttributeName: Color.grey.lighten1, NSFontAttributeName: RobotoFont.light(with: Style.font.xxs), NSParagraphStyleAttributeName: left]
    static let subtext_scaling_1 = [NSForegroundColorAttributeName: Color.white, NSFontAttributeName: RobotoFont.regular(with: Style.font.xs), NSParagraphStyleAttributeName: left]
    static let subtext_scaling_2 = [NSForegroundColorAttributeName: Color.blueGrey.darken2, NSFontAttributeName: RobotoFont.regular(with: Style.font.xs), NSParagraphStyleAttributeName: left]
    static let subtext_white_regular = [NSForegroundColorAttributeName: Color.white, NSFontAttributeName: RobotoFont.regular(with: Style.font.xs), NSParagraphStyleAttributeName: left]
    static let subtext_white_regular_center = [NSForegroundColorAttributeName: Color.white, NSFontAttributeName: RobotoFont.regular(with: Style.font.xs), NSParagraphStyleAttributeName: center]
    static let heading_2a_orange = [NSForegroundColorAttributeName: Color.orange.accent4, NSFontAttributeName: RobotoFont.light(with: Style.font.m), NSParagraphStyleAttributeName: left]
    static let heading_2a_orange_center = [NSForegroundColorAttributeName: Color.orange.accent4, NSFontAttributeName: RobotoFont.light(with: Style.font.m), NSParagraphStyleAttributeName: center]
    static let extra_large_blue_grey = [NSForegroundColorAttributeName: Color.blueGrey.base, NSFontAttributeName: RobotoFont.medium(with: Style.font.xl), NSParagraphStyleAttributeName: left]
    static let extra_large_blue_grey_center = [NSForegroundColorAttributeName: Color.blueGrey.base, NSFontAttributeName: RobotoFont.medium(with: Style.font.xl), NSParagraphStyleAttributeName: center]
    static let extra_large_orange = [NSForegroundColorAttributeName: Color.orange.accent4, NSFontAttributeName: RobotoFont.medium(with: Style.font.xl), NSParagraphStyleAttributeName: left]
    static let extra_large_orange_center = [NSForegroundColorAttributeName: Color.orange.accent4, NSFontAttributeName: RobotoFont.medium(with: Style.font.xl), NSParagraphStyleAttributeName: center]
    static let bottom_button_hight: CGFloat = 44
    
    static let button_height: CGFloat = 40
    static let button_width: CGFloat = 116
    static let input_width: CGFloat = Screen.width - 120
    static let input_center: CGFloat = (Screen.width - input_width)/2
}

class ProjectRTextField: ErrorTextField {
    private let imgViewDivider = UIImageView(image: UIImage(named: "textfield_line")?.withRenderingMode(.alwaysTemplate))
    override var isErrorRevealed: Bool {
        didSet {
            detailLabel.isHidden = !isErrorRevealed
            imgViewDivider.tintColor = isErrorRevealed ? Color.red.base : Style.color.green
            layoutSubviews()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        textColor = Style.color.white
        
        font = ProjectRFont.AvenirLightOblique(with: Style.font.font_medium)
        placeholderLabel.font =  ProjectRFont.AvenirLightOblique(with: Style.font.font_medium)
        
        placeholderNormalColor = Style.color.grey_light
        placeholderActiveColor = Style.color.white
        
        
        placeholderVerticalOffset = Style.padding.xs // ???
        
        dividerColor = Material.Color.clear
        dividerActiveColor = Material.Color.clear
        
        detailLabel.font = RobotoFont.light(with: Style.font.xs)
        detailLabel.textColor = Color.red.base
        detailLabel.textAlignment = .right
        detailVerticalOffset = 8
        
        imgViewDivider.contentMode = .scaleAspectFit
        imgViewDivider.clipsToBounds = true
        
        addSubview(imgViewDivider)
        
        imgViewDivider.autoPinEdge(toSuperviewEdge: .left)
        imgViewDivider.autoPinEdge(toSuperviewEdge: .right)
        imgViewDivider.autoPinEdge(toSuperviewEdge: .bottom, withInset: -20)
    }
    
    convenience init(placeholder: String, frame: CGRect = CGRect.zero) {
        self.init(frame: frame)
        self.placeholder = placeholder
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /* Set this to highlight invalid text fields */
    internal var isValid: Bool = true {
        didSet {
            if isValid {
                dividerColor = Color.blueGrey.base
                dividerActiveColor = Color.orange.accent4
                
            } else {
                dividerColor = Color.red.darken4
                dividerActiveColor = Color.red.darken4
            }
        }
    }
}

class ProjectRButton: Button {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = Style.color.grey_dark
        titleColor = Style.color.grey_light
        titleLabel?.textColor = Style.color.grey_light
        titleLabel?.font = ProjectRFont.AvenirHeavy(with: Style.font.font_small)
        pulseColor = Style.color.grey_dark
        
        let imgView = UIImageView(image: UIImage(named: "button_block_1"))
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        
        addSubview(imgView)
        sendSubview(toBack: imgView)
        imgView.autoPinEdgesToSuperviewEdges()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ProjectRNext: Button {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Style.color.grey_dark
        titleLabel?.textColor = Style.color.grey_light
        titleLabel?.font = ProjectRFont.AvenirHeavy(with: Style.font.font_small)
        pulseColor = Color.clear
        
        let imgView = UIImageView(image: UIImage(named: "arrow_right"))
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        
        addSubview(imgView)
        sendSubview(toBack: imgView)
        imgView.autoPinEdgesToSuperviewEdges()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

