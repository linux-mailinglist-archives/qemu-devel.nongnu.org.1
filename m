Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED874798536
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 11:56:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeYDw-00073u-7q; Fri, 08 Sep 2023 05:56:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qeYDu-00073V-3H; Fri, 08 Sep 2023 05:56:22 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qeYDh-0006VD-CV; Fri, 08 Sep 2023 05:56:21 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D31E3200CC;
 Fri,  8 Sep 2023 12:56:45 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id C909A26912;
 Fri,  8 Sep 2023 12:55:56 +0300 (MSK)
Received: (nullmailer pid 275952 invoked by uid 1000);
 Fri, 08 Sep 2023 09:55:55 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 04/23] riscv: spelling fixes
Date: Fri,  8 Sep 2023 12:55:01 +0300
Message-Id: <20230908095520.275866-5-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230908095520.275866-1-mjt@tls.msk.ru>
References: <20230908095520.275866-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/microchip_pfsoc.c                |  2 +-
 hw/riscv/virt.c                           |  4 ++--
 include/hw/riscv/riscv_hart.h             |  2 +-
 target/riscv/cpu.h                        |  2 +-
 target/riscv/cpu_bits.h                   |  4 ++--
 target/riscv/csr.c                        |  4 ++--
 target/riscv/debug.c                      | 10 +++++-----
 target/riscv/insn_trans/trans_rvf.c.inc   |  4 ++--
 target/riscv/insn_trans/trans_rvv.c.inc   |  4 ++--
 target/riscv/insn_trans/trans_rvzfh.c.inc |  4 ++--
 target/riscv/monitor.c                    |  2 +-
 11 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/hw/riscv/microchip_pfsoc.c b/hw/riscv/microchip_pfsoc.c
