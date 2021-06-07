grammar Belchior;

//
// Whitespace and comments
//

WS  :  [ \t\r\n\u000C]+ -> skip
    ;

COMMENT
    :   '#' ~[\r\n]* -> skip
    ;
