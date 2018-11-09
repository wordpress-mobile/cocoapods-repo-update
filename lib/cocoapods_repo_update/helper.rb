module CocoapodsRepoUpdate
  module Helper

    # Suppress stdout & stderr while the block is run
    #
    # @yield invokes the block with output suppressed
    def self.suppress_output
      original_stdout, original_stderr = $stdout.clone, $stderr.clone
      $stderr.reopen File.new('/dev/null', 'w')
      $stdout.reopen File.new('/dev/null', 'w')
      yield
    ensure
      $stdout.reopen original_stdout
      $stderr.reopen original_stderr
    end
  end
end
