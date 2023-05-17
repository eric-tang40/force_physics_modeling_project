# Project 01 For NeXT CS
### Class Period: 5
### Name0: Eric Tang
---

### New Forces Implemented
Name & Describe the two new forces you created.


**Jet Force:** This force, which is also known as __thrust__, is an __applied force__ meant to simulate a jet plane's engine. Thrust is responsible for moving an planes/jets. The variables that impact jet force are: 
- mass flow rate (rate at which fuel flows out of jet)
- velocity of the jet
- atmospheric and internal pressure 
- cross sectional area of the engine

Jet force does not change the direction of an object, but instead accelerates it in the direction it is headed. Each orb has an instance variable called Engine which is an __object__ with features such as area, pressure, and gas tank. All Orbs that leave a trail (you'll see in the program) are experiencing jet force.                

**Magnetic Force:** Magnetic force is one of the fundamental forces of nature caused by the motion of charged objects. The following variables impact magnetic force:
- charge of the object feeling the force
- velocity of the object feeling the force
- strength of the magnetic field (note that this also has its own calculations)

The direction of magnetic force is unrelated to the above variables. For the purposes of the program, all magnetic __fields__ have directions that are either into or out of the screen. This way, the orb's motion/velocity can remain in 2D. 

---

### Simulation Explanations
Explain what each of your simulations do, and what should appear when running them.

**Simulation 1: Earth Gravity:** This simulation has 5 orbs: 4 are planets (mercury, earth, mars, and saturn) and one sun. The planets are moving orbs and the sun is fixed. Only the sun exerts gravity; there is no mutual attraction. The orbs are sized appropriately, should leave fading trails behind as they move, sould never cross orbits, and should remain in orbit indefinitely. 

**Simulation 2: Springs:** This simulation has 9 orbs, 7 which are free to move and 2 black orbs that are fixed. These two fixed orbs are at the front and back of the row of orbs. The program should not be able to move the fixed orbs and the lines that represent the springs change color as they compress/decompress. 

**Simulation 3: Jet Force:** This simulation begins with 8 orbs on the bottom of the screen. When ran, all of the orbs accelerate __up__ at different speeds and angles (representing fast and slow jets). Bounce is turned __on__. All of the orbs have a gas tank, and when they run out of gas, they no longer feel jet force BUT they keep their current velocities. Also, a red message saying "Out of Gas" will appear above the orb. The orbs leave behind fading trails as they move, but the trail disappears when the orbs run out of gas. 

**Simulation 4: Magnetic Force:** This simulation begins with 4 magnets and 8 orbs. 2 of the magnets are fixed and 2 are free to move. The magnets are orbs themselves, but a PImage is put over them for visual effect. Text above the magnet (either "into" or "outward") represents the direction of the  field exerted by the magnet. When ran, each orb feels magnetic force from all 4 of the magnets. The 2 magnets that CAN move are able to feel magnetic force. Bounce is turned __on__. Orbs should be attracted to the magnets but when they get too close, get repelled.

**Simulation 5: Combination:** This simulation includes a sun, 5 orbs, and 2 fixed magnets. Each orb feels the following forces: 
- Gravitational pull of the sun
- Gravitational pull from other orbs
- Jet Force (assuming the Engine has gas)
- Magnetic Force 

Spring Force is __NOT__ included. The sun's gravitational pull is abnormally strong in this simulation, and the "goal" of each orb is to escape the sun's orbit. The only way the orb can do this is to get very close to one of the magnets, otherwise the sun's gravity will overpower the magnetic force. Orbs will use jet force to try to reach the magnets, but they only have a set amount of fuel. Once the fuel runs out, if they are still stuck in the sun's orbit, they should not be able to leave. If they reach a magnet, they will accelerate rapidly and never be seen again. Each orb has randomized starting speeds, engines, masses, etc. that make each trial different.    
From my trials, orbs will be immediately be attracted to the sun, but begin to accelerate towards the magnets as jet force gets stronger. About 2-3 orbs "escape" the sun's orbit while the other 2-3 typically don't.   
In some cases, orbs that have escaped the sun's orbit will reappear on the screen, but they should no longer be in orbit. 

---

### Changes
What changed about your program after the design phase? Were any of these changes the result of the demo day?

1. I changed the equation I used to get jet force. This is the new one: 
__F = (mass flow rate * v) - (external pressure - internal pressure) * area.__ I realized that the equation I was using before used the wrong m (I mistaked mass flow rate for mass) and that the order of operations was wrong. 

2. I decided to add multiple planets and use gravity to simulate orbits. This is from demo day. 
3. I added a new class named Engine for jet force because engines are objects, not variables, in real life. 
