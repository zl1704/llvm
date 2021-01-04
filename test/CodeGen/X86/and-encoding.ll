; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=x86_64-unknown-unknown -show-mc-encoding < %s | FileCheck %s

; Test that the direct object emission selects the 'and' variant with 8-bit
; immediate.
; We used to get this wrong when using direct object emission, but not when
; reading assembly.

define void @f1() nounwind {
; CHECK-LABEL: f1:
; CHECK:       # %bb.0:
; CHECK-NEXT:    pushq %rbp # encoding: [0x55]
; CHECK-NEXT:    movq %rsp, %rbp # encoding: [0x48,0x89,0xe5]
; CHECK-NEXT:    andq $-32, %rsp # encoding: [0x48,0x83,0xe4,0xe0]
; CHECK-NEXT:    movq %rbp, %rsp # encoding: [0x48,0x89,0xec]
; CHECK-NEXT:    popq %rbp # encoding: [0x5d]
; CHECK-NEXT:    retq # encoding: [0xc3]
  %foo = alloca i8, align 32
  ret void
}

define void @f2(i16 %x, i1 *%y) nounwind  {
; CHECK-LABEL: f2:
; CHECK:       # %bb.0:
; CHECK-NEXT:    andl $1, %edi # encoding: [0x83,0xe7,0x01]
; CHECK-NEXT:    movb %dil, (%rsi) # encoding: [0x40,0x88,0x3e]
; CHECK-NEXT:    retq # encoding: [0xc3]
  %c = trunc i16 %x to i1
  store i1 %c, i1* %y
  ret void
}

define void @f3(i32 %x, i1 *%y) nounwind {
; CHECK-LABEL: f3:
; CHECK:       # %bb.0:
; CHECK-NEXT:    andl $1, %edi # encoding: [0x83,0xe7,0x01]
; CHECK-NEXT:    movb %dil, (%rsi) # encoding: [0x40,0x88,0x3e]
; CHECK-NEXT:    retq # encoding: [0xc3]
  %c = trunc i32 %x to i1
  store i1 %c, i1* %y
  ret void
}

; The immediate (0x0ffffff0) can be made into an i8 by making it negative.

define i32 @lopped32_32to8(i32 %x) {
; CHECK-LABEL: lopped32_32to8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    shrl $4, %edi # encoding: [0xc1,0xef,0x04]
; CHECK-NEXT:    andl $-16, %edi # encoding: [0x83,0xe7,0xf0]
; CHECK-NEXT:    movl %edi, %eax # encoding: [0x89,0xf8]
; CHECK-NEXT:    retq # encoding: [0xc3]
  %shr = lshr i32 %x, 4
  %and = and i32 %shr, 268435440
  ret i32 %and
}

; The immediate (0x0ffffff0) can be made into an i8 by making it negative.

define i64 @lopped64_32to8(i64 %x) {
; CHECK-LABEL: lopped64_32to8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    shrq $36, %rdi # encoding: [0x48,0xc1,0xef,0x24]
; CHECK-NEXT:    andl $-16, %edi # encoding: [0x83,0xe7,0xf0]
; CHECK-NEXT:    movq %rdi, %rax # encoding: [0x48,0x89,0xf8]
; CHECK-NEXT:    retq # encoding: [0xc3]
  %shr = lshr i64 %x, 36
  %and = and i64 %shr, 268435440
  ret i64 %and
}

; The immediate (0x0ffffffffffffff0) can be made into an i8 by making it negative.

define i64 @lopped64_64to8(i64 %x) {
; CHECK-LABEL: lopped64_64to8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    shrq $4, %rdi # encoding: [0x48,0xc1,0xef,0x04]
; CHECK-NEXT:    andq $-16, %rdi # encoding: [0x48,0x83,0xe7,0xf0]
; CHECK-NEXT:    movq %rdi, %rax # encoding: [0x48,0x89,0xf8]
; CHECK-NEXT:    retq # encoding: [0xc3]
  %shr = lshr i64 %x, 4
  %and = and i64 %shr, 1152921504606846960
  ret i64 %and
}

; The immediate (0x0ffffffffff0fff0) can be made into an i32 by making it negative.

define i64 @lopped64_64to32(i64 %x) {
; CHECK-LABEL: lopped64_64to32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    shrq $4, %rdi # encoding: [0x48,0xc1,0xef,0x04]
; CHECK-NEXT:    andq $-983056, %rdi # encoding: [0x48,0x81,0xe7,0xf0,0xff,0xf0,0xff]
; CHECK-NEXT:    # imm = 0xFFF0FFF0
; CHECK-NEXT:    movq %rdi, %rax # encoding: [0x48,0x89,0xf8]
; CHECK-NEXT:    retq # encoding: [0xc3]
  %shr = lshr i64 %x, 4
  %and = and i64 %shr, 1152921504605863920
  ret i64 %and
}

; The transform is not limited to shifts - computeKnownBits() knows the top 4 bits
; must be cleared, so 0x0fffff80 can become 0x80 sign-extended.

define i32 @shrinkAndKnownBits(i32 %x) {
; CHECK-LABEL: shrinkAndKnownBits:
; CHECK:       # %bb.0:
; CHECK-NEXT:    movl %edi, %ecx # encoding: [0x89,0xf9]
; CHECK-NEXT:    movl $4042322161, %eax # encoding: [0xb8,0xf1,0xf0,0xf0,0xf0]
; CHECK-NEXT:    # imm = 0xF0F0F0F1
; CHECK-NEXT:    imulq %rcx, %rax # encoding: [0x48,0x0f,0xaf,0xc1]
; CHECK-NEXT:    shrq $36, %rax # encoding: [0x48,0xc1,0xe8,0x24]
; CHECK-NEXT:    andl $-128, %eax # encoding: [0x83,0xe0,0x80]
; CHECK-NEXT:    # kill: def $eax killed $eax killed $rax
; CHECK-NEXT:    retq # encoding: [0xc3]
  %div = udiv i32 %x, 17
  %and = and i32 %div, 268435328
  ret i32 %and
}

