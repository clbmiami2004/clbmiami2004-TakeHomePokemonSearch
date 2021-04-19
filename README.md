# clbmiami2004-TakeHomePokemonSearch
Pokemon Purchasing

Solution for Project:

1.- Created a Model which included the possible end-points containing that data to be used on the project. <br/><br/>
2.- Created a Cutomer Model which included Mock-up information to be used once the user tried to purchase a Pokemon.<br/><br/>
3.- Created an API Controller, this file will handle the API call, decode the data received and update the model used on the project.<br/><br/>
4.- Created a file called ResultsViewController. For the sake of this project, this file is in charge of handling the logic of the view and the view itself. A searchbar was implemented in order to implement a Pokemon search. In this same file I have implemented 3 different alerts; this first one to inform the user that there has been a misspelling issue and he needs to go back to check the spelling. The second one, when the user tries to buy a Pokemon, the logic checks the balance on the customer's account and if the user doesn't have enough money then it's shown on the alert; and the third one, advices the user that he will be able to purchase the pokemon because he has "such amount" available on the account. <br/><br/>
5.- Created a SummaryViewController, this file conatins the information needed to update the user once the purchase is about to be finished. It allows the user to check current balance, current Pokemon's price, and the remaining balance once the user has purchased the Pokemon. For the sake of this project I decided to user one label for each of them along with string interpolation.<br/><br/>
