CC := gcc
SRCDIR := src
BUILDDIR := build
BINDIR := bin
TARGET := drav
LIBS := libdrav.so

SRCEXT := c
SOURCES := $(shell find $(SRCDIR) -type f -name '*.$(SRCEXT)')
OBJECTS := $(patsubst $(SRCDIR)/%,$(BUILDDIR)/%,$(SOURCES:.$(SRCEXT)=.o))
CFLAGS := -g
LIB := -L./bin/lib
INC := -I./include
all: $(LIBS) $(TARGET)

$(TARGET): 
	$(CC) droidav.c -o $(TARGET) $(LIB) $(INC)

$(LIBS): $(OBJECTS)
	mkdir -p bin/lib
	$(CC) -shared $^ -o bin/lib/$(LIBS) $(INC) $(LIB)
$(BUILDDIR)/%.o: $(SRCDIR)/%.$(SRCEXT)
	mkdir build
	$(CC) $(CFLAGS) -c -o $@ $< $(INC)
test:
	$(CC) $(CFLAGS) tests/test.c $(INC) $(LIB) -o test
clean:
	$(RM) -r $(BUILDDIR) $(TARGET) $(BINDIR)
.PHONY: clean
