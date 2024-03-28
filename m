Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DE1878E47
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Mar 2024 06:48:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjuz0-00078e-O9; Tue, 12 Mar 2024 01:47:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rjuyn-00075p-PX; Tue, 12 Mar 2024 01:47:18 -0400
Received: from out30-97.freemail.mail.aliyun.com ([115.124.30.97])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.huang@linux.alibaba.com>)
 id 1rjuyY-0007do-Em; Tue, 12 Mar 2024 01:47:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1710222408; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=n3lFD/Eap30yyY91QJ2Yy23T+51QoULRPSQPw9NBZrU=;
 b=n/XvU0uxMmNW0rF6sl2oSKN4Jz2uifB+GGlEtGXGbE+fE9zNWtOunXzHXJ+3r0L/cD1oliHhRDw2I5oDFns3Xg9Mu2Qu5SmFf+7VPdxQXTlI5PLPGt8fgd9T4kc/iBl4l9EqB5zumi7rwKP6FgZ1MQBs5Bh+8uL35E2b6joEjGc=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R481e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046049;
 MF=eric.huang@linux.alibaba.com; NM=1; PH=DS; RN=10; SR=0;
 TI=SMTPD_---0W2KhSFI_1710222404; 
Received: from localhost.localdomain(mailfrom:eric.huang@linux.alibaba.com
 fp:SMTPD_---0W2KhSFI_1710222404) by smtp.aliyun-inc.com;
 Tue, 12 Mar 2024 13:46:45 +0800
From: Huang Tao <eric.huang@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bin.meng@windriver.com,
 alistair.francis@wdc.com, palmer@dabbelt.com,
 Huang Tao <eric.huang@linux.alibaba.com>,
 Christoph Muellner <christoph.muellner@vrull.eu>
Subject: [PATCH v2] target/riscv: Implement dynamic establishment of custom
 decoder
Date: Tue, 12 Mar 2024 13:45:53 +0800
Message-ID: <20240312054553.11811-1-eric.huang@linux.alibaba.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.97;
 envelope-from=eric.huang@linux.alibaba.com;
 helo=out30-97.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01, T_SPF_HELO_TEMPERROR=0.01,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

In this patch, we modify the decoder to be a freely composable data
structure instead of a hardcoded one. It can be dynamically builded up
according to the extensions.
This approach has several benefits:
1. Provides support for heterogeneous cpu architectures. As we add decoder in
   RISCVCPU, each cpu can have their own decoder, and the decoders can be
   different due to cpu's features.
2. Improve the decoding efficiency. We run the guard_func to see if the decoder
   can be added to the dynamic_decoder when building up the decoder. Therefore,
   there is no need to run the guard_func when decoding each instruction. It can
   improve the decoding efficiency
3. For vendor or dynamic cpus, it allows them to customize their own decoder
   functions to improve decoding efficiency, especially when vendor-defined
   instruction sets increase. Because of dynamic building up, it can skip the other
   decoder guard functions when decoding.
4. Pre patch for allowing adding a vendor decoder before decode_insn32() with minimal
   overhead for users that don't need this particular vendor deocder.

Signed-off-by: Huang Tao <eric.huang@linux.alibaba.com>
Suggested-by: Christoph Muellner <christoph.muellner@vrull.eu>
Co-authored-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
---
 target/riscv/cpu.c         | 19 +++++++++++++++++++
 target/riscv/cpu.h         |  2 ++
 target/riscv/cpu_decoder.h | 34 ++++++++++++++++++++++++++++++++++
 target/riscv/translate.c   | 28 ++++++++++++----------------
 4 files changed, 67 insertions(+), 16 deletions(-)
 create mode 100644 target/riscv/cpu_decoder.h

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 5ff0192c52..5ea5232ed8 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -38,6 +38,7 @@
 #include "kvm/kvm_riscv.h"
 #include "tcg/tcg-cpu.h"
 #include "tcg/tcg.h"
+#include "cpu_decoder.h"
 
 /* RISC-V CPU definitions */
 static const char riscv_single_letter_exts[] = "IEMAFDQCBPVH";
@@ -1102,6 +1103,22 @@ static void riscv_cpu_satp_mode_finalize(RISCVCPU *cpu, Error **errp)
 }
 #endif
 
+static void riscv_cpu_finalize_dynamic_decoder(RISCVCPU *cpu)
+{
+    decode_fn *dynamic_decoders;
+    dynamic_decoders = g_new0(decode_fn, decoder_table_size);
+    int j = 0;
+    for (size_t i = 0; i < decoder_table_size; ++i) {
+        if (decoder_table[i].guard_func &&
+            decoder_table[i].guard_func(&cpu->cfg)) {
+            dynamic_decoders[j] = decoder_table[i].decode_fn;
+            j++;
+        }
+    }
+
+    cpu->decoders = dynamic_decoders;
+}
+
 void riscv_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
 {
     Error *local_err = NULL;
@@ -1127,6 +1144,8 @@ void riscv_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
             return;
         }
     }
