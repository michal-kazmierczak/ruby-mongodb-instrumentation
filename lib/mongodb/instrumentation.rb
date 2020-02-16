require "mongodb/instrumentation/version"
require "mongodb/instrumentation/command_subscriber"
require "opentracing"

module MongoDB
  module Instrumentation
    class << self
      def instrument(tracer: OpenTracing.global_tracer, ignored_commands: [])
        Mongo::Monitoring::Global.subscribe(
          Mongo::Monitoring::COMMAND,
          MongoDB::Instrumentation::CommandSubscriber.new(
            tracer: tracer, ignored_commands: ignored_commands
          )
        )
      end
    end
  end
end
