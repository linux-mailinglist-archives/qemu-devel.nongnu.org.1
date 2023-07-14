Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 555F97539A2
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 13:40:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKH9M-0000fQ-Qw; Fri, 14 Jul 2023 07:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qKH9E-0000Zy-1X; Fri, 14 Jul 2023 07:39:46 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qKH99-0004K8-Op; Fri, 14 Jul 2023 07:39:43 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4A83F13D9B;
 Fri, 14 Jul 2023 14:38:57 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 4413314BAA;
 Fri, 14 Jul 2023 14:38:41 +0300 (MSK)
Received: (nullmailer pid 1186240 invoked by uid 1000);
 Fri, 14 Jul 2023 11:38:38 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH, trivial 15/29] tree-wide spelling fixes in comments and some
 messages: other architectures
Date: Fri, 14 Jul 2023 14:38:20 +0300
Message-Id: <20230714113834.1186117-17-mjt@tls.msk.ru>
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
 host/include/aarch64/host/cpuinfo.h              |  2 +-
 host/include/generic/host/cpuinfo.h              |  2 +-
 hw/m68k/next-cube.c                              |  2 +-
 hw/m68k/next-kbd.c                               |  2 +-
 hw/m68k/virt.c                                   |  2 +-
 hw/microblaze/petalogix_ml605_mmu.c              |  2 +-
 hw/misc/allwinner-r40-dramc.c                    |  2 +-
 hw/misc/exynos4210_rng.c                         |  2 +-
 hw/sparc/sun4m_iommu.c                           |  8 ++++----
 target/alpha/cpu.h                               |  4 ++--
 target/alpha/translate.c                         |  2 +-
 target/cris/helper.c                             |  6 +++---
 target/cris/op_helper.c                          |  2 +-
 target/cris/translate.c                          | 16 ++++++++--------
 target/hppa/cpu.h                                |  4 ++--
 target/hppa/int_helper.c                         |  2 +-
 target/hppa/translate.c                          |  2 +-
 target/loongarch/cpu-csr.h                       |  2 +-
 target/m68k/helper.c                             |  4 ++--
 target/microblaze/cpu.h                          |  2 +-
 target/openrisc/cpu.h                            |  2 +-
 target/openrisc/translate.c                      |  4 ++--
 target/rx/translate.c                            |  4 ++--
 target/sparc/asi.h                               | 14 +++++++-------
 target/tricore/csfr.h.inc                        |  2 +-
 target/tricore/helper.c                          |  2 +-
 target/tricore/translate.c                       |  8 ++++----
 tests/tcg/Makefile.target                        |  4 ++--
 tests/tcg/aarch64/gdbstub/test-sve.py            |  2 +-
 tests/tcg/aarch64/sme-outprod1.c                 |  2 +-
 tests/tcg/aarch64/system/boot.S                  |  6 +++---
 tests/tcg/aarch64/system/semiheap.c              |  2 +-
 tests/tcg/multiarch/sha512.c                     |  2 +-
 .../tcg/multiarch/system/Makefile.softmmu-target |  2 +-
 tests/tcg/tricore/c/crt0-tc2x.S                  |  4 ++--
 tests/tcg/x86_64/system/boot.S                   |  4 ++--
 36 files changed, 67 insertions(+), 67 deletions(-)

diff --git a/host/include/aarch64/host/cpuinfo.h b/host/include/aarch64/host/cpuinfo.h
index 05feeb4f43..769626b098 100644
--- a/host/include/aarch64/host/cpuinfo.h
+++ b/host/include/aarch64/host/cpuinfo.h
@@ -2,3 +2,3 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
- * Host specific cpu indentification for AArch64.
+ * Host specific cpu identification for AArch64.
  */
diff --git a/host/include/generic/host/cpuinfo.h b/host/include/generic/host/cpuinfo.h
index eca672064a..67ad410871 100644
--- a/host/include/generic/host/cpuinfo.h
+++ b/host/include/generic/host/cpuinfo.h
@@ -1,3 +1,3 @@
 /*
- * No host specific cpu indentification.
+ * No host specific cpu identification.
  * SPDX-License-Identifier: GPL-2.0-or-later
diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index ce8ee50b9e..5d244b3b95 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -736,3 +736,3 @@ static void next_irq(void *opaque, int number, int level)
 
-    /* first switch sets interupt status */
+    /* first switch sets interrupt status */
     /* DPRINTF("IRQ %i\n",number); */
