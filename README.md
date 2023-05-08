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

#### Custom Force 0: Jet Engine Propulsion/Thrust

### Forumla 0
What is the formula for your force? Including descirptions/definitions for the symbols. You may include a picure of the formula if it is not easily typed.

F = mv + A ( P1 + P2). Where m is the mass of the gas ejected per unit of time, v is the exit velocity of the gas, A is the cross sectional area of the nozzle, and P1 and P2 are the pressures of the exhaust gas and the surrounding atmosphere.

### Force 0
- What information that is already present in the `Orb` or `OrbNode` classes does this force use?
  - None, besides that applyForce can be used to apply the force. 

- Does this force require any new constants, if so what are they and what values will you try initially?
  - I will need a constant for the surrounding pressure of the atmosphere. I'm going to start with a low value (<0.01) because jet engines take a lot of power to start and want the other variables to be high if the jet engine force is strong.
  - I will need a constant for the cross sectional area of the nozzle for each orb object.

- Does this force require any new information to be added to the `Orb` class? If so, what is it and what data type will you use?
  - For the cross sectional area, I need to add a new float instance variable called c_area. 
  - I will need to add a getJet method to get the PVector for the new equation. It will return a PVector.
  - I need to add a double instance variable called angle to calculate the direction of the force. The force's direction is based off the angle that the Orb is pointed in. 
  - I will need a boolean instance variable called hasEngine that is null unless the Orb is given an engine. 
  - I will need a Engine object variable. Each Orb can have an Engine object, which has its own variables such as mass of exhaust gas, attached to it or it will be null. 

- Does this force interact with other `Orbs`, or is it applied based on the environment?
  - This force doesn't interact with other orbs and is based on the variables of each individual Orb. The environment affects each Orb object the same way.
  - It's applied based on whether an Orb class has an engine or not based on the boolean instance variable.  
  
- In order to calculate this force, do you need to perform extra intermediary calculations? If so, what?
  - The formula above will calculate the magnitude of the force while the angle of the Orb (instance variable) is the direction. I have to put together the magnitude and angle to return a final PVector. 
  - Not every Orb has the force so I have to check using the boolean instance variable whether it is applicable or not. 



#### Custom Force 1: Magnetic Force 

### Forumla 1
What is the formula for your force? Including descirptions/definitions for the symbols. You may include a picure of the formula if it is not easily typed.

F = qvB. Where q is the charge of the object, v is a vector with velocity and direction of the object, and B is the strength of the magnetic field. 

### Force 1
- What information that is already present in the `Orb` or `OrbNode` classes does this force use?
  - applyForce can be used to apply the force. 
  - I can use the PVector velocity variable in my equation.

- Does this force require any new constants, if so what are they and what values will you try initially?
  - First, I need to add a double constant for Earth's magnetic field. It will be low (<0.001) because Earth's magnetic field is a small force compared to Earth's gravity and others. 
  - I need a double constant for the weight of an electron, which already has a value assigned to it that I'll use. 

- Does this force require any new information to be added to the `Orb` class? If so, what is it and what data type will you use?
  - Each Orb object needs an int instance variable to calculate how many electrons it has, calculated based on its mass.
  - I need to add a getMagnet method to return a PVector of the force.

- Does this force interact with other `Orbs`, or is it applied based on the environment?
  - Technically every object has a magnetic field, but I might not make it interact with other Orbs. If I do, then it will interact similar to the spring force, but every Orb will exert a force on every other Orb, regardless of whether or not they are neighbors. 
  - The environment impacts the Orb because every Orb feels the Earth's magnetic field. 
  
- In order to calculate this force, do you need to perform extra intermediary calculations? If so, what?
  - I need to calculate the q of every Orb class, which is based off the constant for weight of an electron and the instance variable for number of electrons.
  - I also need to calculate the B of any individual magnet that is not the Earth, which I might make a new class for or just assign B randomly.

### Simulation 1: Gravity
Describe what your gravity simulation will look like. Explain how it will be setup, and how it should behave while running.

The setup is a number of Orb objects randomly placed on the upper half of the screen. Once the key is pressed to turn on gravity, each Orb will be attracted to an Orb object that has a very high y-value. They should all fall at the same rate and hit the ground at the same time, then use yBounce. 

### Simulation 2: Spring
Describe what your spring simulation will look like. Explain how it will be setup, and how it should behave while running.

The setup is a random number of Orbs scattered on the screen. The springs will be attached by a line and it should be similar to what we've already coded. The springs should compress and expand based on how other springs act. 

### Simulation 3: Jet Engine Force
Describe what your Force 0 simulation will look like. Explain how it will be setup, and how it should behave while running.

The setup is Orbs lined up on the very left of the screen from top to bottom. They should have different types of Engine objects attached to them and they should have different angles. When the jet is turned on, they should accelerate at different rates based on their variables. There should be a fading trail that follows them. 

### Simulation 4: Magnetic Force 
Describe what your Force 1 simulation will look like. Explain how it will be setup, and how it should behave while running.

The setup would be a bunch of Orbs randomly placed throughout the screen with a giant magnet one side of the screen. When the key is pressed, the magnet should start attracting the Orbs and the Earth's magnetic field starts to affect each Orb. When the key is pressed again the magnet should stop pulling the Orbs. 

### Simulation 5: Combination
Describe what your combined force simulation will look like. Explain how it will be setup, and how it should behave while running.

Each Orb will be drawn to a magnet and have an Engine that has a certain jet engine strength. Some orbs will be able to move far enough for it not to touch the magnet while other Orbs will be attracted to the magnet. Gravity should be present but each Orb should be able to bounce off the sides of the screen. Some Orbs will be attached to other Orbs by springs but some Orbs won't. 
