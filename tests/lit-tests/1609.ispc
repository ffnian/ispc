//; RUN: %{ispc} %s --target=avx512knl-i32x16 --emit-asm -o - | FileCheck %s --implicit-check-not "vpcmpeqb" -check-prefix=CHECK_AVX512knl16
//; RUN: %{ispc} %s --target=avx512skx-i32x16 --emit-asm -o - | FileCheck %s -check-prefix=CHECK_AVX512skx16
//; RUN: %{ispc} %s --target=avx512skx-i32x8 --emit-asm -o - | FileCheck %s --implicit-check-not "vptestnmw" -check-prefix=CHECK_AVX512skx8
// REQUIRES: LLVM_8_0+
void while_loop_test(uniform float cmp[], uniform float vout[], uniform int count) {
    foreach (index = 0 ... count) {
        varying float c = cmp[index];
// Might have to revisit instructions being checked for.

// CHECK_AVX512knl16: vcmp
// CHECK_AVX512knl16-NEXT: kortestw
// CHECK_AVX512knl16: vcmp
// CHECK_AVX512knl16-NEXT: kortestw
// CHECK_AVX512knl16:vcmp
// CHECK_AVX512knl16-NEXT: kortestw
// CHECK_AVX512knl16: vcmp
// CHECK_AVX512knl16-NEXT: kortestw

// CHECK_AVX512skx16: vcmp
// CHECK_AVX512skx16-NEXT: kortestw
// CHECK_AVX512skx16: vcmp
// CHECK_AVX512skx16-NEXT: kortestw
// CHECK_AVX512skx16:vcmp
// CHECK_AVX512skx16-NEXT: kortestw
// CHECK_AVX512skx16: vcmp
// CHECK_AVX512skx16-NEXT: kortestw

// CHECK_AVX512skx8: vcmp
// CHECK_AVX512skx8-NEXT: kortestb
// CHECK_AVX512skx8: vcmp
// CHECK_AVX512skx8-NEXT: kortestb
// CHECK_AVX512skx8:vcmp
// CHECK_AVX512skx8-NEXT: kortestb
// CHECK_AVX512skx8: vcmp
// CHECK_AVX512skx8-NEXT: kortestb
        while (c > 1.0) {
            c = c - 1.0;
        }

        vout[index] = c;
    }
}
