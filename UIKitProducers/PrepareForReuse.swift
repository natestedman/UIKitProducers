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

// MARK: - prepareForReuse
public protocol PrepareForReuseSignalProvidingType
{
    var rac_prepareForReuseSignal: RACSignal! { get }
}

extension UICollectionReusableView: PrepareForReuseSignalProvidingType {}
extension UITableViewCell: PrepareForReuseSignalProvidingType {}
extension UITableViewHeaderFooterView: PrepareForReuseSignalProvidingType {}

extension PrepareForReuseSignalProvidingType
{
    /// A signal producer which will send `()` whenever -prepareForReuse is invoked
    /// upon the receiver.
    public var prepareForReuseProducer: SignalProducer<(), NoError>
    {
        return rac_prepareForReuseSignal.toSignalProducer()
            .demoteErrors()
            .map { _ in () }
    }
}
