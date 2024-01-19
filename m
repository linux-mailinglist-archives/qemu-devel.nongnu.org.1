Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF40832B6A
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 15:42:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQq3M-00061C-IL; Fri, 19 Jan 2024 09:41:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rQq30-0005th-V8
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 09:40:42 -0500
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rQq2w-0003vW-B0
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 09:40:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=r7k10i1SVH85ChTA6Z/gMmAlYkPdspyjFqih1CaFIEM=; b=mV5pRoDJz+iAaydAXG7S7xYx7k
 qcVGE3O8k/1/ig9cNgDD+5hKT903P1s8e2FIPk7onc1ANXrR9DU6LQpeONvdYC1teQlTOkwXFwheB
 2qE+MCoXf19YGbg8v9+nBKq9yub9dUkskXpuIqaqL8HP+iORruvYYSKXeii6ZsVtMO5I=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng,
	richard.henderson@linaro.org,
	philmd@linaro.org
Subject: [RFC PATCH 27/34] accel/tcg: Make translate-all.c target independent
Date: Fri, 19 Jan 2024 15:40:17 +0100
Message-ID: <20240119144024.14289-28-anjo@rev.ng>
In-Reply-To: <20240119144024.14289-1-anjo@rev.ng>
References: <20240119144024.14289-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=5.9.113.41; envelope-from=anjo@rev.ng; helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Makes translate-all.c independent of softmmu target by switching

    TARGET_LONG_BITS        -> target_long_bits()

    TARGET_INSN_START_WORDS -> tcg_ctx->insn_start_words,
                               target_insn_start_words(),

    TCG_GUEST_DEFAULT_MO    -> target_default_memory_order()

    MO_TE                   -> target_endian_memory_order()

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 accel/tcg/translate-all.c | 38 ++++++++++++++++++--------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 9c981d1750..a3ae0c6910 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -65,7 +65,6 @@
 #include "internal-common.h"
 #include "internal-target.h"
 #include "perf.h"
-#include "tcg/insn-start-words.h"
 
 TBContext tb_ctx;
 
@@ -106,7 +105,7 @@ static int64_t decode_sleb128(const uint8_t **pp)
         val |= (int64_t)(byte & 0x7f) << shift;
         shift += 7;
     } while (byte & 0x80);
