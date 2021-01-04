; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=+movdiri | FileCheck %s

define void @test_movdiri(i8* %p, i64 %v) {
; CHECK-LABEL: test_movdiri:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    movdiri %rsi, (%rdi)
; CHECK-NEXT:    retq
entry:
  call void @llvm.x86.directstore64(i8* %p, i64 %v)
  ret void
}

declare void @llvm.x86.directstore64(i8*, i64)