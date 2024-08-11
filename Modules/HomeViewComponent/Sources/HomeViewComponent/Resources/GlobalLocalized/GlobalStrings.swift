// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum GlobalStrings {
  /// Habilidades
  public static let abilities = GlobalStrings.tr("Localizable", "abilities", fallback: "Habilidades")
  /// Base
  public static let base = GlobalStrings.tr("Localizable", "base", fallback: "Base")
  /// Detalle
  public static let detail = GlobalStrings.tr("Localizable", "detail", fallback: "Detalle")
  /// Esfuerzo
  public static let effort = GlobalStrings.tr("Localizable", "effort", fallback: "Esfuerzo")
  /// Aquí no hay nada 🥺
  public static let emptyMessage = GlobalStrings.tr("Localizable", "empty_message", fallback: "Aquí no hay nada 🥺")
  /// Altura
  public static let height = GlobalStrings.tr("Localizable", "height", fallback: "Altura")
  /// Localizable.strings
  ///   Created by Javier Duvan Hospital Melo on 10/08/24.
  public static let home = GlobalStrings.tr("Localizable", "home", fallback: "Inicio")
  /// Estadísticas
  public static let statics = GlobalStrings.tr("Localizable", "statics", fallback: "Estadísticas")
  /// Peso
  public static let weight = GlobalStrings.tr("Localizable", "weight", fallback: "Peso")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension GlobalStrings {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
