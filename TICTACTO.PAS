program TicTacToe;
uses Graph,crt;
var
GraphDriver: Integer;
GraphMode: Integer;
ErrorCode: Integer;
Tavola     : array[1..9] of Integer; (* Scacchiera *)

procedure DrawnSimbol(Pos:Integer;Player: Integer);
   var symbol: String;
       CoordX: Integer;
       CoordY: Integer;
       ColumnX1: Integer;
       ColumnX2: Integer;
       ColumnX3: Integer;
       RowY1: Integer;
       RowY2: Integer;
       RowY3: Integer;
begin

     symbol:='O';
     SetColor(Yellow);

     if Player=1 then
     begin
         symbol:='X';
         SetColor(Green);
     end;

     SetTextStyle(DefaultFont,HorizDir,10);
     ColumnX1:=150;ColumnX2:=275;ColumnX3:=400;
     RowY1:=50;RowY2:=185;RowY3:=RowY2+(RowY2-RowY1);


     case Pos of
          7:
          begin
               coordX:=ColumnX1;coordY:=RowY1;
          end;
          8:
          begin
               coordX:=ColumnX2;coordY:=RowY1;
          end;
          9:
          begin
               coordX:=ColumnX3;coordY:=RowY1;
          end;
          4:
          begin
               coordX:=ColumnX1;coordY:=RowY2;
          end;
          5:
          begin
               coordX:=ColumnX2;coordY:=RowY2;
          end;
          6:
          begin
               coordX:=ColumnX3;coordY:=RowY2;
          end;
          1:
          begin
               coordX:=ColumnX1;coordY:=RowY3;
          end;
          2:
          begin
               coordX:=ColumnX2;coordY:=RowY3;
          end;
          3:
          begin
               coordX:=ColumnX3;coordY:=RowY3;
          end;

     end;

     OutTextXY(coordX,coordY,symbol);

end;

function CheckVittoria(
         var Tavola     : array of Integer;
         Who            : Integer
         ): Boolean;
var resV:Boolean;
begin
    resV:=false;

    if (Tavola[0]=Who) and (Tavola[1]=Who) and (Tavola[2]=Who) then
       resV:=true;

    if (Tavola[3]=Who) and (Tavola[4]=Who) and (Tavola[5]=Who) then
       resV:=true;

    if (Tavola[6]=Who) and (Tavola[7]=Who) and (Tavola[8]=Who) then
       resV:=true;

    if (Tavola[0]=Who) and (Tavola[3]=Who) and (Tavola[6]=Who) then
       resV:=true;

    if (Tavola[1]=Who) and (Tavola[4]=Who) and (Tavola[7]=Who) then
       resV:=true;

    if (Tavola[2]=Who) and (Tavola[5]=Who) and (Tavola[8]=Who) then
       resV:=true;

    if (Tavola[0]=Who) and (Tavola[4]=Who) and (Tavola[8]=Who) then
       resV:=true;

    if (Tavola[2]=Who) and (Tavola[4]=Who) and (Tavola[6]=Who) then
       resV:=true;

    CheckVittoria:=resV;

end;

function CheckCaselleVuote(
         var Tavola     : array of Integer
         ): Integer;
var i    : Integer;
var nvuote : Integer;
begin

     nvuote:=0;

     for i := 0 to 8 do
     begin
          if (Tavola[i] =0) then
             nvuote:=nvuote+1;
     end;

     CheckCaselleVuote:=nvuote;
end;

procedure ValutaMossa(
         var Tavola     : array of Integer;
         var NVuote    : Integer;
         Who           : Integer;
         var DoveMeglio: Integer;
         var MaxVale   : Integer
         );
var
   i  : Integer;
   Vale: Integer;
   Dove: Integer;
begin

     for i := 0 to 8 do
     begin

          if (Tavola[i]=0) then (* Casella Vuota*)
          begin
               Tavola[i]:=Who;
               if (CheckVittoria(Tavola,Who))
                  then
                      Vale := NVuote (* Mossa Vincente *)
                  else if NVuote=1 then (* Rimane una sola vuota *)
                       Vale:=0
                  else  (*Situazione tutta da valutare*)
                  begin
                      Dove:=0;
                      Vale:=0;
                      (* Ricorsione *)
                      Nvuote:=Nvuote-1;
                      if (Who=1)  then
                           ValutaMossa(Tavola,Nvuote,2,Dove,Vale)
                      else
                           ValutaMossa (Tavola,Nvuote,1,Dove,Vale);
                      Vale:=-Vale;
                  end;

                   if (Vale>MaxVale) then
                   begin
                        MaxVale:=Vale;
                        DoveMeglio:=i;
                   end;

                   Tavola[i]:=0;
          end; (* Chiude if casella vuota*)

     end; (* Chiudo il ciclo *)
end;


