%{
#include <stdio.h>
#include <string.h>
int yylex();
extern int line;
extern int err;
void yyerror(const char *str)
{
fprintf(stderr, "line %d: %s\n", line, str);
}
int yywrap()
{
return 1;
}

int main()
{
  FILE *fp;
  fp = freopen("wrongsample.bmm", "r", stdin);
  yyparse();
}
%}
%token NUMBER 
%token def
%token fn
%token data
%token num
%token str
%token variable
%token dim
%token dec
%token end
%token fr
%token to
%token step
%token next
%token gto
%token ift
%token then
%token let
%token inpt
%token prt
%token rem
%token cmt
%token rtn
%token stp
%token gosub
%token strvar
%token flvar


%%
commands: /* empty */

  NUMBER line  commands
  |
  NUMBER end '\n'  {printf("\n Number of errors found is %d \n",err);}
  |
  NUMBER error '\n' {err++;printf("no statement like this found");}
  |
            {printf("\nNumber of errors found is %d \n",err);}
  ;
  

line:
end '\n'
|
def fn '=' error '\n'{err++;printf("Wrong expression syntax");}
|
def fn '=' rexp '\n'
|
data vars'\n'
|
data error'\n'{err++;printf("error in data syntax\n");}
|
dim dacs'\n' 
|
dim error'\n'  {err++;printf("error in dim statement\n");}
|
fr variable '=' rexp to rexp step rexp '\n'
|
fr variable '=' rexp to rexp  '\n'
|
fr variable '=' error'\n'  {err++;printf("wrong for loop syntax\n");}
|
next variable '\n'
|
next error '\n'  {err++;printf("wromg next statement\n");}
|
gto NUMBER '\n'
|
gto error '\n' {err++;printf("error: not number after goto statement\n");}
|
ift strvar '=' str then NUMBER '\n'
|
ift strvar '<''>'str then NUMBER '\n'
|
ift rexp then NUMBER '\n'
|
ift error '\n'    {err++;printf("error: type mismatch or syntax error in construct \'if\' in line no.%d\n",line);}
|
let strvar '=' str '\n'
|
let strvar '=' strvar '\n'
|
let flvar '=' num '\n'
|
let variable '=' rexp '\n'
|
let variable '=' str '\n'
|
let error '\n'   {err++;printf("error: let statement error\n");}
|
inpt ins '\n'
|
inpt error '\n'{err++;printf("errror at input statement");}
|
prt prti '\n'
|
prt error '\n'  {err++;printf("error: wrong syntax of print");}
|
rem '\n'
|
rem error '\n'  {err++;printf("REM comment not proper");}
|
rtn '\n'
|
rtn error '\n'  {err++;printf("nothing should be present after return statement\n");}
|
stp '\n'
|
stp error '\n'  {err++;printf("nothing shoud be present after stop statement\n");}
|
gosub NUMBER '\n'
|
gosub error '\n'   {err++;printf("numer not present after gosub");}
;
 
prti:
prtii prti
|
;

prtii:
rexp ';'
|
str ','
|
rexp ','
|
str ';'
|
str
|
rexp
;



ins:  /*for input statement*/
in ins
|
;


in:
variable ','
|
variable
|
strvar ','
|
strvar
|
dec ','
|
dec
;

dacs:
dac dacs
|
;


dac:
dec ','
|
dec
;

vars:
var vars
|
;

var:
num ','
|
str ','
|
NUMBER ','
|
NUMBER
|
num
|
str
;




rexp:
rexp '>''=' rtemp
|
rtemp
;

rtemp:
rtemp '<''=' rtmp
|
rtmp
;

rtmp:
rtmp '>' rpmp
|
rpmp
;

rpmp:
rpmp '<' rfmp
|
rfmp
;
rfmp:
rfmp '<' rgmp
|
rgmp
;

rgmp:
rgmp '<''>' rxp
|
rxp
;


rxp:
rxp '=' exp
|
exp
;


exp:
exp '+' temp
|
exp '-' temp
|
temp
;

temp:
temp '*' tmp
|
temp'/' tmp
|
tmp
;

tmp:
tmp '^' cmp
|
cmp
;

cmp:
'('cmp')'
|
NUMBER
|
variable
|
num
|
dec
;
 %%
 