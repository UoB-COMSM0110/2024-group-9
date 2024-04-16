# 2024-group-9: Mission Possible

## Team
Liz Elliott, Diwen Fan, Santiago Gasca Garcia, Guangfo Guo, Charles Harris

<img src="Image.jfif" width="250">

## Introduction

This section sets out our two initial ideas and expands on the chosen game idea. 

IDEA 1: Platformer

Examples:
- Celeste
- Super Mario

<img src="Celeste_screenshot_02.png" width="350">

Twist: Weather system to affect efficacy of certain moves. For example:
- wind blows you forward or back
- ice makes surface slipperly (lowers friction)
- fog obscures view

Challenges: 
1. Game flow logic
2. Physics engine
3. Leaderboard

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

We will develop a two-dimensional space-themed platform game which allows players to choose their character, enter their name, play an optional tutorial and play through several levels of the game. The player will be able to do various running, jumping and dashing moves, and will make their way through various obstacles in order to find the parts of their broken spaceship and return home. The twist will be that the game play wil change depending on the weather, which will be different in each level. For example, hot weather would slow a player down, ice would make the surfaces slipperly and wind might make it easier or harder to jump over or past obstacles, depending on the direction.

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

## Design

## Implementation

### 1: Game Flow Logic
Because of the different elemnents we wanted to include in the game (such as a tutorial, the option to change keybinds and multiple levels), the game flow required careful implementation to ensure that the correct things are displayed on screen, and that it is clear to the player how to navigate the game. The game flow is based around an enumerated class SectionVariant which drives what is displayed on the screen, as well as the effect of any mouse clicks or key presses. Where a menu screen only contains information and one possible action, the player is invited to click anywhere. If there are two or more options to choose from, methods are invoked that highlight the option the mouse is hovering over, to make it clear what action will be taken with a mouse click in that place. Unless there's a clear reason for it not to, every menu screen includes a "Return to main menu" to aid navigation and clarity. 

<p float="middle">
  <img src="/report-photos/main-menu.png" width="250" />
  <img src="/report-photos/main-menu-highlight.png" width="250" /> 
</p>

Players are able to change the keybinds for the game controls, and these are stored in the GameState class so that the tutorial instructions and Game Settings menu will always refer to the chosen keys. The tutorial instructions themselves are stored in an ArrayList which is stepped through as the player progresses through the tutorial. 

The scoring formula is based mainly on the inverse of the time taken to complete each level, with additional points for lives remaining at the end of each level and the number of enemies defeated, with an additional weighting for the difficult mode. Level scores are summed and sent to the leaderboard when a player either finishes the game or loses all three hearts in difficult mode. (In easy mode losing all three hearts means restarting the current level, rather than a Game Over scenario.) 

The design information for each level is stored in a JSON file, which constrains the width and height of the available space for the level and specifies the weather, background image, player sprite's starting location, and the size and location of the platforms, enemies and spaceship part. Once set up, this approach enabled us to quickly and smoothly add more levels while keeping the verbose level data out of the Processing code itself. When the player retrieves the level's spaceship part, the level ends and the score for each level completed is shown before the player is invited to continue to the next level. A new Level object is instantiated at that point. 

<p float="middle">
  <img src="/report-photos/score-screen.png" width="400" />
</p>

The four available spaceship parts are shown at the top of the screen with some transparency applied to begin with. When a spaceship part is collected a method is called to set its image transparency to zero for the rest of the current game, so the player can view their progress. 

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

## Conclusion
