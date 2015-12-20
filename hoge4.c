#include <stdio.h>
#include <math.h>

#define N 1000

int main(void)
{
  float x, y, z, ans, l, lk, dk; 
  float angle, t, dt , i;
  float wavelen = 0.1;

  dt = 0.01;
  x = 10;

  for(angle = -M_PI/4; angle < M_PI/4.0; angle += M_PI/500.){
    ans = 0;
    z = x * tan(angle);
    l = sqrt(x*x + z*z);
    for(t = 0; t < 2*M_PI; t += dt){
      y = 0;
      for(i = 0; i < N; i++){
	lk = sqrt(x*x + (z+i/N) * (z+i/N));
	dk = lk - l;
	y += 1.0/N * sin(2*M_PI/wavelen*dk + t);
      }
      ans += y*y*dt;
    }
    printf("%f, %f\n", angle, ans);
  }
  return 0;
}
