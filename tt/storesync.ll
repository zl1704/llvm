; ModuleID = '/home/zl/workspace/clion/llvmtest/test/RSIMD/storesync/storesync.c'
source_filename = "/home/zl/workspace/clion/llvmtest/test/RSIMD/storesync/storesync.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@a = dso_local global i32 5, align 4, !dbg !0
@aa = dso_local global [4 x i32] [i32 1, i32 5, i32 3, i32 4], align 16, !dbg !6
@b = common dso_local global i32 0, align 4, !dbg !12
@.str = private unnamed_addr constant [13 x i8] c"result : %d\0A\00", align 1
@bb = common dso_local global [4 x [4 x [4 x i32]]] zeroinitializer, align 16, !dbg !14

define dso_local i32 @fun_vect() #0 !dbg !22 {
entry:
  %0 = load i32, i32* @a, align 4, !dbg !25
  %add = add nsw i32 %0, 5, !dbg !26
  store i32 %add, i32* getelementptr inbounds ([4 x i32], [4 x i32]* @aa, i64 0, i64 1), align 4, !dbg !27
  %1 = load i32, i32* @b, align 4, !dbg !28
  ret i32 %1, !dbg !29
}

define dso_local i32 @get_vect(i32 %i) #0 !dbg !30 {
entry:
  %i.addr = alloca i32, align 4
  store i32 %i, i32* %i.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %i.addr, metadata !33, metadata !DIExpression()), !dbg !34
  %0 = load i32, i32* %i.addr, align 4, !dbg !35
  %idxprom = sext i32 %0 to i64, !dbg !36
  %arrayidx = getelementptr inbounds [4 x i32], [4 x i32]* @aa, i64 0, i64 %idxprom, !dbg !36
  %1 = load i32, i32* %arrayidx, align 4, !dbg !36
  ret i32 %1, !dbg !37
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @set_vect(i32 %i, i32 %val) #0 !dbg !38 {
entry:
  %i.addr = alloca i32, align 4
  %val.addr = alloca i32, align 4
  store i32 %i, i32* %i.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %i.addr, metadata !41, metadata !DIExpression()), !dbg !42
  store i32 %val, i32* %val.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %val.addr, metadata !43, metadata !DIExpression()), !dbg !44
  %0 = load i32, i32* %val.addr, align 4, !dbg !45
  %1 = load i32, i32* %i.addr, align 4, !dbg !46
  %idxprom = sext i32 %1 to i64, !dbg !47
  %arrayidx = getelementptr inbounds [4 x i32], [4 x i32]* @aa, i64 0, i64 %idxprom, !dbg !47
  store i32 %0, i32* %arrayidx, align 4, !dbg !48
  ret void, !dbg !49
}

; Function Attrs: noinline   uwtable
define dso_local i32 @main() #0 !dbg !50 {
entry:
  %r = alloca i32, align 4
  call void @llvm.dbg.declare(metadata i32* %r, metadata !51, metadata !DIExpression()), !dbg !52
  %call = call i32 @fun_vect(), !dbg !53
  store i32 %call, i32* %r, align 4, !dbg !52
  %call1 = call i32 @get_vect(i32 1), !dbg !54
  %call2 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str, i32 0, i32 0), i32 %call1), !dbg !55
  ret i32 0, !dbg !56
}

