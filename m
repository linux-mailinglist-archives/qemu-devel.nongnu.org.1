Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A747539A1
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 13:40:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKH8f-0000Ml-FB; Fri, 14 Jul 2023 07:39:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qKH8a-0000KT-LD; Fri, 14 Jul 2023 07:39:04 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qKH8Y-0004Br-ML; Fri, 14 Jul 2023 07:39:04 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0F9FA13D94;
 Fri, 14 Jul 2023 14:38:56 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 0722C14BA3;
 Fri, 14 Jul 2023 14:38:40 +0300 (MSK)
Received: (nullmailer pid 1186219 invoked by uid 1000);
 Fri, 14 Jul 2023 11:38:38 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH, trivial 08/29] tree-wide spelling fixes in comments and some
 messages: arm
Date: Fri, 14 Jul 2023 14:38:13 +0300
Message-Id: <20230714113834.1186117-10-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230714113834.1186117-1-mjt@tls.msk.ru>
References: <20230714113834.1186117-1-mjt@tls.msk.ru>
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
---
 hw/arm/aspeed.c                | 2 +-
 hw/arm/mps2-tz.c               | 2 +-
 hw/intc/arm_gic.c              | 4 ++--
 hw/intc/arm_gicv3_redist.c     | 2 +-
 hw/intc/armv7m_nvic.c          | 2 +-
 include/hw/arm/fsl-imx7.h      | 2 +-
 include/hw/intc/armv7m_nvic.h  | 2 +-
 target/arm/cpu.c               | 2 +-
 target/arm/cpu.h               | 2 +-
 target/arm/cpu64.c             | 2 +-
 target/arm/helper.c            | 4 ++--
 target/arm/tcg/m_helper.c      | 2 +-
 target/arm/tcg/translate-a64.c | 4 ++--
 target/arm/tcg/translate-mve.c | 4 ++--
 target/arm/tcg/translate-sve.c | 2 +-
 target/arm/tcg/translate-vfp.c | 2 +-
 target/arm/tcg/vec_helper.c    | 2 +-
 17 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 6880998484..263626abea 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -1567,3 +1567,3 @@ static void ast1030_evb_i2c_init(AspeedMachineState *bmc)
 
-    /* U10 24C08 connects to SDA/SCL Groupt 1 by default */
+    /* U10 24C08 connects to SDA/SCL Group 1 by default */
     uint8_t *eeprom_buf = g_malloc0(32 * 1024);
diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index 07aecd9497..5873107302 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -1207,3 +1207,3 @@ static void mps2_tz_idau_check(IDAUInterface *ii, uint32_t address,
      * The MPS2 TZ FPGA images have IDAUs in them which are connected to
-     * the Master Security Controllers. Thes have the same logic as
+     * the Master Security Controllers. These have the same logic as
      * is used by the IoTKit for the IDAU connected to the CPU, except
diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index 7a34bc0998..074cf50af2 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -241,3 +241,3 @@ static inline bool gic_lr_entry_is_free(uint32_t entry)
 /* Return true if this LR should trigger an EOI maintenance interrupt, i.e. the
- * corrsponding bit in EISR is set.
+ * corresponding bit in EISR is set.
  */
@@ -1335,3 +1335,3 @@ static void gic_dist_writeb(void *opaque, hwaddr offset,
                for per-CPU interrupts.  It's unclear whether this is the
-               corect behavior.  */
+               correct behavior.  */
             if (value & (1 << i)) {
diff --git a/hw/intc/arm_gicv3_redist.c b/hw/intc/arm_gicv3_redist.c
index 297f7f0263..8153525849 100644
--- a/hw/intc/arm_gicv3_redist.c
+++ b/hw/intc/arm_gicv3_redist.c
@@ -496,3 +496,3 @@ static MemTxResult gicr_writel(GICv3CPUState *cs, hwaddr offset,
          * redistributor and the cpu interface to quiescent, and that
-         * we set the ChildrenAsleep bit once the inteface has reached the
+         * we set the ChildrenAsleep bit once the interface has reached the
          * quiescent state.
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 63afe1fdf5..03b6b8c986 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -896,3 +896,3 @@ int armv7m_nvic_complete_irq(NVICState *s, int irq, bool secure)
         /* Re-pend the exception if it's still held high; only
-         * happens for extenal IRQs
+         * happens for external IRQs
          */
diff --git a/include/hw/arm/fsl-imx7.h b/include/hw/arm/fsl-imx7.h
index 54ea2f0890..fcce6421c8 100644
--- a/include/hw/arm/fsl-imx7.h
+++ b/include/hw/arm/fsl-imx7.h
@@ -167,3 +167,3 @@ enum FslIMX7MemoryMap {
      * Linux kernel show that not to be true and that block is
-     * acutally located @ 0x30890000
+     * actually located @ 0x30890000
      */
diff --git a/include/hw/intc/armv7m_nvic.h b/include/hw/intc/armv7m_nvic.h
index 1ca262fbf8..6b4ae566c9 100644
--- a/include/hw/intc/armv7m_nvic.h
+++ b/include/hw/intc/armv7m_nvic.h
@@ -76,3 +76,3 @@ struct NVICState {
     int exception_prio; /* group prio of the highest prio active exception */
-    int vectpending_prio; /* group prio of the exeception in vectpending */
+    int vectpending_prio; /* group prio of the exception in vectpending */
 
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 69e2bde3c2..93c28d50e5 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -679,3 +679,3 @@ static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
     /*
-     * The PSTATE bits only mask the interrupt if we have not overriden the
+     * The PSTATE bits only mask the interrupt if we have not overridden the
      * ability above.
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 4d6c0f95d5..88e5accda6 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2594,3 +2594,3 @@ static inline bool arm_el_is_aa64(CPUARMState *env, int el)
 
-/* Function for determing whether guest cp register reads and writes should
+/* Function for determining whether guest cp register reads and writes should
  * access the secure or non-secure bank of a cp register.  When EL3 is
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 6012e4ef54..96158093cc 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -97,3 +97,3 @@ void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp)
             /*
-             * For KVM we have to automatically enable all supported unitialized
+             * For KVM we have to automatically enable all supported uninitialized
              * lengths, even when the smaller lengths are not all powers-of-two.
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 8e836aaee1..50f61e42ca 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1676,3 +1676,3 @@ static void pmevtyper_rawwrite(CPUARMState *env, const ARMCPRegInfo *ri,
      * we're potentially updating the type of event here, the value written to
-     * c14_pmevcntr_delta by the preceeding pmu_op_start call may be for a
+     * c14_pmevcntr_delta by the preceding pmu_op_start call may be for a
      * different counter type. Therefore, we need to set this value to the
@@ -7011,3 +7011,3 @@ static const ARMCPRegInfo rme_reginfo[] = {
      * invalidating a range of physical addresses is accomplished by
-     * flushing all tlb entries in the outer sharable domain,
+     * flushing all tlb entries in the outer shareable domain,
      * just like PAALLOS.
diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
index 9cef70e5c9..0045c18f80 100644
--- a/target/arm/tcg/m_helper.c
+++ b/target/arm/tcg/m_helper.c
@@ -150,3 +150,3 @@ uint32_t HELPER(v7m_tt)(CPUARMState *env, uint32_t addr, uint32_t op)
      *  MRVALID: 0 because unpriv and A flag not set
-     *  SREGION: 0 becaus SRVALID is 0
+     *  SREGION: 0 because SRVALID is 0
      *  MREGION: 0 because MRVALID is 0
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 7d0c8f79a7..ef0c47407a 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -184,3 +184,3 @@ void gen_a64_update_pc(DisasContext *s, target_long diff)
  *  + for EL0 and EL1, TBI0 controls addresses with bit 55 == 0
- *    and TBI1 controls addressses with bit 55 == 1.
+ *    and TBI1 controls addresses with bit 55 == 1.
  *    If the appropriate TBI bit is set for the address then
@@ -2315,3 +2315,3 @@ static void handle_sys(DisasContext *s, bool isread,
         /*
-         * A write to any coprocessor regiser that ends a TB
+         * A write to any coprocessor register that ends a TB
          * must rebuild the hflags for the next TB.
diff --git a/target/arm/tcg/translate-mve.c b/target/arm/tcg/translate-mve.c
index bbc7b3f4ce..17d8e6804e 100644
--- a/target/arm/tcg/translate-mve.c
+++ b/target/arm/tcg/translate-mve.c
@@ -2184,3 +2184,3 @@ static bool trans_VMOV_to_2gp(DisasContext *s, arg_VMOV_to_2gp *a)
      * corresponding to the lane of the vector register being accessed
-     * then we should skip perfoming the move, and that we need to do
+     * then we should skip performing the move, and that we need to do
      * the usual check for bad ECI state and advance of ECI state.
@@ -2227,3 +2227,3 @@ static bool trans_VMOV_from_2gp(DisasContext *s, arg_VMOV_to_2gp *a)
      * corresponding to the lane of the vector register being accessed
-     * then we should skip perfoming the move, and that we need to do
+     * then we should skip performing the move, and that we need to do
      * the usual check for bad ECI state and advance of ECI state.
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 8350a65f31..2ba5efadfd 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -1843,3 +1843,3 @@ TRANS_FEAT(PNEXT, aa64_sve, do_pfirst_pnext, a, gen_helper_sve_pnext)
  * a 64-bit register.  The second operand is known to be positive,
- * which halves the comparisions we must perform to bound the result.
+ * which halves the comparisons we must perform to bound the result.
  */
diff --git a/target/arm/tcg/translate-vfp.c b/target/arm/tcg/translate-vfp.c
index 359b1e3e96..d3e89fda91 100644
--- a/target/arm/tcg/translate-vfp.c
+++ b/target/arm/tcg/translate-vfp.c
@@ -146,3 +146,3 @@ static void gen_preserve_fp_state(DisasContext *s, bool skip_context_update)
  * necessary. This corresponds to the parts of the pseudocode
- * ExecuteFPCheck() after the inital PreserveFPState() call.
+ * ExecuteFPCheck() after the initial PreserveFPState() call.
  */
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index f59d3b26ea..6712a2c790 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2628,3 +2628,3 @@ void HELPER(gvec_bfmmla)(void *vd, void *vn, void *vm, void *va, uint32_t desc)
          *
-         * Key to indicies by column:
+         * Key to indices by column:
          *               i   j           i   k             j   k
-- 
2.39.2


