require-prof allows you to easily profile your Ruby project's imports:

```shell
   irb -r require-prof -r <path to your code>
```

Then just run

```ruby
   RequireProf.print_timing_infos
```

to see the time breakdown of your requires in chronological order. Run

```ruby
   RequireProf.print_timing_infos_for_optimization
```

to see the time breakdown by amount of time spent.

If you set the environment variable RUBY_REQUIRE_PRINT_LIVE to 'true',
require-prof will print out import timing information as it happens.