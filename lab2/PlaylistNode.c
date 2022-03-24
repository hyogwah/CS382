#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "PlaylistNode.h"

void SetPlaylistNode(PlaylistNode* thisNode, char idInit[], char songNameInit[], char artistNameInit[], int songLengthInit) {
	strcpy(thisNode->uniqueID, idInit);
	strcpy(thisNode->songName, songNameInit);
	strcpy(thisNode->artistName, artistNameInit);
	thisNode->songLength = songLengthInit;
	thisNode->nextNodePtr = NULL;
}

void PrintPlaylistNode(PlaylistNode* thisNode) {
	printf("Unique ID: %s\n", thisNode->uniqueID);
	printf("Song Name: %s\n", thisNode->songName);
	printf("Arist Name: %s\n", thisNode->artistName);
	printf("Song Length (in seconds): %d\n", thisNode->songLength);
}

PlaylistNode* GetNextPlaylistNode(PlaylistNode* thisNode) {
	return thisNode->nextNodePtr;
}