#/bin/bash

function disable(){
echo ""
echo "ОТКЛЮЧЕНИЕ модуля $1"
echo ""
./scripts/config --disable "$1"
}

function enable(){
echo ""
echo "ВКЛЮЧЕНИЕ модуля $1"
echo ""
./scripts/config --enable "$1"
}

function make(){
time make -j$(nproc) deb-pkg 2>error.log
}

################START SCRIPT####################
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
disable "DEBUG_INFO_NONE"
disable "CONFIG_DEBUG_INFO_NONE"
disable "BPFILTER"

# Включение DEBUG_INFO
enable CONFIG_DEBUG_INFO

# Включение DEBUG_FS и отладочных функций
echo "Включение DEBUG_FS и отладочных функций"
enable DEBUG_FS

# Включение ftrace и связанных функций
echo "Включение ftrace и связанных функций"
enable FTRACE
enable FUNCTION_TRACER
enable DYNAMIC_FTRACE
enable FUNCTION_GRAPH_TRACER
enable STACK_TRACER

# Включение KUnit
echo "Включение KUnit"
enable KUNIT
enable KUNIT_TEST

# Включение KASAN
echo "Включение KASAN"
enable KASAN
enable STACKTRACE
enable KASAN_GENERIC
enable KASAN_INLINE
enable KASAN_EXTRA_INFO

# Включение KGDB
echo "Включение KGDB"
enable KGDB
enable KGDB_SERIAL_CONSOLE
enable DEBUG_INFO
enable SERIAL_CONSOLE
enable CONSOLE_POLL

# Включение Kprobes
echo "Включение Kprobes"
enable KPROBES
enable KPROBE_EVENT

#компилируем ядро
make
