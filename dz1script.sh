#!/bin/bash

function makeCONFIG(){
    echo "старт"
    echo "      создания"
    echo "               конфига !"
rm ./.config
make -j$(nproc) defconfig
}

function disable() {
    echo ""
    echo "ОТКЛЮЧЕНИЕ модуля $1"
    echo ""
    ./scripts/config --disable "$1"
}

function enable() {
    echo ""
    echo "ВКЛЮЧЕНИЕ модуля $1"
    echo ""
    ./scripts/config --enable "$1"
}

function compile_kernel() {
    echo "!!!!!!!!!!!!!!!!!!!!!!"
    echo "СТАРТ КОМПИЛЯЦИИ ЯДРА"
    echo "!!!!!!!!!!!!!!!!!!!!!!"
    time make -j$(nproc) deb-pkg 2>error.log
}

################ START SCRIPT ####################
makeCONFIG

disable "SECURITY_SELINUX"
disable "SECURITY_SMACK"
disable "SECURITY_TOMOYO"
disable "SECURITY_APPARMOR"
disable "SECURITY_YAMA"
disable "RANDOMIZE_BASE"
disable "CPU_MITIGATIONS"
disable "MITIGATION_SPECTRE_BHI"
disable "MITIGATION_RFDS"
disable "PAGE_TABLE_ISOLATION"
disable "ZSWAP"
disable "BPF"
disable "BPF_SYSCALL"
disable "BPF_JIT"
disable "BPF_EVENTS"
disable "CONFIG_DEBUG_INFO_NONE"
disable "BPFILTER"

enable "CONFIG_DEBUG_INFO"
enable "DEBUG_FS"
enable "FTRACE"
enable "FUNCTION_TRACER"
enable "DYNAMIC_FTRACE"
enable "FUNCTION_GRAPH_TRACER"
enable "STACK_TRACER"
enable "KUNIT"
enable "KUNIT_TEST"
enable "KASAN"
enable "STACKTRACE"
enable "KASAN_GENERIC"
enable "KASAN_INLINE"
enable "KASAN_EXTRA_INFO"
enable "KGDB"
enable "KGDB_SERIAL_CONSOLE"
enable "DEBUG_INFO"
enable "SERIAL_CONSOLE"
enable "CONSOLE_POLL"
enable "KPROBES"
enable "KPROBE_EVENT"

compile_kernel
