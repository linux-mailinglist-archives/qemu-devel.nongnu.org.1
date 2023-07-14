Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9C77539D6
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 13:43:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKH9f-0000qS-1p; Fri, 14 Jul 2023 07:40:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qKH94-0000Ws-8C; Fri, 14 Jul 2023 07:39:38 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qKH90-0004Fo-Vt; Fri, 14 Jul 2023 07:39:33 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B63AF13D98;
 Fri, 14 Jul 2023 14:38:56 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id B0C3014BA7;
 Fri, 14 Jul 2023 14:38:40 +0300 (MSK)
Received: (nullmailer pid 1186231 invoked by uid 1000);
 Fri, 14 Jul 2023 11:38:38 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH, trivial 12/29] tree-wide spelling fixes in comments and some
 messages: riscv
Date: Fri, 14 Jul 2023 14:38:17 +0300
Message-Id: <20230714113834.1186117-14-mjt@tls.msk.ru>
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
@@ -661,3 +661,3 @@ static void microchip_icicle_kit_machine_class_init(ObjectClass *oc, void *data)
     /*
-     * Map 513 MiB high memory, the mimimum required high memory size, because
+     * Map 513 MiB high memory, the minimum required high memory size, because
      * HSS will do memory test against the high memory address range regardless
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index d90286dc46..a0c2cbce89 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -68,3 +68,3 @@
     IMSIC_GROUP_SIZE(VIRT_CPUS_MAX_BITS, VIRT_IRQCHIP_MAX_GUESTS_BITS)
-#error "Can't accomodate single IMSIC group in address space"
+#error "Can't accommodate single IMSIC group in address space"
 #endif
@@ -74,3 +74,3 @@
 #if 0x4000000 < VIRT_IMSIC_MAX_SIZE
-#error "Can't accomodate all IMSIC groups in address space"
+#error "Can't accommodate all IMSIC groups in address space"
 #endif
diff --git a/include/hw/riscv/riscv_hart.h b/include/hw/riscv/riscv_hart.h
index bbc21cdc9a..912b4a2682 100644
--- a/include/hw/riscv/riscv_hart.h
+++ b/include/hw/riscv/riscv_hart.h
@@ -5,3 +5,3 @@
  *
- * Holds the state of a heterogenous array of RISC-V harts
+ * Holds the state of a heterogeneous array of RISC-V harts
  *
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 6ea22e0eea..6316cbcc23 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -351,3 +351,3 @@ struct CPUArchState {
 
-    /* CSRs for execution enviornment configuration */
+    /* CSRs for execution environment configuration */
     uint64_t menvcfg;
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 59f0ffd9e1..31a8d80990 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -658,3 +658,3 @@ typedef enum {
 
-/* Default Reset Vector adress */
+/* Default Reset Vector address */
 #define DEFAULT_RSTVEC      0x1000
@@ -742,3 +742,3 @@ typedef enum RISCVException {
 
-/* Execution enviornment configuration bits */
+/* Execution environment configuration bits */
 #define MENVCFG_FIOM                       BIT(0)
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index ea7585329e..26bc1f0ff1 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -3218,3 +3218,3 @@ static int write_hvipriox(CPURISCVState *env, int first_index,
 
-    /* Fill-up priority arrary */
+    /* Fill-up priority array */
     for (i = 0; i < num_irqs; i++) {
@@ -3887,3 +3887,3 @@ static inline RISCVException riscv_csrrw_check(CPURISCVState *env,
         /*
-         * We are in HS mode. Add 1 to the effective privledge level to
+         * We are in HS mode. Add 1 to the effective privilege level to
          * allow us to access the Hypervisor CSRs.
diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index 75ee1c4971..211f5921b6 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -576,3 +576,3 @@ static void riscv_itrigger_update_count(CPURISCVState *env)
      * Record last icount, so that we can evaluate the executed instructions
-     * since last priviledge mode change or timer expire.
+     * since last privilege mode change or timer expire.
      */
@@ -590,3 +590,3 @@ static void riscv_itrigger_update_count(CPURISCVState *env)
         /*
-         * Only when priviledge is changed or itrigger timer expires,
+         * Only when privilege is changed or itrigger timer expires,
          * the count field in itrigger tdata1 register is updated.
@@ -596,4 +596,4 @@ static void riscv_itrigger_update_count(CPURISCVState *env)
             /*
-             * If itrigger enabled in this priviledge mode, the number of
-             * executed instructions since last priviledge change
+             * If itrigger enabled in this privilege mode, the number of
+             * executed instructions since last privilege change
              * should be reduced from current itrigger count.
@@ -607,3 +607,3 @@ static void riscv_itrigger_update_count(CPURISCVState *env)
             /*
-             * If itrigger is not enabled in this priviledge mode,
+             * If itrigger is not enabled in this privilege mode,
              * the number of executed instructions will be discard and
diff --git a/target/riscv/insn_trans/trans_rvf.c.inc b/target/riscv/insn_trans/trans_rvf.c.inc
index a0da7391c7..e7ab84cd9a 100644
--- a/target/riscv/insn_trans/trans_rvf.c.inc
+++ b/target/riscv/insn_trans/trans_rvf.c.inc
@@ -302,3 +302,3 @@ static bool trans_fsgnjn_s(DisasContext *ctx, arg_fsgnjn_s *a)
     }
-    /* signed-extended intead of nanboxing for result if enable zfinx */
+    /* signed-extended instead of nanboxing for result if enable zfinx */
     if (ctx->cfg_ptr->ext_zfinx) {
@@ -347,3 +347,3 @@ static bool trans_fsgnjx_s(DisasContext *ctx, arg_fsgnjx_s *a)
     }
-    /* signed-extended intead of nanboxing for result if enable zfinx */
+    /* signed-extended instead of nanboxing for result if enable zfinx */
     if (ctx->cfg_ptr->ext_zfinx) {
diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index c2f7527f53..6ab63f4442 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -2242,3 +2242,3 @@ GEN_OPIWI_NARROW_TRANS(vnclip_wi, IMM_ZX, vnclip_wx)
  * NaN-boxed value, in which case the least-significant SEW bits
- * of the f regsiter are used, else the canonical NaN value is used.
+ * of the f register are used, else the canonical NaN value is used.
  */
@@ -3284,3 +3284,3 @@ static void load_element(TCGv_i64 dest, TCGv_ptr base,
 
-/* offset of the idx element with base regsiter r */
+/* offset of the idx element with base register r */
 static uint32_t endian_ofs(DisasContext *s, int r, int idx)
diff --git a/target/riscv/insn_trans/trans_rvzfh.c.inc b/target/riscv/insn_trans/trans_rvzfh.c.inc
index 8b1e2519bb..4b01812fd8 100644
--- a/target/riscv/insn_trans/trans_rvzfh.c.inc
+++ b/target/riscv/insn_trans/trans_rvzfh.c.inc
@@ -307,3 +307,3 @@ static bool trans_fsgnjn_h(DisasContext *ctx, arg_fsgnjn_h *a)
     }
-    /* signed-extended intead of nanboxing for result if enable zfinx */
+    /* signed-extended instead of nanboxing for result if enable zfinx */
     if (ctx->cfg_ptr->ext_zfinx) {
@@ -351,3 +351,3 @@ static bool trans_fsgnjx_h(DisasContext *ctx, arg_fsgnjx_h *a)
     }
-    /* signed-extended intead of nanboxing for result if enable zfinx */
+    /* signed-extended instead of nanboxing for result if enable zfinx */
     if (ctx->cfg_ptr->ext_zfinx) {
diff --git a/target/riscv/monitor.c b/target/riscv/monitor.c
index f36ddfa967..f5b1ffe6c3 100644
--- a/target/riscv/monitor.c
+++ b/target/riscv/monitor.c
@@ -57,3 +57,3 @@ static void print_pte(Monitor *mon, int va_bits, target_ulong vaddr,
 {
-    /* santity check on vaddr */
+    /* sanity check on vaddr */
     if (vaddr >= (1UL << va_bits)) {
-- 
2.39.2


