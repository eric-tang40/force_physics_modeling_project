# Project 01 For NeXT CS
### Class Period: 5
### Name0: Eric Tang
---


Your mission is to create a Processing program that demonstrates different physical forces, building off of the framework we have been creating in class. Your program should do the following:
- Reasonably model gravity (in the classical mechanics sense) and the spring force. The force calculations for both have already been done in class.
- Reasonably model two other physical forces.
- Produce different simulations that demonstrate each force individually.
- Produce a simulation that combines at least 3 of the forces.
- Use a data structure to hold multile `Orb` (or `Orb` subclasses), to aid in at least 3 of your simulations.

This project will be completed in phases. The first phase will be to work on this document. Use makrdown formatting. For more markdown help [click here](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet) or [here](https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax)

All projects will require the following:
- Researching new forces to impliment.
- Methods for each new force the returns a `PVector` similar to how `getGravity` and `getSpring` (using whatever parameters are necessary).
- A distinct demonstration for each individual force (including gravity and the spring force).
  - Each simulation should have a way to toggle movement on or off, similar to the programs we've been writing.
  - Look back at the gravity classwork assignment. Note how each simulation had its own setup in order to demonstrate a spcific physical interaction. You want to recreate that type of experience.
  - A visual menu at the top providing information about which simulation is currently active and if movement is on or off.
  - The user shoudl be able to switch between simluations using the numebr keys as follows:
    - `1`: Gravity
    - `2`: Spring Force
    - `3`: Custom Force 0
    - `4`: Custom Force 1
    - `5`: Combination

## Phase 0: Force Selection, Analysis & Plan

#### Custom Force 0: NAME OF YOUR FORCE

### Forumla 0
What is the formula for your force? Including descirptions/definitions for the symbols. You may include a picure of the formula if it is not easily typed.

YOUR ANSWER HERE

### Force 0
- What information that is already present in the `Orb` or `OrbNode` classes does this force use?
  - YOUR ANSWER HERE

- Does this force require any new constants, if so what are they and what values will you try initially?
  - YOUR ANSWER HERE

- Does this force require any new information to be added to the `Orb` class? If so, what is it and what data type will you use?
  - YOUR ANSWER HERE

- Does this force interact with other `Orbs`, or is it applied based on the environment?
  - YOUR ANSWER HERE
  
- In order to calculate this force, do you need to perform extra intermediary calculations? If so, what?
  - YOUR ANSWER HERE


### Force 1
- What information that is already present in the `Orb` or `OrbNode` classes does this force use?
  - YOUR ANSWER HERE

- Does this force require any new constants, if so what are they and what values will you try initially?
  - YOUR ANSWER HERE

- Does this force require any new information to be added to the `Orb` class? If so, what is it and what data type will you use?
  - YOUR ANSWER HERE

- Does this force interact with other `Orbs`, or is it applied based on the environment?
  - YOUR ANSWER HERE
  
- In order to calculate this force, do you need to perform extra intermediary calculations? If so, what?
  - YOUR ANSWER HERE

### Simulation 1: Gravity
Describe what your gravity simulation will look like. Explain how it will be setup, and how it should behave while running.

YOUR ANSWER HERE

### Simulation 2: Spring
Describe what your spring simulation will look like. Explain how it will be setup, and how it should behave while running.

YOUR ANSWER HERE

### Simulation 3: Force 0
Describe what your Force 0 simulation will look like. Explain how it will be setup, and how it should behave while running.

YOUR ANSWER HERE

### Simulation 4: Force 1
Describe what your Force 1 simulation will look like. Explain how it will be setup, and how it should behave while running.

YOUR ANSWER HERE

### Simulation 5: Combination
Describe what your combined force simulation will look like. Explain how it will be setup, and how it should behave while running.

YOUR ANSWER HERE
