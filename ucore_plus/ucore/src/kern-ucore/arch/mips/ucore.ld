OUTPUT_FORMAT(elf32-tradlittlemips)
OUTPUT_ARCH(mips:isa32)
ENTRY(kernel_entry)

SECTIONS
{
  . = 0x80000000;
  .text      :
  {
    . = ALIGN(4);
    wrs_kernel_text_start = .; _wrs_kernel_text_start = .;
    *(.startup)
    *(.text)
    *(.text.*)
    *(.gnu.linkonce.t*)
    *(.mips16.fn.*)
    *(.mips16.call.*) /* for MIPS */
    *(.rodata) *(.rodata.*) *(.gnu.linkonce.r*) *(.rodata1)
    . = ALIGN(4096);
    *(.ramexv)
  }
. = ALIGN(16);
wrs_kernel_text_end = .; _wrs_kernel_text_end = .;
etext = .; _etext = .;
.data ALIGN(4)   : AT(etext)
{
  wrs_kernel_data_start = .; _wrs_kernel_data_start = .;
  *(.data)
  *(.data.*)
  *(.gnu.linkonce.d*)
  *(.data1)
  *(.eh_frame)
  *(.gcc_except_table)
  . = ALIGN(8);
  _gp = . + 0x7ff0;  /* set gp for MIPS startup code */
    /* got*, dynamic, sdata*, lit[48], and sbss should follow _gp */
  *(.got.plt)
  *(.got)
  *(.dynamic)
  *(.got2)
  *(.sdata) *(.sdata.*) *(.lit8) *(.lit4)
  __percpu_start = .;
  *(.percpu)
  __percpu_end = .;
  __DWARF_DEBUG_LINE_BEGIN__ = .;
  __DWARF_DEBUG_LINE_END__ = .;
    . = ALIGN(16);
}
initrd_begin = .;
initrd_end = .;
. = ALIGN(16);
edata = .; _edata = .;
wrs_kernel_data_end = .; _wrs_kernel_data_end = .;
.bss  ALIGN(4)  :
{
  wrs_kernel_bss_start = .; _wrs_kernel_bss_start = .;
  *(.sbss) *(.scommon) *(.dynbss) *(.bss) *(COMMON)
  . = ALIGN(16);
}
. = ALIGN(16);

end = .; _end = .;
wrs_kernel_bss_end = .; _wrs_kernel_bss_end = .;

/DISCARD/ :
{
  *(.symtab)
  *(.strtab)
  *(.debug*)
  *(.note)    /* seen on Pentium ELF */
  *(.comment)    /* seen on PPC & SH ELF */
  *(.reginfo)
  *(.pdr)    /* seen on MIPS ELF */
}

}
