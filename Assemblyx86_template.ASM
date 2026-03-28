; ==================================================
; COMPLETE ASSEMBLY BOILERPLATE TEMPLATE
; Target: x86-64 Linux, NASM-style syntax
; Purpose: broad reference template covering common
; data representations, layouts, control flow, stack
; usage, procedures, lookup tables, buffers, records,
; arrays, strings, linked-node layouts, and more.
; ==================================================
;
; NOTE:
; Assembly does not have universal built-in “data structures”
; the way high-level languages do. Most structures are manual
; memory layouts. This template shows the common patterns.
;
; Build (Linux):
;   nasm -felf64 template.asm -o template.o
;   ld template.o -o template
;
; ==================================================
; 1. CONSTANTS / EQUATES
; ==================================================

%define SYS_READ   0
%define SYS_WRITE  1
%define SYS_OPEN   2
%define SYS_CLOSE  3
%define SYS_EXIT   60

%define STDIN      0
%define STDOUT     1
%define STDERR     2

%define TRUE       1
%define FALSE      0
%define NULL       0

%define BUFFER_SIZE 256
%define ARRAY_COUNT 8

; Struct field offsets
%define PERSON_ID      0
%define PERSON_AGE     4
%define PERSON_NAME    8
%define PERSON_SIZE    40

%define NODE_VALUE     0
%define NODE_NEXT      8
%define NODE_SIZE      16

%define POINT_X        0
%define POINT_Y        4
%define POINT_SIZE     8

; ==================================================
; 2. INITIALIZED DATA (.data)
; ==================================================

section .data

; ---- Scalar / primitive-like values ----
byteVal         db  0x7F                    ; 8-bit byte
wordVal         dw  0x1234                  ; 16-bit word
dwordVal        dd  123456789               ; 32-bit integer
qwordVal        dq  1234567890123456789     ; 64-bit integer
signedByte      db  -5
signedWord      dw  -32000
signedDword     dd  -1000000
signedQword     dq  -5000000000

; Floating point data in memory
float32Val      dd  3.14                    ; 32-bit float
double64Val     dq  2.718281828             ; 64-bit double

; Boolean convention (0=false, nonzero=true)
boolTrue        db  TRUE
boolFalse       db  FALSE

; Character / string data
charA           db  'A'
newline         db  10
nullByte        db  0
helloMsg        db  'Hello from Assembly!', 10
helloLen        equ $ - helloMsg

nullTermStr     db  'Sample string', 0
fixedString     db  'FixedWidthString.....'

; ---- Arrays ----
byteArray       db  1,2,3,4,5,6,7,8
wordArray       dw  10,20,30,40
intArray        dd  100,200,300,400,500,600,700,800
longArray       dq  1000,2000,3000,4000

; String table / pointer array
str1            db  'red',0
str2            db  'green',0
str3            db  'blue',0
stringPtrs      dq  str1, str2, str3

; Lookup tables
asciiDigits     db  '0123456789'
hexDigits       db  '0123456789ABCDEF'

; ---- Struct-like records ----
; Person layout:
;   +0  dd id
;   +4  dd age
;   +8  db name[32]
person1:
    dd  1
    dd  30
    db  'Alice',0
    times (32 - 6) db 0

person2:
    dd  2
    dd  41
    db  'Bob',0
    times (32 - 4) db 0

; Point structure
point1:
    dd  10
    dd  20

point2:
    dd  -5
    dd  99

; ---- Queue / stack backing storage ----
stackTopMsg     db  'Stack example',10
stackTopMsgLen  equ $ - stackTopMsg

; ---- Switch / jump table ----
caseTable       dq  case0, case1, case2, caseDefault

; ==================================================
; 3. UNINITIALIZED DATA (.bss)
; ==================================================

section .bss

; Raw buffers
buffer          resb BUFFER_SIZE
smallBuffer     resb 64

; Numeric storage
inputByte       resb 1
inputWord       resw 1
inputDword      resd 1
inputQword      resq 1

; Dynamic-like scratch regions
intArrayScratch resd ARRAY_COUNT
byteBuffer      resb 128

