require 'cocoapods'
require 'cocoapods/resolver'

module CocoapodsRepoUpdate
  # Registers for CocoaPods plugin hooks
  module Hooks
    Pod::HooksManager.register(CocoapodsRepoUpdate::NAME, :pre_install) do |installer_context, options|
      analyzer = Pod::Installer::Analyzer.new(installer_context.sandbox, 
                                              installer_context.podfile,
                                              installer_context.lockfile)
      begin
        Pod::UI.puts "Checking if specs repo should be updated"

        # Analyze dependencies but suppress stdout/stderr so `pod install` output is not polluted
        CocoapodsRepoUpdate::Helper.suppress_output do
          analyzer.analyze
        end
        Pod::UI.puts "Not updating local specs repo"
      rescue Exception => e
        raise unless CocoapodsRepoUpdate::Helper.specs_need_update?(e)

        message = "At least one Pod is not in the local specs repo"
        if CocoapodsRepoUpdate::Helper.version_conflict?(e)
          message = "There was a version conflict with some of your pods"
        end

        Pod::UI.puts "#{message}. Updating specs repo..."
        # Update the specs repos, silently
        CocoapodsRepoUpdate::Helper.suppress_output do
          analyzer.update_repositories
        end
      end
    end
  end
end
