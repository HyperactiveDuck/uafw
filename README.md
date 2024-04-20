When I made this webapp only me and god knew how it worked. Now only god knows. To whoever it is that's tasked with maintining this shitwhole of a repo, Godspeed soldier, for only he can help you now

#Wasted Hours Trying To Optimize The Server Calls: 34


UAFW is a flutter web project that uses firebase as backend. It's used for a non-profit academic psychological test conducted by Umut Ocak. 

It uses firebase auth for user logins, each users gets a document with their uids when their account gets created.

You can assign either of the two games from the firebase and then the site would redirect the user to that certain game. The user has 15 minutes to play the games however many times they want to. During that 15 minutes each of their scores that is recorded that day , their high score for that day and the sum of their scores get stored withing the firebase storage.

The site also keeps track of the users last and first login time so that:
1 - Users can only login every 16 hours.
2 - Their daily scores can be seperated into maps independed from a single time frame.

The aim of the project is to measure the effects of pschological states on the users ability to improve and vice versa.
Users scores on these 2 games which are tetris and snake are stored live and organized so the data can be used for the paper later on.

The Example on the picture for usertetris says Day 30, since the score has been entered 30 days after the accounts first login. For that day it has the first score and it's timestamp , highest score recorded that day and the sum of all the scores the user recorded that day.

![UAFW_1](https://github.com/HyperactiveDuck/uafw/assets/133441799/4fbafd60-70df-4a86-bb92-c0d7a883c0cb)


![UAFW_2](https://github.com/HyperactiveDuck/uafw/assets/133441799/b70167b3-6136-4a67-b7b6-6a27abb88db6)

![UAFW_3](https://github.com/HyperactiveDuck/uafw/assets/133441799/1a0253e8-8de3-4d1b-b300-ff53be647bae)




The Tetris Games is by https://github.com/andnexus

The Snake Game is by https://www.adaycode.com/

