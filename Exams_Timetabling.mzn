%TimeTabling Exams_CSP 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

int: A;
int: E;
int: S;
int: G;


array[1..A] of int: postiAula;
array[1..E] of 2..4: durataEsame;
array[1..S, 1..E] of 0..1: tabEsami;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

array[1..E] of var int: iscrittiEsame;

constraint forall(e in 1..E)(iscrittiEsame[e] = sum(s in 1..S)(tabEsami[s,e]));

array[1..E, 1..A] of var 0..1: auleEsame;
array[1..E] of var 1..G: giornoEsame;
array[1..E] of var 8..16: oraInizio;
array[1..E] of var 10..18: oraFine;

constraint forall(e in 1..E)(sum(i in 1..A where auleEsame[e,i] == 1)(postiAula[i]) >= iscrittiEsame[e]); %vincoloAule
constraint forall(e in 1..E)(oraFine[e] - oraInizio[e] == durataEsame[e]); %vincoloDurata
constraint forall(e,f in 1..E where e!=f)(if(giornoEsame[e] == giornoEsame[f] /\ ((oraInizio[e] < oraFine[f] /\ oraInizio[e] >= oraInizio[f]) \/ (oraInizio[f] < oraFine[e] /\ oraInizio[f] >= oraInizio[e]))) then forall(a in 1..A)(auleEsame[e,a] + auleEsame[f,a] < 2)endif); %vincoloIncastro
constraint forall(e in 1..E)(oraInizio[e] != 11 /\ oraInizio[e] != 12 /\ oraInizio[e] != 13); %vincoloOraInizio
constraint forall(e in 1..E)(if(durataEsame[e] == 4)then oraInizio[e] != 10 /\ oraInizio[e] != 9 endif); %vincoloOraInizio2
constraint forall(e,f in 1..E, s in 1..S where e!=f)(if(tabEsami[s,e] + tabEsami[s,f] == 2) 
then giornoEsame[e] != giornoEsame[f]endif); %vincoloDoppioEsame

solve satisfy ;

% output ["|Esame |  Aula1  |  Aula2  |  Aula3 |  Aula4 |  Aula5  | Giorno | Orario", "\n",
%         "| 1    |    ", show(auleEsame[1,1]), "    |    ", show(auleEsame[1,2]), "    |    ", show(auleEsame[1,3]), "   |    ", show(auleEsame[1,4]), "   |    ", show(auleEsame[1,5]), "    |    ", show(giornoEsame[1]), "   | ", show(oraInizio[1]), ":00 - ", show(oraFine[1]), ":00 \n",
%         "| 2    |    ", show(auleEsame[2,1]), "    |    ", show(auleEsame[2,2]), "    |    ", show(auleEsame[2,3]), "   |    ", show(auleEsame[2,4]), "   |    ", show(auleEsame[2,5]), "    |    ", show(giornoEsame[2]), "   | ", show(oraInizio[2]), ":00 - ", show(oraFine[2]), ":00 \n",
%         "| 3    |    ", show(auleEsame[3,1]), "    |    ", show(auleEsame[3,2]), "    |    ", show(auleEsame[3,3]), "   |    ", show(auleEsame[3,4]), "   |    ", show(auleEsame[3,5]), "    |    ", show(giornoEsame[3]), "   | ", show(oraInizio[3]), ":00 - ", show(oraFine[3]), ":00 \n",
%         "| 4    |    ", show(auleEsame[4,1]), "    |    ", show(auleEsame[4,2]), "    |    ", show(auleEsame[4,3]), "   |    ", show(auleEsame[4,4]), "   |    ", show(auleEsame[4,5]), "    |    ", show(giornoEsame[4]), "   | ", show(oraInizio[4]), ":00 - ", show(oraFine[4]), ":00 \n",
%         "| 5    |    ", show(auleEsame[5,1]), "    |    ", show(auleEsame[5,2]), "    |    ", show(auleEsame[5,3]), "   |    ", show(auleEsame[5,4]), "   |    ", show(auleEsame[5,5]), "    |    ", show(giornoEsame[5]), "   | ", show(oraInizio[5]), ":00 - ", show(oraFine[5]), ":00 \n"];
   
       
