# Belchior Language Proposal
A new JVM programming language proposal, focused in readability, maintainability, testability and extensibility. Any part of its dictionary can be modified according to the user needs and the compilation will perform accordingly to the selected dictionary. Rules and constraints defined at this proposal are only valid for the standard version. Make it on your own :).

# Reasonings behind this proposal
- The community can evolve it in different dictionaries and flavors.
- Code maintainability is crucial.
- Code testability is a major.
- Tests are all 1st class citizens.
- Fully immutable, side-effects free.
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
  
  # Create a new behavior in the User block
  on com.domain.User define `create new user` {
    requires {
      slf4j.info as logInfo
    }
    given {
      User as user
    }
    when {
      user.name not empty
      if not user.age more than 18 {
        Error 'Only users that are older than 18 are allowed'
      }
    }
    then {
      logInfo with {
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
## Example Unit Tests
```
on com.domain.User test `Should not create a new user with <name is 'Sergio' and age less than 18> yo` {
  when {
    User.`create new user` with name, age
  }
  expects {
    Error 'Only users that are older than 18 are allowed'
  }
}

on com.domain.User test `Should not create a user when <name is empty>` {
  when {
    User.`create new user` with {
      name = name
      age = 20
    }
  }
  expects {
    Error 'user.name not empty'
  }
}

on com.domain.User test `Given a valid <name is 'Sergio' and age is 30> expects that a log call is made` {
  requires {
    mock slf4j.info as logInfo
  }
  when {
    User.`create new user` with name, age as user
  }
  expects {
    logInfo with {
      message = "Creating user ${user.name} with age ${user.age}"
    }
  }
}
```

## Constraints
1. `given` blocks should not have no more than 5 instructions by default.
2. `when` blocks should not have more than 5 instructions by default.
3. `then` blocks should not have more than 8 instructions by default.
4. `requires` blocks can be at the top-level or at the block-level.
5. Brackets can be omitted if the block have one instruction only.
6. Any block with cyclomatic complexity bigger than 4 results in build failure.
7. Behaviors not covered by unit tests results in build failures by default.
8. Mutation testing should be enabled by default.
9. If a behavior receives a single parameter, named parameters are optional. If it receives more than one parameter, it should be mandatory to use named parameters.


## Flow control statements examples
| Flow command | Statement |
|--------------|-----------|
| If statement | `if true is true { print(true) }` |
| If-else statement | `if false is true { print('never') } else { print('false is not equal to true') }` |
| for i statement | `for { 1..x.length as i } do { print(i) }` |
| for-each statement | `for { list.objects as obj } do { print(obj) } }` |

## Equality
- Structural equality should be supported using `==`
- Referential equality should be supported using `===`
- Content equality should be supported by using `equals` block call. 

## Operators
- `++` -> Increment a numeric value.
- `--` -> Decrement a numeric value.
- `and ` -> Adds a new comparison clause to the expression.
- `and not` -> Adds a new comparison clause to the expression (negative case).
- `as` -> Labels an expression.
- `more than | bigger than` -> Checks if a numeric X value is bigger than Y.
- `less than` -> Checks if a numeric X value is lower than Y.
- `is` -> Checks if the value of X is equals to Y.
- `is not` -> Checks if the value of X is not equals to Y.
- `''` -> Stores a String without interpolation.
- `""` -> Stores a string with interpolation.



