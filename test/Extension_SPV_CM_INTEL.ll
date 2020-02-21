; RUN: llvm-as %s -o %t.bc
; RUN: llvm-spirv %t.bc -o %t.spt -spirv-text
; RUN: FileCheck %s --input-file %t.spt -check-prefix=SPV

; ModuleID = 'float_control_empty.bc'
source_filename = "float_control_empty.cpp"
target datalayout = "e-p:64:64-i64:64-n8:16:32"
target triple = "genx64-pc-windows-msvc"

; SPV: Extension "SPV_INTEL_cm"
; Function Attrs: noinline norecurse nounwind readnone
define dso_local dllexport void @k_no_fc(i32 %ibuf, i32 %obuf) local_unnamed_addr #16 {
entry:
  ret void
}

attributes #16 = { noinline norecurse nounwind readnone "CMGenxMain" "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!genx.kernels = !{!0}
!llvm.module.flags = !{!5}
!llvm.ident = !{!6}

!0 = !{void (i32, i32)* @k_no_fc, !"k_no_fc", !1, i32 0, !2, !3, !4, i32 0, i32 0}
!1 = !{i32 2, i32 2}
!2 = !{i32 32, i32 36}
!3 = !{i32 0, i32 0}
!4 = !{!"", !""}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 8.0.1"}
!7 = !{i32 6938}
