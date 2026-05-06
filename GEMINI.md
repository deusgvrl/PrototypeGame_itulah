
## Mandates for Gemini CLI

1. **Takeaway & Confirmation Policy:**
   - Whenever the user prompts, **ALWAYS** share your takeaways from what they said.
   - Propose your changes (including code if it's code changes).
   - **WAIT** for user confirmation before applying any changes.

2. **Documentation & Commenting Policy:**
   - Whenever changes are made, **ALWAYS** add or edit comments.
   - **ALWAYS** explain every logic, component, function, and new variables added, explaining what they do.
   - Use a mix of `MARK` comments, `TODO`, standard comments (`//`), and triple-slash documentation (`///`) as appropriate for the context.

3. **Recall Mandate:**
   - Whenever the user asks "Where were we?", **ALWAYS** respond with the exact status of the last conversation turn, including the achieved milestone and the current task, to ensure continuity across session restarts.

---

# Game Project: Latch

**Description:**
Latch is an isometric-inspired 2D endless runner (initially developed in top-down view) where players must jump from animal to animal to survive. The core gameplay loop involves automatic forward movement, steering wild animals, taming them through persistent riding, and timed leaps to new mounts to avoid obstacles and stay off the ground.

## Clean Code Mandate
To ensure "Latch" remains maintainable and professional, all code must follow these foundational principles:

### **1. KISS (Keep It Simple, Stupid)**
*   Avoid over-engineering. If a simple `if` statement solves the problem clearly, don't use a complex design pattern.
*   Logic should be readable at a glance.

### **2. SOLID (The Five Principles of Object-Oriented Design)**
*   **S - Single Responsibility:** A class should have one job (e.g., the `Player` class only handles the player).
*   **O - Open/Closed:** Classes should be open for extension but closed for modification (e.g., adding a new `Zebra` shouldn't require changing the `ScrollingNode` code).
*   **L - Liskov Substitution:** Subclasses should be replaceable for their base class (e.g., `Rock` should work anywhere a `ScrollingNode` is expected).
*   **I - Interface Segregation:** Don't force a class to implement functions it doesn't use.
*   **D - Dependency Inversion:** Depend on abstractions, not concretions (e.g., `GameScene` talks to `ScrollingNode`, not specifically `Rock`).

### **3. DRY (Don't Repeat Yourself)**
*   If you find yourself copy-pasting code (like movement logic), move it into a parent class or a shared function.
*   Centralize shared values (like `gameSpeed`) so changing them in one place updates the whole game.

### **4. YAGNI (You Ain't Gonna Need It)**
*   Don't write code for features we haven't reached in the roadmap yet. Focus on the current step.

## Strategic Roadmap: Top-Down Prototype

**Step 1: Environment & Scrolling Logic**
*   **Infinite World Container:** Create a "World Node" that holds all obstacles and animals.
*   **Downward Movement:** Define a global `gameSpeed` variable. Every object in the World Node moves down at this speed.
    *   *Note:* Keep `gameSpeed` static for now, but structure the code to allow for future ramping.
*   **Object Recycling (Culling):** Implement a system to remove objects once they pass the bottom of the screen to save memory.
*   **Background Feedback:** Add a scrolling floor texture to provide a visual sense of speed.

**Step 2: The Player (The Rider)**
*   **Fixed Position:** Keep the player at a fixed Y-coordinate (lower third of the screen).
*   **Steering Logic:** Implement horizontal movement (X-axis) based on user dragging/holding the screen.
*   **State Machine:** Define player states: `Riding`, `Jumping` (mid-air), and `Falling` (on the ground/Game Over).

**Step 3: Code Architecture & Modularity**
*   **Decoupling Logic:** Move the Player's "brain" (variables like `playerX` and movement math) out of `GameScene` and into a dedicated `Player` class.
*   **Custom Class Setup:** Create subclasses of `SKSpriteNode` so that players, animals, and obstacles can manage their own initialization (size, color, properties).
*   **The "Director" Pattern:** Refactor `GameScene` to act as a manager that only orchestrates the world and passes input data to the actors.
*   **File Organization:** Physically separate classes into their own `.swift` files to keep the project clean and manageable as features are added.

**Step 4: Animal Architecture**
*   **Base Animal Class:** Define a template for all animals with properties:
    *   `runSpeed`: How fast this specific animal moves.
    *   `tameTime`: How many seconds required to "tame" it.
    *   `angerLimit`: How long the player can ride it before it becomes "angry."
*   **Behavioral Logic:** Logic for the animal's movement (some move straight, some zig-zag).

**Step 5: Taming & Riding Mechanics**
*   **Attachment:** Logic to "parent" the player node to an animal node when they collide.
*   **Taming Timer:** A visual or background timer that ticks up while riding.
*   **Anger State:** Logic for what happens when the `angerLimit` is reached (e.g., the animal starts bucking or speeds up significantly).

**Step 6: The "Jump" Mechanic**
*   **Release to Jump:** Trigger a jump when the user releases their finger.
*   **Lasso/Detection:** While in the air, a detection circle (lasso) identifies the nearest animal in front of the player.
*   **Successful Catch:** If an animal is within range, the player "snaps" to it. If not, the player falls.

**Step 7: Spawning & Level Generation**
*   **Dynamic Spawner:** A system that generates "waves" of content (e.g., a group of buffalos followed by a rock formation).
*   **Difficulty Scaling (Future):** Note: While speed is static now, this step covers future implementation of frequency or speed increases.

**Step 8: Collision & Game Over**
*   **Fatal Collisions:** Detect if the player/animal hits a static obstacle (rock/tree).
*   **Fail State:** Logic for when the player stays in the `Falling` state for too long (e.g., missed a jump).

**Step 9: Asset Development & Integration**
*   **Environment Assets:** Static ground texture (grass/dirt) and scrolling background elements.
*   **Player Assets:** Top-down rider sprite (placeholder first, then final).
*   **Animal Assets:** Sprites for different animal types (Buffalo, Zebra, etc.) with basic animation frames.
*   **Obstacle Assets:** Sprites for Rocks, Trees, and Bushes.
*   **UI Assets:** Taming progress bar, "Lasso" target indicator, and "Game Over" screen.

---

# NOTES (Final Game Implementation)

- **World Architecture (Hybrid Spawning):** 
    - **Chunking Method:** Use `.sks` files to design "Micro-Levels" for border decorations (trees, cliffs) and environment set-pieces to ensure visual quality.
    - **Rain Method:** Maintain the code-based random spawning for central obstacles and animals to ensure high replayability and "unpredictable" gameplay.
    - **Treadmill Sync:** Ensure the global floor texture is a separate, persistent layer to prevent "seams" between chunk transitions.

- **Advanced Gameplay Mechanics:**
    - **Bullet Time:** Implement a "Slow-Motion" state (0.75x speed) triggered during the `isJumping` state to aid in mid-air aiming and cinematic impact.
    - **Dynamic AI:** Animals will move on both X and Y axes, requiring more complex steering and anticipation from the player.
    - **Constraint-Based Spawning:** Implement "Lane Safety" in the raining logic to guarantee every animal is reachable and the path is never impossible to navigate.