procedure Game(N: Integer);
var ch: char;
    Giocatori  : Integer; (* Numero di giocatori: 1= Computer vs Umano*)
    Who        : Integer; (* Giocatore che deve muovere: 1(primo) o 2*)
    NVuote     : Integer; (* Numero di caselle vuote: valore 0*)
    DoveMeglio  : Integer; (* Mossa da fare da parte di Who*)
    MaxVale : Integer; (* Valore della mossa *)
    Finito     : Integer; (* -1=Init,0=gioco,1=vinto 1,2=vinto 2,3=pareggio
                          ,27= abbandono *)
    i          :Integer;
    res        :Boolean;
    NumS       :String;
begin

     Giocatori:=2;
     res:=false;

     (* Pulisco la scacchiera *)
     for i := 1 to 10 do
     begin
          Tavola[i] :=0;
     end;

     Finito:=-1;
     Who:=1;
     NVuote:=9;
     MaxVale:=-99;

     while Finito=-1 do
     begin

          NVuote:=CheckCaselleVuote(Tavola);
          DoveMeglio:=-1;
          MaxVale:=-99;

          if (NVuote=0) then
          begin
               Finito:=3;
               break;
          end;

          SetTextStyle(DefaultFont,HorizDir,2);

          SetColor(Black);
          OutTextXY(10,10,Concat('Muove il giocatore: 22222'));

          Str(Who,Nums);
          SetColor(Yellow);
          OutTextXY(10,10,Concat('Muove il giocatore: ',Nums));

          if Who = 2 then
          (* COMPUTER *)
          begin
               ValutaMossa(Tavola,NVuote,Who,DoveMeglio,MaxVale);
               delay(360);
          end;

          if who = 1 then
          begin
          (* UMANO *)
               repeat
                ch :=ReadKey;
                 case ch of
                      #55:
                      begin
                          DoveMeglio:=7;(* Numero 7*)
                          break;
                      end;
                      #56:
                      begin
                           DoveMeglio:=8; (* Numero 8*)
                           break;
                      end;
                      #57:
                      begin
                          DoveMeglio:=9; (* Numero 9*)
                          break;
                      end;
                      #52:
                      begin
                           DoveMeglio:=4;
                           break;
                      end;
                      #53:
                      begin
                          DoveMeglio:=5;
                          break;
                      end;
                      #54:
                      begin
                          DoveMeglio:=6; (* Numero 6*)
                          break;
                      end;
                      #49:
                      begin
                           DoveMeglio:=1; (* Numero 1*)
                           break;
                      end;
                      #50:
                      begin
                           DoveMeglio:=2; (* Numero 2*)
                           break;
                      end;
                      #51:
                      begin
                          DoveMeglio:=3; (* Numero 3*)
                          break;
                      end;
                      #27: Finito:=27;
                 end;
                until ch=#27;
          end;

           if ((Who=2) and (DoveMeglio>=0) and (Tavola[DoveMeglio]<>0)) then
          begin
               if Who=1 then
                  Who:=2
                  else
                  Who:=1;
          end;

          if (DoveMeglio>=0) and (Tavola[DoveMeglio]=0) then
          begin
               Tavola[DoveMeglio]:=Who;
               if (Who=2) then
                  DoveMeglio:=DoveMeglio+1;

               DrawnSimbol(DoveMeglio,Who);

               res:=CheckVittoria(Tavola,Who);


               if (res) then
                  Finito:=Who;

               if Who=1 then
                  Who:=2
                  else
                  Who:=1;
          end;


     end; (* CICLO DI GIOCO *)

     SetTextStyle(DefaultFont,HorizDir,2);
     Str(Finito,Nums);
          SetColor(Green);
          OutTextXY(10,450,Concat('**** Ha vinto il giocatore ',Nums,' ****'));
          readln;
end;

procedure DrawGameTable(N:Integer);
     var
        Xoff: Integer;
        Yoff: Integer;
        Dm:   Integer;
        Dm2:  Integer;
        Dmy:  Integer;
     begin
          Xoff := 250;
          Yoff := 30;
          Dm   := 375;
          Dm2  := 125;


          SetColor(White);
          SetLineStyle(Solidln,0,ThickWidth);
          Line(Xoff,Yoff,Xoff,Yoff+Dm);
          Line(Xoff+Dm2,Yoff,Xoff+Dm2,Yoff+Dm);

          Line(Xoff-Dm2,Yoff+Dm2,Xoff+Dm2+Dm2,Yoff+Dm2);
          Line(Xoff-Dm2,Yoff+(2*Dm2),Xoff+(2*Dm2),Yoff+(2*Dm2));

     end;



begin


     GraphDriver := Detect;
     InitGraph(GraphDriver,GraphMode,'C:\BGI');
     ErrorCode := GraphResult;

     if ErrorCode <> GrOk Then
     begin
          writeln('Errore: ',GraphErrorMsg(ErrorCode));
     end;

     DrawGameTable(1);

     Game(2);

     CloseGraph;


end.