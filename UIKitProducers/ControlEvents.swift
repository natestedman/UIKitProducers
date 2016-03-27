// UIKitProducers
// Written in 2016 by Nate Stedman <nate@natestedman.com>
//
// To the extent possible under law, the author(s) have dedicated all copyright and
// related and neighboring rights to this software to the public domain worldwide.
// This software is distributed without any warranty.
//
// You should have received a copy of the CC0 Public Domain Dedication along with
// this software. If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

import ReactiveCocoa
import UIKit
import enum Result.NoError

// MARK: - producerForControlEvents
public protocol SignalForControlEventsProvidingType
{
    func rac_signalForControlEvents(controlEvents: UIControlEvents) -> RACSignal!
}

extension UIControl: SignalForControlEventsProvidingType {}

extension SignalForControlEventsProvidingType
{
    /// Creates a signal producer that sends the sender of the control event
    /// whenever one of the control events is triggered.
    public func producerForControlEvents(controlEvents: UIControlEvents) -> SignalProducer<Self, NoError>
    {
        return rac_signalForControlEvents(controlEvents).toSignalProducer()
            .demoteErrors()
            .map { $0 as? Self }
            .ignoreNil()
    }
}
