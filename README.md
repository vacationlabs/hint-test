# Context & discussion

https://www.reddit.com/r/haskell/comments/6pu7ch/differences_between_hotreloading_plugin_libraries/

# Benchmarking results

A slowdown of 2-2.5x if the same blaze template is run via `hint` as opposed to getting compiled normally into the main executable.

```
benchmarking without hint
time                 213.0 ms   (208.2 ms .. 224.4 ms)
                     0.999 R²   (0.994 R² .. 1.000 R²)
mean                 208.9 ms   (206.1 ms .. 213.1 ms)
std dev              4.400 ms   (1.590 ms .. 6.449 ms)
variance introduced by outliers: 14% (moderately inflated)

benchmarking with hint
time                 470.8 ms   (187.8 ms .. 591.3 ms)
                     0.959 R²   (0.878 R² .. 1.000 R²)
mean                 488.7 ms   (447.3 ms .. 512.5 ms)
std dev              36.99 ms   (0.0 s .. 41.13 ms)
variance introduced by outliers: 21% (moderately inflated)
```