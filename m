Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 161FF754E8A
	for <lists+qemu-devel@lfdr.de>; Sun, 16 Jul 2023 13:59:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qL0OV-0004Gj-Ra; Sun, 16 Jul 2023 07:58:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qL0OT-0004G3-9U; Sun, 16 Jul 2023 07:58:29 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qL0OO-0001tG-U4; Sun, 16 Jul 2023 07:58:29 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 91A801424A;
 Sun, 16 Jul 2023 14:58:25 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 76A9314F33;
 Sun, 16 Jul 2023 14:58:05 +0300 (MSK)
Received: (nullmailer pid 1505330 invoked by uid 1000);
 Sun, 16 Jul 2023 11:58:04 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 5/6] tree-wide spelling fixes in comments and some messages:
 other architectures
Date: Sun, 16 Jul 2023 14:58:00 +0300
Message-Id: <20230716115801.1505288-6-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230716115801.1505288-1-mjt@tls.msk.ru>
References: <20230716115801.1505288-1-mjt@tls.msk.ru>
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
 host/include/generic/host/cpuinfo.h              |  2 +-
 hw/m68k/next-cube.c                              |  2 +-
 hw/m68k/next-kbd.c                               |  2 +-
 hw/m68k/virt.c                                   |  2 +-
 hw/microblaze/petalogix_ml605_mmu.c              |  2 +-
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
 tests/tcg/multiarch/sha512.c                     |  2 +-
 .../tcg/multiarch/system/Makefile.softmmu-target |  2 +-
 tests/tcg/tricore/c/crt0-tc2x.S                  |  4 ++--
 tests/tcg/x86_64/system/boot.S                   |  4 ++--
 29 files changed, 58 insertions(+), 58 deletions(-)

