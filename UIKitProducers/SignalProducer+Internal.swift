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
import enum Result.NoError

extension SignalProducer
{
    func demoteErrors() -> SignalProducer<Value, NoError>
    {
        return flatMapError { _ in SignalProducer<Value, NoError>.empty }
    }
}

extension SignalProducer
{
    func constrainToType<T>(type: T.Type) -> SignalProducer<T, Error>
    {
        return map({ $0 as? T }).ignoreNil()
    }
}
