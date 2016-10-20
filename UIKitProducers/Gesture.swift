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

// MARK: - gestureProducer
public protocol GestureSignalProvidingType
{
    func rac_gestureSignal() -> RACSignal!
}

extension UIGestureRecognizer: GestureSignalProvidingType {}

extension GestureSignalProvidingType
{
    /// Returns a signal producer that sends the receiver when its gesture occurs.
    public var producer: SignalProducer<Self, NoError>
    {
        return rac_gestureSignal().toSignalProducer()
            .demoteErrors()
            .map { $0 as? Self }
            .ignoreNil()
    }
}
