#include <stdio.h>
#include <stdlib.h>

struct fPoint{
	float x;
	float y;
};


float sign (struct fPoint pt, struct fPoint p1, struct fPoint p2)
{
    return ((pt.x - p2.x) * (p1.y - p2.y)) - ((p1.x - p2.x) * (pt.y - p2.y));
}

int PointInTriangle (struct fPoint pt, struct fPoint v1, struct fPoint v2, struct fPoint v3)
{
    float b1, b2, b3;
	int InTriangle = 0.0;

    b1 = sign(pt, v1, v2);
    b2 = sign(pt, v2, v3);
    b3 = sign(pt, v3, v1);

	if(b1 <= 0)
		b1 = 1;

	if(b2 <= 0)
		b2 = 1;

	if(b3 <= 0)
		b3 = 1;


	if (b1 == b2 && b2 == b3){
		InTriangle = 1;
	}

    return InTriangle;
}

int main(){
	struct fPoint p1,p2,p3,pt;
	int InTriangle;
	int i, j,x,y;

	p1.x = 10;
	p1.y = 10;

	p2.x = 50;
	p2.y = 30;

	p3.x = 90;
	p3.y = 10;

	x = 35;
	y = 14;

	printf("\n");
	for(i = 99; i>=0;i--){
		if (i < 10)
			printf(" ");
		printf("%d",i);

		for(j= 0; j<100;j++){
			pt.x = j;
			pt.y = i;
			InTriangle = PointInTriangle (pt,p1,p2,p3);
			if (pt.x == x && pt.y == y){
				printf("P");
			}
			else{
				if(pt.x == p1.x && pt.y == p1.y)
				{
					printf("¹");
				}
				else
				{
					if(pt.x == p2.x && pt.y == p2.y)
					{
						printf("²");
					}
					else
					{
						if(pt.x == p3.x && pt.y == p3.y)
						{
							printf("³");
						}
						else
						{
							if (InTriangle==1)
							{
								printf("°");
							}
							else
							{
								printf(" ");
							}
						}
					}
				}
			}
		}
		printf("|\n");
	}
	printf("   123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789\n");
	printf("            10        20        30        40        50        60        70        80        90        100\n");

	pt.x = x;
	pt.y = y;

	InTriangle = PointInTriangle (pt,p1,p2,p3);
	if(InTriangle == 1){
		printf("Esta dentro do triangulo");
	}else{
		printf("Nao Esta dentro do triangulo");

	}
	printf("\n\n%d\n\n",InTriangle);
	return 0;
}
