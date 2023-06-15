%{
#include <stdio.h>
#include "y.tab.h"
int line=0;
int total=0;
int lf=0;
int endf=0;
int f=0;
int ren=0; 
int checkr=0;
int cend=0;
int err=0;
%}
%%
[0-9]+ {if(lf==0){line=atoi(yytext);lf=1;};if(endf==1 && cend==1){err++;printf("END not at last ,statemenet no. %d\n",line -10);cend=0;}return NUMBER;}
[A-Z]\$   {return strvar;}
[A-Z]\!   {return flvar;}
DEF {return def;}
FN[A-Z]"("([A-Z]|[A-Z][0-9])")" {return fn;}
FN[A-Z]  { return fn;}
DATA {return data;}
END {endf=1;cend=1;return end;}
FOR {f++;return fr;}
TO   {return to;}
STEP {return step;}
NEXT   {f--;return next;}
GOTO   {return gto;}
IF   {return ift;}
THEN   {return then;}
LET    {return let;}
INPUT   {return inpt;}
GOSUB  {ren++;return gosub; }
REM(.)*    { return rem;}
PRINT   {return prt;}
([0-9]+|[0-9]+"."[0-9]+) {return num;}
","  {return *yytext;}
DIM  { return dim;}
RETURN   {ren--;return rtn;}
STOP   {return stp;}
([A-Z]|[A-Z][0-9]) {return variable;}
\"(.)*\"  {return str;}/* dont know how to scan " */
[A-Z]"("[0-9]+")"   {return dec;}
[A-Z]"("[0-9]+","[0-9]+")"    {return dec;}
[A-Z]"("[A-Z]")"    {return dec;}
[A-Z]"("([A-Z]|[0-9])","([A-Z]|[0-9])")"   {return dec;}
[+]  {return *yytext;}
";"   { return *yytext;}
[-]  {return *yytext;}
[*]  {return *yytext;}
[/]  {return *yytext;}
[=]  {return *yytext;}
[<]    {return *yytext;}
[>]  {return *yytext;}
"^"   {return *yytext;}
[\n]  {lf=0;if(f<0){err++;printf("error: TOO many nexts\n");}if(ren<0 && checkr==0){err++;printf("error: TOO many returns\n");checkr=1;}return *yytext;}
[\t]  {err++;printf("tab found\n");}
[ ]   ;/*ignore spaces*/

.   {err++;printf("error: wrong lexical token found in the statement number %d\n",line);}
%%
    