+
+    riscv_cpu_finalize_dynamic_decoder(cpu);
 }
 
 static void riscv_cpu_realize(DeviceState *dev, Error **errp)
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 5d291a7092..bb96af97f9 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -30,6 +30,7 @@
 #include "qemu/int128.h"
 #include "cpu_bits.h"
 #include "cpu_cfg.h"
+#include "cpu_decoder.h"
 #include "qapi/qapi-types-common.h"
 #include "cpu-qom.h"
 
@@ -457,6 +458,7 @@ struct ArchCPU {
     uint32_t pmu_avail_ctrs;
     /* Mapping of events to counters */
     GHashTable *pmu_event_ctr_map;
+    const decode_fn *decoders;
 };
 
 /**
diff --git a/target/riscv/cpu_decoder.h b/target/riscv/cpu_decoder.h
new file mode 100644
index 0000000000..549414ce4c
--- /dev/null
+++ b/target/riscv/cpu_decoder.h
@@ -0,0 +1,34 @@
+/*
+ * QEMU RISC-V CPU Decoder
+ *
+ * Copyright (c) 2023-2024 Alibaba Group
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef RISCV_CPU_DECODER_H
+#define RISCV_CPU_DECODER_H
+
+struct DisasContext;
+struct RISCVCPUConfig;
+typedef struct RISCVDecoder {
+    bool (*guard_func)(const struct RISCVCPUConfig *);
+    bool (*decode_fn)(struct DisasContext *, uint32_t);
+} RISCVDecoder;
+
+typedef bool (*decode_fn)(struct DisasContext *, uint32_t);
+
+extern const size_t decoder_table_size;
+
+extern const RISCVDecoder decoder_table[];
+#endif
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 177418b2b9..3f50737a50 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -115,6 +115,7 @@ typedef struct DisasContext {
     bool frm_valid;
     /* TCG of the current insn_start */
     TCGOp *insn_start;
+    const decode_fn *decoders;
 } DisasContext;
 
 static inline bool has_ext(DisasContext *ctx, uint32_t ext)
@@ -1118,21 +1119,16 @@ static inline int insn_len(uint16_t first_word)
     return (first_word & 3) == 3 ? 4 : 2;
 }
 
+const RISCVDecoder decoder_table[] = {
+    { always_true_p, decode_insn32 },
+    { has_xthead_p, decode_xthead},
+    { has_XVentanaCondOps_p, decode_XVentanaCodeOps},
+};
+
+const size_t decoder_table_size = ARRAY_SIZE(decoder_table);
+
 static void decode_opc(CPURISCVState *env, DisasContext *ctx, uint16_t opcode)
 {
-    /*
-     * A table with predicate (i.e., guard) functions and decoder functions
-     * that are tested in-order until a decoder matches onto the opcode.
-     */
-    static const struct {
-        bool (*guard_func)(const RISCVCPUConfig *);
-        bool (*decode_func)(DisasContext *, uint32_t);
-    } decoders[] = {
-        { always_true_p,  decode_insn32 },
-        { has_xthead_p, decode_xthead },
-        { has_XVentanaCondOps_p,  decode_XVentanaCodeOps },
-    };
-
     ctx->virt_inst_excp = false;
     ctx->cur_insn_len = insn_len(opcode);
     /* Check for compressed insn */
@@ -1153,9 +1149,8 @@ static void decode_opc(CPURISCVState *env, DisasContext *ctx, uint16_t opcode)
                                              ctx->base.pc_next + 2));
         ctx->opcode = opcode32;
 
-        for (size_t i = 0; i < ARRAY_SIZE(decoders); ++i) {
-            if (decoders[i].guard_func(ctx->cfg_ptr) &&
-                decoders[i].decode_func(ctx, opcode32)) {
+        for (size_t i = 0; ctx->decoders[i]; ++i) {
+            if (ctx->decoders[i](ctx, opcode32)) {
                 return;
             }
         }
@@ -1199,6 +1194,7 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->itrigger = FIELD_EX32(tb_flags, TB_FLAGS, ITRIGGER);
     ctx->zero = tcg_constant_tl(0);
     ctx->virt_inst_excp = false;
+    ctx->decoders = cpu->decoders;
 }
 
 static void riscv_tr_tb_start(DisasContextBase *db, CPUState *cpu)
-- 
2.41.0


