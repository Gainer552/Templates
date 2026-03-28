/*
    COMPLETE C BOILERPLATE TEMPLATE
    Covers common data types, data structures, and usage patterns
    for a wide range of scenarios.
*/

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <stdint.h>
#include <stddef.h>

/*
==================================================
1. MACROS / CONSTANTS
==================================================
*/
#define MAX_NAME_LEN 100
#define MAX_ARRAY_SIZE 10
#define BUFFER_SIZE 256

/*
==================================================
2. TYPEDEFS FOR COMMON DATA TYPES
==================================================
*/
typedef unsigned char      u8;
typedef unsigned short     u16;
typedef unsigned int       u32;
typedef unsigned long long u64;

typedef signed char        i8;
typedef signed short       i16;
typedef signed int         i32;
typedef signed long long   i64;

typedef float              f32;
typedef double             f64;
typedef long double        f128;

/*
==================================================
3. BASIC DATA TYPE EXAMPLES
==================================================
*/
void basic_data_types_demo(void) {
    char character = 'A';
    int integer = 42;
    float decimal_single = 3.14f;
    double decimal_double = 3.1415926535;
    long long big_integer = 1234567890123LL;
    bool is_true = true;
    const char *string = "Hello, C";
    void *generic_pointer = NULL;

    printf("char: %c\n", character);
    printf("int: %d\n", integer);
    printf("float: %.2f\n", decimal_single);
    printf("double: %.5f\n", decimal_double);
    printf("long long: %lld\n", big_integer);
    printf("bool: %s\n", is_true ? "true" : "false");
    printf("string: %s\n", string);
    printf("pointer: %p\n", generic_pointer);
}

/*
==================================================
4. ARRAYS
==================================================
*/
void array_demo(void) {
    int numbers[MAX_ARRAY_SIZE] = {1,2,3,4,5,6,7,8,9,10};

    for (int i = 0; i < MAX_ARRAY_SIZE; i++) {
        printf("numbers[%d] = %d\n", i, numbers[i]);
    }
}

/*
==================================================
5. STRUCTURES
==================================================
*/
typedef struct {
    int id;
    char name[MAX_NAME_LEN];
    int age;
    float salary;
} Person;

void struct_demo(void) {
    Person p = {1, "Alice", 30, 75000.50f};

    printf("Person => ID: %d, Name: %s, Age: %d, Salary: %.2f\n",
           p.id, p.name, p.age, p.salary);
}

/*
==================================================
6. NESTED STRUCTURES
==================================================
*/
typedef struct {
    char street[100];
    char city[50];
    int zip;
} Address;

typedef struct {
    char name[MAX_NAME_LEN];
    Address address;
} Employee;

void nested_struct_demo(void) {
    Employee e = {
        "Bob",
        {"123 Main St", "Edmonton", 12345}
    };

    printf("Employee: %s, Address: %s, %s, %d\n",
           e.name, e.address.street, e.address.city, e.address.zip);
}

/*
==================================================
7. UNIONS
==================================================
*/
typedef union {
    int i;
    float f;
    char str[20];
} Data;

void union_demo(void) {
    Data d;

    d.i = 10;
    printf("Union int: %d\n", d.i);

    d.f = 220.5f;
    printf("Union float: %.2f\n", d.f);

    strcpy(d.str, "Hello");
    printf("Union string: %s\n", d.str);
}

/*
==================================================
8. ENUMS
==================================================
*/
typedef enum {
    STATUS_PENDING,
    STATUS_IN_PROGRESS,
    STATUS_DONE,
    STATUS_FAILED
} Status;

void enum_demo(void) {
    Status current = STATUS_IN_PROGRESS;
    printf("Enum value: %d\n", current);
}

/*
==================================================
9. POINTERS
==================================================
*/
void pointer_demo(void) {
    int value = 25;
    int *ptr = &value;

    printf("Value: %d\n", value);
    printf("Address: %p\n", (void*)&value);
    printf("Pointer points to: %d\n", *ptr);
}

/*
==================================================
10. DYNAMIC MEMORY
==================================================
*/
void dynamic_memory_demo(void) {
    int *arr = malloc(5 * sizeof(int));
    if (!arr) {
        fprintf(stderr, "Memory allocation failed\n");
        return;
    }

    for (int i = 0; i < 5; i++) {
        arr[i] = i * 10;
    }

    for (int i = 0; i < 5; i++) {
        printf("arr[%d] = %d\n", i, arr[i]);
    }

    free(arr);
}

