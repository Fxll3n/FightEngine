
# Fight Engine

A comprehensive Godot 4.5+ plugin for creating precision-based 2D fighting games.

## Overview

Fight Engine is a work-in-progress plugin designed to streamline the development of 2D fighting games in Godot 4.5 and above. It provides essential tools for hitbox management and state-based combat systems, allowing developers to focus on game design rather than low-level collision logic.

## Features

### Collision System

**HitBox2D & HurtBox2D Nodes**

-   Specialized collision nodes that automatically filter irrelevant collisions
-   Only process collisions from other CollisionBox2D nodes
-   Simplifies hit detection logic and reduces boilerplate code

### State Management

**Integrated State Machine Support**

-   Demo implementation uses [LimboAI](https://github.com/limbonaut/limboai) by [limbonaut](https://github.com/limbonaut)
-   High-performance GDExtension for behavior trees and state machines
-   Significantly faster than GDScript-based alternatives

## Getting Started

### Installation

1.  Install the plugin through Godot's AssetLib or by manually copying files to your project's `addons` folder
2.  Enable the plugin in `Project → Project Settings → Plugins`

### Initial Setup

**Configure Frame Rate** (Recommended)

1.  Navigate to `Project → Project Settings`
2.  Enable "Advanced Settings"
3.  Set `Application → Run → Max FPS` to your target frame rate
	-   Most modern fighting games use 60 FPS
	-   Consistent frame rates ensure predictable timing and combos

## Design Philosophy

Fight Engine is built around an animation-driven approach to combat:

**Animation-Based Attacks**

-   Use `AnimationPlayer` nodes to create animation libraries
-   Each animation manipulates HitBox2D and HurtBox2D positions, sizes, and states
-   Animations define attack hitboxes, active frames, and recovery periods
-   This approach creates reproducible, frame-perfect attacks

**Example Workflow:**

1.  Create an animation library resource
2.  Define animations for different moves (jab, kick, special attacks)
3.  Keyframe hitbox/hurtbox transformations within each animation
4.  Trigger animations through your state machine or input handler

See the included demo project for a complete implementation example.

## Resources

-   **Demo Project**: Included with the plugin
-   **LimboAI Documentation**: [github.com/limbonaut/limboai](https://github.com/limbonaut/limboai)

## Roadmap

This plugin is under active development. Planned features and improvements will be added as the project evolves.

## Contributing

Contributions, bug reports, and feature requests are welcome! Please check the issues page or submit a pull request.
