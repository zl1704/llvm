//
// Created by zl on 2020/9/10.
//
int a[10]= {1,2,3,4,5,6,7,9,10};

int lsr_fun(){
    int i = 0;
    int j = 0;
    while(i<10){
        j = 3*i+1;
        a[j] = a[j]-2;
        i = i+2;


    }
    return 0;
}