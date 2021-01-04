; ModuleID = 'qs.c'
source_filename = "qs.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@s = common dso_local global [100 x i32] zeroinitializer, align 16

; Function Attrs: uwtable
define dso_local void @quick_sort(i32 %l, i32 %r) #0 {
entry:
  %l.addr = alloca i32, align 4
  %r.addr = alloca i32, align 4
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %x = alloca i32, align 4
  store i32 %l, i32* %l.addr, align 4
  store i32 %r, i32* %r.addr, align 4
  %0 = load i32, i32* %l.addr, align 4
  %1 = load i32, i32* %r.addr, align 4
  %cmp = icmp slt i32 %0, %1
  br i1 %cmp, label %if.then, label %if.end35

if.then:                                          ; preds = %entry
  %2 = load i32, i32* %l.addr, align 4
  store i32 %2, i32* %i, align 4
  %3 = load i32, i32* %r.addr, align 4
  store i32 %3, i32* %j, align 4
  %4 = load i32, i32* %l.addr, align 4
  %idxprom = sext i32 %4 to i64
  %arrayidx = getelementptr inbounds [100 x i32], [100 x i32]* @s, i64 0, i64 %idxprom
  %5 = load i32, i32* %arrayidx, align 4
  store i32 %5, i32* %x, align 4
  br label %while.cond

while.cond:                                       ; preds = %if.end31, %if.then
  %6 = load i32, i32* %i, align 4
  %7 = load i32, i32* %j, align 4
  %cmp1 = icmp slt i32 %6, %7
  br i1 %cmp1, label %while.body, label %while.end32

while.body:                                       ; preds = %while.cond
  br label %while.cond2

while.cond2:                                      ; preds = %while.body7, %while.body
  %8 = load i32, i32* %i, align 4
  %9 = load i32, i32* %j, align 4
  %cmp3 = icmp slt i32 %8, %9
  br i1 %cmp3, label %land.rhs, label %land.end

land.rhs:                                         ; preds = %while.cond2
  %10 = load i32, i32* %j, align 4
  %idxprom4 = sext i32 %10 to i64
  %arrayidx5 = getelementptr inbounds [100 x i32], [100 x i32]* @s, i64 0, i64 %idxprom4
  %11 = load i32, i32* %arrayidx5, align 4
  %12 = load i32, i32* %x, align 4
  %cmp6 = icmp sge i32 %11, %12
  br label %land.end

land.end:                                         ; preds = %land.rhs, %while.cond2
  %13 = phi i1 [ false, %while.cond2 ], [ %cmp6, %land.rhs ]
  br i1 %13, label %while.body7, label %while.end

while.body7:                                      ; preds = %land.end
  %14 = load i32, i32* %j, align 4
  %dec = add nsw i32 %14, -1
  store i32 %dec, i32* %j, align 4
  br label %while.cond2

while.end:                                        ; preds = %land.end
  %15 = load i32, i32* %i, align 4
  %16 = load i32, i32* %j, align 4
  %cmp8 = icmp slt i32 %15, %16
  br i1 %cmp8, label %if.then9, label %if.end

if.then9:                                         ; preds = %while.end
  %17 = load i32, i32* %j, align 4
  %idxprom10 = sext i32 %17 to i64
  %arrayidx11 = getelementptr inbounds [100 x i32], [100 x i32]* @s, i64 0, i64 %idxprom10
  %18 = load i32, i32* %arrayidx11, align 4
  %19 = load i32, i32* %i, align 4
  %inc = add nsw i32 %19, 1
  store i32 %inc, i32* %i, align 4
  %idxprom12 = sext i32 %19 to i64
  %arrayidx13 = getelementptr inbounds [100 x i32], [100 x i32]* @s, i64 0, i64 %idxprom12
  store i32 %18, i32* %arrayidx13, align 4
  br label %if.end

if.end:                                           ; preds = %if.then9, %while.end
  br label %while.cond14

while.cond14:                                     ; preds = %while.body21, %if.end
  %20 = load i32, i32* %i, align 4
  %21 = load i32, i32* %j, align 4
  %cmp15 = icmp slt i32 %20, %21
  br i1 %cmp15, label %land.rhs16, label %land.end20

land.rhs16:                                       ; preds = %while.cond14
  %22 = load i32, i32* %i, align 4
  %idxprom17 = sext i32 %22 to i64
  %arrayidx18 = getelementptr inbounds [100 x i32], [100 x i32]* @s, i64 0, i64 %idxprom17
  %23 = load i32, i32* %arrayidx18, align 4
  %24 = load i32, i32* %x, align 4
  %cmp19 = icmp slt i32 %23, %24
  br label %land.end20

land.end20:                                       ; preds = %land.rhs16, %while.cond14
  %25 = phi i1 [ false, %while.cond14 ], [ %cmp19, %land.rhs16 ]
  br i1 %25, label %while.body21, label %while.end23

while.body21:                                     ; preds = %land.end20
  %26 = load i32, i32* %i, align 4
  %inc22 = add nsw i32 %26, 1
  store i32 %inc22, i32* %i, align 4
  br label %while.cond14

while.end23:                                      ; preds = %land.end20
  %27 = load i32, i32* %i, align 4
  %28 = load i32, i32* %j, align 4
  %cmp24 = icmp slt i32 %27, %28
  br i1 %cmp24, label %if.then25, label %if.end31

if.then25:                                        ; preds = %while.end23
  %29 = load i32, i32* %i, align 4
  %idxprom26 = sext i32 %29 to i64
  %arrayidx27 = getelementptr inbounds [100 x i32], [100 x i32]* @s, i64 0, i64 %idxprom26
  %30 = load i32, i32* %arrayidx27, align 4
  %31 = load i32, i32* %j, align 4
  %dec28 = add nsw i32 %31, -1
  store i32 %dec28, i32* %j, align 4
  %idxprom29 = sext i32 %31 to i64
  %arrayidx30 = getelementptr inbounds [100 x i32], [100 x i32]* @s, i64 0, i64 %idxprom29
  store i32 %30, i32* %arrayidx30, align 4
  br label %if.end31

if.end31:                                         ; preds = %if.then25, %while.end23
  br label %while.cond

while.end32:                                      ; preds = %while.cond
  %32 = load i32, i32* %x, align 4
  %33 = load i32, i32* %i, align 4
  %idxprom33 = sext i32 %33 to i64
  %arrayidx34 = getelementptr inbounds [100 x i32], [100 x i32]* @s, i64 0, i64 %idxprom33
  store i32 %32, i32* %arrayidx34, align 4
  %34 = load i32, i32* %l.addr, align 4
  %35 = load i32, i32* %i, align 4
  %sub = sub nsw i32 %35, 1
  call void @quick_sort(i32 %34, i32 %sub)
  %36 = load i32, i32* %i, align 4
  %add = add nsw i32 %36, 1
  %37 = load i32, i32* %r.addr, align 4
  call void @quick_sort(i32 %add, i32 %37)
  br label %if.end35

if.end35:                                         ; preds = %while.end32, %entry
  ret void
}

attributes #0 = {  "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 7.1.0 (tags/RELEASE_710/final)"}
