# Documentation
This file is to serve as documentation for the wave survival game we are working on

It will go over:
- State Machine Implementation
- Player
- Enemy Spawning Dynamics
- Creating Items

## State Machine Documentation
This state machine includes all the expected functionality of a FSM. There is a class for the state machine and a class for the state.
The states are implemented using the engine's Node Tree

## Enemy Spawning Dynamics
The parent ```Enemy``` class is contained in ```res://enemy/enemy.gd```
New enemy classes can inherit from this parent class by means of:
```gdscript
extends Enemy
```

## Player
The player is a ```KinematicBody2D```, whose script extend ```StateMachine```. The player directly inherits the state machine's functionality.
The player has a custom state called ```PlayerState``` which has basic functionality for moving the player.
All player states are children of the Player/States node. These hold the basic player functionality.
Items are held under the Player/Items node. The player calls upon the ```fire()``` method on the weapons.
Trinkets also inherit the ```PlayerState``` class.
