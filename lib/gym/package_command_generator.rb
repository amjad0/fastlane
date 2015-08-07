module Gym
  # Responsible for building the fully working xcodebuild command
  class PackageCommandGenerator
    class << self
      def generate
        parts = ["xcodebuild -exportArchive"]
        parts += options
        parts += pipe

        parts
      end

      def options
        options = []

        options << "-archivePath '#{BuildCommandGenerator.archive_path}'"
        options << "exportFormat ipa"
        options << "-exportPath '#{ipa_path}'"

        options
      end

      def pipe
        [""]
      end

      # We export it to the temporary folder and move it over to the actual output once it's finished and valid
      def ipa_path
        File.join(BuildCommandGenerator.build_path, "#{Gym.project.app_name}.ipa")
      end

      # The path the the dsym file for this app. Might be nil
      def dsym_path
        Dir[BuildCommandGenerator.archive_path + "/**/*.dsym"].last
      end
    end
  end
end