-    if (shift < TARGET_LONG_BITS && (byte & 0x40)) {
+    if (shift < target_long_bits() && (byte & 0x40)) {
         val |= -(int64_t)1 << shift;
     }
 
@@ -117,7 +116,7 @@ static int64_t decode_sleb128(const uint8_t **pp)
 /* Encode the data collected about the instructions while compiling TB.
    Place the data at BLOCK, and return the number of bytes consumed.
 
-   The logical table consists of TARGET_INSN_START_WORDS target_ulong's,
+   The logical table consists of tcg_ctx->insn_start_words target_ulong's,
    which come from the target's insn_start data, followed by a uintptr_t
    which comes from the host pc of the end of the code implementing the insn.
 
@@ -128,6 +127,7 @@ static int64_t decode_sleb128(const uint8_t **pp)
 
 static int encode_search(TranslationBlock *tb, uint8_t *block)
 {
+    const uint8_t insn_start_words = tcg_ctx->insn_start_words;
     uint8_t *highwater = tcg_ctx->code_gen_highwater;
     uint64_t *insn_data = tcg_ctx->gen_insn_data;
     uint16_t *insn_end_off = tcg_ctx->gen_insn_end_off;
@@ -137,13 +137,13 @@ static int encode_search(TranslationBlock *tb, uint8_t *block)
     for (i = 0, n = tb->icount; i < n; ++i) {
         uint64_t prev, curr;
 
-        for (j = 0; j < TARGET_INSN_START_WORDS; ++j) {
+        for (j = 0; j < insn_start_words; ++j) {
             if (i == 0) {
                 prev = (!(tb_cflags(tb) & CF_PCREL) && j == 0 ? tb->pc : 0);
             } else {
-                prev = insn_data[(i - 1) * TARGET_INSN_START_WORDS + j];
+                prev = insn_data[(i - 1) * insn_start_words + j];
             }
-            curr = insn_data[i * TARGET_INSN_START_WORDS + j];
+            curr = insn_data[i * insn_start_words + j];
             p = encode_sleb128(p, curr - prev);
         }
         prev = (i == 0 ? 0 : insn_end_off[i - 1]);
@@ -165,6 +165,7 @@ static int encode_search(TranslationBlock *tb, uint8_t *block)
 static int cpu_unwind_data_from_tb(TranslationBlock *tb, uintptr_t host_pc,
                                    uint64_t *data)
 {
+    const uint8_t insn_start_words = tcg_ctx->insn_start_words;
     uintptr_t iter_pc = (uintptr_t)tb->tc.ptr;
     const uint8_t *p = tb->tc.ptr + tb->tc.size;
     int i, j, num_insns = tb->icount;
@@ -175,7 +176,7 @@ static int cpu_unwind_data_from_tb(TranslationBlock *tb, uintptr_t host_pc,
         return -1;
     }
 
-    memset(data, 0, sizeof(uint64_t) * TARGET_INSN_START_WORDS);
+    memset(data, 0, sizeof(uint64_t) * insn_start_words);
     if (!(tb_cflags(tb) & CF_PCREL)) {
         data[0] = tb->pc;
     }
@@ -185,7 +186,7 @@ static int cpu_unwind_data_from_tb(TranslationBlock *tb, uintptr_t host_pc,
      * at which the end of the insn exceeds host_pc.
      */
     for (i = 0; i < num_insns; ++i) {
-        for (j = 0; j < TARGET_INSN_START_WORDS; ++j) {
+        for (j = 0; j < insn_start_words; ++j) {
             data[j] += decode_sleb128(&p);
         }
         iter_pc += decode_sleb128(&p);
@@ -203,7 +204,7 @@ static int cpu_unwind_data_from_tb(TranslationBlock *tb, uintptr_t host_pc,
 void cpu_restore_state_from_tb(CPUState *cpu, TranslationBlock *tb,
                                uintptr_t host_pc)
 {
-    uint64_t data[TARGET_INSN_START_WORDS];
+    uint64_t data[tcg_ctx->insn_start_words];
     int insns_left = cpu_unwind_data_from_tb(tb, host_pc, data);
 
     if (insns_left < 0) {
@@ -341,19 +342,15 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     }
 
     tcg_ctx->gen_tb = tb;
-    tcg_ctx->addr_type = TARGET_LONG_BITS == 32 ? TCG_TYPE_I32 : TCG_TYPE_I64;
+    tcg_ctx->addr_type = target_long_bits() == 32 ? TCG_TYPE_I32 : TCG_TYPE_I64;
 #ifdef CONFIG_SOFTMMU
-    tcg_ctx->mo_te = MO_TE;
+    tcg_ctx->mo_te = target_endian_memory_order();
     tcg_ctx->page_bits = TARGET_PAGE_BITS;
     tcg_ctx->page_mask = TARGET_PAGE_MASK;
-    tcg_ctx->tlb_dyn_max_bits = CPU_TLB_DYN_MAX_BITS;
-#endif
-    tcg_ctx->insn_start_words = TARGET_INSN_START_WORDS;
-#ifdef TCG_GUEST_DEFAULT_MO
-    tcg_ctx->guest_mo = TCG_GUEST_DEFAULT_MO;
-#else
-    tcg_ctx->guest_mo = TCG_MO_ALL;
+    tcg_ctx->tlb_dyn_max_bits = target_tlb_dyn_max_bits();
 #endif
+    tcg_ctx->insn_start_words = target_insn_start_words();
+    tcg_ctx->guest_mo = target_default_memory_order();
 
  restart_translate:
     trace_translate_block(tb, pc, tb->tc.ptr);
@@ -441,6 +438,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
         qemu_log_in_addr_range(pc)) {
         FILE *logfile = qemu_log_trylock();
         if (logfile) {
+            const uint8_t insn_start_words = tcg_ctx->insn_start_words;
             int code_size, data_size;
             const tcg_target_ulong *rx_data_gen_ptr;
             size_t chunk_start;
@@ -460,7 +458,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
             fprintf(logfile, "OUT: [size=%d]\n", gen_code_size);
             fprintf(logfile,
                     "  -- guest addr 0x%016" PRIx64 " + tb prologue\n",
-                    tcg_ctx->gen_insn_data[insn * TARGET_INSN_START_WORDS]);
+                    tcg_ctx->gen_insn_data[insn * insn_start_words]);
             chunk_start = tcg_ctx->gen_insn_end_off[insn];
             disas(logfile, tb->tc.ptr, chunk_start);
 
@@ -473,7 +471,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
                 size_t chunk_end = tcg_ctx->gen_insn_end_off[insn];
                 if (chunk_end > chunk_start) {
                     fprintf(logfile, "  -- guest addr 0x%016" PRIx64 "\n",
-                            tcg_ctx->gen_insn_data[insn * TARGET_INSN_START_WORDS]);
+                            tcg_ctx->gen_insn_data[insn * insn_start_words]);
                     disas(logfile, tb->tc.ptr + chunk_start,
                           chunk_end - chunk_start);
                     chunk_start = chunk_end;
-- 
2.43.0


