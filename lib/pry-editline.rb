module PryEditline

  def self.editor
    if defined?(Pry)
      Pry.editor
    else
      ENV.values_at('VISUAL', 'EDITOR').compact.first || 'vi'
    end
  end

  def self.hijack_inputrc
    inputrc = [
      ENV['INPUTRC'],
      (File.expand_path('~/.inputrc') rescue nil),
      '/etc/inputrc'
    ].compact.detect { |x| File.exist?(x) }

    require 'tempfile'
    file = Tempfile.new('inputrc')
    file.puts '"\C-x\C-l": redraw-current-line'
    file.puts '"\C-x\C-e": "  \C-a\t\C-k\C-x\C-l"'
    file.puts '"\C-o":     "  \C-a\t\C-k\C-x\C-l"'
    file.puts "$include #{inputrc}" if inputrc
    file.close
    ENV['INPUTRC'] = file.path
  end

  def self.completion_proc
    lambda do |s|
      if Readline.point == 0 && Readline.line_buffer =~ /  $/
        require 'tempfile'
        Tempfile.open(['readline-','.rb']) do |f|
          f.puts(Readline.line_buffer[0..-3])
          f.close
          system("#{editor} #{f.path}")
          File.read(f.path).chomp
        end
      else
        yield s
      end
    end
  end

end

if defined?(Pry::InputCompleter)
  PryEditline.hijack_inputrc
  class <<Pry::InputCompleter
    unless method_defined?(:build_completion_proc_without_edit)
      alias build_completion_proc_without_edit build_completion_proc

      def build_completion_proc(*args)
        PryEditline.completion_proc(&build_completion_proc_without_edit(*args))
      end
    end
  end
elsif defined?(IRB) && defined?(Readline)
  PryEditline.hijack_inputrc
  Readline.completion_proc = PryEditline.completion_proc(&Readline.completion_proc)
end
