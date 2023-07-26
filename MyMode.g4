lexer grammar MyMode ;
/***********************************************************************/
WHITESPACE : [ \t\r\n] -> skip ;
LINE_COMMENT : '~~' ~[\r\n]* -> channel(HIDDEN);
COMMENT :   '~/' .*? '/~' -> channel(HIDDEN);

/*************************************************************/
fragment IDENTIFIER: [a-zA-Z$_] ;
fragment Digit : [0-9];
//fragment StartingLegalCharacters : [a-zA-Z$_] ;
//fragment NameLegalChars : [a-zA-Z$_0-9] ;

fragment A : ('A' | 'a') ;
fragment V : ('V' | 'v') ;
fragment R : ('R' | 'r') ;
fragment C : ('C' | 'c') ;
fragment O : ('O' | 'o') ;
fragment S : ('S' | 's') ;
fragment N : ('N' | 'n') ;
fragment T : ('T' | 't') ;
fragment B : ('B' | 'b') ;
fragment E : ('E' | 'e') ;
fragment K : ('K' | 'k') ;
fragment I : ('I' | 'i') ;
fragment M : ('M' | 'm') ;
fragment P : ('P' | 'p') ;
fragment W : ('W' | 'w') ;
fragment F : ('F' | 'f') ;
fragment X : ('X' | 'x') ;
fragment L : ('L' | 'l') ;
fragment Y : ('Y' | 'y') ;
fragment H : ('H' | 'h') ;
fragment U : ('U' | 'u') ;
fragment D : ('D' | 'd') ;
fragment G : ('G' | 'g') ;

DataTyps : (INT | DOUBLE | String | FLOAT | BOOLEAN );
AccessType : (PUBLIC | PRIVATE | PROTECTED) ;

VAR : V A R ;
DEFAULT : D E F A U L T ;
BREAK : B R E A K ;
CASE : C A S E ;
CONST : C O N S T ;
NEW : N E W ;
IMPORT : I M P O R T ;
FROM : F R O M ;
EXTENDS : E X T E N D S;
IMPLEMENTS : I M P L E M E N T S ;
CLASS : C L A S S ;
TRY : T R Y ;
CATCH : C A T C H ;
INT : I N T ;
DOUBLE : D O U B L E ;
String : S T R I N G ;
FLOAT : F L O A T ;
BOOLEAN : B O O L E A N ;
PUBLIC : P U B L I C ;
PROTECTED : P R O T E C T E D ;
PRIVATE : P R I V A T E ;
IF : I F ;
ELIF : E L I F;
ELSE : E L S E;
FOR : F O R ;
WHILE : W H I L E ;
DO : D O ;
VOID : V O I D;
RETURN : R E T U R N ;
SWITCH : S W I T C H;
PRINT : P R I N T;


LP : '(' ;
RP : ')' ;
Colon : ':' ;
SemiColon: ';' ;
Comma: ',' ;
Equal: '=' ;
Star : '*' ;
As : '=>' ;
Power : '^' ;
Minus : '-' ;
Plus : '+' ;
Not : '!' | 'not' ;
Bool : 'false' | 'true' ;
Divide : '/' ;
FloorDivide : '//' ;
Lteq : '<=' ;
Gteq : '>=' ;
Lt : '<' ;
Gt : '>' ;
ArithEq : '==' ;
Neq : '!=' | '<>' ;
And : '&&' | 'and' ;
Or : '||' | 'or';
BitAnd : '&' ;
BitOr : '|' ;
LShift : '<<' ;
RShift : '>>' ;
Xor : '^^' ;
Percent : '%' ;
DoublePointer : '**' ;
PlusPlus : '++' ;
MinusMinus : '--' ;
Plus_E : '+=' ;
Minus_E : '-=' ;
Divide_E : '/=' ;
Star_E : '*=' ;
Power_E : '^=' ;
Percent_E : '%=' ;
LShift_E : '>>=' ;
RShift_E : '<<=' ;
Dot : '.' ;
LBrace : '{' ;
RBrace : '}' ;
Array : 'Array' ;
IN : 'in' ;
ON : 'on' ;
WITH : 'with' ;

//DQOUTE : '"' ;


Number : Digit+;
Double : Number? ( [.] Number ) ;
SciNum : Digit? '.' Number 'e'[-+] Number;

Name : IDENTIFIER [a-zA-Z0-9$_]+ ;

/******************************************************/
LInterpol: '${';
DQOUTE: '"' -> pushMode(STRING);


mode STRING;
TEXT: ~[$\\"]+ ;
Dollar_Brace: '${' -> pushMode(INTERPOLATION);
ESCAPE_SEQUENCE: '}' . ;
DQUOTE_IN_STRING: '"' -> type(DQOUTE), popMode;

mode INTERPOLATION;
WS : [ \t\r\n] -> skip ;
I_IDENTIFIER: [a-zA-Z_][a-zA-Z0-9$_]* -> type(Name);
I_Dquote: '"' -> pushMode(STRING), type(DQOUTE);
I_LInterpol: '${' -> type(LInterpol), pushMode(INTERPOLATION);
I_RInterpol: '}' -> type(RBrace), popMode;

//RInterpol: '}';