index e81bbd12df..b775aa8946 100644
--- a/hw/riscv/microchip_pfsoc.c
+++ b/hw/riscv/microchip_pfsoc.c
@@ -659,7 +659,7 @@ static void microchip_icicle_kit_machine_class_init(ObjectClass *oc, void *data)
     mc->default_ram_id = "microchip.icicle.kit.ram";
 
     /*
-     * Map 513 MiB high memory, the mimimum required high memory size, because
+     * Map 513 MiB high memory, the minimum required high memory size, because
      * HSS will do memory test against the high memory address range regardless
      * of physical memory installed.
      *
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 99c4e6314b..a5ac3ab777 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -66,13 +66,13 @@
 #define VIRT_IMSIC_GROUP_MAX_SIZE      (1U << IMSIC_MMIO_GROUP_MIN_SHIFT)
 #if VIRT_IMSIC_GROUP_MAX_SIZE < \
     IMSIC_GROUP_SIZE(VIRT_CPUS_MAX_BITS, VIRT_IRQCHIP_MAX_GUESTS_BITS)
-#error "Can't accomodate single IMSIC group in address space"
+#error "Can't accommodate single IMSIC group in address space"
 #endif
 
 #define VIRT_IMSIC_MAX_SIZE            (VIRT_SOCKETS_MAX * \
                                         VIRT_IMSIC_GROUP_MAX_SIZE)
 #if 0x4000000 < VIRT_IMSIC_MAX_SIZE
-#error "Can't accomodate all IMSIC groups in address space"
+#error "Can't accommodate all IMSIC groups in address space"
 #endif
 
 static const MemMapEntry virt_memmap[] = {
diff --git a/include/hw/riscv/riscv_hart.h b/include/hw/riscv/riscv_hart.h
index bbc21cdc9a..912b4a2682 100644
--- a/include/hw/riscv/riscv_hart.h
+++ b/include/hw/riscv/riscv_hart.h
@@ -3,7 +3,7 @@
  *
  * Copyright (c) 2017 SiFive, Inc.
  *
- * Holds the state of a heterogenous array of RISC-V harts
+ * Holds the state of a heterogeneous array of RISC-V harts
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 6ea22e0eea..6316cbcc23 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -349,7 +349,7 @@ struct CPUArchState {
     target_ulong upmmask;
     target_ulong upmbase;
 
-    /* CSRs for execution enviornment configuration */
+    /* CSRs for execution environment configuration */
     uint64_t menvcfg;
     uint64_t mstateen[SMSTATEEN_MAX_COUNT];
     uint64_t hstateen[SMSTATEEN_MAX_COUNT];
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 59f0ffd9e1..31a8d80990 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -656,7 +656,7 @@ typedef enum {
 /* Leaf page shift amount */
 #define PGSHIFT             12
 
-/* Default Reset Vector adress */
+/* Default Reset Vector address */
 #define DEFAULT_RSTVEC      0x1000
 
 /* Exception causes */
@@ -740,7 +740,7 @@ typedef enum RISCVException {
 #define PM_CURRENT      0x00000002ULL
 #define PM_INSN         0x00000004ULL
 
-/* Execution enviornment configuration bits */
+/* Execution environment configuration bits */
 #define MENVCFG_FIOM                       BIT(0)
 #define MENVCFG_CBIE                       (3UL << 4)
 #define MENVCFG_CBCFE                      BIT(6)
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index de31818daa..ca95ae1527 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -3215,7 +3215,7 @@ static int write_hvipriox(CPURISCVState *env, int first_index,
                RISCV_EXCP_VIRT_INSTRUCTION_FAULT : RISCV_EXCP_ILLEGAL_INST;
     }
 
-    /* Fill-up priority arrary */
+    /* Fill-up priority array */
     for (i = 0; i < num_irqs; i++) {
         if (riscv_cpu_hviprio_index2irq(first_index + i, &irq, &rdzero)) {
             continue;
@@ -3884,7 +3884,7 @@ static inline RISCVException riscv_csrrw_check(CPURISCVState *env,
     if (riscv_has_ext(env, RVH) && env->priv == PRV_S &&
         !env->virt_enabled) {
         /*
-         * We are in HS mode. Add 1 to the effective privledge level to
+         * We are in HS mode. Add 1 to the effective privilege level to
          * allow us to access the Hypervisor CSRs.
          */
         effective_priv++;
diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index 75ee1c4971..211f5921b6 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -574,7 +574,7 @@ static void riscv_itrigger_update_count(CPURISCVState *env)
     int count, executed;
     /*
      * Record last icount, so that we can evaluate the executed instructions
-     * since last priviledge mode change or timer expire.
+     * since last privilege mode change or timer expire.
      */
     int64_t last_icount = env->last_icount, current_icount;
     current_icount = env->last_icount = icount_get_raw();
@@ -588,14 +588,14 @@ static void riscv_itrigger_update_count(CPURISCVState *env)
             continue;
         }
         /*
-         * Only when priviledge is changed or itrigger timer expires,
+         * Only when privilege is changed or itrigger timer expires,
          * the count field in itrigger tdata1 register is updated.
          * And the count field in itrigger only contains remaining value.
          */
         if (check_itrigger_priv(env, i)) {
             /*
-             * If itrigger enabled in this priviledge mode, the number of
-             * executed instructions since last priviledge change
+             * If itrigger enabled in this privilege mode, the number of
+             * executed instructions since last privilege change
              * should be reduced from current itrigger count.
              */
             executed = current_icount - last_icount;
@@ -605,7 +605,7 @@ static void riscv_itrigger_update_count(CPURISCVState *env)
             }
         } else {
             /*
-             * If itrigger is not enabled in this priviledge mode,
+             * If itrigger is not enabled in this privilege mode,
              * the number of executed instructions will be discard and
              * the count field in itrigger will not change.
              */
diff --git a/target/riscv/insn_trans/trans_rvf.c.inc b/target/riscv/insn_trans/trans_rvf.c.inc
index a0da7391c7..e7ab84cd9a 100644
--- a/target/riscv/insn_trans/trans_rvf.c.inc
+++ b/target/riscv/insn_trans/trans_rvf.c.inc
@@ -300,7 +300,7 @@ static bool trans_fsgnjn_s(DisasContext *ctx, arg_fsgnjn_s *a)
         tcg_gen_and_i64(dest, mask, rs1);
         tcg_gen_or_i64(dest, dest, rs2);
     }
-    /* signed-extended intead of nanboxing for result if enable zfinx */
+    /* signed-extended instead of nanboxing for result if enable zfinx */
     if (ctx->cfg_ptr->ext_zfinx) {
         tcg_gen_ext32s_i64(dest, dest);
     }
@@ -345,7 +345,7 @@ static bool trans_fsgnjx_s(DisasContext *ctx, arg_fsgnjx_s *a)
         tcg_gen_andi_i64(dest, rs2, MAKE_64BIT_MASK(31, 1));
         tcg_gen_xor_i64(dest, rs1, dest);
     }
-    /* signed-extended intead of nanboxing for result if enable zfinx */
+    /* signed-extended instead of nanboxing for result if enable zfinx */
     if (ctx->cfg_ptr->ext_zfinx) {
         tcg_gen_ext32s_i64(dest, dest);
     }
diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index c2f7527f53..6ab63f4442 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -2240,7 +2240,7 @@ GEN_OPIWI_NARROW_TRANS(vnclip_wi, IMM_ZX, vnclip_wx)
  *
  * If SEW < FLEN, check whether input fp register is a valid
  * NaN-boxed value, in which case the least-significant SEW bits
- * of the f regsiter are used, else the canonical NaN value is used.
+ * of the f register are used, else the canonical NaN value is used.
  */
 static void do_nanbox(DisasContext *s, TCGv_i64 out, TCGv_i64 in)
 {
@@ -3282,7 +3282,7 @@ static void load_element(TCGv_i64 dest, TCGv_ptr base,
     }
 }
 
-/* offset of the idx element with base regsiter r */
+/* offset of the idx element with base register r */
 static uint32_t endian_ofs(DisasContext *s, int r, int idx)
 {
 #if HOST_BIG_ENDIAN
diff --git a/target/riscv/insn_trans/trans_rvzfh.c.inc b/target/riscv/insn_trans/trans_rvzfh.c.inc
index 8b1e2519bb..4b01812fd8 100644
--- a/target/riscv/insn_trans/trans_rvzfh.c.inc
+++ b/target/riscv/insn_trans/trans_rvzfh.c.inc
@@ -305,7 +305,7 @@ static bool trans_fsgnjn_h(DisasContext *ctx, arg_fsgnjn_h *a)
         tcg_gen_and_i64(dest, mask, rs1);
         tcg_gen_or_i64(dest, dest, rs2);
     }
-    /* signed-extended intead of nanboxing for result if enable zfinx */
+    /* signed-extended instead of nanboxing for result if enable zfinx */
     if (ctx->cfg_ptr->ext_zfinx) {
         tcg_gen_ext16s_i64(dest, dest);
     }
@@ -349,7 +349,7 @@ static bool trans_fsgnjx_h(DisasContext *ctx, arg_fsgnjx_h *a)
         tcg_gen_andi_i64(dest, rs2, MAKE_64BIT_MASK(15, 1));
         tcg_gen_xor_i64(dest, rs1, dest);
     }
-    /* signed-extended intead of nanboxing for result if enable zfinx */
+    /* signed-extended instead of nanboxing for result if enable zfinx */
     if (ctx->cfg_ptr->ext_zfinx) {
         tcg_gen_ext16s_i64(dest, dest);
     }
diff --git a/target/riscv/monitor.c b/target/riscv/monitor.c
index f36ddfa967..f5b1ffe6c3 100644
--- a/target/riscv/monitor.c
+++ b/target/riscv/monitor.c
@@ -55,7 +55,7 @@ static void print_pte_header(Monitor *mon)
 static void print_pte(Monitor *mon, int va_bits, target_ulong vaddr,
                       hwaddr paddr, target_ulong size, int attr)
 {
-    /* santity check on vaddr */
+    /* sanity check on vaddr */
     if (vaddr >= (1UL << va_bits)) {
         return;
     }
-- 
2.39.2


