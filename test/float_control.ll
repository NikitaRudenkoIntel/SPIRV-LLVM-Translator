; RUN: llvm-as %s -o %t.bc
; RUN: llvm-spirv %t.bc -o %t.spv
; RUN: llvm-spirv %t.bc -o %t.spt -spirv-text
; RUN: llvm-spirv -r %t.spv -o %t.bc
; RUN: llvm-dis %t.bc -o %t.ll
; RUN: FileCheck %s --input-file %t.ll
; RUN: FileCheck %s --input-file %t.spt -check-prefix=SPV


; ModuleID = 'float_control.bc'
source_filename = "float_control.cpp"
target datalayout = "e-p:64:64-i64:64-n8:16:32"
target triple = "genx64-pc-windows-msvc"

; CHECK-DAG: @k_rte{{[^a-zA-Z0-9_][^#]*}}#[[K_RTE:[0-9]+]]
; CHECK-DAG: attributes #[[K_RTE]]{{[^0-9].*"CMFloatControl"="0"}}
; SPV-DAG: EntryPoint 6 [[S_RTE:[0-9]+]] "k_rte"
; SPV-DAG: ExecutionMode [[S_RTE]] 4460 64
; SPV-DAG: ExecutionMode [[S_RTE]] 4460 32
; SPV-DAG: ExecutionMode [[S_RTE]] 4460 16
; SPV-DAG: ExecutionMode [[S_RTE]] 4462 64
; SPV-DAG: ExecutionMode [[S_RTE]] 4462 32
; SPV-DAG: ExecutionMode [[S_RTE]] 4462 16
; SPV-DAG: ExecutionMode [[S_RTE]] 5623 64
; SPV-DAG: ExecutionMode [[S_RTE]] 5623 32
; SPV-DAG: ExecutionMode [[S_RTE]] 5623 16
; Function Attrs: noinline norecurse nounwind readnone
define dso_local dllexport void @k_rte(i32 %ibuf, i32 %obuf) local_unnamed_addr #16 {
entry:
  ret void
}

; CHECK-DAG: @k_rtp{{[^a-zA-Z0-9_][^#]*}}#[[K_RTP:[0-9]+]]
; CHECK-DAG: attributes #[[K_RTP]]{{[^0-9].*"CMFloatControl"="16"}}
; SPV-DAG: EntryPoint 6 [[S_RTP:[0-9]+]] "k_rtp"
; SPV-DAG: ExecutionMode [[S_RTP]] 4460 64
; SPV-DAG: ExecutionMode [[S_RTP]] 4460 32
; SPV-DAG: ExecutionMode [[S_RTP]] 4460 16
; SPV-DAG: ExecutionMode [[S_RTP]] 5620 64
; SPV-DAG: ExecutionMode [[S_RTP]] 5620 32
; SPV-DAG: ExecutionMode [[S_RTP]] 5620 16
; SPV-DAG: ExecutionMode [[S_RTP]] 5623 64
; SPV-DAG: ExecutionMode [[S_RTP]] 5623 32
; SPV-DAG: ExecutionMode [[S_RTP]] 5623 16
; Function Attrs: noinline norecurse nounwind readnone
define dso_local dllexport void @k_rtp(i32 %ibuf, i32 %obuf) local_unnamed_addr #17 {
entry:
  ret void
}

; CHECK-DAG: @k_rtn{{[^a-zA-Z0-9_][^#]*}}#[[K_RTN:[0-9]+]]
; CHECK-DAG: attributes #[[K_RTN]]{{[^0-9].*"CMFloatControl"="32"}}
; SPV-DAG: EntryPoint 6 [[S_RTN:[0-9]+]] "k_rtn"
; SPV-DAG: ExecutionMode [[S_RTN]] 4460 64
; SPV-DAG: ExecutionMode [[S_RTN]] 4460 32
; SPV-DAG: ExecutionMode [[S_RTN]] 4460 16
; SPV-DAG: ExecutionMode [[S_RTN]] 5621 64
; SPV-DAG: ExecutionMode [[S_RTN]] 5621 32
; SPV-DAG: ExecutionMode [[S_RTN]] 5621 16
; SPV-DAG: ExecutionMode [[S_RTN]] 5623 64
; SPV-DAG: ExecutionMode [[S_RTN]] 5623 32
; SPV-DAG: ExecutionMode [[S_RTN]] 5623 16
; Function Attrs: noinline norecurse nounwind readnone
define dso_local dllexport void @k_rtn(i32 %ibuf, i32 %obuf) local_unnamed_addr #18 {
entry:
  ret void
}

; CHECK-DAG: @k_rtz{{[^a-zA-Z0-9_][^#]*}}#[[K_RTZ:[0-9]+]]
; CHECK-DAG: attributes #[[K_RTZ]]{{[^0-9].*"CMFloatControl"="48"}}
; SPV-DAG: EntryPoint 6 [[S_RTZ:[0-9]+]] "k_rtz"
; SPV-DAG: ExecutionMode [[S_RTZ]] 4460 64
; SPV-DAG: ExecutionMode [[S_RTZ]] 4460 32
; SPV-DAG: ExecutionMode [[S_RTZ]] 4460 16
; SPV-DAG: ExecutionMode [[S_RTZ]] 4463 64
; SPV-DAG: ExecutionMode [[S_RTZ]] 4463 32
; SPV-DAG: ExecutionMode [[S_RTZ]] 4463 16
; SPV-DAG: ExecutionMode [[S_RTZ]] 5623 64
; SPV-DAG: ExecutionMode [[S_RTZ]] 5623 32
; SPV-DAG: ExecutionMode [[S_RTZ]] 5623 16
; Function Attrs: noinline norecurse nounwind readnone
define dso_local dllexport void @k_rtz(i32 %ibuf, i32 %obuf) local_unnamed_addr #19 {
entry:
  ret void
}

; CHECK-DAG: @k_ftz{{[^a-zA-Z0-9_][^#]*}}#[[K_RTE]]{{[^0-9]}}
; SPV-DAG: EntryPoint 6 [[S_FTZ:[0-9]+]] "k_ftz"
; SPV-DAG: ExecutionMode [[S_FTZ]] 4460 64
; SPV-DAG: ExecutionMode [[S_FTZ]] 4460 32
; SPV-DAG: ExecutionMode [[S_FTZ]] 4460 16
; SPV-DAG: ExecutionMode [[S_FTZ]] 4462 64
; SPV-DAG: ExecutionMode [[S_FTZ]] 4462 32
; SPV-DAG: ExecutionMode [[S_FTZ]] 4462 16
; SPV-DAG: ExecutionMode [[S_FTZ]] 5623 64
; SPV-DAG: ExecutionMode [[S_FTZ]] 5623 32
; SPV-DAG: ExecutionMode [[S_FTZ]] 5623 16
; Function Attrs: noinline norecurse nounwind readnone
define dso_local dllexport void @k_ftz(i32 %ibuf, i32 %obuf) local_unnamed_addr #16 {
entry:
  ret void
}

; CHECK-DAG: @k_dd{{[^a-zA-Z0-9_][^#]*}}#[[K_DD:[0-9]+]]
; CHECK-DAG: attributes #[[K_DD]]{{[^0-9].*"CMFloatControl"="64"}}
; SPV-DAG: EntryPoint 6 [[S_DD:[0-9]+]] "k_dd"
; SPV-DAG: ExecutionMode [[S_DD]] 4459 64
; SPV-DAG: ExecutionMode [[S_DD]] 4460 32
; SPV-DAG: ExecutionMode [[S_DD]] 4460 16
; SPV-DAG: ExecutionMode [[S_DD]] 4462 64
; SPV-DAG: ExecutionMode [[S_DD]] 4462 32
; SPV-DAG: ExecutionMode [[S_DD]] 4462 16
; SPV-DAG: ExecutionMode [[S_DD]] 5623 64
; SPV-DAG: ExecutionMode [[S_DD]] 5623 32
; SPV-DAG: ExecutionMode [[S_DD]] 5623 16
; Function Attrs: noinline norecurse nounwind readnone
define dso_local dllexport void @k_dd(i32 %ibuf, i32 %obuf) local_unnamed_addr #20 {
entry:
  ret void
}

; CHECK-DAG: @k_df{{[^a-zA-Z0-9_][^#]*}}#[[K_DF:[0-9]+]]
; CHECK-DAG: attributes #[[K_DF]]{{[^0-9].*"CMFloatControl"="128"}}
; SPV-DAG: EntryPoint 6 [[S_DF:[0-9]+]] "k_df"
; SPV-DAG: ExecutionMode [[S_DF]] 4459 32
; SPV-DAG: ExecutionMode [[S_DF]] 4460 64
; SPV-DAG: ExecutionMode [[S_DF]] 4460 16
; SPV-DAG: ExecutionMode [[S_DF]] 4462 64
; SPV-DAG: ExecutionMode [[S_DF]] 4462 32
; SPV-DAG: ExecutionMode [[S_DF]] 4462 16
; SPV-DAG: ExecutionMode [[S_DF]] 5623 64
; SPV-DAG: ExecutionMode [[S_DF]] 5623 32
; SPV-DAG: ExecutionMode [[S_DF]] 5623 16
; Function Attrs: noinline norecurse nounwind readnone
define dso_local dllexport void @k_df(i32 %ibuf, i32 %obuf) local_unnamed_addr #21 {
entry:
  ret void
}

; CHECK-DAG: @k_dhf{{[^a-zA-Z0-9_][^#]*}}#[[K_DFH:[0-9]+]]
; CHECK-DAG: attributes #[[K_DFH]]{{[^0-9].*"CMFloatControl"="1024"}}
; SPV-DAG: EntryPoint 6 [[S_DFH:[0-9]+]] "k_dhf"
; SPV-DAG: ExecutionMode [[S_DFH]] 4459 16
; SPV-DAG: ExecutionMode [[S_DFH]] 4460 64
; SPV-DAG: ExecutionMode [[S_DFH]] 4460 32
; SPV-DAG: ExecutionMode [[S_DFH]] 4462 64
; SPV-DAG: ExecutionMode [[S_DFH]] 4462 32
; SPV-DAG: ExecutionMode [[S_DFH]] 4462 16
; SPV-DAG: ExecutionMode [[S_DFH]] 5623 64
; SPV-DAG: ExecutionMode [[S_DFH]] 5623 32
; SPV-DAG: ExecutionMode [[S_DFH]] 5623 16
; Function Attrs: noinline norecurse nounwind readnone
define dso_local dllexport void @k_dhf(i32 %ibuf, i32 %obuf) local_unnamed_addr #22 {
entry:
  ret void
}

; CHECK-DAG: @k_d{{[^a-zA-Z0-9_][^#]*}}#[[K_D:[0-9]+]]
; CHECK-DAG: attributes #[[K_D]]{{[^0-9].*"CMFloatControl"="1216"}}
; SPV-DAG: EntryPoint 6 [[S_D:[0-9]+]] "k_d"
; SPV-DAG: ExecutionMode [[S_D]] 4459 64
; SPV-DAG: ExecutionMode [[S_D]] 4459 32
; SPV-DAG: ExecutionMode [[S_D]] 4459 16
; SPV-DAG: ExecutionMode [[S_D]] 4462 64
; SPV-DAG: ExecutionMode [[S_D]] 4462 32
; SPV-DAG: ExecutionMode [[S_D]] 4462 16
; SPV-DAG: ExecutionMode [[S_D]] 5623 64
; SPV-DAG: ExecutionMode [[S_D]] 5623 32
; SPV-DAG: ExecutionMode [[S_D]] 5623 16
; Function Attrs: noinline norecurse nounwind readnone
define dso_local dllexport void @k_d(i32 %ibuf, i32 %obuf) local_unnamed_addr #23 {
entry:
  ret void
}

; CHECK-DAG: @k_ieee{{[^a-zA-Z0-9_][^#]*}}#[[K_RTE]]{{[^0-9]}}
; SPV-DAG: EntryPoint 6 [[S_IEEE:[0-9]+]] "k_ieee"
; SPV-DAG: ExecutionMode [[S_IEEE]] 4460 64
; SPV-DAG: ExecutionMode [[S_IEEE]] 4460 32
; SPV-DAG: ExecutionMode [[S_IEEE]] 4460 16
; SPV-DAG: ExecutionMode [[S_IEEE]] 4462 64
; SPV-DAG: ExecutionMode [[S_IEEE]] 4462 32
; SPV-DAG: ExecutionMode [[S_IEEE]] 4462 16
; SPV-DAG: ExecutionMode [[S_IEEE]] 5623 64
; SPV-DAG: ExecutionMode [[S_IEEE]] 5623 32
; SPV-DAG: ExecutionMode [[S_IEEE]] 5623 16
; Function Attrs: noinline norecurse nounwind readnone
define dso_local dllexport void @k_ieee(i32 %ibuf, i32 %obuf) local_unnamed_addr #16 {
entry:
  ret void
}

; CHECK-DAG: @k_alt{{[^a-zA-Z0-9_][^#]*}}#[[K_ALT:[0-9]+]]
; CHECK-DAG: attributes #[[K_ALT]]{{[^0-9].*"CMFloatControl"="1"}}
; SPV-DAG: EntryPoint 6 [[S_ALT:[0-9]+]] "k_alt"
; SPV-DAG: ExecutionMode [[S_ALT]] 4460 64
; SPV-DAG: ExecutionMode [[S_ALT]] 4460 32
; SPV-DAG: ExecutionMode [[S_ALT]] 4460 16
; SPV-DAG: ExecutionMode [[S_ALT]] 4462 64
; SPV-DAG: ExecutionMode [[S_ALT]] 4462 32
; SPV-DAG: ExecutionMode [[S_ALT]] 4462 16
; SPV-DAG: ExecutionMode [[S_ALT]] 5622 64
; SPV-DAG: ExecutionMode [[S_ALT]] 5622 32
; SPV-DAG: ExecutionMode [[S_ALT]] 5622 16
; Function Attrs: noinline norecurse nounwind readnone
define dso_local dllexport void @k_alt(i32 %ibuf, i32 %obuf) local_unnamed_addr #24 {
entry:
  ret void
}

; CHECK-DAG: @k_rtp_rtn{{[^a-zA-Z0-9_][^#]*}}#[[K_RTZ]]{{[^0-9]}}
; SPV-DAG: EntryPoint 6 [[S_RTP_RTN:[0-9]+]] "k_rtp_rtn"
; SPV-DAG: ExecutionMode [[S_RTP_RTN]] 4460 64
; SPV-DAG: ExecutionMode [[S_RTP_RTN]] 4460 32
; SPV-DAG: ExecutionMode [[S_RTP_RTN]] 4460 16
; SPV-DAG: ExecutionMode [[S_RTP_RTN]] 4463 64
; SPV-DAG: ExecutionMode [[S_RTP_RTN]] 4463 32
; SPV-DAG: ExecutionMode [[S_RTP_RTN]] 4463 16
; SPV-DAG: ExecutionMode [[S_RTP_RTN]] 5623 64
; SPV-DAG: ExecutionMode [[S_RTP_RTN]] 5623 32
; SPV-DAG: ExecutionMode [[S_RTP_RTN]] 5623 16
; Function Attrs: noinline norecurse nounwind readnone
define dso_local dllexport void @k_rtp_rtn(i32 %ibuf, i32 %obuf) local_unnamed_addr #19 {
entry:
  ret void
}

; CHECK-DAG: @k_dd_df_dhf{{[^a-zA-Z0-9_][^#]*}}#[[K_D]]{{[^0-9]}}
; SPV-DAG: EntryPoint 6 [[S_DD_DF_DHF:[0-9]+]] "k_dd_df_dhf"
; SPV-DAG: ExecutionMode [[S_DD_DF_DHF]] 4459 64
; SPV-DAG: ExecutionMode [[S_DD_DF_DHF]] 4459 32
; SPV-DAG: ExecutionMode [[S_DD_DF_DHF]] 4459 16
; SPV-DAG: ExecutionMode [[S_DD_DF_DHF]] 4462 64
; SPV-DAG: ExecutionMode [[S_DD_DF_DHF]] 4462 32
; SPV-DAG: ExecutionMode [[S_DD_DF_DHF]] 4462 16
; SPV-DAG: ExecutionMode [[S_DD_DF_DHF]] 5623 64
; SPV-DAG: ExecutionMode [[S_DD_DF_DHF]] 5623 32
; SPV-DAG: ExecutionMode [[S_DD_DF_DHF]] 5623 16
; Function Attrs: noinline norecurse nounwind readnone
define dso_local dllexport void @k_dd_df_dhf(i32 %ibuf, i32 %obuf) local_unnamed_addr #23 {
entry:
  ret void
}

; CHECK-DAG: @k_rte_ftz_ieee{{[^#]*}}#[[K_RTE]]{{[^0-9]}}
; SPV-DAG: EntryPoint 6 [[S_RTE_FTZ_IEEE:[0-9]+]] "k_rte_ftz_ieee"
; SPV-DAG: ExecutionMode [[S_RTE_FTZ_IEEE]] 4460 64
; SPV-DAG: ExecutionMode [[S_RTE_FTZ_IEEE]] 4460 32
; SPV-DAG: ExecutionMode [[S_RTE_FTZ_IEEE]] 4460 16
; SPV-DAG: ExecutionMode [[S_RTE_FTZ_IEEE]] 4462 64
; SPV-DAG: ExecutionMode [[S_RTE_FTZ_IEEE]] 4462 32
; SPV-DAG: ExecutionMode [[S_RTE_FTZ_IEEE]] 4462 16
; SPV-DAG: ExecutionMode [[S_RTE_FTZ_IEEE]] 5623 64
; SPV-DAG: ExecutionMode [[S_RTE_FTZ_IEEE]] 5623 32
; SPV-DAG: ExecutionMode [[S_RTE_FTZ_IEEE]] 5623 16
; Function Attrs: noinline norecurse nounwind readnone
define dso_local dllexport void @k_rte_ftz_ieee(i32 %ibuf, i32 %obuf) local_unnamed_addr #16 {
entry:
  ret void
}

; CHECK-DAG: @k_rtp_df_alt{{[^a-zA-Z0-9_][^#]*}}#[[K_RTP_DF_ALT:[0-9]+]]
; CHECK-DAG: attributes #[[K_RTP_DF_ALT]]{{[^0-9].*"CMFloatControl"="145"}}
; SPV-DAG: EntryPoint 6 [[S_RTP_DF_ALT:[0-9]+]] "k_rtp_df_alt"
; SPV-DAG: ExecutionMode [[S_RTP_DF_ALT]] 4459 32
; SPV-DAG: ExecutionMode [[S_RTP_DF_ALT]] 4460 64
; SPV-DAG: ExecutionMode [[S_RTP_DF_ALT]] 4460 16
; SPV-DAG: ExecutionMode [[S_RTP_DF_ALT]] 5620 64
; SPV-DAG: ExecutionMode [[S_RTP_DF_ALT]] 5620 32
; SPV-DAG: ExecutionMode [[S_RTP_DF_ALT]] 5620 16
; SPV-DAG: ExecutionMode [[S_RTP_DF_ALT]] 5622 64
; SPV-DAG: ExecutionMode [[S_RTP_DF_ALT]] 5622 32
; SPV-DAG: ExecutionMode [[S_RTP_DF_ALT]] 5622 16
; Function Attrs: noinline norecurse nounwind readnone
define dso_local dllexport void @k_rtp_df_alt(i32 %ibuf, i32 %obuf) local_unnamed_addr #25 {
entry:
  ret void
}

; CHECK-DAG: @k_rtz_d_alt{{[^a-zA-Z0-9_][^#]*}}#[[K_RTZ_D_ALT:[0-9]+]]
; CHECK-DAG: attributes #[[K_RTZ_D_ALT]]{{[^0-9].*"CMFloatControl"="1265"}}
; SPV-DAG: EntryPoint 6 [[S_RTZ_D_ALT:[0-9]+]] "k_rtz_d_alt"
; SPV-DAG: ExecutionMode [[S_RTZ_D_ALT]] 4459 64
; SPV-DAG: ExecutionMode [[S_RTZ_D_ALT]] 4459 32
; SPV-DAG: ExecutionMode [[S_RTZ_D_ALT]] 4459 16
; SPV-DAG: ExecutionMode [[S_RTZ_D_ALT]] 4463 64
; SPV-DAG: ExecutionMode [[S_RTZ_D_ALT]] 4463 32
; SPV-DAG: ExecutionMode [[S_RTZ_D_ALT]] 4463 16
; SPV-DAG: ExecutionMode [[S_RTZ_D_ALT]] 5622 64
; SPV-DAG: ExecutionMode [[S_RTZ_D_ALT]] 5622 32
; SPV-DAG: ExecutionMode [[S_RTZ_D_ALT]] 5622 16
; Function Attrs: noinline norecurse nounwind readnone
define dso_local dllexport void @k_rtz_d_alt(i32 %ibuf, i32 %obuf) local_unnamed_addr #26 {
entry:
  ret void
}

attributes #16 = { noinline norecurse nounwind readnone "CMFloatControl"="0" "CMGenxMain" "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #17 = { noinline norecurse nounwind readnone "CMFloatControl"="16" "CMGenxMain" "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #18 = { noinline norecurse nounwind readnone "CMFloatControl"="32" "CMGenxMain" "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #19 = { noinline norecurse nounwind readnone "CMFloatControl"="48" "CMGenxMain" "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #20 = { noinline norecurse nounwind readnone "CMFloatControl"="64" "CMGenxMain" "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #21 = { noinline norecurse nounwind readnone "CMFloatControl"="128" "CMGenxMain" "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #22 = { noinline norecurse nounwind readnone "CMFloatControl"="1024" "CMGenxMain" "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #23 = { noinline norecurse nounwind readnone "CMFloatControl"="1216" "CMGenxMain" "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #24 = { noinline norecurse nounwind readnone "CMFloatControl"="1" "CMGenxMain" "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #25 = { noinline norecurse nounwind readnone "CMFloatControl"="145" "CMGenxMain" "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #26 = { noinline norecurse nounwind readnone "CMFloatControl"="1265" "CMGenxMain" "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!genx.kernels = !{!0, !5, !6, !7, !8, !9, !10, !11, !12, !13, !14, !15, !16, !17, !18, !19}
!llvm.module.flags = !{!20}
!llvm.ident = !{!21}

!0 = !{void (i32, i32)* @k_rte, !"k_rte", !1, i32 0, !2, !3, !4, i32 0, i32 0}
!1 = !{i32 2, i32 2}
!2 = !{i32 32, i32 36}
!3 = !{i32 0, i32 0}
!4 = !{!"", !""}
!5 = !{void (i32, i32)* @k_rtp, !"k_rtp", !1, i32 0, !2, !3, !4, i32 0, i32 0}
!6 = !{void (i32, i32)* @k_rtn, !"k_rtn", !1, i32 0, !2, !3, !4, i32 0, i32 0}
!7 = !{void (i32, i32)* @k_rtz, !"k_rtz", !1, i32 0, !2, !3, !4, i32 0, i32 0}
!8 = !{void (i32, i32)* @k_ftz, !"k_ftz", !1, i32 0, !2, !3, !4, i32 0, i32 0}
!9 = !{void (i32, i32)* @k_dd, !"k_dd", !1, i32 0, !2, !3, !4, i32 0, i32 0}
!10 = !{void (i32, i32)* @k_df, !"k_df", !1, i32 0, !2, !3, !4, i32 0, i32 0}
!11 = !{void (i32, i32)* @k_dhf, !"k_dhf", !1, i32 0, !2, !3, !4, i32 0, i32 0}
!12 = !{void (i32, i32)* @k_d, !"k_d", !1, i32 0, !2, !3, !4, i32 0, i32 0}
!13 = !{void (i32, i32)* @k_ieee, !"k_ieee", !1, i32 0, !2, !3, !4, i32 0, i32 0}
!14 = !{void (i32, i32)* @k_alt, !"k_alt", !1, i32 0, !2, !3, !4, i32 0, i32 0}
!15 = !{void (i32, i32)* @k_rtp_rtn, !"k_rtp_rtn", !1, i32 0, !2, !3, !4, i32 0, i32 0}
!16 = !{void (i32, i32)* @k_dd_df_dhf, !"k_dd_df_dhf", !1, i32 0, !2, !3, !4, i32 0, i32 0}
!17 = !{void (i32, i32)* @k_rte_ftz_ieee, !"k_rte_ftz_ieee", !1, i32 0, !2, !3, !4, i32 0, i32 0}
!18 = !{void (i32, i32)* @k_rtp_df_alt, !"k_rtp_df_alt", !1, i32 0, !2, !3, !4, i32 0, i32 0}
!19 = !{void (i32, i32)* @k_rtz_d_alt, !"k_rtz_d_alt", !1, i32 0, !2, !3, !4, i32 0, i32 0}
!20 = !{i32 1, !"wchar_size", i32 4}
!21 = !{!"clang version 8.0.1"}
!22 = !{i32 6938}
