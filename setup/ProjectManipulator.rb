require 'xcodeproj'

module Pod

  class ProjectManipulator
    attr_reader :configurator, :xcodeproj_path, :platform, :remove_demo_target, :string_replacements, :prefix

    def self.perform(options)
      new(options).perform
    end

    def initialize(options)
      @xcodeproj_path = options.fetch(:xcodeproj_path)
      @configurator = options.fetch(:configurator)
      @platform = options.fetch(:platform)
      @remove_demo_target = options.fetch(:remove_demo_project)
      @prefix = options.fetch(:prefix)
    end

    def run
      @string_replacements = {
        "PROJECT_OWNER" => @configurator.user_name,
        "TODAYS_DATE" => @configurator.date,
        "TODAYS_YEAR" => @configurator.year,
        "ReduxProjectTemplate" => @configurator.project_name,
        "CPD" => @prefix
      }
      replace_internal_project_settings

      @project = Xcodeproj::Project.open(@xcodeproj_path)
      @project.save

      rename_files
      rename_project_folder
    end

    def project_folder
      File.dirname @xcodeproj_path
    end

    def rename_files
      # rename tests
      File.rename(project_folder + "/ReduxProjectTemplateTests/ReduxProjectTemplateTests.swift", project_folder + "/ReduxProjectTemplateTests/" +  @configurator.project_name + "Tests.swift")
      File.rename(project_folder + "/ReduxProjectTemplateTests", project_folder + "/" + @configurator.project_name + "Tests")

      # rename xcproject
      File.rename(project_folder + "/ReduxProjectTemplate.xcodeproj", project_folder + "/" +  @configurator.project_name + ".xcodeproj")

      unless @remove_demo_target
        # change app file prefixes
        ["CPDAppDelegate.h", "CPDAppDelegate.m", "CPDViewController.h", "CPDViewController.m"].each do |file|
          before = project_folder + "/ReduxProjectTemplate/" + file
          next unless File.exists? before

          after = project_folder + "/ReduxProjectTemplate/" + file.gsub("CPD", prefix)
          File.rename before, after
        end

        # rename project related files
        ["ReduxProjectTemplate-Info.plist", "ReduxProjectTemplate-Prefix.pch"].each do |file|
          before = project_folder + "/ReduxProjectTemplate/" + file
          next unless File.exists? before

          after = project_folder + "/ReduxProjectTemplate/" + file.gsub("ReduxProjectTemplate", @configurator.project_name)
          File.rename before, after
        end
      end
    end

    def rename_project_folder
      if Dir.exist? project_folder + "/ReduxProjectTemplate"
        File.rename(project_folder + "/ReduxProjectTemplate", project_folder + "/" + @configurator.project_name)
      end
    end

    def replace_internal_project_settings
      print "start replace_internal_project_settings\n"
      Dir.glob(project_folder + "/**/**/**/**").each do |name|
        next if Dir.exists? name
        text = File.read(name)

        for find, replace in @string_replacements
            text = text.gsub(find, replace)
        end

        File.open(name, "w") { |file| file.puts text }
      end
      print "end replace_internal_project_settings\n"
    end

  end

end
