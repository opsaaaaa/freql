# Freql

*aka. ((word) Freqency Lang/Lib)*
{: .small }

A library for handling word/token freqencies.

Right now all we do is convert fpmw to zipf and other units.



## Lets educate you about word frequency units real quick.

### rank
the relative rank of how common a word is within your corpus.
the #1, just #41

### freq
frequency represented as a proportion between 0 and 1
occurances in corpus divided by total words in corpus

practicle range 0.053(the) 0.00000001(trella)
actual range 0 to 1

### fpmw

frequency per million words.
or the number of times a word occurs in one million words
Practical range 53703(the) to 0.01(trella)
actual range is from 1000000 to 0

a fpmw of 1 means that word occurs 1 once on average for every million words
a fpmw of 1,000,000 would mean every word/token in the corpus was the same.

Advantages
- Its straight forward to calculated and understand.
- corpus size doesn't change the relative value.
- Its a old standard.

Disadvantages:
- the issue with fpmw is that rare words can have a fpmw of less than 1
- and its not easy for humans to compare.

### fpbw

frequency per billion words.
the same as fpmw but with a billion instead of million.
  
The advantages over fpbw is that values are far less likely to dip below 1


### cB
Its a word frequency from of logarithmic centibel scale.

practical range -127(the) to -799
actuall range is 0 to -900(or less)

cb is the word frequency unit used by our inital dataset pulled from the wordfreq program.
https://github.com/rspeer/wordfreq

> 0 cB represents a word that occurs with probability 1, so it is the only
> word in the data (this of course doesn't happen). -200 cB represents a
> word that occurs once per 100 tokens, -300 cB represents a word that
> occurs once per 1000 tokens, and so on.

Advantages
- Its very similar to zipf, but with a different scale and 0 point.
- Its really good for storage sizes.
- Its always less than 0, so rare values cant cross 0.
- and numbers are larger, so you dont need decimils for reasonable accuracy.
- you can easilly save them as positive integers.

Disadvantages
- its less human readable.

In the wordfreq program they 'bin' the data to reduce the file size further.
array[ bin[ "words", ...], ... ]
The index of the bin represents the positive frequency value.
you end up with a lot of leading empty bins, but after that it gets really effecient.

### zipf scale
Its log10 of frequency per billion words
Named after the American linguist George Kingsley Zipf

Practical Range 1-7ish 1.01(the) to 7.73(trella). *(wait i might have that backwards...)*
Actual Range is 9.0 to 0.0(or less technically)

Advantages
- Its human readable and its a known common standerd.

Disavantages
- It requires decimials for accuracy.
- Technically it can cross 0 with extremely rare items in large datasets.


## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add freql

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install freql

## Usage

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/freql.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
