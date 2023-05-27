# Freql

*aka. ((word) Freqency Lang/Lib)*

A library for handling word/token freqencies.
Right now all we do is convert fpmw to zipf and other units.



## Lets educate you about word frequency units real quick.


| name | desciption | range | examples |
| --- | --- | --- | --- |
| fq | frequency represented as a proportion between 0 and 1. Occurrence count divided by total words/tokens | 0 to 1 | 0.053(the) 0.00000001(trella) |
| fpmw | frequency per million words. | 1 million to 0 | 53703(the) 0.01(trella) |
| fpbw | frequency per billion words. | 1 billion to 0 | nah |
| word rank | Frequency rank relative to all the other words within your corpus. | 1+n | the #1 |
| zipf scale | Its log10 of frequency per billion words. Named after the American linguist George Kingsley Zipf | 9.0 to 0.0(or less technically) | 1.01(the) to 7.73(trella) |
| cb | Its a word frequency from of logarithmic centibel scale. Basically zipf optimized for storage. | 0 to -900(or less) | -127(the) -799(trella) |


| name | Advantages | Disadvantages |
| --- | --- | --- |
| fq | simple | ...lots and lots of decimals |
| fpmw | Its straight forward to calculated and understand | Its not easy for humans to compare. for some words its less than 1 |
| fpbw | words arn't going to be less than one. | nobody uses it |
| zipf scale | Easy for humans to compare. | requires decimals for accuracy |
| cb | we can safely represent it as a positive integer without sacrificing significant accuracy | less human readable than zipf |


### WTF does cb come from?

cb is the word frequency unit used by our inital dataset pulled from the wordfreq program.
https://github.com/rspeer/wordfreq

> 0 cB represents a word that occurs with probability 1, so it is the only
> word in the data (this of course doesn't happen). -200 cB represents a
> word that occurs once per 100 tokens, -300 cB represents a word that
> occurs once per 1000 tokens, and so on.

Its very similar to zipf, but with a different scale and 0 point.
Its always less than 0, so rare values cant cross 0.
and numbers are larger, so you dont need decimils for reasonable accuracy.
You can easilly save them as positive integers.

In the wordfreq program they 'bin' the data to reduce the file size further.
`array[ bin[ "words", ...], ... ]`
The index of the bin represents the positive cb frequency value.
you end up with a lot of leading empty bins, but after that it gets really efficient.


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

## Credits


- I read the code from the python wordfq program. https://github.com/rspeer/wordfq


