# 2024-group-9

## Team 9
Liz Elliott, Diwen Fan, Santiago Gasca Garcia, Guangfo Guo, Charles Harris

<img src="Image.jfif" width="250">

## Game ideas

IDEA 1: Platformer

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

### Reflections from user stories:
TO DO
Important to be clear about the order in which things need to happen and what dependencies there are.
For example
- no need to select a character for the tutorial. 
- player should be able to change keybinds as early as possible
- experienced player may want to skip the tutorial
Things still undecided:
- easy vs hard version
- how many levels
- what to include on leaderboard
