// UIKitProducers
// Written in 2016 by Nate Stedman <nate@natestedman.com>
//
// To the extent possible under law, the author(s) have dedicated all copyright and
// related and neighboring rights to this software to the public domain worldwide.
// This software is distributed without any warranty.
//
// You should have received a copy of the CC0 Public Domain Dedication along with
// this software. If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

import Foundation
import ReactiveCocoa
import enum Result.NoError

// MARK: - Object
extension NSObject
{
    // MARK: - Deallocation

    /// A signal producer that will complete when the receiver is deallocated.
    public var willDeallocProducer: SignalProducer<(), NoError>
    {
        return rac_willDeallocSignal().toSignalProducer().demoteErrors().constrainToType(Void)
    }

    // MARK: - Selectors

    /// A producer wrapping `rac_signalForSelector(_:)`.
    ///
    /// - parameter selector: The selector.
    public func producer(for selector: Selector) -> SignalProducer<[AnyObject], NoError>
    {
        return rac_signalForSelector(selector)
            .toSignalProducer()
            .demoteErrors()
            .constrainToType(RACTuple)
            .map({ $0.allObjects() })
    }

    // MARK: - Key Paths

    /// A producer wrapping `rac_valuesForKeyPath(_:keyPath:)`.
    ///
    /// - parameter keyPath: The key path.
    public func producer(for keyPath: String) -> SignalProducer<AnyObject?, NoError>
    {
        return rac_valuesForKeyPath(keyPath, observer: self).toSignalProducer().demoteErrors()
    }
}