; Struct arrays
personTable     resb PERSON_SIZE * 4
pointTable      resb POINT_SIZE * 16

; Manual linked list nodes (fixed storage example)
node1           resb NODE_SIZE
node2           resb NODE_SIZE
node3           resb NODE_SIZE

; Simple stack / queue memory
stackStorage    resq 32
queueStorage    resq 32
queueHead       resq 1
queueTail       resq 1

; ==================================================
; 4. CODE (.text)
; ==================================================

section .text
global _start

; --------------------------------------------------
; write_stdout
; In:  rsi = buffer, rdx = length
; Out: none
; --------------------------------------------------
write_stdout:
    mov rax, SYS_WRITE
    mov rdi, STDOUT
    syscall
    ret

; --------------------------------------------------
; exit_program
; In:  rdi = exit code
; --------------------------------------------------
exit_program:
    mov rax, SYS_EXIT
    syscall

; --------------------------------------------------
; add_numbers
; In:  rdi = a, rsi = b
; Out: rax = a + b
; --------------------------------------------------
add_numbers:
    mov rax, rdi
    add rax, rsi
    ret

; --------------------------------------------------
; init_linked_nodes
; Fixed-storage singly linked list example
; node.value at +0 (qword)
; node.next  at +8 (qword pointer)
; --------------------------------------------------
init_linked_nodes:
    mov qword [node1 + NODE_VALUE], 11
    mov qword [node1 + NODE_NEXT], node2

    mov qword [node2 + NODE_VALUE], 22
    mov qword [node2 + NODE_NEXT], node3

    mov qword [node3 + NODE_VALUE], 33
    mov qword [node3 + NODE_NEXT], NULL
    ret

; --------------------------------------------------
; init_queue
; --------------------------------------------------
init_queue:
    mov qword [queueHead], 0
    mov qword [queueTail], 0
    ret

; --------------------------------------------------
; queue_push
; In:  rdi = value
; Very simple fixed queue using queueStorage
; --------------------------------------------------
queue_push:
    mov rax, [queueTail]
    mov [queueStorage + rax*8], rdi
    inc rax
    mov [queueTail], rax
    ret

; --------------------------------------------------
; queue_pop
; Out: rax = value
; --------------------------------------------------
queue_pop:
    mov rcx, [queueHead]
    mov rax, [queueStorage + rcx*8]
    inc rcx
    mov [queueHead], rcx
    ret

; --------------------------------------------------
; _start
; --------------------------------------------------
_start:

    ; ==============================================
    ; BASIC OUTPUT
    ; ==============================================
    mov rsi, helloMsg
    mov rdx, helloLen
    call write_stdout

    ; ==============================================
    ; SCALAR DATA TYPE EXAMPLES
    ; ==============================================
    ; byte / word / dword / qword are represented in memory
    ; registers commonly used:
    ;   al/ax/eax/rax
    ; ==============================================

    mov al, [byteVal]
    mov ax, [wordVal]
    mov eax, [dwordVal]
    mov rax, [qwordVal]

    ; signed integer example
    movsx eax, byte [signedByte]
    movsx eax, word [signedWord]
    movsxd rax, dword [signedDword]

    ; floating point example (SSE)
    movss xmm0, [float32Val]
    movsd xmm1, [double64Val]

    ; boolean example
    cmp byte [boolTrue], TRUE
    je .bool_is_true
    jmp .after_bool
.bool_is_true:
    nop
.after_bool:

    ; ==============================================
    ; ARRAY EXAMPLES
    ; ==============================================
    ; byteArray[index]
    xor rcx, rcx
.array_loop:
    cmp rcx, 8
    jge .array_done
    mov al, [byteArray + rcx]
    inc rcx
    jmp .array_loop
.array_done:

    ; intArray[index] where each element is 4 bytes
    xor rcx, rcx
.int_array_loop:
    cmp rcx, ARRAY_COUNT
    jge .int_array_done
    mov eax, [intArray + rcx*4]
    inc rcx
    jmp .int_array_loop
