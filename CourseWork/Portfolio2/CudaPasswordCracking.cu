#include <stdio.h>
#include <cuda_runtime_api.h>
#include <time.h>

// nvcc -o CudaPasswordCracking CudaPasswordCracking.cu

__device__ int passcrack(char *crack){

   char pass1[]="SH2973";
   char pass2[]="KR3097";
   char pass3[]="PK9736";
   char pass4[]="BM4397";

   char *s1 = crack;
   char *s2 = crack;
   char *s3 = crack;
   char *s4 = crack;

   char *p1 = pass1;
   char *p2 = pass2;
   char *p3 = pass3;
   char *p4 = pass4;

   while(*s1 == *p1){
    
       if(*s1 == '\0'){
          return 1;
       }
       s1++;
       p1++;
   }
   
    while(*s2 == *p2){
    
       if(*s2 == '\0'){
          return 1;
       }
       s2++;
       p2++;
   }

    while(*s3 == *p3){
    
       if(*s3 == '\0'){
          return 1;
       }
       s3++;
       p3++;
   }

    while(*s4 == *p4){
    
       if(*s4 == '\0'){
          return 1;
       }
       s4++;
       p4++;
   }
 return 0;
}

__global__ void kernel() {

 
  char alphabet[26] = {'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'};
  

  char num[10] = {'0','1','2','3','4','5','6','7','8','9'};
  

  char crack[7];
  crack[6] = '\0';
  int s, h, k, r;

     for(s=0;s<10;s++){
      for(h=0; h<10; h++){
       for(k=0; k<10; k++){
        for(r=0; r<10; r++){

        crack[0] = alphabet[blockIdx.x];
        crack[1] = alphabet[threadIdx.x];
        crack[2] = num[s];
        crack[3] = num[h];
        crack[4] = num[k];
        crack[5] = num[r];

        if(passcrack(crack)){
            printf("Password successfully cracked: %s\n", crack);
        }

       }
      }
     }
    }
   }

int time_difference(struct timespec *start, struct timespec *finish, long long int *difference)
 {
     long long int ds =  finish->tv_sec - start->tv_sec;
     long long int dn =  finish->tv_nsec - start->tv_nsec;

     if(dn < 0 )
     {
      ds--;
      dn += 1000000000;
      }

     *difference = ds * 1000000000 + dn;
    return !(*difference > 0);
}


int main(int argc, char *argv[])
{

    struct timespec start, finish;  
    long long int time_elapsed;

    clock_gettime(CLOCK_MONOTONIC, &start);

    kernel <<<26, 26>>>();

    cudaThreadSynchronize();


    clock_gettime(CLOCK_MONOTONIC, &finish);
    time_difference(&start, &finish, &time_elapsed);
     printf("Time elapsed was %lldns or %0.9lfs\n", time_elapsed,
                                           (time_elapsed/1.0e9));
  return 0;
}







