/*
% cc -O ediff.c -o ediff && strip ediff

   ediff - translate diff output into plain English

   Translates only the normal diff output (not -c or -e/-f).
   Use as a filter.  Copies non-diff lines verbatim.  Deletes NULs.

   The Unix variant that runs on our Charles River Data Systems
   machines, UNOS, comes with, in addition to the standard diff program,
   a program called "difference" that produces more human-readable
   output.  Ediff provides the advantages of that program to users of other
   versions of Unix (soon to include us, as we're hoping to get rid of
   the CRDS machines before too long).

   Thanks to Mike Haertel for the following information.
   The exact meaning of the normal diff symbols is as follows
   (all line numbers are the ORIGINAL line numbers in each file):

   	5,7c8,10
   Change lines 5-7 of file 1 to read as lines 8-10 of file 2 (or, if changing
   file 2 into file 1, change lines 8-10 of file 2 to read as lines 5-7
   of file 1).

   	5,7d3
   Delete lines 5-7 of file 1 (alternatively, append lines 5-7 of file 1
   after line 3 of file 2).

   	8a12,15
   Append lines 12-15 of file 2 after line 8 of file 1 (alternatively,
   delete lines 12-15 of file 2).

   David MacKenzie
   edf@rocky2.rockefeller.edu

   Latest revision: 12/30/88 */

#include <stdio.h>

/* Magic value meaning that a line number is missing from the input. */
#define UNUSED -1L

#ifdef __STDC__
#define P(x) x
#else
#define P(x) ()
#endif

void exit P((int));

void change P ((long, long, long, long));
void delete P ((long, long, long));
void append P ((long, long, long));
void copylines P ((long, int));
int readline P ((char *, int, FILE *));

char line[BUFSIZ];		/* Input line. */

main ()
{
  long f1n1, f1n2, f2n1, f2n2;	/* File 1, line number 1; etc. */
  int result;			/* Result of readline. */

  for (;;)
    {
      result = readline (line, BUFSIZ, stdin);
      f1n2 = f2n2 = UNUSED;
      if
	(sscanf (line, "%ld,%ldc%ld,%ld\n", &f1n1, &f1n2, &f2n1, &f2n2) == 4 ||
	sscanf (line, "%ld,%ldc%ld\n", &f1n1, &f1n2, &f2n1) == 3 ||
	sscanf (line, "%ldc%ld,%ld\n", &f1n1, &f2n1, &f2n2) == 3 ||
	sscanf (line, "%ldc%ld\n", &f1n1, &f2n1) == 2)
	change (f1n1, f1n2, f2n1, f2n2);
      else if
	  (sscanf (line, "%ld,%ldd%ld\n", &f1n1, &f1n2, &f2n1) == 3 ||
	sscanf (line, "%ldd%ld\n", &f1n1, &f2n1) == 2)
	delete (f1n1, f1n2, f2n1);
      else if
	  (sscanf (line, "%lda%ld,%ld\n", &f1n1, &f2n1, &f2n2) == 3 ||
	sscanf (line, "%lda%ld\n", &f1n1, &f2n1) == 2)
	append (f1n1, f2n1, f2n2);
      else
	{
	  /* The line wasn't the start of a diff.  Copy it verbatim. */
	  fputs (line, stdout);
	  /* If it was a long line, copy the remainder. */
	  while (result == -1)
	    {
	      result = readline (line, BUFSIZ, stdin);
	      fputs (line, stdout);
	    }
	}
    }
}

void change (f1n1, f1n2, f2n1, f2n2)
  long f1n1, f1n2, f2n1, f2n2;
{
  printf ("\n-------- ");
  if (f1n2 == UNUSED && f2n2 == UNUSED)
    /* 1c1 */
    printf ("1 line changed at %ld from:\n",
      f1n1);
  else if (f1n2 == UNUSED)
    /* 1c1,2 */
    printf ("1 line changed to %ld lines at %ld from:\n",
      f2n2 - f2n1 + 1L, f1n1);
  else if (f2n2 == UNUSED)
    /* 1,2c1 */
    printf ("%ld lines changed to 1 line at %ld-%ld from:\n",
      f1n2 - f1n1 + 1L, f1n1, f1n2);
  else if (f1n2 - f1n1 == f2n2 - f2n1)
    /* 1,2c1,2 */
    printf ("%ld lines changed at %ld-%ld from:\n",
      f1n2 - f1n1 + 1L, f1n1, f1n2);
  else
    /* 1,2c1,3 */
    printf ("%ld lines changed to %ld lines at %ld-%ld from:\n",
      f1n2 - f1n1 + 1L, f2n2 - f2n1 + 1L, f1n1, f1n2);

  if (f1n2 == UNUSED)
    copylines (1L, 2);		/* Skip the "< ". */
  else
    copylines (f1n2 - f1n1 + 1L, 2);

  printf ("-------- to:\n");
  (void) readline (line, BUFSIZ, stdin);	/* Eat the "---" line. */
  if (f2n2 == UNUSED)
    copylines (1L, 2);		/* Skip the "> ". */
  else
    copylines (f2n2 - f2n1 + 1L, 2);
}

/* ARGSUSED */
void delete (f1n1, f1n2, f2n1)
  long f1n1, f1n2, f2n1;
{
  printf ("\n-------- ");
  if (f1n2 == UNUSED)
    {
      /* 1d1 */
      printf ("1 line deleted at %ld:\n", f1n1);
      copylines (1L, 2);	/* Skip the "< ". */
    }
  else
    {
      /* 1,2d1 */
      printf ("%ld lines deleted at %ld:\n", f1n2 - f1n1 + 1L, f1n1);
      copylines (f1n2 - f1n1 + 1L, 2);
    }
}

void append (f1n1, f2n1, f2n2)
  long f1n1, f2n1, f2n2;
{
  printf ("\n-------- ");
  if (f2n2 == UNUSED)
    {
      /* 1a1 */
      printf ("1 line added at %ld:\n", f1n1);
      copylines (1L, 2);	/* Skip the "> ". */
    }
  else
    {
      /* 1a1,2 */
      printf ("%ld lines added at %ld:\n", f2n2 - f2n1 + 1L, f1n1);
      copylines (f2n2 - f2n1 + 1L, 2);
    }
}

/* Copy nlines lines from stdin to stdout; start writing at position skip. */

void copylines (nlines, skip)
  long nlines;
  int skip;
{
  int result;

  while (nlines-- > 0L)
    {
      result = readline (line, BUFSIZ, stdin);
      fputs (&line[skip], stdout);
      /* If it was a long line, copy the remainder. */
      while (result == -1)
	{
	  result = readline (line, BUFSIZ, stdin);
	  fputs (line, stdout);
	}
    }
}

/* Front end to fgets.
   Exit if EOF; return 1 if end of line read, -1 if partial line read. */

int readline (s, length, fp)
  char *s;
  int length;
  FILE *fp;
{
  if (!fgets (s, length, fp))
    exit (0);
  if (s[strlen (s) - 1] == '\n')
    return 1;
  else
    return -1;
}
