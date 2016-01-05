module Pod

  class ConfigureSwift
    attr_reader :configurator

    def self.perform(options)
      new(options).perform
    end

    def initialize(options)
      @configurator = options.fetch(:configurator)
    end

    def perform
      keep_demo = :yes

      framework = :none
      configurator.add_pod_to_podfile "Redux', '~> 0.1.0"

      Pod::ProjectManipulator.new({
        :configurator => @configurator,
        :xcodeproj_path => "template/ReduxProjectTemplate.xcodeproj",
        :platform => :ios,
        :remove_demo_project => (keep_demo == :no),
        :prefix => ""
      }).run

      `mv ./template/* ./`
    end
  end

end
