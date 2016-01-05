require 'fileutils'
require 'colored'

module Pod
  class TemplateConfigurator

    attr_reader :project_name, :pods_for_podfile, :prefixes, :test_example_file, :username, :email

    def initialize(project_name)
      @project_name = project_name
      @pods_for_podfile = []
      @prefixes = []
      @message_bank = MessageBank.new(self)
    end

    def ask(question)
      answer = ""
      loop do
        puts "\n#{question}?"

        @message_bank.show_prompt
        answer = gets.chomp

        break if answer.length > 0

        print "\nYou need to provide an answer."
      end
      answer
    end

    def ask_with_answers(question, possible_answers)

      print "\n#{question}? ["

      print_info = Proc.new {

        possible_answers_string = possible_answers.each_with_index do |answer, i|
           _answer = (i == 0) ? answer.underline : answer
           print " " + _answer
           print(" /") if i != possible_answers.length-1
        end
        print " ]\n"
      }
      print_info.call

      answer = ""

      loop do
        @message_bank.show_prompt
        answer = gets.downcase.chomp

        answer = "yes" if answer == "y"
        answer = "no" if answer == "n"

        # default to first answer
        if answer == ""
          answer = possible_answers[0].downcase
          print answer.yellow
        end

        break if possible_answers.map { |a| a.downcase }.include? answer

        print "\nPossible answers are ["
        print_info.call
      end

      answer
    end

    def run
      @message_bank.welcome_message

      ConfigureSwift.perform(configurator: self)

      replace_variables_in_files
      clean_template_files
      rename_template_files
      add_pods_to_podfile
      reinitialize_git_repo
      run_pod_install

      `rm -r template`

      @message_bank.farewell_message
    end

    #----------------------------------------#

    def run_pod_install
      puts "\nRunning " + "pod install".magenta + " on your new library."
      puts ""

      `pod install`

      `git add #{project_name}.xcodeproj/project.pbxproj`
      `git commit -m "Initial commit"`
    end

    def clean_template_files
      ["./**/.gitkeep", "configure", "_CONFIGURE.rb", "README.md", "LICENSE", "templates", "setup", "test.sh"].each do |asset|
        `rm -rf #{asset}`
      end
    end

    def replace_variables_in_files
      file_names = ['PROJECT_LICENSE', 'PROJECT_README.md', '.swiftlint.yml', podfile_path]
      file_names.each do |file_name|
        text = File.read(file_name)
        text.gsub!("${PROJECT_NAME}", @project_name)
        text.gsub!("${REPO_NAME}", @project_name.gsub('+', '-'))
        text.gsub!("${USER_NAME}", user_name)
        text.gsub!("${USER_EMAIL}", user_email)
        text.gsub!("${YEAR}", year)
        text.gsub!("${DATE}", date)
        File.open(file_name, "w") { |file| file.puts text }
      end
    end

    def add_pod_to_podfile podname
      @pods_for_podfile << podname
    end

    def add_pods_to_podfile
      podfile = File.read podfile_path
      podfile_content = @pods_for_podfile.map do |pod|
        "pod '" + pod + "'"
      end.join("\n  ")
      podfile.gsub!("${INCLUDED_PODS}", podfile_content)
      File.open(podfile_path, "w") { |file| file.puts podfile }
    end

    def add_line_to_pch line
      @prefixes << line
    end

    def rename_template_files
      FileUtils.mv "PROJECT_README.md", "README.md"
      FileUtils.mv "PROJECT_LICENSE", "LICENSE"
    end

    def reinitialize_git_repo
      `rm -rf .git`
      `git init`
      `git add -A`
    end

    def validate_user_details
        return (user_email.length > 0) && (user_name.length > 0)
    end

    #----------------------------------------#

    def user_name
      (ENV['GIT_COMMITTER_NAME'] || `git config user.name`).strip
    end

    def user_email
      (ENV['GIT_COMMITTER_EMAIL'] || `git config user.email`).strip
    end

    def year
      Time.now.year.to_s
    end

    def date
      Time.now.strftime "%m/%d/%Y"
    end

    def podfile_path
      'Podfile'
    end

    #----------------------------------------#
  end
end
