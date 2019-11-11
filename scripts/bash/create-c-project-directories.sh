#!/bin/bash
mkdir -p source include static-libraries scripts Resources OBJECTS OUTPUT/BINARY OUTPUT/STATIC_LIBRARY;
nvim ~/dev/FunctionFactory/c_makefile.json ~/dev/FunctionFactory/Resources/templates/c_makefile.hbs && ~/dev/FunctionFactory/function_factory.js -I ~/dev/FunctionFactory/c_makefile.json && cp ~/dev/FunctionFactory/output ./scripts/makefile.mk;
ln -f ./scripts/makefile.mk Makefile;

