/*** HELP START ***//*

Macro:    %dog_patrol
  Purpose:  Start patrol by enabling dataset generations. 
            The police dog begins sniffing the target dataset and 
            monitors its changes up to a specified generation limit.
 
  Parameters:
    lib=         Library containing the dataset (default=WORK).
    target=      Target dataset to patrol (REQUIRED).
    sniff_limit= Maximum number of generations to keep (default=5).
 
  Behavior:
    - If target is missing, the dog barks angrily (ERROR message).
    - Otherwise, proc datasets is used to enable generation tracking.
    - A playful message is displayed confirming patrol start.
 
  Example:
    data test;
    do X = 1 to 10;
      output;
    end;
    run;
    data wk1;
      set test;
      if X > 5 then cat="A"; else cat="B";
    run;
    %dog_patrol(target=wk1)

*//*** HELP END ***/

%macro dog_patrol(lib=work, target=, sniff_limit=5);
  %if %length(&target)=0 %then %do;
    %put ERROR: [Police Dog] BARK! BARK!! You forgot to give me a target to sniff! (target= is missing);
    %return;
  %end;

  proc datasets lib=&lib nolist;
    modify &target(genmax=&sniff_limit);
  quit;

  %put NOTE: [Police Dog] Woof! Patrol started. I am sniffing the target = &target.;

%mend;
