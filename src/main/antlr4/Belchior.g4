grammar Belchior;

// Parser rules
start : stmt '\n' ;

stmt : expr COMMENT? ;  // A statement can be an expression optionally followed by a comment

expr : expr '+' term #Addition
     | expr '-' term #Subtraction
     | term         #SimpleTerm
     ;

term : term '*' factor #Multiplication
     | term '/' factor #Division
     | factor          #SimpleFactor
     ;

factor : number         #SimpleNumber
       | '(' expr ')'   #ParenExpr
       ;

// Lexer rules
number : FLOAT | INT ;
COMMENT : '#' ~('\n')* -> skip ; // Consumes everything after '#' until a newline, and skips it

// Tokens
FLOAT :   '-'? INT '.' INT ;
INT   :   '-'? DIGIT+ ;
PLUS  :   '+' ;
MINUS :   '-' ;
MUL   :   '*' ;
DIV   :   '/' ;
LPAREN:   '(' ;
RPAREN:   ')' ;

fragment DIGIT : [0-9] ; // a helper rule that matches a single digit