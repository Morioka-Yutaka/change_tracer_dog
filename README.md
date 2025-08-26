# change_tracer_dog
change_tracer_dog A SAS macro package that behaves like a police dog: tracing dataset changes, sniffing out differences, and stopping patrol when the mission is complete.

<img width="360" height="360" alt="Image" src="https://github.com/user-attachments/assets/03cdeda9-1626-4fb3-9d53-bb4cce8b0255" />


Example:
~~~sas
data test;
do X = 1 to 10;
  output;
end;
run;

data wk1;
  set test;
  if X > 5 then cat = "A";
  else cat="B";
run;
%dog_patrol(target=wk1)
~~~

<img width="668" height="30" alt="Image" src="https://github.com/user-attachments/assets/f3e50028-86b1-458f-a6f6-7a4264cd672c" />  

~~~sas
data wk1;
  set test;
  if X > 6 then cat = "A";
  else cat="B";
run;
~~~

<img width="353" height="411" alt="Image" src="https://github.com/user-attachments/assets/5c802cdc-4243-401b-92e2-80a8aed795ca" />  

~~~sas
 %sniffer_compare(target=wk1, scent_age=-1);
~~~

<img width="378" height="198" alt="Image" src="https://github.com/user-attachments/assets/39d2550d-d39b-4748-bcc8-ab78bb780d95" />  
</br>
  
<img width="400" height="32" alt="Image" src="https://github.com/user-attachments/assets/09f98131-6ba0-407c-91c9-928280d1f876" />      

## `%dog_patrol()` macro <a name="dogpatrol-macro-2"></a> ######
  Purpose:  Start patrol by enabling dataset generations. The police dog begins sniffing the target dataset and monitors its changes up to a specified generation limit.  

<img width="120" height="144" alt="Image" src="https://github.com/user-attachments/assets/af6303cd-45b6-49d8-b19b-51cc74c1f605" />
   
  Parameters:  
~~~text  
    lib=         Library containing the dataset (default=WORK).
    target=      Target dataset to patrol (REQUIRED).
    sniff_limit= Maximum number of generations to keep (default=5).
 ~~~
  Behavior:
    - If target is missing, the dog barks angrily (ERROR message).
    - Otherwise, proc datasets is used to enable generation tracking.
    - A playful message is displayed confirming patrol start.
 
  Example:  
~~~sas
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
~~~

<img width="668" height="30" alt="Image" src="https://github.com/user-attachments/assets/f3e50028-86b1-458f-a6f6-7a4264cd672c" />  

~~~sas
data wk1;
  set test;
  if X > 6 then cat = "A";
  else cat="B";
run;
~~~

<img width="353" height="411" alt="Image" src="https://github.com/user-attachments/assets/5c802cdc-4243-401b-92e2-80a8aed795ca" />  


---

## `%sniffer_compare()` macro <a name="sniffercompare-macro-4"></a> ######
  Purpose:  Compare the current dataset with one of its generations. The police dog "sniffs" both versions to detect differences.  
 <img width="115" height="111" alt="Image" src="https://github.com/user-attachments/assets/ac863df5-4540-44e0-b34f-4b2442d959e4" />  
 
  Parameters:
  ~~~text
    lib=        Library containing the dataset (default=WORK).
    target=     Target dataset to compare (REQUIRED).
    scent_age=  Generation number to compare against (default=-1,
                meaning the immediately previous generation).
 ~~~
  Behavior:  
    - If target is missing, the dog growls angrily (ERROR message).  
    - Uses PROC COMPARE to check differences between generations.  
    - If &sysinfo=0 → Woof! Perfect match, no differences found.  
    - Otherwise → Bark! Differences detected.  
   
  Example:  
~~~sas
    data wk1; 
      set test;  
      if X > 6 then cat="A"; else cat="B";  
    run;  
    %sniffer_compare(target=wk1, scent_age=-1)
~~~

<img width="378" height="198" alt="Image" src="https://github.com/user-attachments/assets/39d2550d-d39b-4748-bcc8-ab78bb780d95" />  
</br>
  
<img width="400" height="32" alt="Image" src="https://github.com/user-attachments/assets/09f98131-6ba0-407c-91c9-928280d1f876" />   

---
 
## `%patrol_end()` macro <a name="patrolend-macro-3"></a> ######
  Purpose:  End patrol by resetting generation tracking. The police dog stops monitoring and returns to the kennel.  
  
 <img width="100" height="120" alt="Image" src="https://github.com/user-attachments/assets/9638a978-8e3b-4bd3-80e5-ad9e13bcce09" />  
 
 
  Parameters:  
  ~~~text
    lib=     Library containing the dataset (default=WORK).
    target=  Target dataset to stop patrolling (REQUIRED).
 ~~~
  Behavior:  
    - If target is missing, the dog growls (ERROR message).  
    - Otherwise, proc datasets resets GENMAX=0 to disable generations.  
    - Displays a message confirming the patrol has ended.  
   
  Example:  
~~~sas
    %patrol_end(target=wk1)
~~~

<img width="700" height="36" alt="Image" src="https://github.com/user-attachments/assets/434fbab1-1aca-4c3b-bf5a-e152b14f1a52" />  


  
---