.int_array_done:

    ; ==============================================
    ; STRUCT / RECORD EXAMPLES
    ; ==============================================
    mov eax, [person1 + PERSON_ID]
    mov ebx, [person1 + PERSON_AGE]
    lea rsi, [person1 + PERSON_NAME]

    mov eax, [point1 + POINT_X]
    mov ebx, [point1 + POINT_Y]

    ; ==============================================
    ; POINTER EXAMPLES
    ; ==============================================
    lea rbx, [buffer]
    mov byte [rbx], 'Z'
    mov al, [rbx]

    ; pointer to pointer example using stringPtrs table
    mov rax, [stringPtrs]        ; address of str1
    mov bl, [rax]                ; first character

    ; ==============================================
    ; FUNCTION / PROCEDURE EXAMPLES
    ; ==============================================
    mov rdi, 5
    mov rsi, 7
    call add_numbers             ; rax = 12

    ; ==============================================
    ; STACK EXAMPLES
    ; ==============================================
    push 10
    push 20
    pop rbx
    pop rcx

    ; manual stack storage example
    mov qword [stackStorage + 0], 111
    mov qword [stackStorage + 8], 222

    ; ==============================================
    ; QUEUE EXAMPLES
    ; ==============================================
    call init_queue
    mov rdi, 100
    call queue_push
    mov rdi, 200
    call queue_push
    call queue_pop               ; rax = 100

    ; ==============================================
    ; LINKED LIST EXAMPLES
    ; ==============================================
    call init_linked_nodes
    mov rbx, node1
.list_loop:
    cmp rbx, NULL
    je .list_done
    mov rax, [rbx + NODE_VALUE]
    mov rbx, [rbx + NODE_NEXT]
    jmp .list_loop
.list_done:

    ; ==============================================
    ; STRING / BUFFER EXAMPLES
    ; ==============================================
    lea rdi, [buffer]
    mov byte [rdi], 'H'
    mov byte [rdi+1], 'i'
    mov byte [rdi+2], 0

    ; copy bytes manually
    lea rsi, [nullTermStr]
    lea rdi, [smallBuffer]
.copy_loop:
    mov al, [rsi]
    mov [rdi], al
    cmp al, 0
    je .copy_done
    inc rsi
    inc rdi
    jmp .copy_loop
.copy_done:

    ; ==============================================
    ; CONDITIONALS / IF-ELSE EXAMPLES
    ; ==============================================
    mov rax, 10
    mov rbx, 20
    cmp rax, rbx
    jl .less_than
    jmp .not_less
.less_than:
    nop
.not_less:

    ; ==============================================
    ; SWITCH / JUMP TABLE EXAMPLE
    ; ==============================================
    mov rax, 2
    cmp rax, 2
    ja .use_default
    jmp [caseTable + rax*8]
.use_default:
    jmp caseDefault

case0:
    nop
    jmp afterCase
case1:
    nop
    jmp afterCase
case2:
    nop
    jmp afterCase
caseDefault:
    nop
afterCase:

    ; ==============================================
    ; BITFIELDS / MASKS EXAMPLES
    ; ==============================================
    mov eax, 0b10110100
    and eax, 0x0F
    or  eax, 0x80
    xor eax, eax

    ; ==============================================
    ; MATRIX / 2D ARRAY EXAMPLE
    ; Treat pointTable as generic multi-record storage
    ; address = base + ((row * cols) + col) * elem_size
    ; ==============================================
    ; Example with 4-byte ints, 4 columns:
    lea rbx, [intArrayScratch]
    mov rcx, 1                  ; row
    mov rdx, 2                  ; col
    lea r8, [rcx*4 + rdx]       ; index = row*4 + col
    mov dword [rbx + r8*4], 999

    ; ==============================================
    ; UNION-LIKE / OVERLAY EXAMPLE
    ; Same bytes interpreted differently
    ; ==============================================
    mov dword [buffer], 0x41424344
    mov eax, [buffer]
    mov al, [buffer]

    ; ==============================================
    ; EXIT
    ; ==============================================
    mov rdi, 0
    call exit_program