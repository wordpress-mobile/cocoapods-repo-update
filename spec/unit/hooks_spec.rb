require File.expand_path('../../spec_helper', __FILE__)

def trigger_pre_install(installer_context, options)
  pre_install_hooks = Pod::HooksManager.registrations[:pre_install]
  hook = pre_install_hooks.find { |h| h.plugin_name == CocoapodsRepoUpdate::NAME }
  hook.block.call(installer_context, options)
end

describe CocoapodsRepoUpdate::Hooks do
  let(:options) { double('options') }
  let(:installer_context) { double('Pod::Installer::Analyzer', sandbox: double('sandbox'),
                                                               podfile: double('podfile'),
                                                               lockfile: double('lockfile')) }
  let(:analyzer) { double('analyzer') }
  let(:sources_manager) { double('sources manager') }
  let(:config) { double('config', sources_manager: sources_manager) }

  before do
    allow(Pod::Installer::Analyzer).to receive(:new).with(installer_context.sandbox,
                                                          installer_context.podfile,
                                                          installer_context.lockfile).and_return(analyzer)
    allow(Pod::Config).to receive(:new).and_return(config)
  end

  context 'pre install' do
    it 'runs the post install action without updating specs' do
      allow(analyzer).to receive(:analyze)
      expect(sources_manager).not_to receive(:update)

      trigger_pre_install(installer_context, options)
    end

    it 'runs the post install action and updates specs' do
      allow(analyzer).to receive(:analyze).and_raise(Pod::NoSpecFoundError)
      expect(sources_manager).to receive(:update)

      trigger_pre_install(installer_context, options)
    end
  end
end