diff --git a/host/include/generic/host/cpuinfo.h b/host/include/generic/host/cpuinfo.h
index eca672064a..67ad410871 100644
--- a/host/include/generic/host/cpuinfo.h
+++ b/host/include/generic/host/cpuinfo.h
@@ -1,4 +1,4 @@
 /*
- * No host specific cpu indentification.
+ * No host specific cpu identification.
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index ce8ee50b9e..5d244b3b95 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -734,7 +734,7 @@ static void next_irq(void *opaque, int number, int level)
     M68kCPU *cpu = s->cpu;
     int shift = 0;
 
-    /* first switch sets interupt status */
+    /* first switch sets interrupt status */
     /* DPRINTF("IRQ %i\n",number); */
     switch (number) {
     /* level 3 - floppy, kbd/mouse, power, ether rx/tx, scsi, clock */
diff --git a/hw/m68k/next-kbd.c b/hw/m68k/next-kbd.c
index 0544160e91..0c348c18cf 100644
--- a/hw/m68k/next-kbd.c
+++ b/hw/m68k/next-kbd.c
@@ -37,7 +37,7 @@
 
 OBJECT_DECLARE_SIMPLE_TYPE(NextKBDState, NEXTKBD)
 
-/* following defintions from next68k netbsd */
+/* following definitions from next68k netbsd */
 #define CSR_INT 0x00800000
 #define CSR_DATA 0x00400000
 
diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
index 731205b215..de91726cf9 100644
--- a/hw/m68k/virt.c
+++ b/hw/m68k/virt.c
@@ -1,7 +1,7 @@
 /*
  * SPDX-License-Identifier: GPL-2.0-or-later
  *
- * QEMU Vitual M68K Machine
+ * QEMU Virtual M68K Machine
  *
  * (c) 2020 Laurent Vivier <laurent@vivier.eu>
  *
diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogix_ml605_mmu.c
index a24fadddca..babb053035 100644
--- a/hw/microblaze/petalogix_ml605_mmu.c
+++ b/hw/microblaze/petalogix_ml605_mmu.c
@@ -104,7 +104,7 @@ petalogix_ml605_init(MachineState *machine)
 
     dinfo = drive_get(IF_PFLASH, 0, 0);
     /* 5th parameter 2 means bank-width
-     * 10th paremeter 0 means little-endian */
+     * 10th parameter 0 means little-endian */
     pflash_cfi01_register(FLASH_BASEADDR, "petalogix_ml605.flash", FLASH_SIZE,
                           dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
                           64 * KiB, 2, 0x89, 0x18, 0x0000, 0x0, 0);
diff --git a/hw/sparc/sun4m_iommu.c b/hw/sparc/sun4m_iommu.c
index 71f5465249..eb40f9377c 100644
--- a/hw/sparc/sun4m_iommu.c
+++ b/hw/sparc/sun4m_iommu.c
@@ -96,10 +96,10 @@
 #define IOMMU_AER_SBW       0x80000000    /* S-to-M asynchronous writes */
 #define IOMMU_AER_MASK      0x801f000f
 
-#define IOMMU_SBCFG0        (0x1010 >> 2) /* SBUS configration per-slot */
-#define IOMMU_SBCFG1        (0x1014 >> 2) /* SBUS configration per-slot */
-#define IOMMU_SBCFG2        (0x1018 >> 2) /* SBUS configration per-slot */
-#define IOMMU_SBCFG3        (0x101c >> 2) /* SBUS configration per-slot */
+#define IOMMU_SBCFG0        (0x1010 >> 2) /* SBUS configuration per-slot */
+#define IOMMU_SBCFG1        (0x1014 >> 2) /* SBUS configuration per-slot */
+#define IOMMU_SBCFG2        (0x1018 >> 2) /* SBUS configuration per-slot */
+#define IOMMU_SBCFG3        (0x101c >> 2) /* SBUS configuration per-slot */
 #define IOMMU_SBCFG_SAB30   0x00010000 /* Phys-address bit 30 when
                                           bypass enabled */
 #define IOMMU_SBCFG_BA16    0x00000004 /* Slave supports 16 byte bursts */
diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index fcd20bfd3a..13306665af 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -191,7 +191,7 @@ enum {
 
    That said, we're only emulating Unix PALcode, and not attempting VMS,
    so we don't need to implement Executive and Supervisor.  QEMU's own
-   PALcode cheats and usees the KSEG mapping for its code+data rather than
+   PALcode cheats and uses the KSEG mapping for its code+data rather than
    physical addresses.  */
 
 #define MMU_KERNEL_IDX   0
@@ -362,7 +362,7 @@ enum {
    The Unix PALcode only uses bit 4.  */
 #define PS_USER_MODE  8u
 
-/* CPUAlphaState->flags constants.  These are layed out so that we
+/* CPUAlphaState->flags constants.  These are laid out so that we
    can set or reset the pieces individually by assigning to the byte,
    or manipulated as a whole.  */
 
diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 1f7dd078d8..846f3d8091 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -2893,7 +2893,7 @@ static void alpha_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cpu)
        the first fp insn of the TB.  Alternately we could define a proper
        default for every TB (e.g. QUAL_RM_N or QUAL_RM_D) and make sure
        to reset the FP_STATUS to that default at the end of any TB that
-       changes the default.  We could even (gasp) dynamiclly figure out
+       changes the default.  We could even (gasp) dynamically figure out
        what default would be most efficient given the running program.  */
     ctx->tb_rm = -1;
     /* Similarly for flush-to-zero.  */
diff --git a/target/cris/helper.c b/target/cris/helper.c
index 81a72699b5..c0bf987e3e 100644
--- a/target/cris/helper.c
+++ b/target/cris/helper.c
@@ -113,7 +113,7 @@ void crisv10_cpu_do_interrupt(CPUState *cs)
     assert(!(env->pregs[PR_CCS] & PFIX_FLAG));
     switch (cs->exception_index) {
     case EXCP_BREAK:
-        /* These exceptions are genereated by the core itself.
+        /* These exceptions are generated by the core itself.
            ERP should point to the insn following the brk.  */
         ex_vec = env->trap_vector;
         env->pregs[PRV10_BRP] = env->pc;
@@ -169,7 +169,7 @@ void cris_cpu_do_interrupt(CPUState *cs)
 
     switch (cs->exception_index) {
     case EXCP_BREAK:
-        /* These exceptions are genereated by the core itself.
+        /* These exceptions are generated by the core itself.
            ERP should point to the insn following the brk.  */
         ex_vec = env->trap_vector;
         env->pregs[PR_ERP] = env->pc;
@@ -228,7 +228,7 @@ void cris_cpu_do_interrupt(CPUState *cs)
        undefined.  */
     env->pc = cpu_ldl_code(env, env->pregs[PR_EBP] + ex_vec * 4);
 
-    /* Clear the excption_index to avoid spurios hw_aborts for recursive
+    /* Clear the excption_index to avoid spurious hw_aborts for recursive
        bus faults.  */
     cs->exception_index = -1;
 
diff --git a/target/cris/op_helper.c b/target/cris/op_helper.c
index d55a18a213..40cb74ce73 100644
--- a/target/cris/op_helper.c
+++ b/target/cris/op_helper.c
@@ -231,7 +231,7 @@ static inline uint32_t evaluate_flags_writeback(CPUCRISState *env,
 {
     unsigned int x, z, mask;
 
-    /* Extended arithmetics, leave the z flag alone.  */
+    /* Extended arithmetic, leave the z flag alone.  */
     x = env->cc_x;
     mask = env->cc_mask | X_FLAG;
     if (x) {
diff --git a/target/cris/translate.c b/target/cris/translate.c
index 1445cd8bb5..0b3d724281 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -342,7 +342,7 @@ static void t_gen_cris_mstep(TCGv d, TCGv a, TCGv b, TCGv ccs)
     tcg_gen_add_tl(d, d, t);
 }
 
-/* Extended arithmetics on CRIS.  */
+/* Extended arithmetic on CRIS.  */
 static inline void t_gen_add_flag(TCGv d, int flag)
 {
     TCGv c;
@@ -646,7 +646,7 @@ static void cris_alu_op_exec(DisasContext *dc, int op,
     switch (op) {
     case CC_OP_ADD:
         tcg_gen_add_tl(dst, a, b);
-        /* Extended arithmetics.  */
+        /* Extended arithmetic.  */
         t_gen_addx_carry(dc, dst);
         break;
     case CC_OP_ADDC:
@@ -659,7 +659,7 @@ static void cris_alu_op_exec(DisasContext *dc, int op,
         break;
     case CC_OP_SUB:
         tcg_gen_sub_tl(dst, a, b);
-        /* Extended arithmetics.  */
+        /* Extended arithmetic.  */
         t_gen_subx_carry(dc, dst);
         break;
     case CC_OP_MOVE:
@@ -685,7 +685,7 @@ static void cris_alu_op_exec(DisasContext *dc, int op,
         break;
     case CC_OP_NEG:
         tcg_gen_neg_tl(dst, b);
-        /* Extended arithmetics.  */
+        /* Extended arithmetic.  */
         t_gen_subx_carry(dc, dst);
         break;
     case CC_OP_LZ:
@@ -708,7 +708,7 @@ static void cris_alu_op_exec(DisasContext *dc, int op,
         break;
     case CC_OP_CMP:
         tcg_gen_sub_tl(dst, a, b);
-        /* Extended arithmetics.  */
+        /* Extended arithmetic.  */
         t_gen_subx_carry(dc, dst);
         break;
     default:
@@ -2924,12 +2924,12 @@ static unsigned int crisv32_decoder(CPUCRISState *env, DisasContext *dc)
  * On QEMU care needs to be taken when a branch+delayslot sequence is broken
  * and the branch and delayslot don't share pages.
  *
- * The TB contaning the branch insn will set up env->btarget and evaluate 
+ * The TB containing the branch insn will set up env->btarget and evaluate 
  * env->btaken. When the translation loop exits we will note that the branch 
  * sequence is broken and let env->dslot be the size of the branch insn (those
  * vary in length).
  *
- * The TB contaning the delayslot will have the PC of its real insn (i.e no lsb
+ * The TB containing the delayslot will have the PC of its real insn (i.e no lsb
  * set). It will also expect to have env->dslot setup with the size of the 
  * delay slot so that env->pc - env->dslot point to the branch insn. This TB 
  * will execute the dslot and take the branch, either to btarget or just one 
@@ -3143,7 +3143,7 @@ static void cris_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
         tcg_gen_lookup_and_goto_ptr();
         break;
     case DISAS_UPDATE:
-        /* Indicate that interupts must be re-evaluated before the next TB. */
+        /* Indicate that interrupts must be re-evaluated before the next TB. */
         tcg_gen_exit_tb(NULL, 0);
         break;
     default:
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 7373177b55..9fe79b1242 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -35,7 +35,7 @@
 #define MMU_PHYS_IDX     4
 #define TARGET_INSN_START_EXTRA_WORDS 1
 
-/* Hardware exceptions, interupts, faults, and traps.  */
+/* Hardware exceptions, interrupts, faults, and traps.  */
 #define EXCP_HPMC                1  /* high priority machine check */
 #define EXCP_POWER_FAIL          2
 #define EXCP_RC                  3  /* recovery counter */
@@ -276,7 +276,7 @@ static inline void cpu_get_tb_cpu_state(CPUHPPAState *env, vaddr *pc,
     /* TB lookup assumes that PC contains the complete virtual address.
        If we leave space+offset separate, we'll get ITLB misses to an
        incomplete virtual address.  This also means that we must separate
-       out current cpu priviledge from the low bits of IAOQ_F.  */
+       out current cpu privilege from the low bits of IAOQ_F.  */
 #ifdef CONFIG_USER_ONLY
     *pc = env->iaoq_f & -4;
     *cs_base = env->iaoq_b & -4;
diff --git a/target/hppa/int_helper.c b/target/hppa/int_helper.c
index d2480b163b..bebc732c97 100644
--- a/target/hppa/int_helper.c
+++ b/target/hppa/int_helper.c
@@ -37,7 +37,7 @@ static void eval_interrupt(HPPACPU *cpu)
 
 /* Each CPU has a word mapped into the GSC bus.  Anything on the GSC bus
  * can write to this word to raise an external interrupt on the target CPU.
- * This includes the system controler (DINO) for regular devices, or
+ * This includes the system controller (DINO) for regular devices, or
  * another CPU for SMP interprocessor interrupts.
  */
 static uint64_t io_eir_read(void *opaque, hwaddr addr, unsigned size)
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index d33813d173..d66fcb3e6a 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1964,7 +1964,7 @@ static void do_page_zero(DisasContext *ctx)
 {
     /* If by some means we get here with PSW[N]=1, that implies that
        the B,GATE instruction would be skipped, and we'd fault on the
-       next insn within the privilaged page.  */
+       next insn within the privileged page.  */
     switch (ctx->null_cond.c) {
     case TCG_COND_NEVER:
         break;
diff --git a/target/loongarch/cpu-csr.h b/target/loongarch/cpu-csr.h
index 4c8ce7fed5..f8f24032cb 100644
--- a/target/loongarch/cpu-csr.h
+++ b/target/loongarch/cpu-csr.h
@@ -10,7 +10,7 @@
 
 #include "hw/registerfields.h"
 
-/* Base on kernal definitions: arch/loongarch/include/asm/loongarch.h */
+/* Based on kernel definitions: arch/loongarch/include/asm/loongarch.h */
 
 /* Basic CSRs */
 #define LOONGARCH_CSR_CRMD           0x0 /* Current mode info */
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 01c18a7c59..0a1544cd68 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -590,10 +590,10 @@ static void dump_address_map(CPUM68KState *env, uint32_t root_pointer)
 
 #define DUMP_CACHEFLAGS(a) \
     switch (a & M68K_DESC_CACHEMODE) { \
-    case M68K_DESC_CM_WRTHRU: /* cachable, write-through */ \
+    case M68K_DESC_CM_WRTHRU: /* cacheable, write-through */ \
         qemu_printf("T"); \
         break; \
-    case M68K_DESC_CM_COPYBK: /* cachable, copyback */ \
+    case M68K_DESC_CM_COPYBK: /* cacheable, copyback */ \
         qemu_printf("C"); \
         break; \
     case M68K_DESC_CM_SERIAL: /* noncachable, serialized */ \
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index a7b040abd4..f6cab6ce19 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -205,7 +205,7 @@ typedef struct CPUArchState CPUMBState;
 #define PVR10_TARGET_FAMILY_MASK        0xFF000000
 #define PVR10_ASIZE_SHIFT               18
 
-/* MMU descrtiption */
+/* MMU description */
 #define PVR11_USE_MMU                   0xC0000000
 #define PVR11_MMU_ITLB_SIZE             0x38000000
 #define PVR11_MMU_DTLB_SIZE             0x07000000
diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index 92c38f54c2..ce4d605eb7 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -290,7 +290,7 @@ typedef struct CPUArchState {
     int is_counting;
 
     uint32_t picmr;         /* Interrupt mask register */
-    uint32_t picsr;         /* Interrupt contrl register*/
+    uint32_t picsr;         /* Interrupt control register */
 #endif
 } CPUOpenRISCState;
 
diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 7760329e75..a86360d4f5 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -273,7 +273,7 @@ static void gen_div(DisasContext *dc, TCGv dest, TCGv srca, TCGv srcb)
 
     tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_sr_ov, srcb, 0);
     /* The result of divide-by-zero is undefined.
-       Supress the host-side exception by dividing by 1.  */
+       Suppress the host-side exception by dividing by 1. */
     tcg_gen_or_tl(t0, srcb, cpu_sr_ov);
     tcg_gen_div_tl(dest, srca, t0);
 
@@ -287,7 +287,7 @@ static void gen_divu(DisasContext *dc, TCGv dest, TCGv srca, TCGv srcb)
 
     tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_sr_cy, srcb, 0);
     /* The result of divide-by-zero is undefined.
-       Supress the host-side exception by dividing by 1.  */
+       Suppress the host-side exception by dividing by 1. */
     tcg_gen_or_tl(t0, srcb, cpu_sr_cy);
     tcg_gen_divu_tl(dest, srca, t0);
 
diff --git a/target/rx/translate.c b/target/rx/translate.c
index 08cabbde61..f552a0319a 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -2066,7 +2066,7 @@ static inline void clrsetpsw(DisasContext *ctx, int cb, int val)
             tcg_gen_movi_i32(cpu_psw_o, val << 31);
             break;
         default:
-            qemu_log_mask(LOG_GUEST_ERROR, "Invalid distination %d", cb);
+            qemu_log_mask(LOG_GUEST_ERROR, "Invalid destination %d", cb);
             break;
         }
     } else if (is_privileged(ctx, 0)) {
@@ -2084,7 +2084,7 @@ static inline void clrsetpsw(DisasContext *ctx, int cb, int val)
             }
             break;
         default:
-            qemu_log_mask(LOG_GUEST_ERROR, "Invalid distination %d", cb);
+            qemu_log_mask(LOG_GUEST_ERROR, "Invalid destination %d", cb);
             break;
         }
     }
diff --git a/target/sparc/asi.h b/target/sparc/asi.h
index bb58735ddb..3270ed0c7f 100644
--- a/target/sparc/asi.h
+++ b/target/sparc/asi.h
@@ -144,13 +144,13 @@
  * ASIs, "(4V)" designates SUN4V specific ASIs.  "(NG4)" designates SPARC-T4
  * and later ASIs.
  */
-#define ASI_REAL                0x14 /* Real address, cachable          */
+#define ASI_REAL                0x14 /* Real address, cacheable          */
 #define ASI_PHYS_USE_EC		0x14 /* PADDR, E-cachable		*/
 #define ASI_REAL_IO             0x15 /* Real address, non-cachable      */
 #define ASI_PHYS_BYPASS_EC_E	0x15 /* PADDR, E-bit			*/
 #define ASI_BLK_AIUP_4V		0x16 /* (4V) Prim, user, block ld/st	*/
 #define ASI_BLK_AIUS_4V		0x17 /* (4V) Sec, user, block ld/st	*/
-#define ASI_REAL_L              0x1c /* Real address, cachable, LE      */
+#define ASI_REAL_L              0x1c /* Real address, cacheable, LE      */
 #define ASI_PHYS_USE_EC_L	0x1c /* PADDR, E-cachable, little endian*/
 #define ASI_REAL_IO_L           0x1d /* Real address, non-cachable, LE  */
 #define ASI_PHYS_BYPASS_EC_E_L	0x1d /* PADDR, E-bit, little endian	*/
@@ -163,15 +163,15 @@
 #define ASI_BLK_INIT_QUAD_LDD_AIUS 0x23 /* (NG) init-store, twin load,
 					 * secondary, user
 					 */
-#define ASI_NUCLEUS_QUAD_LDD	0x24 /* Cachable, qword load		*/
+#define ASI_NUCLEUS_QUAD_LDD	0x24 /* Cacheable, qword load		*/
 #define ASI_QUEUE		0x25 /* (4V) Interrupt Queue Registers	*/
-#define ASI_TWINX_REAL          0x26 /* twin load, real, cachable       */
+#define ASI_TWINX_REAL          0x26 /* twin load, real, cacheable	*/
 #define ASI_QUAD_LDD_PHYS_4V	0x26 /* (4V) Physical, qword load	*/
 #define ASI_TWINX_N             0x27 /* twin load, nucleus              */
 #define ASI_TWINX_AIUP_L        0x2a /* twin load, primary user, LE     */
 #define ASI_TWINX_AIUS_L        0x2b /* twin load, secondary user, LE   */
-#define ASI_NUCLEUS_QUAD_LDD_L	0x2c /* Cachable, qword load, l-endian 	*/
-#define ASI_TWINX_REAL_L        0x2e /* twin load, real, cachable, LE   */
+#define ASI_NUCLEUS_QUAD_LDD_L	0x2c /* Cacheable, qword load, l-endian */
+#define ASI_TWINX_REAL_L        0x2e /* twin load, real, cacheable, LE	*/
 #define ASI_QUAD_LDD_PHYS_L_4V	0x2e /* (4V) Phys, qword load, l-endian	*/
 #define ASI_TWINX_NL            0x2f /* twin load, nucleus, LE          */
 #define ASI_PCACHE_DATA_STATUS	0x30 /* (III) PCache data stat RAM diag	*/
@@ -231,7 +231,7 @@
 #define ASI_INTR_ID		0x63 /* (CMT) Interrupt ID register	*/
 #define ASI_CORE_ID		0x63 /* (CMT) LP ID register		*/
 #define ASI_CESR_ID		0x63 /* (CMT) CESR ID register		*/
-#define ASI_IC_INSTR		0x66 /* Insn cache instrucion ram diag	*/
+#define ASI_IC_INSTR		0x66 /* Insn cache instruction ram diag	*/
 #define ASI_IC_TAG		0x67 /* Insn cache tag/valid ram diag 	*/
 #define ASI_IC_STAG		0x68 /* (III) Insn cache snoop tag ram	*/
 #define ASI_IC_PRE_DECODE	0x6e /* Insn cache pre-decode ram diag	*/
diff --git a/target/tricore/csfr.h.inc b/target/tricore/csfr.h.inc
index ff004cbddc..cdfaf1d662 100644
--- a/target/tricore/csfr.h.inc
+++ b/target/tricore/csfr.h.inc
@@ -1,4 +1,4 @@
-/* A(ll) access permited
+/* A(ll) access permitted
    R(ead only) access
    E(nd init protected) access
 
diff --git a/target/tricore/helper.c b/target/tricore/helper.c
index 951024d491..7587c2ffe8 100644
--- a/target/tricore/helper.c
+++ b/target/tricore/helper.c
@@ -57,7 +57,7 @@ hwaddr tricore_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
     return phys_addr;
 }
 
-/* TODO: Add exeption support*/
+/* TODO: Add exception support */
 static void raise_mmu_exception(CPUTriCoreState *env, target_ulong address,
                                 int rw, int tlb_error)
 {
diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 2f32463d4d..1947733870 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -128,7 +128,7 @@ void tricore_cpu_dump_state(CPUState *cs, FILE *f, int flags)
  * Functions to generate micro-ops
  */
 
-/* Makros for generating helpers */
+/* Macros for generating helpers */
 
 #define gen_helper_1arg(name, arg) do {                           \
     TCGv_i32 helper_tmp = tcg_constant_i32(arg);                  \
@@ -336,8 +336,8 @@ static void gen_swapmsk(DisasContext *ctx, int reg, TCGv ea)
 
 /* We generate loads and store to core special function register (csfr) through
    the function gen_mfcr and gen_mtcr. To handle access permissions, we use 3
-   makros R, A and E, which allow read-only, all and endinit protected access.
-   These makros also specify in which ISA version the csfr was introduced. */
+   macros R, A and E, which allow read-only, all and endinit protected access.
+   These macros also specify in which ISA version the csfr was introduced. */
 #define R(ADDRESS, REG, FEATURE)                                         \
     case ADDRESS:                                                        \
         if (has_feature(ctx, FEATURE)) {                             \
@@ -362,7 +362,7 @@ static inline void gen_mfcr(DisasContext *ctx, TCGv ret, int32_t offset)
 #undef E
 
 #define R(ADDRESS, REG, FEATURE) /* don't gen writes to read-only reg,
-                                    since no execption occurs */
+                                    since no exception occurs */
 #define A(ADDRESS, REG, FEATURE) R(ADDRESS, REG, FEATURE)                \
     case ADDRESS:                                                        \
         if (has_feature(ctx, FEATURE)) {                             \
diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
index 2462c26000..462289f47c 100644
--- a/tests/tcg/Makefile.target
+++ b/tests/tcg/Makefile.target
@@ -120,7 +120,7 @@ endif
 %: %.S
 	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
 else
-# For softmmu targets we include a different Makefile fragement as the
+# For softmmu targets we include a different Makefile fragment as the
 # build options for bare programs are usually pretty different. They
 # are expected to provide their own build recipes.
 EXTRA_CFLAGS += -ffreestanding
@@ -154,7 +154,7 @@ PLUGINS=$(patsubst %.c, lib%.so, $(notdir $(wildcard $(PLUGIN_SRC)/*.c)))
 # pre-requistes manually here as we can't use stems to handle it. We
 # only expand MULTIARCH_TESTS which are common on most of our targets
 # to avoid an exponential explosion as new tests are added. We also
-# add some special helpers the run-plugin- rules can use bellow.
+# add some special helpers the run-plugin- rules can use below.
 
 ifneq ($(MULTIARCH_TESTS),)
 $(foreach p,$(PLUGINS), \
diff --git a/tests/tcg/multiarch/sha512.c b/tests/tcg/multiarch/sha512.c
index 9e701bcf20..12c2b6c2b7 100644
--- a/tests/tcg/multiarch/sha512.c
+++ b/tests/tcg/multiarch/sha512.c
@@ -453,7 +453,7 @@ void sha512(struct sha512 *sha, const void *p, size_t size)
 /* From hex.h */
 /**
  * hex_decode - Unpack a hex string.
- * @str: the hexidecimal string
+ * @str: the hexadecimal string
  * @slen: the length of @str
  * @buf: the buffer to write the data into
  * @bufsize: the length of @buf
diff --git a/tests/tcg/multiarch/system/Makefile.softmmu-target b/tests/tcg/multiarch/system/Makefile.softmmu-target
index fe40195d39..7ba9053375 100644
--- a/tests/tcg/multiarch/system/Makefile.softmmu-target
+++ b/tests/tcg/multiarch/system/Makefile.softmmu-target
@@ -3,7 +3,7 @@
 # Multiarch system tests
 #
 # We just collect the tests together here and rely on the actual guest
-# architecture to add to the test dependancies and deal with the
+# architecture to add to the test dependencies and deal with the
 # complications of building.
 #
 
diff --git a/tests/tcg/tricore/c/crt0-tc2x.S b/tests/tcg/tricore/c/crt0-tc2x.S
index 3100da123c..399f112c35 100644
--- a/tests/tcg/tricore/c/crt0-tc2x.S
+++ b/tests/tcg/tricore/c/crt0-tc2x.S
@@ -263,7 +263,7 @@ __copy_table_next:
     ld.w    %d3,[%a13+]4            # %d3 = block length
     jeq %d3,-1,__copy_table_done    # length == -1 => end of table
     sh  %d0,%d3,-3          # %d0 = length / 8 (doublewords)
-    and %d1,%d3,7           # %d1 = lenght % 8 (rem. bytes)
+    and %d1,%d3,7           # %d1 = length % 8 (rem. bytes)
     jz  %d0,__copy_word         # block size < 8 => copy word
     addi    %d0,%d0,-1          # else doublewords -= 1
     mov.a   %a2,%d0             # %a2 = loop counter
@@ -274,7 +274,7 @@ __copy_dword:
 __copy_word:
     jz  %d1,__copy_table_next
     sh  %d0,%d1,-2          # %d0 = length / 4 (words)
-    and %d1,%d1,3           # %d1 = lenght % 4 (rem. bytes)
+    and %d1,%d1,3           # %d1 = length % 4 (rem. bytes)
     jz  %d0,__copy_hword        # block size < 4 => copy hword
     ld.w    %d14,[%a15+]4           # copy one word
     st.w    [%a14+]4,%d14
diff --git a/tests/tcg/x86_64/system/boot.S b/tests/tcg/x86_64/system/boot.S
index ed0f638406..dac9bd534d 100644
--- a/tests/tcg/x86_64/system/boot.S
+++ b/tests/tcg/x86_64/system/boot.S
@@ -121,7 +121,7 @@ _start:
 	// Setup stack ASAP
 	movq $stack_end,%rsp
 
-        /* don't worry about stack frame, assume everthing is garbage when we return */
+        /* don't worry about stack frame, assume everything is garbage when we return */
 	call main
 
 _exit:	/* output any non-zero result in eax to isa-debug-exit device */
@@ -195,7 +195,7 @@ idt_1F: .int 0, 0
 	 *
 	 * This describes various memory areas (segments) through
 	 * segment descriptors. In 32 bit mode each segment each
-	 * segement is associated with segment registers which are
+	 * segment is associated with segment registers which are
 	 * implicitly (or explicitly) referenced depending on the
 	 * instruction. However in 64 bit mode selectors are flat and
 	 * segmented addressing isn't used.
-- 
2.39.2


