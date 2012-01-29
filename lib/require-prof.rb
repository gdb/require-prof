module RequireProf
  @@print_live = (print_live = ENV['RUBY_REQUIRE_PRINT_LIVE']) && (print_live != 'false')

  @@orig_require = method(:require)
  @@orig_load = method(:load)
  @@global_start = Time.now
  @@level = 0
  @@lower_level_progress = 0
  @@timing_info = []

  def self.backend_requiring(orig_method, name, args)
    initial_lower_level_progress = @@lower_level_progress
    spacing = ' ' * @@level
    start_at = Time.now
    cumulative_duration = start_at - @@global_start

    if @@print_live
      $stderr.puts "#{spacing}[#{cumulative_duration}s] BEGIN #{name} #{args.inspect}..."
    end

    @@level += 1
    orig_method.call(*args)
    @@level -= 1

    end_at = Time.now
    cumulative_duration = end_at - @@global_start
    total_duration = end_at - start_at
    my_duration = total_duration - (@@lower_level_progress - initial_lower_level_progress)

    if @@print_live
      print_timing_entry(my_duration, total_duration, cumulative_duration, spacing, "END #{name}", args)
    end

    @@timing_info << [my_duration, total_duration, cumulative_duration, spacing, name, args]
    @@lower_level_progress += my_duration
  end

  def self.require(*args)
    backend_requiring(@@orig_require, 'requiring', args)
  end

  def self.load(*args)
    backend_requiring(@@orig_load, 'loading', args)
  end

  def self.print_timing_infos_for_optimization
    @@timing_info.sort_by { |timing| timing.first }.each do |my_duration, _, _, _, name, args|
      $stderr.puts "#{my_duration} -- #{name} #{args.inspect}"
    end
    nil
  end

  def self.print_timing_infos
    @@timing_info.each { |entry| print_timing_entry(*entry) }
    nil
  end

  private

  def self.print_timing_entry(my_duration, total_duration, cumulative_duration, spacing, name, args)
    $stderr.puts "#{spacing}[#{cumulative_duration}s] #{name} #{args.inspect}. Took a cumulative #{total_duration}s (#{my_duration}s outside of sub-requires)."
  end
end

def require(*args)
  RequireProf.require(*args)
end

def load(*args)
  RequireProf.load(*args)
end
