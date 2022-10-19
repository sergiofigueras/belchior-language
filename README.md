# Belchior Language Proposal
A new programming language proposal based in LLVM, focused in readability, maintainability, testability and extensibility. Any part of its dictionary can be modified according to the community needs and the compilation will perform accordingly to the selected dictionary. Rules and constraints defined at this proposal are only valid for the standard version. Make it on your own :).

# Reasonings behind this proposal
- Code maintainability is crucial. (https://www.coveros.com/13-ways-to-improve-maintainability/)
- Code testability is a major. (https://en.wikipedia.org/wiki/Software_testability)
- Testing is mandatory. (https://stackoverflow.com/questions/90002/what-is-a-reasonable-code-coverage-for-unit-tests-and-why / https://github.com/theofidry/awesome-mutation-testing)
- Focus on immutability, side-effects free (https://elizarov.medium.com/immutability-we-can-afford-10c0dcb8351d).
- No global methods or variables (https://www.yegor256.com/2014/05/05/oop-alternative-to-utility-classes.html).
- Blocks and behaviors instead of classes and methods. (https://dl.acm.org/doi/10.1145/359576.359579)
- Null is not allowed. (https://www.infoq.com/presentations/Null-References-The-Billion-Dollar-Mistake-Tony-Hoare/)
- No annotations. (https://www.yegor256.com/2016/04/12/java-annotations-are-evil.html)

## Example Belchior program
```
  # Creating a new block in the namespace com.domain
  on com.domain def User {
    attrs {
      name, age
    }    
  }
  
  # Create a new behavior in the User block
  on com.domain.User def `create new user` {
    req {
      log.info
    }
    when {
      age less than 18 {
        raise ${condition}
      }
    }
    then {
      log.info with message = "Creating user ${name} with age ${age}"
    }
  }
  
  start {
    User.`create new user` with name = "Sergio" and age = 32
  }
```
## Example Unit Tests
```
on com.domain.User test "Create new user should fail if its younger than 18yo" {
  when {
    User.`create new user` with name = 'Sergio' and age = 17
  }
  expects {
    raised 'age less than 18'
  }
}

on com.domain.User test "Given a valid user expects that a log.info call is made" {
  when {
    User.`create new user` with name = 'Sergio' and age = 30
  }
  expects {
    executed log.info with message = "Creating user with age 30"
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

## Equality
- Structural equality should be supported using `==`
- Referential equality should be supported using `===`
- Content equality should be supported by using `equals` block call. 

## Operators
- `=` -> Assigns a value
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



