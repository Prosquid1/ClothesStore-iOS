//
//  EntryKitHelper.swift
//  ClothesStore
//
//  Created by Oyeleke Okiki on 7/12/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import SwiftEntryKit

private enum ThumbDesc: String {
    case bottomToast = "ic_bottom_toast"
    case bottomFloat = "ic_bottom_float"
    case topToast = "ic_top_toast"
    case topFloat = "ic_top_float"
    case statusBarNote = "ic_sb_note"
    case topNote = "ic_top_note"
    case bottomPopup = "ic_bottom_popup"
}


// Description of a single preset to be presented
struct PresetDescription {
    let title: String
    let description: String
    let thumb: String
    let attributes: EKAttributes

    init(with attributes: EKAttributes, title: String, description: String = "", thumb: String) {
        self.attributes = attributes
        self.title = title
        self.description = description
        self.thumb = thumb
    }
}


extension UIViewController {
    // Bumps a standard note

    func showTopSuccessNote(_ message: String) {
        showTopMessageNote(message: message, messageEKColor:  EKColor(ColorPalette.topNoteSuccessGreen))
    }

    func showTopErrorNote(_ message: String) {
        showTopMessageNote(message: message, messageEKColor:  EKColor(.red))
    }

    func showTopMessageNote(message: String, messageEKColor: EKColor) {

        var notes: [PresetDescription] = []
        var attributes: EKAttributes
        var description: PresetDescription
        var descriptionString: String
        var descriptionThumb: String

        attributes = .topNote
        attributes.hapticFeedbackType = .success
        attributes.popBehavior = .animated(animation: .translation)
        attributes.entryBackground = .color(color: messageEKColor)
        descriptionString = "Overrides the status bar"
        descriptionThumb = ThumbDesc.statusBarNote.rawValue
        description = .init(with: attributes, title: "Status Bar Note", description: descriptionString, thumb: descriptionThumb)
        notes.append(description)

        let style = EKProperty.LabelStyle(font: UIFont.systemFont(ofSize: 14.0, weight: .regular), color: .white, alignment: .center)
        let labelContent = EKProperty.LabelContent(text: message, style: style)

        let contentView = EKNoteMessageView(with: labelContent)

        SwiftEntryKit.display(entry: contentView, using: attributes)
    }
}
