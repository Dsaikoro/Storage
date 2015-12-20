#include <stdio.h>
#include <math.h>

#define N 100

int main(void)
{
  float y,ans;
  float angle, i, t, dt = 0.01;
  float wavelen = 0.1;

  for(angle = -M_PI/4.; angle < M_PI/4.; angle += M_PI/1000.){
    ans = 0;
    for(t = 0; t < 2.*M_PI ; t += dt){
      y = 0;
      for(i = 0; i < N; i++){
	y += 1./N *sin(2.*M_PI/wavelen * i/N*sin(angle) + t);
      }
      ans += y*y*dt;
    }
    printf("%f, %f\n", angle, ans);
  }
  return 0;
}
