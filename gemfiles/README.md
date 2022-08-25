# History
 
These `gemfiles` help with testing this gem against various versions of Rails-ish-ness.

```ruby
gem "actionpack", [">= 6", "< 8"]
```

# *.gemfile Naming

In the naming of gemfiles, we will use the below shorthand for actionpack and version

| Gem        | Version | Gemfile    |
|------------|---------|------------|
| actionpack | ~> 6.0  | a6.gemfile |
| actionpack | ~> 7.0  | a7.gemfile |

# References

Compatibility Matrix for Ruby and Rails:
* https://dev.to/galtzo/matrix-ruby-gem-bundler-etc-4kk7
