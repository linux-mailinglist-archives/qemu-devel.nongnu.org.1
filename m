Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4469EC0FE46
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Oct 2025 19:20:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDRmC-0004hj-Re; Mon, 27 Oct 2025 14:17:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vDRm4-0004hK-6o
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 14:16:56 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vDRly-0003yX-5r
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 14:16:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=Mn7dG4swH3+/JYz00FsCpxgBd1EQhYrfOm5c002jNVw=; b=ILBKUprbd/RARIs
 04n8DPkR5rqvioA4KsJrINDqJp9ZnZzGkF+EuzB8e4Qe+jQIBxsXhH/aPRmEopTh1O1amU/J1Oit7
 SdR57zaY5jnWxXpWFL971Vnc6xJAKrWbY2eQtXF9wP2YGrvCbJ0L++rYa0fKfvj4ydkYBygAw/B6C
 cc=;
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, philmd@linaro.org, alistair.francis@wdc.com,
 palmer@dabbelt.com, Anton Johansson <anjo@rev.ng>
Subject: [PATCH v4 09/33] target/riscv: Fix size of gpr and gprh
Date: Mon, 27 Oct 2025 19:18:06 +0100
Message-ID: <20251027181831.27016-10-anjo@rev.ng>
In-Reply-To: <20251027181831.27016-1-anjo@rev.ng>
References: <20251027181831.27016-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

gprh is only needed for TARGET_RISCV64 when modeling 128-bit registers,
fixing their size to 64 bits makes sense.

gpr is also fixed to 64 bits since all direct uses of env->gpr
correctly zero extend/truncate to/from target_ulong, meaning
!TARGET_RISCV64 will behave as expected.

We do however need to be a bit careful when mapping 64-bit fields to
32-bit TCGv globals on big endian hosts.

Note, the cpu/rv128 VMSTATE version is bumped, breaking migration from
older versions.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h            |  4 ++--
 target/riscv/cpu.c            |  2 +-
 target/riscv/machine.c        |  8 ++++----
 target/riscv/riscv-qmp-cmds.c |  2 +-
 target/riscv/translate.c      | 17 +++++++++++++++--
 5 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 2e0b86e68d..6b4edbfe9e 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -213,8 +213,8 @@ typedef struct PMUFixedCtrState {
 } PMUFixedCtrState;
 
 struct CPUArchState {
-    target_ulong gpr[32];
-    target_ulong gprh[32]; /* 64 top bits of the 128-bit registers */
+    uint64_t gpr[32];
+    uint64_t gprh[32]; /* 64 top bits of the 128-bit registers */
 
     /* vector coprocessor state. */
     uint64_t vreg[32 * RV_VLEN_MAX / 64] QEMU_ALIGNED(16);
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 73d4280d7c..dc97d35458 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -583,7 +583,7 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 #endif
 
     for (i = 0; i < 32; i++) {
-        qemu_fprintf(f, " %-8s " TARGET_FMT_lx,
+        qemu_fprintf(f, " %-8s %" PRIx64,
                      riscv_int_regnames[i], env->gpr[i]);
         if ((i & 3) == 3) {
             qemu_fprintf(f, "\n");
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 09c032a879..7349383eab 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -177,11 +177,11 @@ static bool rv128_needed(void *opaque)
 
 static const VMStateDescription vmstate_rv128 = {
     .name = "cpu/rv128",
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .needed = rv128_needed,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINTTL_ARRAY(env.gprh, RISCVCPU, 32),
+        VMSTATE_UINT64_ARRAY(env.gprh, RISCVCPU, 32),
         VMSTATE_UINT64(env.mscratchh, RISCVCPU),
         VMSTATE_UINT64(env.sscratchh, RISCVCPU),
         VMSTATE_END_OF_LIST()
@@ -429,7 +429,7 @@ const VMStateDescription vmstate_riscv_cpu = {
     .minimum_version_id = 11,
     .post_load = riscv_cpu_post_load,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINTTL_ARRAY(env.gpr, RISCVCPU, 32),
+        VMSTATE_UINT64_ARRAY(env.gpr, RISCVCPU, 32),
         VMSTATE_UINT64_ARRAY(env.fpr, RISCVCPU, 32),
         VMSTATE_UINT8_ARRAY(env.miprio, RISCVCPU, 64),
         VMSTATE_UINT8_ARRAY(env.siprio, RISCVCPU, 64),
diff --git a/target/riscv/riscv-qmp-cmds.c b/target/riscv/riscv-qmp-cmds.c
index d5e9bec0f8..93488450bd 100644
--- a/target/riscv/riscv-qmp-cmds.c
+++ b/target/riscv/riscv-qmp-cmds.c
@@ -262,7 +262,7 @@ static bool reg_is_ulong_integer(CPURISCVState *env, const char *name,
                                  target_ulong *val, bool is_gprh)
 {
     const char * const *reg_names;
-    target_ulong *vals;
+    uint64_t *vals;
 
     if (is_gprh) {
         reg_names = riscv_int_regnamesh;
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index e1f4dc5ffd..8df1a2ed3c 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -27,6 +27,7 @@
 #include "accel/tcg/cpu-ldst.h"
 #include "exec/translation-block.h"
 #include "exec/log.h"
+#include "exec/tswap.h"
 #include "semihosting/semihost.h"
 
 #include "internals.h"
@@ -1443,12 +1444,24 @@ void riscv_translate_init(void)
      */
     cpu_gpr[0] = NULL;
     cpu_gprh[0] = NULL;
+    /*
+     * Be careful with big endian hosts when mapping 64-bit CPUArchState fields
+     * to 32-bit TCGv globals.  An offset of 4 bytes is applied so the least
+     * significant bytes are correctly written to.
+     */
+#if HOST_BIG_ENDIAN && !defined(TARGET_RISCV64)
+    size_t field_offset = 4;
+#else
+    size_t field_offset = 0;
+#endif
 
     for (i = 1; i < 32; i++) {
         cpu_gpr[i] = tcg_global_mem_new(tcg_env,
-            offsetof(CPURISCVState, gpr[i]), riscv_int_regnames[i]);
+            offsetof(CPURISCVState, gpr[i]) + field_offset,
+            riscv_int_regnames[i]);
         cpu_gprh[i] = tcg_global_mem_new(tcg_env,
-            offsetof(CPURISCVState, gprh[i]), riscv_int_regnamesh[i]);
+            offsetof(CPURISCVState, gprh[i]) + field_offset,
+            riscv_int_regnamesh[i]);
     }
 
     for (i = 0; i < 32; i++) {
-- 
2.51.0


