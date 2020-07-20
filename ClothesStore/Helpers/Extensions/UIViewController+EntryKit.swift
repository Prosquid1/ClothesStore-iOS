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
    func showTopErrorNote(message: String) {

        var notes: [PresetDescription] = []
        var attributes: EKAttributes
        var description: PresetDescription
        var descriptionString: String
        var descriptionThumb: String

        attributes = .topNote
        attributes.hapticFeedbackType = .success
        attributes.popBehavior = .animated(animation: .translation)
        attributes.entryBackground = .color(color: EKColor(.red))
        descriptionString = "Overrides the status bar"
        descriptionThumb = ThumbDesc.statusBarNote.rawValue
        description = .init(with: attributes, title: "Status Bar Note", description: descriptionString, thumb: descriptionThumb)
        notes.append(description)

        let style = EKProperty.LabelStyle(font: UIFont.systemFont(ofSize: 14.0, weight: .regular), color: .white, alignment: .center)
        let labelContent = EKProperty.LabelContent(text: message, style: style)

        let contentView = EKNoteMessageView(with: labelContent)

        SwiftEntryKit.display(entry: contentView, using: attributes)
    }

    func showCenterPopup(title: String, message: String, completion: (() -> Void)?) {

        var attributes: EKAttributes
        // Preset II
        attributes = EKAttributes.centerFloat
        attributes.hapticFeedbackType = .success
        attributes.displayDuration = .infinity
        attributes.entryBackground = .gradient(gradient: .init(colors: [.white, EKColor(ColorPalette.accent)], startPoint: .zero, endPoint: CGPoint(x: 1, y: 1)))
        attributes.screenBackground = .color(color: EKColor(ColorPalette.accent))
        attributes.shadow = .active(with: .init(color: .black, opacity: 0.3, radius: 8))
        attributes.screenInteraction = .dismiss
        attributes.entryInteraction = .absorbTouches
        attributes.scroll = .enabled(swipeable: true, pullbackAnimation: .jolt)
        attributes.roundCorners = .all(radius: 8)
        attributes.entranceAnimation = .init(translate: .init(duration: 0.7, spring: .init(damping: 0.7, initialVelocity: 0)),
                                             scale: .init(from: 0.7, to: 1, duration: 0.4, spring: .init(damping: 1, initialVelocity: 0)))
        attributes.exitAnimation = .init(translate: .init(duration: 0.2))
        attributes.popBehavior = .animated(animation: .init(translate: .init(duration: 0.35)))
        attributes.positionConstraints.size = .init(width: .offset(value: 20), height: .intrinsic)
        attributes.positionConstraints.maxSize = .init(width: .constant(value: UIScreen.main.bounds.minEdge), height: .intrinsic)
        attributes.statusBar = .dark

        attributes.lifecycleEvents.didDisappear = {
            completion?()
        }

        let image = UIImage(named: "AppIcon")!
        showPopupMessage(attributes: attributes, title: title, titleColor: .white, description: message, descriptionColor: .white, buttonTitleColor: EKColor(ColorPalette.accent), buttonBackgroundColor: .white, image: image, completion: completion)
    }

    func showPopupMessage(attributes: EKAttributes, title: String, titleColor: EKColor, description: String, descriptionColor: EKColor, buttonTitleColor: EKColor, buttonBackgroundColor: EKColor, image: UIImage? = nil, completion: (() -> Void)?) {

        var themeImage: EKPopUpMessage.ThemeImage?

        if let image = image {
            themeImage = .init(image: .init(image: image, size: CGSize(width: 60, height: 60), contentMode: .scaleAspectFit))
        }

        let title = EKProperty.LabelContent(text: title, style: .init(font: UIFont.systemFont(ofSize: 24.0, weight: .regular), color: titleColor, alignment: .center))
        let description = EKProperty.LabelContent(text: description, style: .init(font: UIFont.systemFont(ofSize: 16.0, weight: .regular), color: descriptionColor, alignment: .center))
        let button = EKProperty.ButtonContent(label: .init(text: "Done", style: .init(font: UIFont.systemFont(ofSize: 16.0, weight: .bold), color: buttonTitleColor)), backgroundColor: buttonBackgroundColor, highlightedBackgroundColor: buttonTitleColor)
        let message = EKPopUpMessage(themeImage: themeImage, title: title, description: description, button: button) {
            SwiftEntryKit.dismiss()
        }

        let contentView = EKPopUpMessageView(with: message)
        SwiftEntryKit.display(entry: contentView, using: attributes)
    }

    func showMultiOptionMessage(title: String,
                                message: String,
                                positiveButtonTitle: String,
                                negativeButtonTitle: String,
                                onPositiveDismiss: @escaping () -> ()?,
                                onNegativeDismiss: @escaping () -> ()?) {
        var attributes = EKAttributes.topFloat
        attributes.displayDuration = .infinity

        attributes.hapticFeedbackType = .success
        attributes.entryBackground = .color(color: .white)
        attributes.popBehavior = .animated(animation: .init(translate: .init(duration: 0.3), scale: .init(from: 1, to: 0.7, duration: 0.7)))
        attributes.shadow = .active(with: .init(color: .black, opacity: 0.5, radius: 10))
        attributes.statusBar = .dark
        attributes.scroll = .enabled(swipeable: true, pullbackAnimation: .easeOut)
        attributes.positionConstraints.maxSize = .init(width: .constant(value: UIScreen.main.bounds.minEdge), height: .intrinsic)
        attributes.entryInteraction = .absorbTouches

        // Generate textual content
        let title = EKProperty.LabelContent(text: title, style: .init(font: UIFont.systemFont(ofSize: 15.0, weight: .regular), color: .black))
        let description = EKProperty.LabelContent(text: message, style: .init(font: UIFont.systemFont(ofSize: 13.0, weight: .regular), color: .black))
        let image = EKProperty.ImageContent(imageName: "purple_circle_switch", size: CGSize(width: 35, height: 35), contentMode: .scaleAspectFit)
        let simpleMessage = EKSimpleMessage(image: image, title: title, description: description)

        // Generate buttons content
        let buttonFont = UIFont.systemFont(ofSize: 13.0, weight: .regular)

        // Close button - Just dismiss entry when the button is tapped
        let closeButtonLabelStyle = EKProperty.LabelStyle(font: buttonFont, color: EKColor(ColorPalette.moneyBlue))
        let closeButtonLabel = EKProperty.LabelContent(text: negativeButtonTitle, style: closeButtonLabelStyle)
        let closeButton = EKProperty.ButtonContent(label: closeButtonLabel, backgroundColor: .clear, highlightedBackgroundColor:  EKColor(ColorPalette.accent.withAlphaComponent(0.05)), action: {
            SwiftEntryKit.dismiss()
            onNegativeDismiss()
        })

        // Ok Button - Make transition to a new entry when the button is tapped
        let okButtonLabelStyle = EKProperty.LabelStyle(font: buttonFont, color: EKColor(ColorPalette.primaryDark))
        let okButtonLabel = EKProperty.LabelContent(text: positiveButtonTitle, style: okButtonLabelStyle)
        let okButton = EKProperty.ButtonContent(label: okButtonLabel, backgroundColor: .clear, highlightedBackgroundColor:  EKColor(ColorPalette.dimGray.withAlphaComponent(0.05)), action: {
            SwiftEntryKit.dismiss()
            onPositiveDismiss()
        } )

        let buttonsBarContent = EKProperty.ButtonBarContent(with: closeButton, okButton, separatorColor: EKColor(ColorPalette.lightColor), buttonHeight: 60, expandAnimatedly: true)

        // Generate the content
        let alertMessage = EKAlertMessage(simpleMessage: simpleMessage, imagePosition: .left, buttonBarContent: buttonsBarContent)

        let contentView = EKAlertMessageView(with: alertMessage)

        SwiftEntryKit.display(entry: contentView, using: attributes)
    }

}
