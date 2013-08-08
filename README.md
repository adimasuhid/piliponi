# Piliponi

Simple mobile phone formatter for the Philippines

## Installation

Add this line to your application's Gemfile:

    gem 'piliponi'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install piliponi

## Usage

###Plausible
Check if the number is a probable mobile number

    Piliponi.plausible? "091700000001"   #true
    Piliponi.plausible? "NotaNumber"   #false

###Clean
Removes Non-numeric characters

    Piliponi.clean "+639-17-000-0001" #639170000001

###Telco
Returns local Telco coverage of a given number

    Piliponi.telco "09170000001" #globe

###Normalization
Returns formatted numbers as specified

####Local
    Piliponi.normalize("0917-000-0000", format: :local) #09170000000

####International
    Piliponi.normalize("0917-000-0000", format: :international) #+639170000000

####Pure
    Piliponi.normalize("0917-000-0000", format: :pure) #9170000000

####Erroneous Numbers
    Piliponi.normalize("wat", format: :pure) #Piliponi::InvalidPhoneNumberException

####Wrong format
    Piliponi.normalize("0917-000-0000", format: :none) #Piliponi::FormatNotRecognizedException

##Needs

Formatting Numbers
<br>
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
