------------------------------- MODULE TLight -------------------------------
EXTENDS Integers
VARIABLES clock, pc, out1, out2, button

Init == /\ clock = 0
        /\ pc = "G1"
        /\ out1 = "G"
        /\ out2 = "R"
        /\ button = 0
        
G1 == /\ pc = "G1"
      /\ \/  /\ clock < 30
             /\ clock' = clock + 1
             /\ button' \in {0, 1}
             /\ UNCHANGED <<pc, out1, out2>>
         \/  /\ clock = 30
             /\ clock' = 0
             /\ pc' = "Y1"
             /\ out1' = "Y"
             /\ button' = 0
             /\ UNCHANGED <<out2>>
              
              
Y1 == /\ pc = "Y1"
      /\ \/ /\ clock < 5
            /\ clock' = clock + 1
            /\ button' \in {0, 1}
            /\ UNCHANGED <<out1, out2, pc>>    
         \/ /\ clock = 5
            /\ pc' = "G2"
            /\ clock' = 0
            /\ out1' = "R"
            /\ out2' = "G"
            /\ button' = 0
        
G2 == /\ pc = "G2"
      /\ \/ /\ clock < 60
            /\ clock' = clock + 1
            /\ button' \in {0, 1}
            /\ UNCHANGED <<pc, out1, out2>>
         \/ /\ \/ clock = 60
               \/ /\ clock = 30
                  /\ button = 1
            /\ clock' = 0
            /\ pc' = "Y2"
            /\ out2' = "Y"
            /\ button' = 0
            /\ UNCHANGED <<out1>>
             
Y2 == /\ pc = "Y2"
      /\ \/ /\ clock < 5
            /\ clock' = clock + 1
            /\ button' \in {0, 1}
            /\ UNCHANGED <<out1, out2, pc>>    
         \/ /\ clock = 5
            /\ pc' = "G1"
            /\ clock' = 0
            /\ out1' = "R"
            /\ out2' = "G"
            /\ button' = 0
            
        
Next == G1 \/ Y1 \/ G2 \/ Y2

=============================================================================
\* Modification History
\* Last modified Tue Dec 17 19:57:09 CST 2019 by matthijsbrouns
\* Created Tue Dec 17 14:16:38 CST 2019 by matthijsbrouns
