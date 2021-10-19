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

    def self.specs_need_update?(exception)
      no_spec_found?(exception) || version_conflict?(exception) || no_such_dependency(exception)
    end

    def self.no_spec_found?(exception)
      exception.is_a?(Pod::NoSpecFoundError)
    end

    def self.version_conflict?(exception)
      exception.cause.is_a?(Molinillo::VersionConflict)
    end

    def self.no_such_dependency(exception)
      exception.cause.is_a?(Molinillo::NoSuchDependencyError)
    end
  end
end
