
TYPE classprop
      name AS STRING
      value AS STRING
    END TYPE

DECLARE FUNCTION PlayerClass$ (prop$,val$,classdef() AS classprop,action$)

DECLARE FUNCTION PlayerClassExt$ (prop$,val$,classdef() AS classprop,action$)


FUNCTION PlayerClass$ (prop$,val$,classdef() AS classprop,action$)
  
    DECLARE SUB setProp$ (prop$,val$,classdef() AS classprop)
    DECLARE SUB New (classdef() AS classprop)
    DECLARE SUB Print (classdef() AS classprop)
    DECLARE FUNCTION getProp$ (prop$,classdef() AS classprop)

    SUB New(classdef() AS classprop)
          
        'creo l'oggetto con le sue proprietà
          classdef(1).name = "NAME"
          classdef(1).value = ""

          classdef(2).name = "SCORE"
          classdef(2).value = ""                   
    END SUB

    SUB Print(classdef() AS classprop)          
      PRINT "Giocatore: "+classdef(1).value
      PRINT "Punteggio: "+ classdef(2).value                   
    END SUB

    SUB setProp$(prop$,val$,classdef() AS classprop)  
        FOR i% = 1 TO 2
          IF val$ <> "" AND prop$=classdef(i%).name THEN
            classdef(i%).value = val$
            
          END IF
        NEXT i%

    END SUB
 
    FUNCTION getProp$ (prop$,classdef() AS classprop)
      
      ret$=""
      FOR i% = 1 TO 2
         IF prop$=classdef(i%).name THEN   
          ret$= classdef(i%).value
         END IF
      NEXT i%      

      getProp$=ret$
    END FUNCTION


    'Gestione Action
    IF action$="NEW" THEN
        New(classdef)       
    END IF

    IF action$="PRINT" THEN
        Print(classdef)
    END IF

    IF val$ <>"" AND prop$ <> "" THEN
        setProp$(prop$,val$,classdef)
    END IF



  PlayerClass$ = getProp$(prop$,classdef)

 

END FUNCTION


FUNCTION PlayerClassExt$ (prop$,val$,classdef() AS classprop,action$)

       DECLARE SUB NewExt (classdef() AS classprop)
       DECLARE SUB setPropExt$ (prop$,val$,classdef() AS classprop)
       DECLARE FUNCTION getPropExt$ (prop$,classdef() AS classprop)
       DECLARE SUB PrintExt (classdef() AS classprop)

      'Override del new
       SUB NewExt(classdef() AS classprop)
          
        'Richiamo la base da cui eredito
         PlayerClass$("","",classdef,"NEW")

        'Aggiungo la proprietà
          classdef(3).name = "LIFE"
          classdef(3).value = ""
                  
      END SUB

      SUB PrintExt (classdef() AS classprop)

          'Base print
          PlayerClass$("","",classdef,"PRINT")
          PRINT "Vite: "+ classdef(3).value 


      END SUB


       SUB setPropExt$(prop$,val$,classdef() AS classprop)             
                

         'Richiamo la base
         IF val$ <> "" AND prop$<>"LIFE" THEN        
          PlayerClass$(prop$,val$,classdef,"")
          
        END IF
        
        'Valorizzo la nuova
        IF val$ <> "" AND prop$="LIFE" THEN
          classdef(3).value = val$
        END IF

      END SUB

      FUNCTION getPropExt$ (prop$,classdef() AS classprop)
      
        ret$=""

        IF prop$<>"LIFE" THEN   
          ret$= PlayerClass$(prop$,"",classdef,"")
        END IF

        IF prop$="LIFE" THEN   
          ret$= classdef(3).value
        END IF

        getProp$=ret$
    END FUNCTION


     'Gestione Action
    IF action$="NEW" THEN
        NewExt(classdef)       
    END IF

     IF action$="PRINT" THEN
        PrintExt(classdef)
    END IF

    IF val$ <>"" AND prop$ <> "" THEN
        setPropExt$(prop$,val$,classdef)
    END IF



     PlayerClassExt$ = getPropExt$(prop$,classdef)

END FUNCTION




''''''' MAIN ''''''''''''''''

'Definisco l'istanza della classe con 2 proprietà
DIM  playerObj(2) AS classprop

'Creo la nuova istanza dell'oggetto
PlayerClass$("","",playerObj,"NEW")

'Valorizzo le due proprietà
PlayerClass$("NAME","Diego",playerObj,"")
PlayerClass$("SCORE","2",playerObj,"")

PRINT "********************* CREO PRIMO OGGETTO ******************"

'Invoco il metodo PRINT per stamparle
PlayerClass$("","",playerObj,"PRINT")

'modifico una proprietà
PlayerClass$("SCORE","10",playerObj,"")

PRINT "********************* MODIFICO PRIMO OGGETTO ******************"

'Invoco il metodo PRINT per stamparla
PlayerClass$("","",playerObj,"PRINT")


'Definisco l'istanza della classe con 2 proprietà
DIM  playerObjTwo(2) AS classprop

'Creo la nuova istanza dell'oggetto
PlayerClass$("","",playerObjTwo,"NEW")

'Valorizzo le due proprietà
PlayerClass$("NAME","Mario",playerObjTwo,"")
PlayerClass$("SCORE","5",playerObjTwo,"")

'Invoco il metodo PRINT per stamparle
PRINT "********************* CREO SECONDO OGGETTO ******************"
PlayerClass$("","",playerObjTwo,"PRINT")


'Definisco l'istanza della classe con 3 proprietà
DIM  playerObjVG(3) AS classprop

'Creo la nuova istanza dell'oggetto
PlayerClassExt$("","",playerObjVG,"NEW")

'Valorizzo le due proprietà
PlayerClassExt$("NAME","Metroid",playerObjVG,"")
PlayerClassExt$("SCORE","20",playerObjVG,"")
PlayerClassExt$("LIFE","10",playerObjVG,"")

'Invoco il metodo PRINT per stamparle
PRINT "********************* CREO OGGETTO CHE EREDITA DAL PRECEDENTE *********************"
PlayerClassExt$("","",playerObjVG,"PRINT")











