//
//  ComponentConfiguration.swift
//  Kronor
//
//  Created by Niclas Heltoft on 09/03/2026.
//

import Foundation
import Kronor

/// Shared configuration for all payment components.
public struct ComponentConfiguration {
    /// The Kronor environment to use.
    public let env: Kronor.Environment
    /// The session token obtained from the backend via the `newPaymentSession` query.
    public let sessionToken: String
    /// The URL the payment flow will redirect back to upon completion.
    public let returnURL: URL
    /// Optional device information for device-specific payment flows.
    public let device: Kronor.Device?
    /// Whether WebSockets are used for payment status updates.
    public let isWebSocketsEnabled: Bool
    /// Whether to use `ASWebAuthenticationSession` instead of an embedded `WKWebView`
    /// for the payment flow. When `true`, the payment gateway page opens in a Safari-powered
    /// sheet that shares Safari's cookies and user-agent, bypassing Cloudflare challenges
    /// that block `WKWebView`. Defaults to `false`.
    public let prefersAuthenticationSession: Bool

    /// Creates a new component configuration.
    /// - Parameters:
    ///   - env: The Kronor environment to use.
    ///   - sessionToken: The session token obtained from the backend.
    ///   - returnURL: The URL to redirect back to after the payment flow.
    ///   - device: Optional device information. Defaults to `nil`.
    ///   - isWebSocketsEnabled: Whether WebSockets are used for payment status updates. Defaults to `true`.
    ///   - prefersAuthenticationSession: Whether to use `ASWebAuthenticationSession` instead of `WKWebView`. Defaults to `false`.
    public init(
        env: Kronor.Environment,
        sessionToken: String,
        returnURL: URL,
        device: Kronor.Device? = nil,
        isWebSocketsEnabled: Bool = true,
        prefersAuthenticationSession: Bool = false
    ) {
        self.env = env
        self.sessionToken = sessionToken
        self.returnURL = returnURL
        self.device = device
        self.isWebSocketsEnabled = isWebSocketsEnabled
        self.prefersAuthenticationSession = prefersAuthenticationSession
    }
}
