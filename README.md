# Entity Persistence (Alpha)

**Entity Persistence** is a Dart framework to facilitate entity persistence in SQLite databases. This project is currently in alpha stage of development, which means it is in an early stage and may undergo significant changes.

## Objective

The main goal of Entity Persistence is to simplify the interaction between Dart applications and SQLite databases, offering an abstraction layer that handles common operations like create, read, update, and delete (CRUD) in an intuitive and efficient way.

## Key Features

- **Entity Mapping:** The framework provides an easy way to map Dart objects to tables in SQLite databases.
  
- **Simplified CRUD Operations:** With Entity Persistence, you can perform CRUD operations directly and intuitively, without dealing directly with SQL queries.

- **Exclusive SQLite Support:** The framework is specifically designed to work with SQLite databases, leveraging all its functionalities and characteristics.

## Installation

To use Entity Persistence in your Dart project, you can add it as a dependency in your `pubspec.yaml` file:

```yaml
dependencies:
  entity_persistence: ^0.1.0-alpha