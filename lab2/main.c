#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "PlaylistNode.h"

void PrintMenu(char playlistTitle[]) {
   printf("%s PLAYLIST MENU\n", playlistTitle);
   printf("a - Add song\n");
   printf("r - Remove song\n");
   printf("o - Output full playlist\n");
   printf("q - Quit\n\n");
}

PlaylistNode* ExecuteMenu(char option, char playlistTitle[], PlaylistNode* headNode) {
   switch (option) {
      case 'a':
         break;

      case 'r':
         /* Remove a song */
         break;

      case 'o':
         printf("%s - OUTPUT FULL PLAYLIST\n", playlistTitle);
         printf("Playlist is empty\n\n");
         break;
   }
   return 0;
}

int main(void) {
   // Prompt user for playlist title
   printf("Enter playlist's title:\n");
   char playlistTitle[50];
   fgets(playlistTitle, 50, stdin);
   printf("\n");
   char menuOp;
   // Eliminate end-of-line char
   playlistTitle[strlen(playlistTitle) - 1] = '\0';

   // Output play list menu options
   PrintMenu(playlistTitle);

   while(menuOp != 'q') {
      printf("Choose an option:\n");
      scanf(" %c", &menuOp);
      if (menuOp == 'a' || menuOp == 'r' || menuOp == 'o') {
         PlaylistNode* headNode = ExecuteMenu(menuOp, playlistTitle, headNode);
         PrintMenu(playlistTitle);
      }
   }

   return 0;
}

// PN* newNode = (PN*)malloc(sizeof(PN));
// newNode -> next=NULL;
// tailNode -> next=newNode;
// tailNode = newNode;

// removing -> free()