# Piliponi

[![Build Status](https://travis-ci.org/adimasuhid/piliponi.png?branch=master)](https://travis-ci.org/adimasuhid/piliponi)

Simple mobile phone formatter for the Philippines

## Installation

Add this line to your application's Gemfile:

    gem 'piliponi'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install piliponi

## Usage
Include piliponi to your class to use its methods

    class Dummy
      include Piliponi
    end

    dummy = Dummy.new

###Plausible
Check if the number is a probable mobile number

    dummy.plausible? "091700000001"   #true
    dummy.plausible? "NotaNumber"   #false

###Clean
Removes Non-numeric characters

    dummy.clean "+639-17-000-0001" #639170000001

###Telco
Returns local Telco coverage of a given number

    dummy.telco "09170000001" #globe

###Normalization
Returns formatted numbers as specified

####Local
    dummy.normalize("0917-000-0000", format: :local) #09170000000

####International
    dummy.normalize("0917-000-0000", format: :international) #+639170000000

####Pure
    dummy.normalize("0917-000-0000", format: :pure) #9170000000

####Erroneous Numbers
    dummy.normalize("wat", format: :pure) #Piliponi::InvalidPhoneNumberException

####Wrong format
    dummy.normalize("0917-000-0000", format: :none) #Piliponi::FormatNotRecognizedException

##Needs

Accepting Integers
<br>
Thorough testing

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Add Rspec Tests
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request
