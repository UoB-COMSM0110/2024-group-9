# 2024-group-9: Mission Possible

## Team
Liz Elliott, Diwen Fan, Santiago Gasca Garcia, Guangfo Guo, Charles Harris

<img src="Image.jfif" width="250">

## Introduction

This section sets out our two initial ideas and expands on the chosen game idea. 

IDEA 1: Platformer (which we have ended up committing to)

Our game, Mission Possible, is a short story about a space explorer in the future who crash-lands on a distant planet and must return to their home planet of Earth B-13. In order to do so, the player must select their hero and embark on a journey to traverse various levels (the number and complexity of which will be affected by which of the two difficulty settings the player selects) and make it back to their ship, all while finding ways to avoid or work around the strongly disorienting and potentially fatal space monsters and weather conditions found in the far corners of outer space.

Mission Possible is a traditional platformer game like the original Donkey Kong, a model still prevalent in the modern day, as seen in blockbuster games like the latest instalments in the Super Mario series as well as smaller independent releases such as Celeste. 

Our distinguishing feature is the implementation of adverse weather effects in the levels. We have used a few conditions. Firstly, we use ice which, if stepped on, causes the player to lose the grip and restricts their ability to go back and forth at will, making it more difficult to time jumps and steps to get around obstacles and enemies. Secondly, we have gone for extreme winds which are constantly pushing the player in one direction thus making it much harder to progress. If a player jumps, the wind can send them flying backwards possibly even pushing them into an enemy and costing a life. And thirdly we have decided to add a fog setting. This blacks out the entire screen apart from a small circle of light around the player, so it becomes much harder to plan the optimal course in advance and relies on the player’s instinct to avoid the pitfalls of the level.


Examples:
- Celeste
- Super Mario

<img src="Celeste_screenshot_02.png" width="350">

Twist: Weather system to affect efficacy of certain moves. For example:
- wind blows you forward or back
- ice makes surface slipperly (lowers friction)
- cloud obscures view
- heat makes you move more slowly

Challenges (need to choose 3): 
1. Physics engine
2. Collision detection (hit boxes)
3. Leaderboard
4. Map design
5. Creating the skills/player abilities

IDEA 2: Tower Defense Game,

Examples:
- Tower Defense King 
- Kingdom Defense
<img src="Tower-Defense-King-screenshot.png" width ="350">

Twist: Game mode which allows the player to be the attacking party. 

Challenges: 
1. Bullet/weaponry design
2. Different attackers and tower types
3. Weather system to affect efficacy of certain moves

**Chosen game:** game idea 1 - platformer with weather conditions.

We will develop a two-dimensional space-themed platform game which allows players to choose their character, enter their name, play and optional tutorial and play through several levels of the game. The player will be able to do various running, jumping and dashing moves, and will make their way through various obstacles in order to reach their spaceship and return home. The twist will be that the game play wil change depending on the weather, which will change randomly during the game. For example, hot weather would slow a player down, ice would make the surfaces slipperly and wind might make it easier or harder to jump over or past obstacles, depending on the direction.

Working title: "Mission Possible!"