/*
==================================================
11. LINKED LIST
==================================================
*/
typedef struct Node {
    int data;
    struct Node *next;
} Node;

Node *create_node(int value) {
    Node *new_node = malloc(sizeof(Node));
    if (!new_node) return NULL;
    new_node->data = value;
    new_node->next = NULL;
    return new_node;
}

void linked_list_demo(void) {
    Node *head = create_node(10);
    head->next = create_node(20);
    head->next->next = create_node(30);

    Node *current = head;
    while (current) {
        printf("Node data: %d\n", current->data);
        current = current->next;
    }

    current = head;
    while (current) {
        Node *temp = current;
        current = current->next;
        free(temp);
    }
}

/*
==================================================
12. STACK (ARRAY-BASED)
==================================================
*/
typedef struct {
    int items[MAX_ARRAY_SIZE];
    int top;
} Stack;

void stack_init(Stack *s) {
    s->top = -1;
}

bool stack_push(Stack *s, int value) {
    if (s->top >= MAX_ARRAY_SIZE - 1) return false;
    s->items[++s->top] = value;
    return true;
}

bool stack_pop(Stack *s, int *out) {
    if (s->top < 0) return false;
    *out = s->items[s->top--];
    return true;
}

void stack_demo(void) {
    Stack s;
    int value;
    stack_init(&s);
    stack_push(&s, 10);
    stack_push(&s, 20);
    stack_push(&s, 30);

    while (stack_pop(&s, &value)) {
        printf("Popped: %d\n", value);
    }
}

/*
==================================================
13. QUEUE (ARRAY-BASED SIMPLE VERSION)
==================================================
*/
typedef struct {
    int items[MAX_ARRAY_SIZE];
    int front;
    int rear;
} Queue;

void queue_init(Queue *q) {
    q->front = 0;
    q->rear = -1;
}

bool enqueue(Queue *q, int value) {
    if (q->rear >= MAX_ARRAY_SIZE - 1) return false;
    q->items[++q->rear] = value;
    return true;
}

bool dequeue(Queue *q, int *out) {
    if (q->front > q->rear) return false;
    *out = q->items[q->front++];
    return true;
}

void queue_demo(void) {
    Queue q;
    int value;
    queue_init(&q);
    enqueue(&q, 100);
    enqueue(&q, 200);
    enqueue(&q, 300);

    while (dequeue(&q, &value)) {
        printf("Dequeued: %d\n", value);
    }
}

/*
==================================================
14. FUNCTION POINTERS
==================================================
*/
int add(int a, int b) {
    return a + b;
}

void function_pointer_demo(void) {
    int (*operation)(int, int) = add;
    printf("Function pointer result: %d\n", operation(5, 7));
}

/*
==================================================
15. FILE HANDLING
==================================================
*/
void file_demo(void) {
    FILE *fp = fopen("example.txt", "w");
    if (!fp) {
        fprintf(stderr, "Could not open file\n");
        return;
    }

    fprintf(fp, "Hello file!\n");
    fclose(fp);
}

/*
==================================================
16. GENERIC BUFFER / BYTE DATA
==================================================
*/
void byte_buffer_demo(void) {
    uint8_t buffer[BUFFER_SIZE] = {0};
    buffer[0] = 255;
    buffer[1] = 128;

    printf("Buffer[0]: %u\n", buffer[0]);
    printf("Buffer[1]: %u\n", buffer[1]);
}

/*
==================================================
17. MAIN
==================================================
*/
int main(void) {
    printf("=== Basic Data Types ===\n");
    basic_data_types_demo();

    printf("\n=== Arrays ===\n");
    array_demo();

    printf("\n=== Structs ===\n");
    struct_demo();

    printf("\n=== Nested Structs ===\n");
    nested_struct_demo();

    printf("\n=== Unions ===\n");
    union_demo();

    printf("\n=== Enums ===\n");
    enum_demo();

    printf("\n=== Pointers ===\n");
    pointer_demo();

    printf("\n=== Dynamic Memory ===\n");
    dynamic_memory_demo();

    printf("\n=== Linked List ===\n");
    linked_list_demo();

    printf("\n=== Stack ===\n");
    stack_demo();

    printf("\n=== Queue ===\n");
    queue_demo();

    printf("\n=== Function Pointers ===\n");
    function_pointer_demo();

    printf("\n=== File Handling ===\n");
    file_demo();

    printf("\n=== Byte Buffer ===\n");
    byte_buffer_demo();

    return 0;
}