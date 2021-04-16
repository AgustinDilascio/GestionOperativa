#!/bin/bash
function mensajeAyuda()
{
    echo "-----------------------------------------------------------------
Descripcion :
    Este script recorre todo los itmes publicados por un cliente en el site
    MLA y devuelve un archivo log con los siguientes campos.
    'id' del item, 'title' del item,'category_id' donde esta publcado,
    'name' de la categoria."
    echo "-----------------------------------------------------------------
Forma de ejecucion:
    ./listarItmes.sh  <id>
    en caso de queres pasar varios id 
    ./listarItmes.sh  <id> <id>" 
}

function mensajeError()
{
    echo "cantidad de parametros erroneos,vea la ayuda
    ./listarItmes.sh -h
    ./listarItmes.sh -?
    ./listarItmes.sh --help"
}



#validacion parametros de entrada
if [[ $# = 0 ]] 
then
    mensajeError
    exit
elif [[ $1 = "-h" || $1 = "--help" || $1 = "-?" ]]
then
    mensajeAyuda
    exit
fi

IFS=' ' read -a variables <<<"$@"
SITE_ID="MLA"
for (( i=0 ; i < $# ; i++))
do
    SELLER_ID="${variables[i]}"
    
    json="curl -X GET -H 'Authorization: Bearer $ACCESS_TOKEN' https://api.mercadolibre.com/sites/$SITE_ID/search?seller_id=$SELLER_ID" 

    atributos=$($json | jq '.results[] | .id, .title, .category_id') 


    #formto para el log
    ruta=$(echo $SELLER_ID"log.log")
    echo "$ruta"
    IFS=$'\n'
    j=0
    echo -n "">"$ruta"
    for atributo in $atributos
    do
        if [[ $j = 2 ]]
        then
            categoriaID=$(echo "$atributo" | sed -e 's/^.//' -e 's/.$//')
            categoria=$(curl -X GET https://api.mercadolibre.com/categories/$categoriaID | jq '.name')
            echo "$atributo, $categoria">> "$ruta"
            j=0
        else
            echo -n "$atributo,">> "$ruta"
            j=$((j + 1))
        fi
    
    done

done
 