### Paper prototype
[YouTube link](https://youtu.be/xK1kFr6qZxw)

## Requirements

### Stakeholders:
- Players of the game:
  - novice player
  - experienced player
  - competitive player
  - player with physical accessibility requirements
- Game developers
- Markers (who have 5 mins max to play the game)

### User stories:
1. As a novice gamer I want a tutorial to teach me the basic game commands so I can become proficient at the game.
2. As someone with problems with my hands I want to be able to remap the key binds to use my preferred layout.
3. As a player I want to choose between two different levels of difficulty so I can start easy and get more difficult.
4. As a player I want the game to include different challenges, to make sure the game is interesting.
5. As a player I want to feel I'm involved and engaged with the story in the game.
6. As an experienced player I want the option to skip the tutorial so I can get straight on with playing the game.
7. As a competitive player I want to see my name on the leaderboad so I can compare my score with others.
8. As a developer I want the game to have good performance and stability so that people enjoy playing it.
9. As a developer I want the difficulty to be set so that not everyone finishes the game first time but it is possible to win eventually.
10. As a marker I want to get an overview of the game in a few minutes in order to be able to give it a fair review.
 
### Use case specification for user story 1:
1. Player opens the game and sees an intuitive navigation menu.
2. Player selects tutorial.
3. Tutorial opens showing the player a basic level that builds up from the basics in separate screens, focusing on one thing at a time.
4. Player reaches the end of the tutorial and is taken back to the home screen so they can decide whether to do the tutorial again or play the full game.

### Use case specification for user story 7:
1. Player opens game
2. Player selects to skip tutorial (already has pre-existing knowledge of game, keybinds, enemies, etc.)
3. Player enters nickname to be displayed on leaderboard
4. Player selects a character from a menu of choices
5. Player successfully navigates through complete game.
6. Success screen is displayed
7. Followed by leaderboard - including position, score, top 10?
8. Options to restart, quit

Use case diagram for user story 7

<img src="use-case-story7.jpg" width="500">

### Reflections 
The main things that we realised from developing the user stories and use cases were how it's important to be clear about which order things will need to happen in, and being very clear to the players about what they need to do next. 

For example, an player should be able to skip the tutorial if they want to, but a novice player should really easily be able to see what they need to do to start the tutorial. We might choose not to have character selection or entering the player's name for the tutorial, but these menu screens will need to be available for the main game. If we include the option to change the keybinds to make it easier for players to use the keys best suited to their physical requirements, we should do this as early on as possible. 

We also noted that we are still undecided about exactly what our three challenges will be, how many levels to have, and what details to include on the leaderboard. For example, how will we calculate a score for a player, will we show duplicates (i.e. if a player has played twice, will their two different scores appear in the leaderboard) and how will we show the current player's high score if it is not in, say, the top 10? 

### Ideation process and how we settled on the final idea
The process began by setting limits; it was important to know and manage expectations. Naturally, a totally revolutionary open-world RPG was well beyond anyone’s capabilities. But at the same time games like advanced Pong or Tic-Tac-Toe did not feel like enough of a challenge. Initially, the idea of a racing game seemed appealing but we quickly decided this felt a bit boring given what the kind of racing game we would be able to make and so we landed on a platformer with the idea of adding some kind of storyline to make it more interesting for the player. To make sure we did not end up doing something too derivative of a Super Mario we decided to take it extra-terrestrial and come up with our own storyline of a lost and crashed cowboy of the future; the solo space explorer. With a rough outline defined we were able to begin brainstorming features and ideas. Immediately, we decided we needed obstacles to add some sort of challenge, lives so that there is ‘something at risk’ and the player cannot just spam moves until something fortuitously happens to work and scores to add an incentive to complete the game faster/better (settling on how the player’s attempt would be scored was not something we were able to do in the earlier stages as this required more knowledge of the code we would be using and how complicated each scoring method would end up being).

With these objectives decided we set about drawing up the very bare bones draft of the game which featured an intro menu with the option to play the game or the tutorial. We had the user ‘click’ the play button, which took them to an “ENTER YOUR NAME” screen. This was followed by a screen revealing a level map which starts off as a very simple ‘obstacle course’ in which the player need only jump to reach the next platform and complete that level. Then suggestions were made to include enemy sprites that the player was to avoid. Failing to do so would cost one of the player’s 3 lives and the loss of all 3 lives would take the player (initially) back to the start of the level. Eventually, the player completes the draft level and sees a ‘MISSION COMPLETE’ screen followed by a scoreboard screen with their name and score on it, comparing them to previous players.


## Design

## Implementation

## Evaluation

Rough notes:

Think aloud evaluation:
- Menu screens - clear what you need to do - clicked through and entered name with no problems.
- Jump physics feels natural.

Heuristic evaluation:
- User control and freedom: would like ability to go back and change character and name before game levels start.
- Aesthetic - extra space in welcome name screen. Not frequent or persistent, cosmetic problem. 
- Match between system and real world - can jump from mid-air. Is this intended? Frequent but not persistent (i.e. player can get used to it).
- Consistency and standards - several keys being used for the same movements, but not clear why for example A and D are used for right and left, but W is not used for jump. Frequent, minor usability problem which can be overcome. 

### Qualitative

### Quantitative

### Testing

## Process

When placed in assigned teams, there is an important, inevitable stage at the beginning where everyone must make an effort to break the ice and establish team goals and ambitions for the project at hand. We quickly got on with introductions and discussed the types of games we had in mind based on previous experiences playing them and even, for some, designing them. At the start, most of the work was done in the Monday morning labs but there was also a significant bit of going away and individually seeing what was feasible and finding examples from which to draw inspiration that were then shared and further explored as a team on the Teams group which has served as our main form of communication throughout. We have also met in person various times throughout the course of the project which feels more efficient but is harder to coordinate. 

In terms of team roles, at no point did we deem in necessary or even helpful to assign any specific roles. In my experience at least, for these types of projects the roles are very fluid and tend to define themselves if specifically needed. Although there were no specific roles, in our meetings and calls we discussed what each of us would be happy to attempt/do and this was a very smooth process with everyone volunteering to tackle one task or another. This was easier before the Easter break when everyone was in Bristol and focused solely on work. Naturally, with the holiday there can be a bit of a downturn in the pace and consistency of the work. However, we planned around this pre-emptively so that everyone could let the group know roughly of any dates over the holiday during which they would be totally unavailable, thus minimising the impact on the project and ensuring we stayed on track. For the most part, this worked well with only minor disruptions to the workflow. Once we returned [finish this off when it’s happened]


## Conclusion
