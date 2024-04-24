# CashCartMate

This project is a cash register application, where users can select products and calculate the total price according to specific pricing rules. It can be used as a command-line interface (CLI) application.

### Getting Started
- This project runs on Ruby version `3.1.4`, this can be downloaded [here](https://rubyinstaller.org/downloads/archives/). For macOS users, the recommended way to install Ruby is with [rbenv](https://github.com/rbenv/rbenv)
- Clone the project `CashCartMate` to a folder of your choosing by running: `git clone https://github.com/IsabelGouveia/CashCartMate`.
- Run `bundle install`. This will install any Ruby gems configured in [Gemfile](https://github.com/IsabelGouveia/CashCartMate/blob/main/Gemfile)
- Run `rails db:migrate`. This will run all migrations in the [migrate](https://github.com/IsabelGouveia/CashCartMate/tree/main/db/migrate) folder

## Description
### 1) Assumptions:

**Products Registered**
| Product Code | Name | Price |  
|--|--|--|
| GR1 |  Green Tea | 3.11€ |
| SR1 |  Strawberries | 5.00 € |
| CF1 |  Coffee | 11.23 € |

**Special conditions**
- Buy-one-get-one-free offer for Green Tea (GR1).
- Bulk purchase discount for Strawberries (SR1): If 3 or more strawberries are purchased, the price drops to 4.50€ each.
- Discount for bulk purchase of Coffee (CF1): If 3 or more coffees are purchased, the price drops to 2/3 of the original price.

The checkout system can scan items in any order and it's flexible regarding pricing rules, as these may change frequently.

### 2) Testing

To ensure the correctness of the application's functionality, automated tests have been implemented. To run the tests, navigate to the project directory in the terminal and execute:

```bash
rails test
```
### 3) Usage

To use the application, simply run the following command and provide a list of items separated by commas:

```bash
ruby lib/cli.rb calculate --cart_items 
```
Example:

```bash
ruby lib/cli.rb calculate --cart_items GR1,SR1,CF1
```
