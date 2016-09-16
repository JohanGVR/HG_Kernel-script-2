#
##################################
# Gr2_srk  <gr2.stark@gmail.com> #	
# HB72K  <xxxxxxx@gmail.com>     #
# Script Para Compilar Kernel    #
##################################
#

#!/bin/bash

#DIRECTORIO
KERNEL="/home/$USUARIO/android_kernel_huawei_msm8916/arch/arm/boot/zImage"
ZIP="/home/$USUARIO/android_kernel_huawei_msm8916/zip"

#Inicio
echo ''
echo "============================="
echo ''
echo "KERNEL COMPILER-DemoniackTeam"
echo ''
echo "============================="
echo ''

#LINARIO
echo "***Verificando Linario...***"
echo ''
LIN=~/arm-cortex_a7-linux-gnueabihf-linaro_4.9
if [ ! -d "$LIN" ]; then
git clone https://github.com/Christopher83/arm-cortex_a7-linux-gnueabihf-linaro_4.9.git 
echo "***Se usará Linario existente***"
echo ''
fi

#SOURCE
echo ''
echo '***¿DESEA DESCARGAR SU SOURCE?***'
echo 'Diga si o no'
echo ''
read start
if [ "$start" = si ]; then
echo '***Ingrese el perfil de su source:***'
echo 'NOTA, SOLO EL PERFIL DEL SOURCE'
echo 'Ejemplo: Gr2007'
read PERFIL
echo ''
echo '***Ingrese la dirección de su source:***'
echo 'NOTA, SOLO LO QUE VA DESPUES DE https://github.com/*Perfil*/ SIN EL .GIT'
echo 'Ejemplo: android_kernel_huawei_msm8916'
echo ''
read SOURCE
echo ''
echo '***Nombre del branch***' 
echo 'Ejemplo: cm-12.1-caf'
echo ''
read branch
git clone https://github.com/$PERFIL/$SOURCE.git -b $branch
elif [ "$start" = no ]; then
echo '***Ingrese el nombre de la carpeta de su source:***'
echo 'Donde esta descargado el source, en home'
echo 'Ejemplo: android_kernel_huawei_msm8916'
echo ''
read SOURCE
fi
sleep 3s

#Cuestion
echo ''
echo '***Especifique la config del DEVICE***'
echo 'Ejemplo: cm_hwY635_defconfig'
echo ''
read DEVICE
echo ''
echo '***¿Cual es su nick***?'
echo ''
read NICK 
echo ''
echo '***Nombre del kernel***: ' 
echo ''
read KERNEL 
echo '<<<<<Edite sus modificaciones>>>>>'
echo 'Con su explorador de archivos edite la source del kernel'
echo ''
sleep 5s 
cd $SOURCE
echo ''
echo '***Desea borrar la compilación anterior?***'
echo "Diga si o no:"
echo ''
read COMP
if [ "$COMP" = si ]; then
echo ''
echo '***Borrando compilaciones Anteriores***'
echo ''
make clean 
elif [ "$COMP" = no ]; then
echo ''
echo "***Escribiste -no-***"
echo '***se continuara con la compilación***'
echo ''
fi

#AsignandoNombreYNick
export KBUILD_BUILD_USER= $NICK
export KBUILD_BUILD_HOST= $KERNEL
make ARCH=arm $DEVICE

#Compilacion
echo ''
echo '==================================='
echo ''
echo 'Compilando Kernel con Linario'
echo ''
echo '==================================='
echo ''
echo '***Ingrese numero de nucleos de su Equipo +1***'
echo 'Ejemplo: Si su equipo cuenta con 4 nucleos debe ingresar el numero 5 '
read NUCLEO
make -j$NUCLEO ARCH=arm CROSS_COMPILE=~/arm-cortex_a7-linux-gnueabihf-linaro_4.9/bin/arm-cortex_a7-linux-gnueabihf-

#zip
#REVISA ESTE APARTADO, NO LO PROBE
#echo ">>>Construyendo zip<<<"
#rm -rvf $ZIP/tools/zImage
#mv $KERNEL $ZIP/tools
#rm -f $ZIP/*.zip
#cd $ZIP
#zip -r $NICK-$KERNEL-$DEVICE *
#cd

#FIN
echo ''
echo '========================================='
echo ''
echo 'Compilacion terminada, Felicidades $NICK!'
echo ''
echo '========================================='
echo ''
sleep 10s