declare dso_local i32 @printf(i8*, ...) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!18, !19, !20}
!llvm.ident = !{!21}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "a", scope: !2, file: !3, line: 5, type: !9, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 7.1.0 (tags/RELEASE_710/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !5)
!3 = !DIFile(filename: "/home/zl/workspace/clion/llvmtest/test/RSIMD/storesync/storesync.c", directory: "/home/zl/work/llvm7/tt")
!4 = !{}
!5 = !{!0, !6, !12, !14}
!6 = !DIGlobalVariableExpression(var: !7, expr: !DIExpression())
!7 = distinct !DIGlobalVariable(name: "aa", scope: !2, file: !3, line: 7, type: !8, isLocal: false, isDefinition: true)
!8 = !DICompositeType(tag: DW_TAG_array_type, baseType: !9, size: 128, elements: !10)
!9 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!10 = !{!11}
!11 = !DISubrange(count: 4)
!12 = !DIGlobalVariableExpression(var: !13, expr: !DIExpression())
!13 = distinct !DIGlobalVariable(name: "b", scope: !2, file: !3, line: 6, type: !9, isLocal: false, isDefinition: true)
!14 = !DIGlobalVariableExpression(var: !15, expr: !DIExpression())
!15 = distinct !DIGlobalVariable(name: "bb", scope: !2, file: !3, line: 8, type: !16, isLocal: false, isDefinition: true)
!16 = !DICompositeType(tag: DW_TAG_array_type, baseType: !9, size: 2048, elements: !17)
!17 = !{!11, !11, !11}
!18 = !{i32 2, !"Dwarf Version", i32 4}
!19 = !{i32 2, !"Debug Info Version", i32 3}
!20 = !{i32 1, !"wchar_size", i32 4}
!21 = !{!"clang version 7.1.0 (tags/RELEASE_710/final)"}
!22 = distinct !DISubprogram(name: "fun_vect", scope: !3, file: !3, line: 10, type: !23, isLocal: false, isDefinition: true, scopeLine: 10, isOptimized: false, unit: !2, retainedNodes: !4)
!23 = !DISubroutineType(types: !24)
!24 = !{!9}
!25 = !DILocation(line: 11, column: 13, scope: !22)
!26 = !DILocation(line: 11, column: 15, scope: !22)
!27 = !DILocation(line: 11, column: 11, scope: !22)
!28 = !DILocation(line: 12, column: 12, scope: !22)
!29 = !DILocation(line: 12, column: 5, scope: !22)
!30 = distinct !DISubprogram(name: "get_vect", scope: !3, file: !3, line: 15, type: !31, isLocal: false, isDefinition: true, scopeLine: 15, flags: DIFlagPrototyped, isOptimized: false, unit: !2, retainedNodes: !4)
!31 = !DISubroutineType(types: !32)
!32 = !{!9, !9}
!33 = !DILocalVariable(name: "i", arg: 1, scope: !30, file: !3, line: 15, type: !9)
!34 = !DILocation(line: 15, column: 18, scope: !30)
!35 = !DILocation(line: 17, column: 15, scope: !30)
!36 = !DILocation(line: 17, column: 12, scope: !30)
!37 = !DILocation(line: 17, column: 5, scope: !30)
!38 = distinct !DISubprogram(name: "set_vect", scope: !3, file: !3, line: 21, type: !39, isLocal: false, isDefinition: true, scopeLine: 21, flags: DIFlagPrototyped, isOptimized: false, unit: !2, retainedNodes: !4)
!39 = !DISubroutineType(types: !40)
!40 = !{null, !9, !9}
!41 = !DILocalVariable(name: "i", arg: 1, scope: !38, file: !3, line: 21, type: !9)
!42 = !DILocation(line: 21, column: 19, scope: !38)
!43 = !DILocalVariable(name: "val", arg: 2, scope: !38, file: !3, line: 21, type: !9)
!44 = !DILocation(line: 21, column: 27, scope: !38)
!45 = !DILocation(line: 23, column: 13, scope: !38)
!46 = !DILocation(line: 23, column: 8, scope: !38)
!47 = !DILocation(line: 23, column: 5, scope: !38)
!48 = !DILocation(line: 23, column: 11, scope: !38)
!49 = !DILocation(line: 24, column: 1, scope: !38)
!50 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 26, type: !23, isLocal: false, isDefinition: true, scopeLine: 26, isOptimized: false, unit: !2, retainedNodes: !4)
!51 = !DILocalVariable(name: "r", scope: !50, file: !3, line: 27, type: !9)
!52 = !DILocation(line: 27, column: 9, scope: !50)
!53 = !DILocation(line: 27, column: 13, scope: !50)
!54 = !DILocation(line: 28, column: 28, scope: !50)
!55 = !DILocation(line: 28, column: 5, scope: !50)
!56 = !DILocation(line: 29, column: 1, scope: !50)
