//
//  PointsPayComponent.swift
//  KronorComponents
//
//  Created by Tim Kofoed on 31/03/2026.
//

import SwiftUI
import Kronor

/// A payment component that handles PointsPay (EuroBonus) payments.
///
/// Uses `ASWebAuthenticationSession` instead of an embedded `WKWebView`
/// to bypass Cloudflare challenges that block `WKWebView`.
public struct PointsPayComponent: View {
    let viewModel: EmbeddedPaymentViewModel

    /// Creates a new PointsPay payment component.
    /// - Parameters:
    ///   - configuration: The shared component configuration.
    ///   - paymentResultHandler: A closure called with the payment result.
    public init(
        configuration: ComponentConfiguration,
        paymentResultHandler: @escaping PaymentResultHandler
    ) {
        let machine = EmbeddedPaymentStatechart.makeStateMachine()
        let networking = KronorEmbeddedPaymentNetworking(configuration: configuration)
        let viewModel = EmbeddedPaymentViewModel(
            configuration: configuration,
            stateMachine: machine,
            networking: networking,
            paymentMethod: .pointsPay,
            paymentResultHandler: paymentResultHandler,
            prefersAuthenticationSession: true
        )

        self.viewModel = viewModel

        Task {
            await viewModel.initialize()
        }
    }

    public var body: some View {
        WrapperView(header: FallbackHeaderView()) {
            EmbeddedPaymentView(
                viewModel: self.viewModel,
                waitingView: FallbackWaitingView()
            )
        }
    }
}

struct PointsPayComponent_Previews: PreviewProvider {
    static var previews: some View {
        PointsPayComponent(
            configuration: Preview.configuration,
            paymentResultHandler: Preview.paymentResultHandler
        )
    }
}
