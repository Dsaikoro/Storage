#include <stdio.h>
#include <math.h>

int main(void)
{
  float y,ans;
  float angle = 0;
  int i,n;
  float t,dt=0.01;
  float wavelen = 0.1;
  float k=3;

  n = 100;
  for(angle = -M_PI/4.0; angle < M_PI/4.0; angle += M_PI/1000.){
    ans = (k * sin(M_PI/wavelen*sin(angle)) * sin(M_PI/wavelen*sin(angle))) / ( (M_PI/wavelen*sin(angle)) * (M_PI/wavelen*sin(angle)));
    printf("%f, %f\n", angle, ans);
  }
  return 0;
}
