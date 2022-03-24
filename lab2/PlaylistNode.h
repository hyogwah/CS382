#ifndef PLAYLIST_H
#define PLAYLIST_H


typedef struct PlaylistNode_struct {
   /* Data members */
	char uniqueID[50];
	char songName[50];
	char artistName[50];
	int songLength;
	struct PlaylistNode_struct* nextNodePtr;
} PlaylistNode;

/* Function declarations */

void SetPlaylistNode(PlaylistNode* thisNode, char idInit[], char songNameInit[], char artistNameInit[], int songLengthInit);

void PrintPlaylistNode();

PlaylistNode* GetNextPlaylistNode(PlaylistNode* thisNode);
#endif
