# Welcome to NobeBank :wave:

<p align="center">
  <img src="https://user-images.githubusercontent.com/39783638/81606899-3ae48680-93aa-11ea-8146-48d193ed7a9b.png" height="150">
</p>

Link site deployed: https://appnobebank.herokuapp.com/

The application handles the movements that a customer can make when arriving at a bank's teller.
The customer can do:
* Register, Edit and Close Your Account
* Make Deposits
* Make Withdrawals
* Perform Transfers between Accounts
* Request Balance
* Request Statement Filtering by Start and End Date



### Ruby version
```
2.7.2
```

### Rails version
```
6.0.4
```

## :information_source: How To Use

```shell
bundle install
yarn install
bundle exec rails db:create
bundle exec rails db:migrate
run it: rails s
test and run it: rspec
```
## Documentation
An account balance can never go negative

To make withdrawals and transfers it is necessary to authenticate the user.

Cancel Account:

An account cannot be deleted but will become inactive.

Transfer rate:
 * From Monday to Friday from 9 am to 6 pm the fee is 5 reais per transfer
 * Outside these hours the fee is 7 reais
 * Above 1000 reais there is an additional 10 reais in the fee

### Author

[Matheus Marques](https://www.linkedin.com/in/matheuscmarques/)    
