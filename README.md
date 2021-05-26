# Belchior Language Proposal
A new JVM programming language proposal, focused in readability, maintainability and testability.

# Reasonings behind this proposal
- Code maintainability is crucial.
- Code testability is a major.
- Everything should be fully immutable, side-effects free.
- No static methods.
- No classes.
- No inheritance.
- Null is not allowed.
- No global variables.
- No reflection.
- No annotations.

## Example Belchior program
```
  # Creating a new block in the namespace com.domain
  on com.domain define User {
    attributes {
      name -> String
      age -> String
    }
  }
  
  # Create a new behavior-block in the User block
  on com.domain.User define `create new user` {
    requires {
      slf4j.info
    }
    given {
      User -> user
    }
    when {
      user.name not empty
      if not user.age more than 18 {
        Error "Only users that are older than 18 are allowed"
      }
    }
    then {
      slf4j.info with {
        message = "Creating user ${user.name} with age ${user.age}"
      }
    }
  }
  
  start {
    User.`create new user` with {
      name = "Sergio"
      age = 32
    }
  }
```

## Constraints
1. `given` blocks can have no more than 5 instructions by default.
2. `when` blocks can have no more than 5 instructions by default.
3. `then` blocks can have no more than 10 instructions by default.
4. `requires` blocks can be top-level or block-level.
5. Brackets can be omitted if the block have one instruction only.
6. Any block with cyclomatic complexity bigger than 4 results in build failure.

## Flow control statements examples
|--------------------------|
| Flow command | Statement |
|--------------|-----------|
| If statement | `if <clause> {}` |
| If-else statement | `if <clause> {} else {}` |
| for i statement | `for 1..x.length {}` |
| for-each statement | `for each in x {}` |
|--------------------------|
