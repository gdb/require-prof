require-prof allows you to easily profile your Ruby project's imports:

```shell
irb -r require-prof -r <path to your code>
```

Then just run

```ruby
RequireProf.print_timing_infos
```

to see the time breakdown of your requires in chronological order:

```
 [0.03884s] requiring ["rational"]. Took a cumulative 0.006192s (0.006192s outside of sub-requires).
  [0.04679s] requiring ["rational"]. Took a cumulative 0.000622s (0.000622s outside of sub-requires).
 [0.047041s] requiring ["date/format"]. Took a cumulative 0.008191s (0.007569s outside of sub-requires).
[0.048926s] requiring ["date"]. Took a cumulative 0.025349s (0.010966s outside of sub-requires).
[0.053214s] requiring ["shellwords"]. Took a cumulative 0.004279s (0.004279s outside of sub-requires).
 [0.074198s] requiring ["uri/common"]. Took a cumulative 0.017014s (0.017014s outside of sub-requires).
  [0.08092s] requiring ["uri/common"]. Took a cumulative 0.00071s (0.00071s outside of sub-requires).
 [0.081387s] requiring ["uri/generic"]. Took a cumulative 0.007173s (0.006463s outside of sub-requires).
  [0.086468s] requiring ["uri/generic"]. Took a cumulative 0.000742s (0.000742s outside of sub-requires).
...
```

 Run

```ruby
RequireProf.print_timing_infos_for_optimization
```

to see the ordered time breakdown by amount of time spent in loading
and executing the code for a particular import:

```
...
0.017014 -- requiring ["uri/common"]
0.020225 -- requiring ["mail/indifferent_hash"]
0.022671 -- requiring ["mail/version_specific/ruby_1_8"]
0.0239660000000002 -- requiring ["mail"]
0.024664 -- requiring ["mail/core_extensions/nil"]
0.025889 -- requiring ["mail/core_extensions/string"]
0.046102 -- requiring ["yaml/rubytypes"]
0.151068 -- requiring ["mime/types"]
```

If you set the environment variable RUBY_REQUIRE_PRINT_LIVE to 'true',
require-prof will print out import timing information as it happens.