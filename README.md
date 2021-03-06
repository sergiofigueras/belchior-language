# Belchior Language Proposal
A new JVM programming language proposal, focused in readability, maintainability, testability and extensibility. Any part of its dictionary can be modified according to the community needs and the compilation will perform accordingly to the selected dictionary. Rules and constraints defined at this proposal are only valid for the standard version. Make it on your own :).

# Reasonings behind this proposal
- Code maintainability is crucial. (https://www.coveros.com/13-ways-to-improve-maintainability/)
- Code testability is a major. (https://en.wikipedia.org/wiki/Software_testability)
- Testing is mandatory. (https://stackoverflow.com/questions/90002/what-is-a-reasonable-code-coverage-for-unit-tests-and-why / https://github.com/theofidry/awesome-mutation-testing)
- Focus on immutability, side-effects free (https://elizarov.medium.com/immutability-we-can-afford-10c0dcb8351d).
- No global methods or variables (https://www.yegor256.com/2014/05/05/oop-alternative-to-utility-classes.html).
- Blocks and behaviors instead of classes and methods. (https://dl.acm.org/doi/10.1145/359576.359579)
- Null is not allowed. (https://www.infoq.com/presentations/Null-References-The-Billion-Dollar-Mistake-Tony-Hoare/)
- No reflection. (https://medium.com/the-telegraph-engineering/mirror-gazing-a-closer-look-at-the-good-and-bad-sides-of-java-reflection-884f65a4ef20)
- No annotations. (https://www.yegor256.com/2016/04/12/java-annotations-are-evil.html)

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
on com.domain.User test `Should not create a new user with <name is 'Sergio' and age is 17> yo` {
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
    spy slf4j.info as logInfo
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
0. `given`, `when` and `then` blocks are mandatory.
1. `given` blocks should not have no more than 5 instructions by default.
2. `when` blocks should not have more than 5 instructions by default.
3. `then` blocks should not have more than 8 instructions by default.
4. `requires` blocks can be at the top-level or at the block-level.
5. Brackets can be omitted if the block have one instruction only.
6. Any block with cyclomatic complexity bigger than 4 results in build failure.
7. Behaviors not covered by unit tests results in build failures by default.
8. Mutation testing should be enabled by default.
9. If a behavior receives a single parameter, named parameters are optional. If it receives more than one parameter, it should be mandatory to use named parameters.
10. Behaviors should have given/when/then blocks by default.

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
- `less than | lower than` -> Checks if a numeric X value is lower than Y.
- `is` -> Checks if the value of X is equals to Y.
- `is not` -> Checks if the value of X is not equals to Y.
- `''` -> Stores a String without interpolation.
- `""` -> Stores a string with interpolation.



