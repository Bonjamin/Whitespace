### This Makefile was written for nmake. ###
MSVC_MACROS = /D_CRT_SECURE_NO_WARNINGS /D_SECURE_SCL=0

GETOPT_DIR        = getopt
GETOPT_REPOSITORY = https://github.com/koturn/$(GETOPT_DIR).git
GETOPT_LIBS_DIR   = $(GETOPT_DIR)/lib
GETOPT_LIB        = getopt.lib
GETOPT_LDLIBS     = /link /LIBPATH:$(GETOPT_LIBS_DIR) $(GETOPT_LIB)
GETOPT_INCS       = /Igetopt/include/

MAX_SOURCE_SIZE   = 65536
MAX_BYTECODE_SIZE = 1048576
MAX_LABEL_LENGTH  = 65536
MAX_N_LABEL       = 1024
UNDEF_LIST_SIZE   = 256
STACK_SIZE        = 65536
HEAP_SIZE         = 65536
CALL_STACK_SIZE   = 65536
WS_INT            = int
WS_ADDR_INT       = "unsigned int"
INDENT_STR        = "\"  \""

MACROS = $(MSVC_MACROS) \
         /DMAX_SOURCE_SIZE=$(MAX_SOURCE_SIZE) \
         /DMAX_BYTECODE_SIZE=$(MAX_BYTECODE_SIZE) \
         /DMAX_LABEL_LENGTH=$(MAX_LABEL_LENGTH) \
         /DMAX_N_LABEL=$(MAX_N_LABEL) \
         /DUNDEF_LIST_SIZE=$(UNDEF_LIST_SIZE) \
         /DSTACK_SIZE=$(STACK_SIZE) \
         /DHEAP_SIZE=$(HEAP_SIZE) \
         /DCALL_STACK_SIZE=$(CALL_STACK_SIZE) \
         /DWS_INT=$(WS_INT) \
         /DWS_ADDR_INT=$(WS_ADDR_INT) \
         /DINDENT_STR=$(INDENT_STR)

CC       = cl
RM       = del /F
MAKE     = $(MAKE) /nologo
GIT      = git
INCS     = $(GETOPT_INCS)
CFLAGS   = /nologo /O2 /W4 /EHsc /c $(INCS) $(MACROS)
LDFLAGS  = /nologo /O2
LDLIBS   = $(GETOPT_LDLIBS)
TARGET   = whitespace.exe
OBJ      = $(TARGET:.exe=.obj)
SRC      = $(TARGET:.exe=.c)
MAKEFILE = msvc.mk


.SUFFIXES: .c .obj .exe
.obj.exe:
	$(CC) $(LDFLAGS) $** /Fe$@ $(LDLIBS)
.c.obj:
	$(CC) $(CFLAGS) $** /Fo$@


all: $(GETOPT_LIBS_DIR)/$(GETOPT_LIB) $(TARGET)

$(TARGET): $(OBJ)

$(OBJ): $(SRC)

$(GETOPT_LIBS_DIR)/$(GETOPT_LIB):
	@if not exist $(@D)\NUL \
	    $(GIT) clone $(GETOPT_REPOSITORY)
	cd $(GETOPT_DIR)  &  $(MAKE) /f $(MAKEFILE)  &  cd $(MAKEDIR)


clean:
	$(RM) $(TARGET) $(OBJ)
cleanobj:
	$(RM) $(OBJ)
