#include <stdio.h>
#include <math.h>

int main(void)
{
  float y,ans;
  float angle = 0;
  int i,n;
  float t,dt=0.01;
  float wavelen = 0.1;

  n = 1000;
  for(angle = -M_PI/4.0; angle < M_PI/4.0; angle += M_PI/1000.){
    ans = 0;
    for(t = 0; t < 2*M_PI ; t += dt){
      y = 0;
      for(i = 0; i < n; i++){
	y += 1.0/n *sin(2*M_PI/wavelen * i/n*sin(angle) + t);
      }
      ans += y*y*dt;
    }
    printf("%f, %f\n", angle, ans);
  }
  return 0;
}
