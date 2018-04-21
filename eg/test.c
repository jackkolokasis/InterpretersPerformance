#include <stdio.h> 
int main ()
{
	int c;
	int     i, j;

	for (i=0; i<2000; i++) {
		for (j=0; j<2000; j++) {
			c++;
		}
	}
	return c;

}
