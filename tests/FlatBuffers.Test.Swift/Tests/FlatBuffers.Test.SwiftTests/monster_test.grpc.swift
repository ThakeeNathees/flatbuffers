// Generated GRPC code for FlatBuffers swift!
/// The following code is generated by the Flatbuffers library which might not be in sync with grpc-swift
/// in case of an issue please open github issue, though it would be maintained
import Foundation
import GRPC
import NIO
import NIOHTTP1
import FlatBuffers

public protocol GRPCFlatBufPayload: GRPCPayload, FlatBufferGRPCMessage {}
public extension GRPCFlatBufPayload {
    init(serializedByteBuffer: inout NIO.ByteBuffer) throws {
        self.init(byteBuffer: FlatBuffers.ByteBuffer(contiguousBytes: serializedByteBuffer.readableBytesView, count: serializedByteBuffer.readableBytes))
    }
    func serialize(into buffer: inout NIO.ByteBuffer) throws {
        let buf = UnsafeRawBufferPointer(start: self.rawPointer, count: Int(self.size))
        buffer.writeBytes(buf)
    }
}
extension Message: GRPCFlatBufPayload {}

/// Usage: instantiate MonsterStorageServiceClient, then call methods of this protocol to make API calls.
public protocol MonsterStorageService {
	 func Store(_ request: Message<Monster>, callOptions: CallOptions?) -> UnaryCall<Message<Monster>,Message<Stat>>
	 func Retrieve(_ request: Message<Stat>, callOptions: CallOptions?, handler: @escaping (Message<Monster>) -> Void) -> ServerStreamingCall<Message<Stat>, Message<Monster>>
	 func GetMaxHitPoint(callOptions: CallOptions?) -> ClientStreamingCall<Message<Monster>,Message<Stat>>
	 func GetMinMaxHitPoints(callOptions: CallOptions?, handler: @escaping (Message<Stat>) -> Void) -> BidirectionalStreamingCall<Message<Monster>, Message<Stat>>
}

public final class MonsterStorageServiceClient: GRPCClient, MonsterStorageService {
	public let channel: GRPCChannel
	public var defaultCallOptions: CallOptions

	public init(channel: GRPCChannel, defaultCallOptions: CallOptions = CallOptions()) {
		self.channel = channel
		self.defaultCallOptions = defaultCallOptions
	}

	public func Store(_ request: Message<Monster>, callOptions: CallOptions? = nil) -> UnaryCall<Message<Monster>,Message<Stat>> {
		return self.makeUnaryCall(path: "/MyGame.Example.MonsterStorage/Store", request: request, callOptions: callOptions ?? self.defaultCallOptions)
	}

	public func Retrieve(_ request: Message<Stat>, callOptions: CallOptions? = nil, handler: @escaping (Message<Monster>) -> Void) -> ServerStreamingCall<Message<Stat>, Message<Monster>> {
		return self.makeServerStreamingCall(path: "/MyGame.Example.MonsterStorage/Retrieve", request: request, callOptions: callOptions ?? self.defaultCallOptions, handler: handler)
	}

	public func GetMaxHitPoint(callOptions: CallOptions? = nil) -> ClientStreamingCall<Message<Monster>,Message<Stat>> {
		return self.makeClientStreamingCall(path: "/MyGame.Example.MonsterStorage/GetMaxHitPoint", callOptions: callOptions ?? self.defaultCallOptions)
	}

	public func GetMinMaxHitPoints(callOptions: CallOptions? = nil, handler: @escaping (Message<Stat>) -> Void) -> BidirectionalStreamingCall<Message<Monster>, Message<Stat>> {
		return self.makeBidirectionalStreamingCall(path: "/MyGame.Example.MonsterStorage/GetMinMaxHitPoints", callOptions: callOptions ?? self.defaultCallOptions, handler: handler)
	}
}

public protocol MonsterStorageProvider: CallHandlerProvider {
	func Store(_ request: Message<Monster>, context: StatusOnlyCallContext) -> EventLoopFuture<Message<Stat>>
	func Retrieve(request: Message<Stat>, context: StreamingResponseCallContext<Message<Monster>>) -> EventLoopFuture<GRPCStatus>
	func GetMaxHitPoint(context: UnaryResponseCallContext<Message<Stat>>) -> EventLoopFuture<(StreamEvent<Message<Monster>>) -> Void>
	func GetMinMaxHitPoints(context: StreamingResponseCallContext<Message<Stat>>) -> EventLoopFuture<(StreamEvent<Message<Monster>>) -> Void>
}

public extension MonsterStorageProvider {
	var serviceName: String { return "MyGame.Example.MonsterStorage" }
	func handleMethod(_ methodName: String, callHandlerContext: CallHandlerContext) -> GRPCCallHandler? {
		switch methodName {
		case "Store":
		return CallHandlerFactory.makeUnary(callHandlerContext: callHandlerContext) { context in
			return { request in
				self.Store(request, context: context)
			}
		}
		case "Retrieve":
		return CallHandlerFactory.makeServerStreaming(callHandlerContext: callHandlerContext) { context in
			return { request in
				self.Retrieve(request: request, context: context)
			}
		}
		case "GetMaxHitPoint":
		return CallHandlerFactory.makeClientStreaming(callHandlerContext: callHandlerContext) { context in
			self.GetMaxHitPoint(context: context)
		}
		case "GetMinMaxHitPoints":
		return CallHandlerFactory.makeBidirectionalStreaming(callHandlerContext: callHandlerContext) { context in
			self.GetMinMaxHitPoints(context: context)
		}
		default: return nil;
		}
	}

}


