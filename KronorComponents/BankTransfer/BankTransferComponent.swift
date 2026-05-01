//
//  BankTransferComponent.swift
//
//
//  Created by lorenzo on 2024-04-16.
//

import SwiftUI
import Kronor

/// A payment component that handles bank transfer payments.
public struct BankTransferComponent: View {
    @StateObject private var viewModel: TrustlyPaymentViewModel

    /// Creates a new bank transfer payment component.
    /// - Parameters:
    ///   - configuration: The shared component configuration.
    ///   - paymentResultHandler: A closure called with the payment result.
    public init(
        configuration: ComponentConfiguration,
        paymentResultHandler: @escaping PaymentResultHandler
    ) {
        _viewModel = StateObject(
            wrappedValue: TrustlyPaymentViewModel(
                stateMachine: EmbeddedPaymentStatechart.makeStateMachine(),
                networking: KronorTrustlyPaymentNetworking(configuration: configuration),
                returnURL: configuration.returnURL,
                paymentResultHandler: paymentResultHandler
            )
        )
    }

    public var body: some View {
        TrustlyPaymentView(viewModel: self.viewModel)
            .task {
                await viewModel.transition(.initialize)
            }
    }
}

struct BankTransferComponent_Previews: PreviewProvider {
    static var previews: some View {
        BankTransferComponent(
            configuration: Preview.configuration,
            paymentResultHandler: Preview.paymentResultHandler
        )
    }
}
