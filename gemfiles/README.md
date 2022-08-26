#<--rubocop/md--># History
#<--rubocop/md-->
#<--rubocop/md-->These `gemfiles` help with testing this gem against various versions of Rails-ish-ness.
#<--rubocop/md-->
#<--rubocop/md-->```ruby
gem "actionpack", [">= 6", "< 8"]
#<--rubocop/md-->```
#<--rubocop/md-->
#<--rubocop/md--># *.gemfile Naming
#<--rubocop/md-->
#<--rubocop/md-->In the naming of gemfiles, we will use the below shorthand for actionpack and version
#<--rubocop/md-->
#<--rubocop/md-->| Gem        | Version | Gemfile    |
#<--rubocop/md-->|------------|---------|------------|
#<--rubocop/md-->| actionpack | ~> 6.0  | a6.gemfile |
#<--rubocop/md-->| actionpack | ~> 7.0  | a7.gemfile |
#<--rubocop/md-->
#<--rubocop/md--># References
#<--rubocop/md-->
#<--rubocop/md-->Compatibility Matrix for Ruby and Rails:
#<--rubocop/md-->* https://dev.to/galtzo/matrix-ruby-gem-bundler-etc-4kk7
