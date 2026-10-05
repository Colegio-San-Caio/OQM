#include <stdio.h>
#include <unistd.h>

int main(int argc, char *argv[]) {
    char *args[argc + 1];
    args[0] = "./dist/D16S";
    for (int i = 1; i < argc; i++) {
        args[i] = argv[i];
    }
    args[argc] = NULL;

    execvp(args[0], args);
    perror("Failed to execute D16S");
    return 1;
}