diff --git a/hw/m68k/next-kbd.c b/hw/m68k/next-kbd.c
index 0544160e91..0c348c18cf 100644
--- a/hw/m68k/next-kbd.c
+++ b/hw/m68k/next-kbd.c
@@ -39,3 +39,3 @@ OBJECT_DECLARE_SIMPLE_TYPE(NextKBDState, NEXTKBD)
 
-/* following defintions from next68k netbsd */
+/* following definitions from next68k netbsd */
 #define CSR_INT 0x00800000
diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
index 731205b215..de91726cf9 100644
--- a/hw/m68k/virt.c
+++ b/hw/m68k/virt.c
@@ -3,3 +3,3 @@
  *
- * QEMU Vitual M68K Machine
+ * QEMU Virtual M68K Machine
  *
diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogix_ml605_mmu.c
index a24fadddca..babb053035 100644
--- a/hw/microblaze/petalogix_ml605_mmu.c
+++ b/hw/microblaze/petalogix_ml605_mmu.c
@@ -106,3 +106,3 @@ petalogix_ml605_init(MachineState *machine)
     /* 5th parameter 2 means bank-width
-     * 10th paremeter 0 means little-endian */
+     * 10th parameter 0 means little-endian */
     pflash_cfi01_register(FLASH_BASEADDR, "petalogix_ml605.flash", FLASH_SIZE,
diff --git a/hw/misc/allwinner-r40-dramc.c b/hw/misc/allwinner-r40-dramc.c
index ea6124744f..6944f84455 100644
--- a/hw/misc/allwinner-r40-dramc.c
+++ b/hw/misc/allwinner-r40-dramc.c
@@ -370,3 +370,3 @@ static const MemoryRegionOps allwinner_r40_detect_ops = {
  * mctl_r40_detect_rank_count in u-boot will write the high 1G of DDR
- * to detect wether the board support dual_rank or not. Create a virtual memory
+ * to detect whether the board support dual_rank or not. Create a virtual memory
  * if the board's ram_size less or equal than 1G, and set read time out flag of
diff --git a/hw/misc/exynos4210_rng.c b/hw/misc/exynos4210_rng.c
index 1b9e8347a1..9214ec14cc 100644
--- a/hw/misc/exynos4210_rng.c
+++ b/hw/misc/exynos4210_rng.c
@@ -1,3 +1,3 @@
 /*
- *  Exynos4210 Pseudo Random Nubmer Generator Emulation
+ *  Exynos4210 Pseudo Random Number Generator Emulation
  *
diff --git a/hw/sparc/sun4m_iommu.c b/hw/sparc/sun4m_iommu.c
index 71f5465249..eb40f9377c 100644
--- a/hw/sparc/sun4m_iommu.c
+++ b/hw/sparc/sun4m_iommu.c
@@ -98,6 +98,6 @@
 
-#define IOMMU_SBCFG0        (0x1010 >> 2) /* SBUS configration per-slot */
-#define IOMMU_SBCFG1        (0x1014 >> 2) /* SBUS configration per-slot */
-#define IOMMU_SBCFG2        (0x1018 >> 2) /* SBUS configration per-slot */
-#define IOMMU_SBCFG3        (0x101c >> 2) /* SBUS configration per-slot */
+#define IOMMU_SBCFG0        (0x1010 >> 2) /* SBUS configuration per-slot */
+#define IOMMU_SBCFG1        (0x1014 >> 2) /* SBUS configuration per-slot */
+#define IOMMU_SBCFG2        (0x1018 >> 2) /* SBUS configuration per-slot */
+#define IOMMU_SBCFG3        (0x101c >> 2) /* SBUS configuration per-slot */
 #define IOMMU_SBCFG_SAB30   0x00010000 /* Phys-address bit 30 when
diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index fcd20bfd3a..13306665af 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -193,3 +193,3 @@ enum {
    so we don't need to implement Executive and Supervisor.  QEMU's own
-   PALcode cheats and usees the KSEG mapping for its code+data rather than
+   PALcode cheats and uses the KSEG mapping for its code+data rather than
    physical addresses.  */
@@ -364,3 +364,3 @@ enum {
 
-/* CPUAlphaState->flags constants.  These are layed out so that we
+/* CPUAlphaState->flags constants.  These are laid out so that we
    can set or reset the pieces individually by assigning to the byte,
diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 1f7dd078d8..846f3d8091 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -2895,3 +2895,3 @@ static void alpha_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cpu)
        to reset the FP_STATUS to that default at the end of any TB that
-       changes the default.  We could even (gasp) dynamiclly figure out
+       changes the default.  We could even (gasp) dynamically figure out
        what default would be most efficient given the running program.  */
diff --git a/target/cris/helper.c b/target/cris/helper.c
index 81a72699b5..c0bf987e3e 100644
--- a/target/cris/helper.c
+++ b/target/cris/helper.c
@@ -115,3 +115,3 @@ void crisv10_cpu_do_interrupt(CPUState *cs)
     case EXCP_BREAK:
-        /* These exceptions are genereated by the core itself.
+        /* These exceptions are generated by the core itself.
            ERP should point to the insn following the brk.  */
@@ -171,3 +171,3 @@ void cris_cpu_do_interrupt(CPUState *cs)
     case EXCP_BREAK:
-        /* These exceptions are genereated by the core itself.
+        /* These exceptions are generated by the core itself.
            ERP should point to the insn following the brk.  */
@@ -230,3 +230,3 @@ void cris_cpu_do_interrupt(CPUState *cs)
 
-    /* Clear the excption_index to avoid spurios hw_aborts for recursive
+    /* Clear the excption_index to avoid spurious hw_aborts for recursive
        bus faults.  */
diff --git a/target/cris/op_helper.c b/target/cris/op_helper.c
index d55a18a213..40cb74ce73 100644
--- a/target/cris/op_helper.c
+++ b/target/cris/op_helper.c
@@ -233,3 +233,3 @@ static inline uint32_t evaluate_flags_writeback(CPUCRISState *env,
 
-    /* Extended arithmetics, leave the z flag alone.  */
+    /* Extended arithmetic, leave the z flag alone.  */
     x = env->cc_x;
diff --git a/target/cris/translate.c b/target/cris/translate.c
index 1445cd8bb5..0b3d724281 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -344,3 +344,3 @@ static void t_gen_cris_mstep(TCGv d, TCGv a, TCGv b, TCGv ccs)
 
-/* Extended arithmetics on CRIS.  */
+/* Extended arithmetic on CRIS.  */
 static inline void t_gen_add_flag(TCGv d, int flag)
@@ -648,3 +648,3 @@ static void cris_alu_op_exec(DisasContext *dc, int op,
         tcg_gen_add_tl(dst, a, b);
-        /* Extended arithmetics.  */
+        /* Extended arithmetic.  */
         t_gen_addx_carry(dc, dst);
@@ -661,3 +661,3 @@ static void cris_alu_op_exec(DisasContext *dc, int op,
         tcg_gen_sub_tl(dst, a, b);
-        /* Extended arithmetics.  */
+        /* Extended arithmetic.  */
         t_gen_subx_carry(dc, dst);
@@ -687,3 +687,3 @@ static void cris_alu_op_exec(DisasContext *dc, int op,
         tcg_gen_neg_tl(dst, b);
-        /* Extended arithmetics.  */
+        /* Extended arithmetic.  */
         t_gen_subx_carry(dc, dst);
@@ -710,3 +710,3 @@ static void cris_alu_op_exec(DisasContext *dc, int op,
         tcg_gen_sub_tl(dst, a, b);
-        /* Extended arithmetics.  */
+        /* Extended arithmetic.  */
         t_gen_subx_carry(dc, dst);
@@ -2926,3 +2926,3 @@ static unsigned int crisv32_decoder(CPUCRISState *env, DisasContext *dc)
  *
- * The TB contaning the branch insn will set up env->btarget and evaluate 
+ * The TB containing the branch insn will set up env->btarget and evaluate 
  * env->btaken. When the translation loop exits we will note that the branch 
@@ -2931,3 +2931,3 @@ static unsigned int crisv32_decoder(CPUCRISState *env, DisasContext *dc)
  *
- * The TB contaning the delayslot will have the PC of its real insn (i.e no lsb
+ * The TB containing the delayslot will have the PC of its real insn (i.e no lsb
  * set). It will also expect to have env->dslot setup with the size of the 
@@ -3145,3 +3145,3 @@ static void cris_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
     case DISAS_UPDATE:
-        /* Indicate that interupts must be re-evaluated before the next TB. */
+        /* Indicate that interrupts must be re-evaluated before the next TB. */
         tcg_gen_exit_tb(NULL, 0);
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 7373177b55..9fe79b1242 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -37,3 +37,3 @@
 
-/* Hardware exceptions, interupts, faults, and traps.  */
+/* Hardware exceptions, interrupts, faults, and traps.  */
 #define EXCP_HPMC                1  /* high priority machine check */
@@ -278,3 +278,3 @@ static inline void cpu_get_tb_cpu_state(CPUHPPAState *env, vaddr *pc,
        incomplete virtual address.  This also means that we must separate
-       out current cpu priviledge from the low bits of IAOQ_F.  */
+       out current cpu privilege from the low bits of IAOQ_F.  */
 #ifdef CONFIG_USER_ONLY
diff --git a/target/hppa/int_helper.c b/target/hppa/int_helper.c
index d2480b163b..bebc732c97 100644
--- a/target/hppa/int_helper.c
+++ b/target/hppa/int_helper.c
@@ -39,3 +39,3 @@ static void eval_interrupt(HPPACPU *cpu)
  * can write to this word to raise an external interrupt on the target CPU.
- * This includes the system controler (DINO) for regular devices, or
+ * This includes the system controller (DINO) for regular devices, or
  * another CPU for SMP interprocessor interrupts.
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index d33813d173..d66fcb3e6a 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1966,3 +1966,3 @@ static void do_page_zero(DisasContext *ctx)
        the B,GATE instruction would be skipped, and we'd fault on the
-       next insn within the privilaged page.  */
+       next insn within the privileged page.  */
     switch (ctx->null_cond.c) {
diff --git a/target/loongarch/cpu-csr.h b/target/loongarch/cpu-csr.h
index 4c8ce7fed5..f8f24032cb 100644
--- a/target/loongarch/cpu-csr.h
+++ b/target/loongarch/cpu-csr.h
@@ -12,3 +12,3 @@
 
-/* Base on kernal definitions: arch/loongarch/include/asm/loongarch.h */
+/* Based on kernel definitions: arch/loongarch/include/asm/loongarch.h */
 
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 01c18a7c59..0a1544cd68 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -592,6 +592,6 @@ static void dump_address_map(CPUM68KState *env, uint32_t root_pointer)
     switch (a & M68K_DESC_CACHEMODE) { \
-    case M68K_DESC_CM_WRTHRU: /* cachable, write-through */ \
+    case M68K_DESC_CM_WRTHRU: /* cacheable, write-through */ \
         qemu_printf("T"); \
         break; \
-    case M68K_DESC_CM_COPYBK: /* cachable, copyback */ \
+    case M68K_DESC_CM_COPYBK: /* cacheable, copyback */ \
         qemu_printf("C"); \
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index a7b040abd4..f6cab6ce19 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -207,3 +207,3 @@ typedef struct CPUArchState CPUMBState;
 
-/* MMU descrtiption */
+/* MMU description */
 #define PVR11_USE_MMU                   0xC0000000
diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index 92c38f54c2..ce4d605eb7 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -292,3 +292,3 @@ typedef struct CPUArchState {
     uint32_t picmr;         /* Interrupt mask register */
-    uint32_t picsr;         /* Interrupt contrl register*/
+    uint32_t picsr;         /* Interrupt control register */
 #endif
diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 7760329e75..a86360d4f5 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -275,3 +275,3 @@ static void gen_div(DisasContext *dc, TCGv dest, TCGv srca, TCGv srcb)
     /* The result of divide-by-zero is undefined.
-       Supress the host-side exception by dividing by 1.  */
+       Suppress the host-side exception by dividing by 1. */
     tcg_gen_or_tl(t0, srcb, cpu_sr_ov);
@@ -289,3 +289,3 @@ static void gen_divu(DisasContext *dc, TCGv dest, TCGv srca, TCGv srcb)
     /* The result of divide-by-zero is undefined.
-       Supress the host-side exception by dividing by 1.  */
+       Suppress the host-side exception by dividing by 1. */
     tcg_gen_or_tl(t0, srcb, cpu_sr_cy);
diff --git a/target/rx/translate.c b/target/rx/translate.c
index 08cabbde61..f552a0319a 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -2068,3 +2068,3 @@ static inline void clrsetpsw(DisasContext *ctx, int cb, int val)
         default:
-            qemu_log_mask(LOG_GUEST_ERROR, "Invalid distination %d", cb);
+            qemu_log_mask(LOG_GUEST_ERROR, "Invalid destination %d", cb);
             break;
@@ -2086,3 +2086,3 @@ static inline void clrsetpsw(DisasContext *ctx, int cb, int val)
         default:
-            qemu_log_mask(LOG_GUEST_ERROR, "Invalid distination %d", cb);
+            qemu_log_mask(LOG_GUEST_ERROR, "Invalid destination %d", cb);
             break;
diff --git a/target/sparc/asi.h b/target/sparc/asi.h
index bb58735ddb..3270ed0c7f 100644
--- a/target/sparc/asi.h
+++ b/target/sparc/asi.h
@@ -146,3 +146,3 @@
  */
-#define ASI_REAL                0x14 /* Real address, cachable          */
+#define ASI_REAL                0x14 /* Real address, cacheable          */
 #define ASI_PHYS_USE_EC		0x14 /* PADDR, E-cachable		*/
@@ -152,3 +152,3 @@
 #define ASI_BLK_AIUS_4V		0x17 /* (4V) Sec, user, block ld/st	*/
-#define ASI_REAL_L              0x1c /* Real address, cachable, LE      */
+#define ASI_REAL_L              0x1c /* Real address, cacheable, LE      */
 #define ASI_PHYS_USE_EC_L	0x1c /* PADDR, E-cachable, little endian*/
@@ -165,5 +165,5 @@
 					 */
-#define ASI_NUCLEUS_QUAD_LDD	0x24 /* Cachable, qword load		*/
+#define ASI_NUCLEUS_QUAD_LDD	0x24 /* Cacheable, qword load		*/
 #define ASI_QUEUE		0x25 /* (4V) Interrupt Queue Registers	*/
-#define ASI_TWINX_REAL          0x26 /* twin load, real, cachable       */
+#define ASI_TWINX_REAL          0x26 /* twin load, real, cacheable	*/
 #define ASI_QUAD_LDD_PHYS_4V	0x26 /* (4V) Physical, qword load	*/
@@ -172,4 +172,4 @@
 #define ASI_TWINX_AIUS_L        0x2b /* twin load, secondary user, LE   */
-#define ASI_NUCLEUS_QUAD_LDD_L	0x2c /* Cachable, qword load, l-endian 	*/
-#define ASI_TWINX_REAL_L        0x2e /* twin load, real, cachable, LE   */
+#define ASI_NUCLEUS_QUAD_LDD_L	0x2c /* Cacheable, qword load, l-endian */
+#define ASI_TWINX_REAL_L        0x2e /* twin load, real, cacheable, LE	*/
 #define ASI_QUAD_LDD_PHYS_L_4V	0x2e /* (4V) Phys, qword load, l-endian	*/
@@ -233,3 +233,3 @@
 #define ASI_CESR_ID		0x63 /* (CMT) CESR ID register		*/
-#define ASI_IC_INSTR		0x66 /* Insn cache instrucion ram diag	*/
+#define ASI_IC_INSTR		0x66 /* Insn cache instruction ram diag	*/
 #define ASI_IC_TAG		0x67 /* Insn cache tag/valid ram diag 	*/
diff --git a/target/tricore/csfr.h.inc b/target/tricore/csfr.h.inc
index ff004cbddc..cdfaf1d662 100644
--- a/target/tricore/csfr.h.inc
+++ b/target/tricore/csfr.h.inc
@@ -1,2 +1,2 @@
-/* A(ll) access permited
+/* A(ll) access permitted
    R(ead only) access
diff --git a/target/tricore/helper.c b/target/tricore/helper.c
index 951024d491..7587c2ffe8 100644
--- a/target/tricore/helper.c
+++ b/target/tricore/helper.c
@@ -59,3 +59,3 @@ hwaddr tricore_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
 
-/* TODO: Add exeption support*/
+/* TODO: Add exception support */
 static void raise_mmu_exception(CPUTriCoreState *env, target_ulong address,
diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 2f32463d4d..1947733870 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -130,3 +130,3 @@ void tricore_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 
-/* Makros for generating helpers */
+/* Macros for generating helpers */
 
@@ -338,4 +338,4 @@ static void gen_swapmsk(DisasContext *ctx, int reg, TCGv ea)
    the function gen_mfcr and gen_mtcr. To handle access permissions, we use 3
-   makros R, A and E, which allow read-only, all and endinit protected access.
-   These makros also specify in which ISA version the csfr was introduced. */
+   macros R, A and E, which allow read-only, all and endinit protected access.
+   These macros also specify in which ISA version the csfr was introduced. */
 #define R(ADDRESS, REG, FEATURE)                                         \
@@ -364,3 +364,3 @@ static inline void gen_mfcr(DisasContext *ctx, TCGv ret, int32_t offset)
 #define R(ADDRESS, REG, FEATURE) /* don't gen writes to read-only reg,
-                                    since no execption occurs */
+                                    since no exception occurs */
 #define A(ADDRESS, REG, FEATURE) R(ADDRESS, REG, FEATURE)                \
diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
index 2462c26000..462289f47c 100644
--- a/tests/tcg/Makefile.target
+++ b/tests/tcg/Makefile.target
@@ -122,3 +122,3 @@ endif
 else
-# For softmmu targets we include a different Makefile fragement as the
+# For softmmu targets we include a different Makefile fragment as the
 # build options for bare programs are usually pretty different. They
@@ -156,3 +156,3 @@ PLUGINS=$(patsubst %.c, lib%.so, $(notdir $(wildcard $(PLUGIN_SRC)/*.c)))
 # to avoid an exponential explosion as new tests are added. We also
-# add some special helpers the run-plugin- rules can use bellow.
+# add some special helpers the run-plugin- rules can use below.
 
diff --git a/tests/tcg/aarch64/gdbstub/test-sve.py b/tests/tcg/aarch64/gdbstub/test-sve.py
index b96bdbb99a..ef57c7412c 100644
--- a/tests/tcg/aarch64/gdbstub/test-sve.py
+++ b/tests/tcg/aarch64/gdbstub/test-sve.py
@@ -2,3 +2,3 @@
 #
-# Test the SVE registers are visable and changeable via gdbstub
+# Test the SVE registers are visible and changeable via gdbstub
 #
diff --git a/tests/tcg/aarch64/sme-outprod1.c b/tests/tcg/aarch64/sme-outprod1.c
index 6e5972d75e..0c814ed529 100644
--- a/tests/tcg/aarch64/sme-outprod1.c
+++ b/tests/tcg/aarch64/sme-outprod1.c
@@ -30,3 +30,3 @@ asm(
  * Read the first 4x4 sub-matrix of elements from tile 1:
- * Note that za1h should be interchangable here.
+ * Note that za1h should be interchangeable here.
  */
diff --git a/tests/tcg/aarch64/system/boot.S b/tests/tcg/aarch64/system/boot.S
index f136363d2a..501685d0ec 100644
--- a/tests/tcg/aarch64/system/boot.S
+++ b/tests/tcg/aarch64/system/boot.S
@@ -11,3 +11,3 @@
  * Semihosting interface on ARM AArch64
- * See "Semihosting for AArch32 and AArch64 Relase 2.0" by ARM
+ * See "Semihosting for AArch32 and AArch64 Release 2.0" by ARM
  * w0 - semihosting call number
@@ -149,3 +149,3 @@ __start:
 	 * The size of T0SZ controls what the initial lookup level. It
-	 * would be nice to start at level 2 but unfortunatly for a
+	 * would be nice to start at level 2 but unfortunately for a
 	 * flat-mapping on the virt machine we need to handle IA's
@@ -191,3 +191,3 @@ __start:
 	/* Setup some stack space and enter the test code.
-	 * Assume everthing except the return value is garbage when we
+	 * Assume everything except the return value is garbage when we
 	 * return, we won't need it.
diff --git a/tests/tcg/aarch64/system/semiheap.c b/tests/tcg/aarch64/system/semiheap.c
index 693a1b037d..1a8c0f31a0 100644
--- a/tests/tcg/aarch64/system/semiheap.c
+++ b/tests/tcg/aarch64/system/semiheap.c
@@ -88,3 +88,3 @@ int main(int argc, char *argv[argc])
     }
-    ml_printf("r/w to heap upto %p\n", ptr_to_heap);
+    ml_printf("r/w to heap up to %p\n", ptr_to_heap);
 
diff --git a/tests/tcg/multiarch/sha512.c b/tests/tcg/multiarch/sha512.c
index 9e701bcf20..12c2b6c2b7 100644
--- a/tests/tcg/multiarch/sha512.c
+++ b/tests/tcg/multiarch/sha512.c
@@ -455,3 +455,3 @@ void sha512(struct sha512 *sha, const void *p, size_t size)
  * hex_decode - Unpack a hex string.
- * @str: the hexidecimal string
+ * @str: the hexadecimal string
  * @slen: the length of @str
diff --git a/tests/tcg/multiarch/system/Makefile.softmmu-target b/tests/tcg/multiarch/system/Makefile.softmmu-target
index fe40195d39..7ba9053375 100644
--- a/tests/tcg/multiarch/system/Makefile.softmmu-target
+++ b/tests/tcg/multiarch/system/Makefile.softmmu-target
@@ -5,3 +5,3 @@
 # We just collect the tests together here and rely on the actual guest
-# architecture to add to the test dependancies and deal with the
+# architecture to add to the test dependencies and deal with the
 # complications of building.
diff --git a/tests/tcg/tricore/c/crt0-tc2x.S b/tests/tcg/tricore/c/crt0-tc2x.S
index 3100da123c..399f112c35 100644
--- a/tests/tcg/tricore/c/crt0-tc2x.S
+++ b/tests/tcg/tricore/c/crt0-tc2x.S
@@ -265,3 +265,3 @@ __copy_table_next:
     sh  %d0,%d3,-3          # %d0 = length / 8 (doublewords)
-    and %d1,%d3,7           # %d1 = lenght % 8 (rem. bytes)
+    and %d1,%d3,7           # %d1 = length % 8 (rem. bytes)
     jz  %d0,__copy_word         # block size < 8 => copy word
@@ -276,3 +276,3 @@ __copy_word:
     sh  %d0,%d1,-2          # %d0 = length / 4 (words)
-    and %d1,%d1,3           # %d1 = lenght % 4 (rem. bytes)
+    and %d1,%d1,3           # %d1 = length % 4 (rem. bytes)
     jz  %d0,__copy_hword        # block size < 4 => copy hword
diff --git a/tests/tcg/x86_64/system/boot.S b/tests/tcg/x86_64/system/boot.S
index ed0f638406..dac9bd534d 100644
--- a/tests/tcg/x86_64/system/boot.S
+++ b/tests/tcg/x86_64/system/boot.S
@@ -123,3 +123,3 @@ _start:
 
-        /* don't worry about stack frame, assume everthing is garbage when we return */
+        /* don't worry about stack frame, assume everything is garbage when we return */
 	call main
@@ -197,3 +197,3 @@ idt_1F: .int 0, 0
 	 * segment descriptors. In 32 bit mode each segment each
-	 * segement is associated with segment registers which are
+	 * segment is associated with segment registers which are
 	 * implicitly (or explicitly) referenced depending on the
-- 
2.39.2


