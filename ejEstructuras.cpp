void invertirCadena (string cadena){
    std::queue<string> pila;
    std::string palabra;
    
    for(int i = 0; i < cadena.lenght(); i++){
        string letra = cadena.subsrt[i]
        if(letra != " "){
             palabra += letra
         }else{
             pila.push(palabra);
             palabra = "";
         }   
    }

    while(!pila.Empty()){
       string salida = pila.top()
       pila.pop();
       std:: cout << salida << " ";
    }

}