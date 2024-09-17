SRCS = $(wildcard *.c)	#获取当前目录下的所有.c文件
OBJ = $(patsubst %.c,%.o,$(SRCS))	#将SRCS中的.c替换为.o

all: $(OBJ) 

%.o: %.c				# 生成.o文件
	$(GCC) $(CFLAG) -c $<	

clean:				# 清除所有.o文件，并过滤掉错误信息
	$(shell rm *.o 2>/dev/null) 	