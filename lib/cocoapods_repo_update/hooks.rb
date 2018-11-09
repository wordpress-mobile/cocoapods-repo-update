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
      rescue Pod::NoSpecFoundError
        Pod::UI.puts "At least one Pod is not in the local specs repo. Updating specs repo..."

        config = Pod::Config.new
        config.sources_manager.update(nil, false) # Update all specs repos, silently
      end
    end
  end
end
