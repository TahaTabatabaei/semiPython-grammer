parser grammar myLang;

options {
tokenVocab = MyMode;
}


// part1:                  <<parsers>>

startFile : importingLib* newClass EOF;


//----------------------<< Variables , Consts >>----------------------

variables : AccessType? (VAR | CONST) (multi) SemiColon ;
single : (Star | DoublePointer)? Name (def)? ;
multi : single (',' single)* ;

def : Colon (element | array) ;
element : DataTyps ('=' (value))? ;
array : NEW? arrayPhrase ;
arrayPhrase : 'Array' DataTyps args ;
args :'(' (multiArgs)? ')' ;
multiArgs : singleArg (',' singleArg)* ;
singleArg : value ;
/*********************************************************/

//----------------------<< import >>----------------------

importingLib : (importFrom | importImmediate | importFromDirectoryAs) SemiColon;
importFrom : FROM directory IMPORT multiLib ;
importImmediate : IMPORT multiLib ;
importFromDirectoryAs : FROM directory IMPORT directory As Name ;
multiLib : (Star | (directory (',' directory)*) ) ;
directory : Name ('.' Name)* ;
/*********************************************************/

//----------------------<< Function >>----------------------

defFunc : AccessType? return_type Name parameters '{' code? return? RBrace ;
return_type : (DataTyps | VOID) ;
parameters : '(' (multiPar)? ')' ;
multiPar : singlePar (',' singlePar)* ;
singlePar : DataTyps Name ;
return : RETURN (Name | Bool | phrase) SemiColon ;

consrtuctor: AccessType? Name parameters '{' code? RBrace ;
/*********************************************************/

//----------------------<< class >>----------------------

newClass : AccessType? CLASS Name extends? implements? '{' classCode? RBrace;
extends : EXTENDS Name ;
implements : IMPLEMENTS Name ('with' Name)* ;
classCode : (consrtuctor | variables | defFunc | makingInstant)+ ;
/*********************************************************/

//----------------------<< instantiation >>----------------------

makingInstant : AccessType? (VAR | CONST) Name Colon NEW Name objParameters SemiColon ;
objParameters : '(' (multiObjPar)? ')' ;
multiObjPar : singleObjPar (',' singleObjPar)* ;
singleObjPar : value ;
/*********************************************************/

//----------------------<< Loop >>----------------------
loop : for | itrFor | while | doWhile ;
for : FOR '(' phrase? SemiColon condition SemiColon phrase? ')' '{' code? RBrace ;
itrFor : FOR '(' Name 'in' Name ')' '{' code? RBrace ;
while : WHILE '(' condition? ')' '{' code? RBrace ;
doWhile : DO '{' code? RBrace WHILE  ;
/*********************************************************/

//----------------------<< if Conditions >>----------------------

ifStatement : if elif* else? ;
if : IF '(' condition? ')' '{' code? return? RBrace ;
elif : ELIF '(' condition? ')' '{' code? return? RBrace ;
else : ELSE '{' code? return? RBrace ;
condition: (cndPhrase ((And | Or) cndPhrase)* ) ;
cndPhrase : (cnd1 | ops) ;
cnd1 : (Not Name) | Name ;
/*********************************************************/

//----------------------<< switch >>----------------------

switch:SWITCH '(' expr? ')' '{' switchBody? RBrace;
expr: ops ;
switchBody: case* default? ;
case : CASE (value | Name) ':' code? (BREAK SemiColon)? ;
default : DEFAULT ':' code ;
/*********************************************************/

//----------------------<< Exceptions >>----------------------

try_catch : TRY '{' code? RBrace excp '{' code? RBrace ;
excp : (ON Name catchPhrase?) | catchPhrase ;
catchPhrase : CATCH '(' Name ')' ;
/*********************************************************/

code : (statement | loop | makingInstant | ifStatement | variables | switch | try_catch )+ ;

value : string | arithValue | Bool | ops ;
arithValue : ( Number | Double | SciNum) ;
string : DQOUTE stringContents* DQOUTE ;
stringContents : TEXT | ESCAPE_SEQUENCE | (Dollar_Brace (Name | ops) RBrace) ;

print : PRINT '(' string ')' ;

statement : (phrase | print) SemiColon ;
phrase : (assign | value ) ;
assign : Name equal;
//( ('=' (Name | value)) | ('+=' Name) | ('-=' Name)
//| ('/=' Name) | ( '*=' Name ) | ('^=' Name ) | ('%=' Name)
//| ('>>=' Name) | ('<<=' Name) ) ;

equal : ('=' | '+=' | '-=' | '/=' | '*=' | '^=' | '%=' | '>>=' | '<<=')
(Name | value)
;

//ops : (binaryOperandOps | unaryOprandOps | '('ops')' ) ;
ops :  '('ops')'
| Name | arithValue | unaryOprandOps ops
| inc_dec ops | ops inc_dec | ops priority1 ops
| ops priority2 ops | ops priority3 ops | ops bit ops | ops compOperands ops ;


unaryOprandOps : Not | Plus | Minus ;
inc_dec : PlusPlus | MinusMinus ;

//binaryOperandOps : ((Name | arithValue) binaryOperand (Name | arithValue)) (binaryOperand (Name | arithValue))* ;
//binaryOperand : (Star | Divide | Power | Plus | Minus | FloorDivide
// | Lt | Gt | Lteq | Gteq | ArithEq | Neq | And | Or | BitAnd | BitOr | Xor
// | LShift | RShift | Percent) ;

priority1 : Power;
priority2 : Star | Divide | FloorDivide | Percent ;
priority3 : Plus | Minus ;
compOperands : Lt | Gt | Lteq | Gteq | ArithEq | Neq | And | Or;
bit: BitAnd | BitOr | Xor | LShift | RShift ;


// part2:                  <<lexers>>



