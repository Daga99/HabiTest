#include <cstring>
#include <iostream>
char temp; //Variable temporal en donde se guardan las variables
void ordenar(char *l, int len){ //Función que se encarga ordenar el arreglo
    for(int i=0; i<len; i++){ // Recorre el arreglo
        for(int j=i+1; j<len;j++){ //Recorre el arreglo una posición adelante
            if(l[i]<l[j]){ //Ordena primero las minúsculas, luego mayúsculas y por último los números
                temp=l[j];
                l[j]=l[i];
                l[i]=temp;
            }
        }
    }
    std::cout<<l<<std::endl; // Se observa el orden anterior mencionado
    for(int i=0; i<len; i++){
        if(l[i]>='a' && l[i]<='z'){ //Si el valor se encuentra entre a y z entra a la condición
            for(int j=i+1; j<len;j++){
                if(l[i]>l[j] && l[j]>='a'){ // Al ser mayor a que Z y 9, se tiene la condición de ordenar primero las minúsculas
                    temp=l[j];
                    l[j]=l[i];
                    l[i]=temp;
                }
            }
        }
    }
    std::cout<<l<<std::endl; //Se observa el orden de las minúsculas
    for(int i=0; i<len; i++){
        if(l[i]>='A' && l[i]<='Z'){ //Condición para las mayúsculas
            for(int j=i+1; j<len;j++){
                if(l[i]>l[j] && l[j]<='Z'&& l[j]>='A'){ // Al ser 'Z' menor que 'a' y 'A' mayor que '9' se hace la condición para dejar las minúsculas antes y números después
                    temp=l[j];
                    l[j]=l[i];
                    l[i]=temp;
                }
            }
        }
    }
    std::cout<<l<<std::endl; //Se observa el orden de mayúsculas
    for(int i=0; i<len; i++){
        if(l[i]>='0' && l[i]<='9'){ // Condición para números
            for(int j=i+1; j<len;j++){
                if(l[i]%2!=0 && l[i]>=l[j]){ //Orden de números  impares
                    temp=l[j];
                    l[j]=l[i];
                    l[i]=temp;
                }
            }
            for(int j=i+1; j<len;j++){
                if(l[i]%2==0 && l[i]>=l[j]){ //Orden de números pares
                    temp=l[j];
                    l[j]=l[i];
                    l[i]=temp;
                    }
                }
            }
        }

    std::cout<<l<<std::endl; // Se observa el orden de los números
}
int main()
{
    char in[1000]; //Máximo 1000 caracteres según requerimientos
    std::cout<<"Ingrese la cadena de alfanumericos"<<std::endl; //Se ingresa la cadena de alfanuméricos
    std:: cin>>in; // Ingreso del alfanumérico
    std::cout<<in<<std::endl; //Se muestra el número ingresado
    int t = strlen(in); // Función que permite conocer la longitud la cadena de caracteres
    ordenar(in, t); //Se aplica la función creada
    std::cout<<in; // Se muestra el arreglo final
    return 0;
}