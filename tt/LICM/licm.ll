; ModuleID = 'licm_tt.ll'
source_filename = "licm_hoist.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nounwind uwtable
define dso_local i32 @licm_fun() #0 {
entry:
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  %sum = alloca i32, align 4
  %i = alloca i32, align 4
  store i32 123, i32* %a, align 4
  store i32 456, i32* %b, align 4
  store i32 0, i32* %sum, align 4
  store i32 0, i32* %i, align 4
  %0 = load i32, i32* %a, align 4
  %1 = load i32, i32* %b, align 4
  %add = add nsw i32 %0, %1
  %add1 = add nsw i32 %add, 5
  %i.promoted = load i32, i32* %i, align 1
  %sum.promoted = load i32, i32* %sum, align 1
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %add22 = phi i32 [ %add2, %for.inc ], [ %sum.promoted, %entry ]
  %inc1 = phi i32 [ %inc, %for.inc ], [ %i.promoted, %entry ]
  %cmp = icmp slt i32 %inc1, 100
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %add2 = add nsw i32 %add22, %add1
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %inc = add nsw i32 %inc1, 1
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %add22.lcssa = phi i32 [ %add22, %for.cond ]
  %inc1.lcssa = phi i32 [ %inc1, %for.cond ]
  store i32 %inc1.lcssa, i32* %i, align 1
  store i32 %add22.lcssa, i32* %sum, align 1
  %2 = load i32, i32* %sum, align 4
  ret i32 %2
}

attributes #0 = { nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 7.1.0 (tags/RELEASE_710/final)"}
