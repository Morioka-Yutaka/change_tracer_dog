/*** HELP START ***//*

Macro:    %sniffer_compare
  Purpose:  Compare the current dataset with one of its generations. 
            The police dog "sniffs" both versions to detect differences.
 
  Parameters:
    lib=        Library containing the dataset (default=WORK).
    target=     Target dataset to compare (REQUIRED).
    scent_age=  Generation number to compare against (default=-1,
                meaning the immediately previous generation).
 
  Behavior:
    - If target is missing, the dog growls angrily (ERROR message).
    - Uses PROC COMPARE to check differences between generations.
    - If &sysinfo=0 â†’ Woof! Perfect match, no differences found.
    - Otherwise â†’ Bark! Differences detected.
 
  Example:
    data wk1;
      set test;
      if X > 6 then cat="A"; else cat="B";
    run;
    %sniffer_compare(target=wk1, scent_age=-1)

*//*** HELP END ***/

%macro sniffer_compare(lib=work, target=, scent_age=-1);

  %if %length(&target)=0 %then %do;
    %put ERROR: [Police Dog] GRRR!! You forgot to give me a target to sniff! (target= is missing);
    %return;
  %end;

  %put NOTE: [Police Dog] Sniff sniff... comparing current scent of &target with generation &scent_age..;

  proc compare 
    base=&lib..&target 
    comp=&lib..&target(gennum=&scent_age)
  listall  ;
  run;

  %if &sysinfo = 0 %then %do;
    %put NOTE: [Police Dog] Woof! Perfect match. No differences found!í¶´;
  %end;
  %else %do;
    %put WARNING: [Police Dog] Bark! Bark! Differences detected in &target.;
  %end;

%mend;
