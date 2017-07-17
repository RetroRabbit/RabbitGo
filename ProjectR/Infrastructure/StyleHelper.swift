//
//  StyleHelper.swift
//  ProjectR
//
//  Created by Niell Agenbag on 2017/07/12.
//  Copyright © 2017 Retro Rabbit Professional Services. All rights reserved.
//

import Material

struct Style {
    struct font {
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
        static let xxs: CGFloat = 8.0
        static let xs: CGFloat = 12.0
        static let s: CGFloat = 16.0
        static let m: CGFloat = 20.0
        static let l: CGFloat = 24.0
        static let xl: CGFloat = 32.0
        static let xxl: CGFloat = 60.0
        static let mega: CGFloat = 100.0
    }
    
    struct image {
        static let s: CGFloat = 28.0
        static let m: CGFloat = 40.0
        static let l: CGFloat = 48.0
        static let xl: CGFloat = 88.0
    }
    
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
}
