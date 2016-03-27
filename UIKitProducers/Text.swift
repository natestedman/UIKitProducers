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

// MARK: - textProducer
public protocol TextSignalProvidingType
{
	func rac_textSignal() -> RACSignal!
}

extension UITextField: TextSignalProvidingType {}
extension UITextView: TextSignalProvidingType {}

extension TextSignalProvidingType
{
	/// Creates and returns a signal producer for the text of the receiver,
	/// starting with the current text.
	///
	/// For underlying behavior and potential side-effects, see the
	/// documentation for the receiver's implementation of `rac_textSignal`.
	var textProducer: SignalProducer<String?, NoError>
    {
		return rac_textSignal().toSignalProducer()
			.demoteErrors()
			.map { $0 as? String }
	}
}
