/*** HELP START ***//*

Macro:    %patrol_end
  Purpose:  End patrol by resetting generation tracking. 
            The police dog stops monitoring and returns to the kennel.
 
  Parameters:
    lib=     Library containing the dataset (default=WORK).
    target=  Target dataset to stop patrolling (REQUIRED).
 
  Behavior:
    - If target is missing, the dog growls (ERROR message).
    - Otherwise, proc datasets resets GENMAX=0 to disable generations.
    - Displays a message confirming the patrol has ended.
 
  Example:
    %patrol_end(target=wk1)

*//*** HELP END ***/

%macro patrol_end(lib=work, target=);

  %if %length(&target)=0 %then %do;
    %put ERROR: [Police Dog] GRRR!! No target specified to finish patrol! (target= is missing);
    %return;
  %end;

  proc datasets lib=&lib nolist;
    modify &target(genmax=0);
  quit;

  %put NOTE: [Police Dog] Patrol finished for &target. Woof! Generation tracking stopped. í°¾;

%mend;
