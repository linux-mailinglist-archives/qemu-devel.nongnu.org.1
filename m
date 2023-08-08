Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B7C773A8D
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 15:46:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTN1j-0000aL-2t; Tue, 08 Aug 2023 09:45:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <m.tyutin@yadro.com>)
 id 1qTN1O-0000YK-LC
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 09:45:18 -0400
Received: from mta-04.yadro.com ([89.207.88.248])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <m.tyutin@yadro.com>)
 id 1qTN1K-0006EE-N5
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 09:45:14 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 96BB6C0006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
 t=1691502304; bh=gMSSlkHpjavbAWB5sooUd2wDSAnwxnetOX6BaO/2UxM=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=V941yJcUBClcEs3am+S+mU9d5ylbl4Ff6yS3eYlvPEcDdLoti/TpyvoBtwNeisHdR
 S2GDTabDJ+C4hkyM4yURAyunIvqZn1/qfIp7WrmaHpOFyY1232jYg2U/qdn2VrONz8
 af1WByWpPLeFcuVNwK3+Vo5cXjjdf7TuggMeWxEQgGMMIHNZ04/LzUCcLUGN0h1yh7
 4f5ovy6nAyP5roRpJpAHrTWEaJlFWZnkNQD9iBFesQ+O1Ce07Npb7vEtKFJFMO2Y1A
 zA4LoJZcCAfSqvOBpprLkEaCpmsijoWIiSX4HU5p5V8O39hd/uhkO2jxlqenYh4JsT
 M0fyHy/6UyCng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
 t=1691502304; bh=gMSSlkHpjavbAWB5sooUd2wDSAnwxnetOX6BaO/2UxM=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=p8+wP2L8ppr7M7l5iBRCyiP4JUyAFxjHvkl3li2n+SJ81fvTPYz7X+GcOn8b/fzej
 gQ8ckmD2jTm+IyNVCX6pnX9VUjqedweDPrxvck8E0SvaLTGPgLw/s6T7FYIZct6plX
 Hy29vUSnmQJdTl96RloTUpB6J0rwEjUlH+LxgCBXoATX+22iAuZZzlVwrXr1zAc6Bm
 IdM2v0DoETkAW86aA+7cOKXPF2/xlzy34RF5//B6QnuLaFeTyoek4eyZbWub7L2iQP
 7/0sLi4nA1azPrX7DWvRN65iLpKKJM54ZN/v9zrgKqw0y/q5MnhC8ynPDh2ZuAetp1
 CeGicaxzRQsuw==
From: Mikhail Tyutin <m.tyutin@yadro.com>
To: <qemu-devel@nongnu.org>
CC: <richard.henderson@linaro.org>, <pbonzini@redhat.com>,
 <alex.bennee@linaro.org>, Mikhail Tyutin <m.tyutin@yadro.com>, Aleksandr
 Anenkov <a.anenkov@yadro.com>
Subject: [PATCH] Add support of callbacks after instructions to plugin api
Date: Tue, 8 Aug 2023 16:44:35 +0300
Message-ID: <20230808134435.2719-1-m.tyutin@yadro.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-06.corp.yadro.com (172.17.10.110) To
 T-EXCH-08.corp.yadro.com (172.17.11.58)
Received-SPF: pass client-ip=89.207.88.248; envelope-from=m.tyutin@yadro.com;
 helo=mta-04.yadro.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Initially, we can only call the callback BEFORE instructions. This commit adds the ability to insert the callback AFTER instructions.

No callback call for control-flow instructions.

Signed-off-by: Aleksandr Anenkov <a.anenkov@yadro.com>
Signed-off-by: Mikhail Tyutin <m.tyutin@yadro.com>
---
 accel/tcg/plugin-gen.c       | 25 ++++++++++++++++++++-----
 accel/tcg/translator.c       | 18 +++++++++++++-----
 include/qemu/plugin.h        |  1 +
 include/qemu/qemu-plugin.h   | 33 ++++++++++++++++++++++++++++++++-
 plugins/api.c                | 26 ++++++++++++++++++++++++--
 plugins/qemu-plugins.symbols |  2 ++
 tcg/tcg-op.c                 | 16 ++++++++++++++++
 7 files changed, 108 insertions(+), 13 deletions(-)

diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 5c13615112..88dcbda651 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -180,6 +180,8 @@ static void plugin_gen_empty_callback(enum plugin_gen_from from)
 {
     switch (from) {
     case PLUGIN_GEN_AFTER_INSN:
+        gen_wrapped(from, PLUGIN_GEN_CB_UDATA, gen_empty_udata_cb);
+        gen_wrapped(from, PLUGIN_GEN_CB_INLINE, gen_empty_inline_cb);
         gen_wrapped(from, PLUGIN_GEN_DISABLE_MEM_HELPER,
                     gen_empty_mem_helper);
         break;
@@ -598,18 +600,21 @@ static void plugin_gen_tb_inline(const struct qemu_plugin_tb *ptb,
 }
 
 static void plugin_gen_insn_udata(const struct qemu_plugin_tb *ptb,
+                                  enum plugin_dyn_cb_type cb_type,
                                   TCGOp *begin_op, int insn_idx)
 {
+    g_assert(cb_type == PLUGIN_CB_INSN || cb_type == PLUGIN_CB_AFTER_INSN);
     struct qemu_plugin_insn *insn = g_ptr_array_index(ptb->insns, insn_idx);
-
-    inject_udata_cb(insn->cbs[PLUGIN_CB_INSN][PLUGIN_CB_REGULAR], begin_op);
+    inject_udata_cb(insn->cbs[cb_type][PLUGIN_CB_REGULAR], begin_op);
 }
 
 static void plugin_gen_insn_inline(const struct qemu_plugin_tb *ptb,
+                                   enum plugin_dyn_cb_type cb_type,
                                    TCGOp *begin_op, int insn_idx)
 {
+    g_assert(cb_type == PLUGIN_CB_INSN || cb_type == PLUGIN_CB_AFTER_INSN);
     struct qemu_plugin_insn *insn = g_ptr_array_index(ptb->insns, insn_idx);
-    inject_inline_cb(insn->cbs[PLUGIN_CB_INSN][PLUGIN_CB_INLINE],
+    inject_inline_cb(insn->cbs[cb_type][PLUGIN_CB_INLINE],
                      begin_op, op_ok);
 }
 
@@ -738,10 +743,12 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
 
                 switch (type) {
                 case PLUGIN_GEN_CB_UDATA:
-                    plugin_gen_insn_udata(plugin_tb, op, insn_idx);
+                    plugin_gen_insn_udata(plugin_tb, PLUGIN_CB_INSN,
+                                          op, insn_idx);
                     break;
                 case PLUGIN_GEN_CB_INLINE:
-                    plugin_gen_insn_inline(plugin_tb, op, insn_idx);
+                    plugin_gen_insn_inline(plugin_tb, PLUGIN_CB_INSN,
+                                           op, insn_idx);
                     break;
                 case PLUGIN_GEN_ENABLE_MEM_HELPER:
                     plugin_gen_enable_mem_helper(plugin_tb, op, insn_idx);
@@ -773,6 +780,14 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
                 g_assert(insn_idx >= 0);
 
                 switch (type) {
+                case PLUGIN_GEN_CB_UDATA:
+                    plugin_gen_insn_udata(plugin_tb, PLUGIN_CB_AFTER_INSN,
+                                          op, insn_idx);
+                    break;
+                case PLUGIN_GEN_CB_INLINE:
+                    plugin_gen_insn_inline(plugin_tb, PLUGIN_CB_AFTER_INSN,
+                                           op, insn_idx);
+                    break;
                 case PLUGIN_GEN_DISABLE_MEM_HELPER:
                     plugin_gen_disable_mem_helper(plugin_tb, op, insn_idx);
                     break;
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 1a6a5448c8..5e57dc754e 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -180,6 +180,12 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
             ops->translate_insn(db, cpu);
         }
 
+
+        /* Stop translation if translate_insn so indicated.  */
+        if (db->is_jmp != DISAS_NEXT) {
+            break;
+        }
+
         /*
          * We can't instrument after instructions that change control
          * flow although this only really affects post-load operations.
@@ -193,11 +199,6 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
             plugin_gen_insn_end();
         }
 
-        /* Stop translation if translate_insn so indicated.  */
-        if (db->is_jmp != DISAS_NEXT) {
-            break;
-        }
-
         /* Stop translation if the output buffer is full,
            or we have executed all of the allowed instructions.  */
         if (tcg_op_buf_full() || db->num_insns >= db->max_insns) {
@@ -211,6 +212,13 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
     gen_tb_end(tb, cflags, icount_start_insn, db->num_insns);
 
     if (plugin_enabled) {
+        /*
+         * Last chance to call plugin_gen_insn_end() if is skipped in translation
+         * loop above.
+         */
+        if (db->is_jmp != DISAS_NEXT && tcg_ctx->exitreq_label == NULL) {
+            plugin_gen_insn_end();
+        }
         plugin_gen_tb_end(cpu);
     }
 
diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index bc0781cab8..b221650281 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -68,6 +68,7 @@ union qemu_plugin_cb_sig {
 enum plugin_dyn_cb_type {
     PLUGIN_CB_INSN,
     PLUGIN_CB_MEM,
+    PLUGIN_CB_AFTER_INSN,
     PLUGIN_N_CB_TYPES,
 };
 
diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 50a9957279..21e25e895d 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -51,7 +51,7 @@ typedef uint64_t qemu_plugin_id_t;
 
 extern QEMU_PLUGIN_EXPORT int qemu_plugin_version;
 
-#define QEMU_PLUGIN_VERSION 1
+#define QEMU_PLUGIN_VERSION 2
 
 /**
  * struct qemu_info_t - system information for plugins
@@ -314,6 +314,21 @@ void qemu_plugin_register_vcpu_insn_exec_cb(struct qemu_plugin_insn *insn,
                                             enum qemu_plugin_cb_flags flags,
                                             void *userdata);
 
+/**
+ * qemu_plugin_register_vcpu_after_insn_exec_cb() - register cb
+ * after insn execution
+ * @insn: the opaque qemu_plugin_insn handle for an instruction
+ * @cb: callback function
+ * @flags: does the plugin read or write the CPU's registers?
+ * @userdata: any plugin data to pass to the @cb?
+ *
+ * The @cb function is called every time after a non-control-flow
+ * instruction is executed
+ */
+void qemu_plugin_register_vcpu_after_insn_exec_cb(
+    struct qemu_plugin_insn *insn, qemu_plugin_vcpu_udata_cb_t cb,
+    enum qemu_plugin_cb_flags flags, void *userdata);
+
 /**
  * qemu_plugin_register_vcpu_insn_exec_inline() - insn execution inline op
  * @insn: the opaque qemu_plugin_insn handle for an instruction
@@ -328,6 +343,22 @@ void qemu_plugin_register_vcpu_insn_exec_inline(struct qemu_plugin_insn *insn,
                                                 enum qemu_plugin_op op,
                                                 void *ptr, uint64_t imm);
 
+/**
+ * qemu_plugin_register_vcpu_after_insn_exec_inline() - after insn execution
+ * inline op
+ * @insn: the opaque qemu_plugin_insn handle for an instruction
+ * @op: the type of qemu_plugin_op (e.g. ADD_U64)
+ * @ptr: the target memory location for the op
+ * @imm: the op data (e.g. 1)
+ *
+ * Insert an inline op to every time after a non-control-flow
+ * instruction executes.
+ * Useful if you just want to increment a single counter somewhere in memory.
+ */
+void qemu_plugin_register_vcpu_after_insn_exec_inline(
+    struct qemu_plugin_insn *insn, enum qemu_plugin_op op,
+    void *ptr, uint64_t imm);
+
 /**
  * qemu_plugin_tb_n_insns() - query helper for number of insns in TB
  * @tb: opaque handle to TB passed to callback
diff --git a/plugins/api.c b/plugins/api.c
index 2078b16edb..5d4aedc0b5 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -114,16 +114,38 @@ void qemu_plugin_register_vcpu_insn_exec_cb(struct qemu_plugin_insn *insn,
     }
 }
 
+void qemu_plugin_register_vcpu_after_insn_exec_cb(
+    struct qemu_plugin_insn *insn, qemu_plugin_vcpu_udata_cb_t cb,
+    enum qemu_plugin_cb_flags flags, void *udata)
+{
+    if (!insn->mem_only) {
+        plugin_register_dyn_cb__udata(
+            &insn->cbs[PLUGIN_CB_AFTER_INSN][PLUGIN_CB_REGULAR],
+            cb, flags, udata);
+    }
+}
+
 void qemu_plugin_register_vcpu_insn_exec_inline(struct qemu_plugin_insn *insn,
                                                 enum qemu_plugin_op op,
                                                 void *ptr, uint64_t imm)
 {
     if (!insn->mem_only) {
-        plugin_register_inline_op(&insn->cbs[PLUGIN_CB_INSN][PLUGIN_CB_INLINE],
-                                  0, op, ptr, imm);
+        plugin_register_inline_op(
+            &insn->cbs[PLUGIN_CB_INSN][PLUGIN_CB_INLINE],
+            0, op, ptr, imm);
     }
 }
 
+void qemu_plugin_register_vcpu_after_insn_exec_inline(
+    struct qemu_plugin_insn *insn, enum qemu_plugin_op op,
+    void *ptr, uint64_t imm)
+{
+    if (!insn->mem_only) {
+        plugin_register_inline_op(
+            &insn->cbs[PLUGIN_CB_AFTER_INSN][PLUGIN_CB_INLINE],
+            0, op, ptr, imm);
+    }
+}
 
 /*
  * We always plant memory instrumentation because they don't finalise until
diff --git a/plugins/qemu-plugins.symbols b/plugins/qemu-plugins.symbols
index 71f6c90549..d6c25521d1 100644
--- a/plugins/qemu-plugins.symbols
+++ b/plugins/qemu-plugins.symbols
@@ -26,7 +26,9 @@
   qemu_plugin_register_vcpu_idle_cb;
   qemu_plugin_register_vcpu_init_cb;
   qemu_plugin_register_vcpu_insn_exec_cb;
+  qemu_plugin_register_vcpu_after_insn_exec_cb;
   qemu_plugin_register_vcpu_insn_exec_inline;
+  qemu_plugin_register_vcpu_after_insn_exec_inline;
   qemu_plugin_register_vcpu_mem_cb;
   qemu_plugin_register_vcpu_mem_inline;
   qemu_plugin_register_vcpu_resume_cb;
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 7aadb37756..566da1cb04 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -2819,6 +2819,22 @@ void tcg_gen_exit_tb(const TranslationBlock *tb, unsigned idx)
         tcg_debug_assert(idx == TB_EXIT_REQUESTED);
     }
 
+#ifdef CONFIG_PLUGIN
+    /*
+     * Some of instruction generators insert exit_tb explicitelly to
+     * trigger early exit from translation block. On the other hand
+     * translation loop (translator_loop()) inserts plugin callbacks
+     * after instruction is generated, but it appears as dead code
+     * because of the explicit exit_tb insert.
+     *
+     * Calling plugin_gen_insn_end() here before the exit allows
+     * plugins to receive control before translation block exits.
+     */
+    if (tcg_ctx->plugin_insn) {
+        plugin_gen_insn_end();
+    }
+#endif
+
     tcg_gen_op1i(INDEX_op_exit_tb, val);
 }
 
-- 
2.34.1


