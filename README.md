# Belchior Language Proposal
A new programming language proposal based on JVM, focused in readability, maintainability, testability and extensibility. Any part of its dictionary can be modified according to the community needs and the compilation will perform accordingly to the selected dictionary. Rules and constraints defined at this proposal are only valid for the standard version. Make it on your own :).

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
  # Comments are always made starting with #
  # Creating a new block and behavior in the namespace com.domain
  on com.domain.User def `create new user` {
    given age < 18 {
      `user should accept use terms`
    } then {
      log.info with "Creating user ${name} with age ${age}"
    } test {
      with User.`create new user` with name = "Sergio" and age = 32 {
        `user should accept use terms` was called
      }
    }
  }

  on com.domain.User def `user should accept use terms` {
  ...
  }
  
  start {
    User.`create new user` with name = "Sergio" and age = 32 
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
9. If a behavior receives a single parameter, named parameters are optional. If it receives more than one parameter, it should be mandatory to use named parameters.
10. Behaviors should have given/when/then blocks by default.

## Equality
- Structural and Referential equality should be supported using `==`

## Operators
- `=` -> Assigns a value
- `+` -> Sum up two or more values, example: + 1,5,7 would result in 13.
- `++` -> Increment a numeric value.
- `--` -> Decrement a numeric value.
- `a` -> Adds a new comparison clause to the expression.
- `an` -> Adds a new comparison clause to the expression (negative case).
- `as` -> Labels an expression.
- `mt | bt` -> Checks if a numeric X value is bigger than Y.
- `lt` -> Checks if a numeric X value is lower than Y.
- `is` -> Checks if the value of X is equals to Y.
- `isnot` -> Checks if the value of X is not equal to Y.
- `""` -> Stores a String with or without string interpolation.



