module Pod

  class ConfigureIOS
    attr_reader :configurator

    def self.perform(options)
      new(options).perform
    end

    def initialize(options)
      @configurator = options.fetch(:configurator)
    end

    def perform

        keep_demo = :yes

        framework = :None
        configurator.set_test_framework("xctest", "m", "ios")

        snapshots = :No
      

      prefix = nil
      platform = nil

      loop do
          puts '--------- 王大仙最帅 ---------'.green
          puts '--- 模板工程正在加载中，请稍后 ---'.green
        prefix = configurator.ask("设置下你的项目前缀")

        if prefix.include?(' ')
          puts 'Your class prefix cannot contain spaces.'.red
        else
          break
        end
        puts '--- 模板工程正在加载中，请稍后 ---'.green
        platform = configurator.ask_with_answers("输入想要的平台demo", ["osx", "ios"]).to_sym
        
      end
      

      Pod::ProjectManipulator.new({
        :configurator => @configurator,
        :xcodeproj_path => "templates/ios/Example/PROJECT.xcodeproj",
        :platform => :platform,
        :remove_demo_project => (keep_demo == :no),
        :prefix => prefix
      }).run
      
#      Pod::ProjectManipulator.new({
#        :configurator => @configurator,
#        :xcodeproj_path => "templates/ios/Example-osx/PROJECT.xcodeproj",
#        :platform => :osx,
#        :remove_demo_project => (keep_demo == :no),
#        :prefix => prefix
#      }).run

      # There has to be a single file in the Classes dir
      # or a framework won't be created, which is now default
      `touch Pod/Classes/ReplaceMe.m`

      `mv ./templates/ios/* ./`

      # remove podspec for osx
      `rm ./NAME-osx.podspec`
    end
  end

end
