#!/bin/bash

LIB=./lib
SRC=./src

if [ ! -d $LIB ]; then
    mkdir $LIB
fi

if [ ! -f $LIB/tiny.jar ]; then
    echo "Downloading tiny-remapper JAR..."
    wget -q "https://maven.fabricmc.net/net/fabricmc/tiny-remapper/0.9.0/tiny-remapper-0.9.0.jar" -O $LIB/tiny.jar
fi

if [ ! -f $LIB/vineflower.jar ]; then
    echo "Downloading vineflower JAR..."
    wget -q "https://github.com/Vineflower/vineflower/releases/download/1.10.1/vineflower-1.10.1-slim.jar" -O $LIB/vineflower.jar
fi

if [ ! -f $LIB/mapping-io.jar ]; then
    echo "Downloading mapping-io JAR..."
    wget -q "https://maven.fabricmc.net/net/fabricmc/mapping-io/0.6.1/mapping-io-0.6.1.jar" -O $LIB/mapping-io.jar
fi

if [ ! -f $LIB/asm.jar ]; then
    echo "Downloading ASM JAR..."
    wget -q "https://maven.fabricmc.net/org/ow2/asm/asm/9.7/asm-9.7.jar" -O $LIB/asm.jar
fi

if [ ! -f $LIB/asm-commons.jar ]; then
    echo "Downloading ASM Commons JAR..."
    wget -q "https://maven.fabricmc.net/org/ow2/asm/asm-commons/9.7/asm-commons-9.7.jar" -O $LIB/asm-commons.jar
fi

if [ ! -f $LIB/asm-tree.jar ]; then
    echo "Downloading ASM Tree JAR..."
    wget -q "https://maven.fabricmc.net/org/ow2/asm/asm-tree/9.7/asm-tree-9.7.jar" -O $LIB/asm-tree.jar
fi

if [ ! -f $LIB/a1.1.2_01.jar ]; then
    echo "Downloading a1.1.2_01 JAR..."
    wget -q "https://piston-data.mojang.com/v1/objects/daa4b9f192d2c260837d3b98c39432324da28e86/client.jar" -O $LIB/a1.1.2_01.jar
fi

rm -f ./a1.1.2_01-remapped.jar

echo "Remapping a1.1.2_01..."
java -cp $LIB/asm.jar:$LIB/asm-commons.jar:$LIB/asm-tree.jar:$LIB/mapping-io.jar:$LIB/tiny.jar net.fabricmc.tinyremapper.Main $LIB/a1.1.2_01.jar ./a1.1.2_01-remapped.jar ./a1.1.2_01-official.tiny intermediary named

rm -rf $SRC/*

echo "Decompiling a1.1.2_01..."
java -jar $LIB/vineflower.jar $(realpath ./a1.1.2_01-remapped.jar) $SRC
