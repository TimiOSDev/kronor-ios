import SwiftUI
import Kronor

/// A payment component that handles Trustly payments.
public struct TrustlyComponent: View {
    @StateObject private var viewModel: TrustlyPaymentViewModel

    /// Creates a new Trustly payment component.
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

struct TrustlyComponent_Previews: PreviewProvider {
    static var previews: some View {
        TrustlyComponent(
            configuration: Preview.configuration,
            paymentResultHandler: Preview.paymentResultHandler
        )
    }
}
