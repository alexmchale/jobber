Jobber
======

## DESCRIPTION

Jobber is a tool for conducting interviews with programmers over the internet.

## JAVASCRIPT SYNCHRONIZATION

Given a patchLevel, previousData and currentData:

  1. Diff serverData and localData to generate patch1.
  2. Post patchLevel and patch1 to the server.
  3. Receive back patch2 and patchLevel.
  4. Apply patch2 to serverData.
  5. Diff serverData and localData to generate patch3.
  6. Apply patch3 to localData.

Things the editor needs to do:

  1. When a user switches the current document, all clients need to update to
     the new one.
