Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8E2761C51
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 16:56:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOJS1-0002Fr-8O; Tue, 25 Jul 2023 10:55:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qOJRw-0002Ej-P3; Tue, 25 Jul 2023 10:55:44 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qOJRs-00009K-ND; Tue, 25 Jul 2023 10:55:44 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3EFE4161C1;
 Tue, 25 Jul 2023 17:55:37 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id C64C11953C;
 Tue, 25 Jul 2023 17:55:34 +0300 (MSK)
Received: (nullmailer pid 3375806 invoked by uid 1000);
 Tue, 25 Jul 2023 14:55:34 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 3/8] arm: spelling fixes
Date: Tue, 25 Jul 2023 17:55:27 +0300
Message-Id: <673d8215415dc0c13e96b8d757102d942916d1b2.1690294956.git.mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1690294956.git.mjt@tls.msk.ru>
References: <cover.1690294956.git.mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 host/include/aarch64/host/cpuinfo.h   | 2 +-
 hw/arm/aspeed.c                       | 2 +-
 hw/arm/mps2-tz.c                      | 2 +-
 hw/intc/arm_gic.c                     | 4 ++--
 hw/intc/arm_gicv3_redist.c            | 2 +-
 hw/intc/armv7m_nvic.c                 | 2 +-
 hw/misc/allwinner-r40-dramc.c         | 2 +-
 hw/misc/exynos4210_rng.c              | 2 +-
 include/hw/arm/fsl-imx7.h             | 2 +-
 include/hw/intc/armv7m_nvic.h         | 2 +-
 target/arm/cpu.c                      | 2 +-
 target/arm/cpu.h                      | 2 +-
 target/arm/cpu64.c                    | 2 +-
 target/arm/helper.c                   | 4 ++--
 target/arm/tcg/m_helper.c             | 2 +-
 target/arm/tcg/translate-a64.c        | 4 ++--
 target/arm/tcg/translate-mve.c        | 4 ++--
 target/arm/tcg/translate-sve.c        | 2 +-
 target/arm/tcg/translate-vfp.c        | 2 +-
 target/arm/tcg/vec_helper.c           | 2 +-
 tests/tcg/aarch64/gdbstub/test-sve.py | 2 +-
 tests/tcg/aarch64/sme-outprod1.c      | 2 +-
 tests/tcg/aarch64/system/boot.S       | 6 +++---
 tests/tcg/aarch64/system/semiheap.c   | 2 +-
 24 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/host/include/aarch64/host/cpuinfo.h b/host/include/aarch64/host/cpuinfo.h
index 05feeb4f43..769626b098 100644
--- a/host/include/aarch64/host/cpuinfo.h
+++ b/host/include/aarch64/host/cpuinfo.h
@@ -1,6 +1,6 @@
 /*
  * SPDX-License-Identifier: GPL-2.0-or-later
- * Host specific cpu indentification for AArch64.
+ * Host specific cpu identification for AArch64.
  */
 
 #ifndef HOST_CPUINFO_H
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 6880998484..263626abea 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -1565,7 +1565,7 @@ static void ast1030_evb_i2c_init(AspeedMachineState *bmc)
 {
     AspeedSoCState *soc = &bmc->soc;
 
-    /* U10 24C08 connects to SDA/SCL Groupt 1 by default */
+    /* U10 24C08 connects to SDA/SCL Group 1 by default */
     uint8_t *eeprom_buf = g_malloc0(32 * 1024);
     smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 0), 0x50, eeprom_buf);
 
diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index 07aecd9497..5873107302 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -1205,7 +1205,7 @@ static void mps2_tz_idau_check(IDAUInterface *ii, uint32_t address,
 {
     /*
      * The MPS2 TZ FPGA images have IDAUs in them which are connected to
-     * the Master Security Controllers. Thes have the same logic as
+     * the Master Security Controllers. These have the same logic as
      * is used by the IoTKit for the IDAU connected to the CPU, except
      * that MSCs don't care about the NSC attribute.
      */
diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index 7a34bc0998..074cf50af2 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -239,7 +239,7 @@ static inline bool gic_lr_entry_is_free(uint32_t entry)
 }
 
 /* Return true if this LR should trigger an EOI maintenance interrupt, i.e. the
- * corrsponding bit in EISR is set.
+ * corresponding bit in EISR is set.
  */
 static inline bool gic_lr_entry_is_eoi(uint32_t entry)
 {
@@ -1333,7 +1333,7 @@ static void gic_dist_writeb(void *opaque, hwaddr offset,
 
             /* ??? This currently clears the pending bit for all CPUs, even
                for per-CPU interrupts.  It's unclear whether this is the
-               corect behavior.  */
+               correct behavior.  */
             if (value & (1 << i)) {
                 GIC_DIST_CLEAR_PENDING(irq + i, ALL_CPU_MASK);
             }
diff --git a/hw/intc/arm_gicv3_redist.c b/hw/intc/arm_gicv3_redist.c
index 297f7f0263..8153525849 100644
--- a/hw/intc/arm_gicv3_redist.c
+++ b/hw/intc/arm_gicv3_redist.c
@@ -494,7 +494,7 @@ static MemTxResult gicr_writel(GICv3CPUState *cs, hwaddr offset,
         /* Only the ProcessorSleep bit is writable. When the guest sets
          * it, it requests that we transition the channel between the
          * redistributor and the cpu interface to quiescent, and that
-         * we set the ChildrenAsleep bit once the inteface has reached the
+         * we set the ChildrenAsleep bit once the interface has reached the
          * quiescent state.
          * Setting the ProcessorSleep to 0 reverses the quiescing, and
          * ChildrenAsleep is cleared once the transition is complete.
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 63afe1fdf5..03b6b8c986 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -894,7 +894,7 @@ int armv7m_nvic_complete_irq(NVICState *s, int irq, bool secure)
     vec->active = 0;
     if (vec->level) {
         /* Re-pend the exception if it's still held high; only
-         * happens for extenal IRQs
+         * happens for external IRQs
          */
         assert(irq >= NVIC_FIRST_IRQ);
         vec->pending = 1;
diff --git a/hw/misc/allwinner-r40-dramc.c b/hw/misc/allwinner-r40-dramc.c
index ea6124744f..6944f84455 100644
--- a/hw/misc/allwinner-r40-dramc.c
+++ b/hw/misc/allwinner-r40-dramc.c
@@ -368,7 +368,7 @@ static const MemoryRegionOps allwinner_r40_detect_ops = {
 
 /*
  * mctl_r40_detect_rank_count in u-boot will write the high 1G of DDR
- * to detect wether the board support dual_rank or not. Create a virtual memory
+ * to detect whether the board support dual_rank or not. Create a virtual memory
  * if the board's ram_size less or equal than 1G, and set read time out flag of
  * REG_DRAMCTL_PGSR when the user touch this high dram.
  */
diff --git a/hw/misc/exynos4210_rng.c b/hw/misc/exynos4210_rng.c
index 1b9e8347a1..9214ec14cc 100644
--- a/hw/misc/exynos4210_rng.c
+++ b/hw/misc/exynos4210_rng.c
@@ -1,5 +1,5 @@
 /*
- *  Exynos4210 Pseudo Random Nubmer Generator Emulation
+ *  Exynos4210 Pseudo Random Number Generator Emulation
  *
  *  Copyright (c) 2017 Krzysztof Kozlowski <krzk@kernel.org>
  *
diff --git a/include/hw/arm/fsl-imx7.h b/include/hw/arm/fsl-imx7.h
index 54ea2f0890..fcce6421c8 100644
--- a/include/hw/arm/fsl-imx7.h
+++ b/include/hw/arm/fsl-imx7.h
@@ -165,7 +165,7 @@ enum FslIMX7MemoryMap {
      * Some versions of the reference manual claim that UART2 is @
      * 0x30870000, but experiments with HW + DT files in upstream
      * Linux kernel show that not to be true and that block is
-     * acutally located @ 0x30890000
+     * actually located @ 0x30890000
      */
     FSL_IMX7_UART2_ADDR           = 0x30890000,
     FSL_IMX7_UART3_ADDR           = 0x30880000,
diff --git a/include/hw/intc/armv7m_nvic.h b/include/hw/intc/armv7m_nvic.h
index 1ca262fbf8..6b4ae566c9 100644
--- a/include/hw/intc/armv7m_nvic.h
+++ b/include/hw/intc/armv7m_nvic.h
@@ -74,7 +74,7 @@ struct NVICState {
      */
     bool vectpending_is_s_banked;
     int exception_prio; /* group prio of the highest prio active exception */
-    int vectpending_prio; /* group prio of the exeception in vectpending */
+    int vectpending_prio; /* group prio of the exception in vectpending */
 
     MemoryRegion sysregmem;
 
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 69e2bde3c2..93c28d50e5 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -677,7 +677,7 @@ static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
     }
 
     /*
-     * The PSTATE bits only mask the interrupt if we have not overriden the
+     * The PSTATE bits only mask the interrupt if we have not overridden the
      * ability above.
      */
     return unmasked || pstate_unmasked;
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 4d6c0f95d5..88e5accda6 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2592,7 +2592,7 @@ static inline bool arm_el_is_aa64(CPUARMState *env, int el)
     return aa64;
 }
 
-/* Function for determing whether guest cp register reads and writes should
+/* Function for determining whether guest cp register reads and writes should
  * access the secure or non-secure bank of a cp register.  When EL3 is
  * operating in AArch32 state, the NS-bit determines whether the secure
  * instance of a cp register should be used. When EL3 is AArch64 (or if
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 6012e4ef54..96158093cc 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -95,7 +95,7 @@ void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp)
 
         if (kvm_enabled()) {
             /*
-             * For KVM we have to automatically enable all supported unitialized
+             * For KVM we have to automatically enable all supported uninitialized
              * lengths, even when the smaller lengths are not all powers-of-two.
              */
             vq_map |= vq_supported & ~vq_init & vq_mask;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 8e836aaee1..50f61e42ca 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1674,7 +1674,7 @@ static void pmevtyper_rawwrite(CPUARMState *env, const ARMCPRegInfo *ri,
      * pmevtyper_rawwrite is called between a pair of pmu_op_start and
      * pmu_op_finish calls when loading saved state for a migration. Because
      * we're potentially updating the type of event here, the value written to
-     * c14_pmevcntr_delta by the preceeding pmu_op_start call may be for a
+     * c14_pmevcntr_delta by the preceding pmu_op_start call may be for a
      * different counter type. Therefore, we need to set this value to the
      * current count for the counter type we're writing so that pmu_op_finish
      * has the correct count for its calculation.
@@ -7009,7 +7009,7 @@ static const ARMCPRegInfo rme_reginfo[] = {
     /*
      * QEMU does not have a way to invalidate by physical address, thus
      * invalidating a range of physical addresses is accomplished by
-     * flushing all tlb entries in the outer sharable domain,
+     * flushing all tlb entries in the outer shareable domain,
      * just like PAALLOS.
      */
     { .name = "TLBI_RPALOS", .state = ARM_CP_STATE_AA64,
diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
index 9cef70e5c9..0045c18f80 100644
--- a/target/arm/tcg/m_helper.c
+++ b/target/arm/tcg/m_helper.c
@@ -148,7 +148,7 @@ uint32_t HELPER(v7m_tt)(CPUARMState *env, uint32_t addr, uint32_t op)
      *  R: 0 because unpriv and A flag not set
      *  SRVALID: 0 because NS
      *  MRVALID: 0 because unpriv and A flag not set
-     *  SREGION: 0 becaus SRVALID is 0
+     *  SREGION: 0 because SRVALID is 0
      *  MREGION: 0 because MRVALID is 0
      */
     return 0;
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 7d0c8f79a7..ef0c47407a 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -182,7 +182,7 @@ void gen_a64_update_pc(DisasContext *s, target_long diff)
  *  + for EL2 and EL3 there is only one TBI bit, and if it is set
  *    then the address is zero-extended, clearing bits [63:56]
  *  + for EL0 and EL1, TBI0 controls addresses with bit 55 == 0
- *    and TBI1 controls addressses with bit 55 == 1.
+ *    and TBI1 controls addresses with bit 55 == 1.
  *    If the appropriate TBI bit is set for the address then
  *    the address is sign-extended from bit 55 into bits [63:56]
  *
@@ -2313,7 +2313,7 @@ static void handle_sys(DisasContext *s, bool isread,
 
     if (!isread && !(ri->type & ARM_CP_SUPPRESS_TB_END)) {
         /*
-         * A write to any coprocessor regiser that ends a TB
+         * A write to any coprocessor register that ends a TB
          * must rebuild the hflags for the next TB.
          */
         gen_rebuild_hflags(s);
diff --git a/target/arm/tcg/translate-mve.c b/target/arm/tcg/translate-mve.c
index bbc7b3f4ce..17d8e6804e 100644
--- a/target/arm/tcg/translate-mve.c
+++ b/target/arm/tcg/translate-mve.c
@@ -2182,7 +2182,7 @@ static bool trans_VMOV_to_2gp(DisasContext *s, arg_VMOV_to_2gp *a)
      * execution if it is not in an IT block. For us this means
      * only that if PSR.ECI says we should not be executing the beat
      * corresponding to the lane of the vector register being accessed
-     * then we should skip perfoming the move, and that we need to do
+     * then we should skip performing the move, and that we need to do
      * the usual check for bad ECI state and advance of ECI state.
      * (If PSR.ECI is non-zero then we cannot be in an IT block.)
      */
@@ -2225,7 +2225,7 @@ static bool trans_VMOV_from_2gp(DisasContext *s, arg_VMOV_to_2gp *a)
      * execution if it is not in an IT block. For us this means
      * only that if PSR.ECI says we should not be executing the beat
      * corresponding to the lane of the vector register being accessed
-     * then we should skip perfoming the move, and that we need to do
+     * then we should skip performing the move, and that we need to do
      * the usual check for bad ECI state and advance of ECI state.
      * (If PSR.ECI is non-zero then we cannot be in an IT block.)
      */
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 8350a65f31..2ba5efadfd 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -1841,7 +1841,7 @@ TRANS_FEAT(PNEXT, aa64_sve, do_pfirst_pnext, a, gen_helper_sve_pnext)
 
 /* Perform an inline saturating addition of a 32-bit value within
  * a 64-bit register.  The second operand is known to be positive,
- * which halves the comparisions we must perform to bound the result.
+ * which halves the comparisons we must perform to bound the result.
  */
 static void do_sat_addsub_32(TCGv_i64 reg, TCGv_i64 val, bool u, bool d)
 {
diff --git a/target/arm/tcg/translate-vfp.c b/target/arm/tcg/translate-vfp.c
index 359b1e3e96..d3e89fda91 100644
--- a/target/arm/tcg/translate-vfp.c
+++ b/target/arm/tcg/translate-vfp.c
@@ -144,7 +144,7 @@ static void gen_preserve_fp_state(DisasContext *s, bool skip_context_update)
  * Generate code for M-profile FP context handling: update the
  * ownership of the FP context, and create a new context if
  * necessary. This corresponds to the parts of the pseudocode
- * ExecuteFPCheck() after the inital PreserveFPState() call.
+ * ExecuteFPCheck() after the initial PreserveFPState() call.
  */
 static void gen_update_fp_context(DisasContext *s)
 {
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index f59d3b26ea..6712a2c790 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2626,7 +2626,7 @@ void HELPER(gvec_bfmmla)(void *vd, void *vn, void *vm, void *va, uint32_t desc)
          * Process the entire segment at once, writing back the
          * results only after we've consumed all of the inputs.
          *
-         * Key to indicies by column:
+         * Key to indices by column:
          *               i   j           i   k             j   k
          */
         sum00 = a[s + H4(0 + 0)];
diff --git a/tests/tcg/aarch64/gdbstub/test-sve.py b/tests/tcg/aarch64/gdbstub/test-sve.py
index b96bdbb99a..ef57c7412c 100644
--- a/tests/tcg/aarch64/gdbstub/test-sve.py
+++ b/tests/tcg/aarch64/gdbstub/test-sve.py
@@ -1,6 +1,6 @@
 from __future__ import print_function
 #
-# Test the SVE registers are visable and changeable via gdbstub
+# Test the SVE registers are visible and changeable via gdbstub
 #
 # This is launched via tests/guest-debug/run-test.py
 #
diff --git a/tests/tcg/aarch64/sme-outprod1.c b/tests/tcg/aarch64/sme-outprod1.c
index 6e5972d75e..0c814ed529 100644
--- a/tests/tcg/aarch64/sme-outprod1.c
+++ b/tests/tcg/aarch64/sme-outprod1.c
@@ -28,7 +28,7 @@ asm(
 "	fmopa za1.s, p0/m, p0/m, z0.s, z0.s\n"
 /*
  * Read the first 4x4 sub-matrix of elements from tile 1:
- * Note that za1h should be interchangable here.
+ * Note that za1h should be interchangeable here.
  */
 "	mov w12, #0\n"
 "	mova z0.s, p0/m, za1v.s[w12, #0]\n"
diff --git a/tests/tcg/aarch64/system/boot.S b/tests/tcg/aarch64/system/boot.S
index f136363d2a..501685d0ec 100644
--- a/tests/tcg/aarch64/system/boot.S
+++ b/tests/tcg/aarch64/system/boot.S
@@ -9,7 +9,7 @@
 
 /*
  * Semihosting interface on ARM AArch64
- * See "Semihosting for AArch32 and AArch64 Relase 2.0" by ARM
+ * See "Semihosting for AArch32 and AArch64 Release 2.0" by ARM
  * w0 - semihosting call number
  * x1 - semihosting parameter
  */
@@ -147,7 +147,7 @@ __start:
 	 * T0SZ[5:0]  = 2^(64 - 25)
 	 *
 	 * The size of T0SZ controls what the initial lookup level. It
-	 * would be nice to start at level 2 but unfortunatly for a
+	 * would be nice to start at level 2 but unfortunately for a
 	 * flat-mapping on the virt machine we need to handle IA's
 	 * with at least 1gb range to see RAM. So we start with a
 	 * level 1 lookup.
@@ -189,7 +189,7 @@ __start:
 	msr	cpacr_el1, x0
 
 	/* Setup some stack space and enter the test code.
-	 * Assume everthing except the return value is garbage when we
+	 * Assume everything except the return value is garbage when we
 	 * return, we won't need it.
 	 */
 	adrp	x0, stack_end
diff --git a/tests/tcg/aarch64/system/semiheap.c b/tests/tcg/aarch64/system/semiheap.c
index 693a1b037d..1a8c0f31a0 100644
--- a/tests/tcg/aarch64/system/semiheap.c
+++ b/tests/tcg/aarch64/system/semiheap.c
@@ -86,7 +86,7 @@ int main(int argc, char *argv[argc])
         }
         ptr_to_heap++;
     }
-    ml_printf("r/w to heap upto %p\n", ptr_to_heap);
+    ml_printf("r/w to heap up to %p\n", ptr_to_heap);
 
     ml_printf("Passed HeapInfo checks\n");
     return 0;
-- 
2.39.2


