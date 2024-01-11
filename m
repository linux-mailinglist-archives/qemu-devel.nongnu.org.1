Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E468882B095
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 15:25:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNvyT-0004LB-6d; Thu, 11 Jan 2024 09:24:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rNvyO-0004KX-4y
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 09:23:56 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rNvyG-0002Iq-Sb
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 09:23:52 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3368ac0f74dso3746580f8f.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 06:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704983024; x=1705587824; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IJ7j1cDsI/uXWEkCQ4Id/bagXB6Y2gY5m1Du+N1BU48=;
 b=Qe6Nl1d2T0CXnGKGDLyVVf4YGDSlyjhfHRLj8h2nPeXFtfd4tLawDdqJNqmgoLB/kw
 RV/pNUfs3jLKbvUu1Wqk3x3y05J5iUBWLngcihxN9FPxsjt6JQnUovMS6Fp72MWUfGkM
 PL/e85f25fQRsXWfQ3SWAe2W/2i7yIAjDZh7Xc7607oanP3y0ZAifiuv8sm5u2v2RyJP
 y6vh/063zJd2QhSCrgNAd7ZQln/FYl1RJ245mctYMUremxlgDhFWcROYZQcqiLErQzae
 Z3NEfNNo8fqdbq5QUFdYB5f9A6jjWMaxx5OZ2MhkE+ZnSaglm4Z6A1D9TN5kC9KOoAKe
 pqZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704983024; x=1705587824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IJ7j1cDsI/uXWEkCQ4Id/bagXB6Y2gY5m1Du+N1BU48=;
 b=xLOH2k5vhALY/JMlqRkG1Zsb0cq8WrYBbRNyEstveIRbV3rlHw1w8TRKC84whFT4n7
 rdKctalPY0jFnIu3AoqfF12K4JzeWMiz+QAnrAvRDSMDsYSrCbO4i5+wgCgiZp5Effpa
 o4x+T+mVO+s4Vg3aQ/RW4oSP9+VYd7CsJxAcixDM9KF0zWMctbIr3KYOuhEofvFpEDBY
 /UQEhwfslDueXm8HYDyfGcBESQ5i3p88QjJBpGX+enutUwcGaje+++o79oxB38UC0tvr
 T+zOMdJpEygU+ORAesNolQXMWILFY/o8ciRFtn8KQPArgHFY8UXfuRESU64j/KuCAP47
 lZFw==
X-Gm-Message-State: AOJu0Yx7Ih7E3KAxv9e1nv50TKDDOBWDJm9y4qOmumHUXhSfziJ7mhJv
 WdM6YcdRrA10/uyjlePWQPnyDUG2T9nHrHFSJvwyYq0PNrCPtA==
X-Google-Smtp-Source: AGHT+IEuUNX3Ledm3oMOjhEYFkNf7usYSiFNsg9XTUgUTPj5CvDFDgPGC+svu/pBfWZOOMCKb0dOnA==
X-Received: by 2002:a5d:480b:0:b0:337:62d3:f68a with SMTP id
 l11-20020a5d480b000000b0033762d3f68amr690624wrq.81.1704983024567; 
 Thu, 11 Jan 2024 06:23:44 -0800 (PST)
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 h7-20020adff4c7000000b0033677aae2e2sm1349000wrp.107.2024.01.11.06.23.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 06:23:43 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH 01/12] plugins: implement inline operation with cpu_index
 offset
Date: Thu, 11 Jan 2024 18:23:14 +0400
Message-ID: <20240111142326.1743444-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240111142326.1743444-1-pierrick.bouvier@linaro.org>
References: <20240111142326.1743444-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Instead of working on a fixed memory location, allow to index it based
on cpu_index and a given offset (ptr + cpu_index * offset).
Current semantic is not modified as we use a 0 offset, thus inline
operation still targets always the same memory location.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 accel/tcg/plugin-gen.c | 60 +++++++++++++++++++++++++++++++++++-------
 include/qemu/plugin.h  |  1 +
 plugins/api.c          |  7 ++---
 plugins/core.c         | 11 +++++---
 plugins/plugin.h       |  5 ++--
 5 files changed, 65 insertions(+), 19 deletions(-)

diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 78b331b2510..fc9d3ee23bc 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -118,16 +118,28 @@ static void gen_empty_udata_cb(void)
  */
 static void gen_empty_inline_cb(void)
 {
+    TCGv_i32 cpu_index = tcg_temp_ebb_new_i32();
+    TCGv_ptr cpu_index_as_ptr = tcg_temp_ebb_new_ptr();
     TCGv_i64 val = tcg_temp_ebb_new_i64();
     TCGv_ptr ptr = tcg_temp_ebb_new_ptr();
 
+    tcg_gen_ld_i32(cpu_index, tcg_env,
+                   -offsetof(ArchCPU, env) + offsetof(CPUState, cpu_index));
+    /* pass an immediate != 0 so that it doesn't get optimized away */
+    tcg_gen_muli_i32(cpu_index, cpu_index, 0xdeadbeef);
+    tcg_gen_ext_i32_ptr(cpu_index_as_ptr, cpu_index);
+
     tcg_gen_movi_ptr(ptr, 0);
+    tcg_gen_add_ptr(ptr, ptr, cpu_index_as_ptr);
     tcg_gen_ld_i64(val, ptr, 0);
     /* pass an immediate != 0 so that it doesn't get optimized away */
     tcg_gen_addi_i64(val, val, 0xdeadface);
+
     tcg_gen_st_i64(val, ptr, 0);
     tcg_temp_free_ptr(ptr);
     tcg_temp_free_i64(val);
+    tcg_temp_free_ptr(cpu_index_as_ptr);
+    tcg_temp_free_i32(cpu_index);
 }
 
 static void gen_empty_mem_cb(TCGv_i64 addr, uint32_t info)
@@ -274,12 +286,37 @@ static TCGOp *copy_const_ptr(TCGOp **begin_op, TCGOp *op, void *ptr)
     return op;
 }
 
+static TCGOp *copy_ld_i32(TCGOp **begin_op, TCGOp *op)
+{
+    return copy_op(begin_op, op, INDEX_op_ld_i32);
+}
+
+static TCGOp *copy_ext_i32_ptr(TCGOp **begin_op, TCGOp *op)
+{
+    if (UINTPTR_MAX == UINT32_MAX) {
+        op = copy_op(begin_op, op, INDEX_op_mov_i32);
+    } else {
+        op = copy_op(begin_op, op, INDEX_op_ext_i32_i64);
+    }
+    return op;
+}
+
+static TCGOp *copy_add_ptr(TCGOp **begin_op, TCGOp *op)
+{
+    if (UINTPTR_MAX == UINT32_MAX) {
+        op = copy_op(begin_op, op, INDEX_op_add_i32);
+    } else {
+        op = copy_op(begin_op, op, INDEX_op_add_i64);
+    }
+    return op;
+}
+
 static TCGOp *copy_ld_i64(TCGOp **begin_op, TCGOp *op)
 {
     if (TCG_TARGET_REG_BITS == 32) {
         /* 2x ld_i32 */
-        op = copy_op(begin_op, op, INDEX_op_ld_i32);
-        op = copy_op(begin_op, op, INDEX_op_ld_i32);
+        op = copy_ld_i32(begin_op, op);
+        op = copy_ld_i32(begin_op, op);
     } else {
         /* ld_i64 */
         op = copy_op(begin_op, op, INDEX_op_ld_i64);
@@ -315,6 +352,13 @@ static TCGOp *copy_add_i64(TCGOp **begin_op, TCGOp *op, uint64_t v)
     return op;
 }
 
+static TCGOp *copy_mul_i32(TCGOp **begin_op, TCGOp *op, uint32_t v)
+{
+    op = copy_op(begin_op, op, INDEX_op_mul_i32);
+    op->args[2] = tcgv_i32_arg(tcg_constant_i32(v));
+    return op;
+}
+
 static TCGOp *copy_st_ptr(TCGOp **begin_op, TCGOp *op)
 {
     if (UINTPTR_MAX == UINT32_MAX) {
@@ -380,18 +424,14 @@ static TCGOp *append_inline_cb(const struct qemu_plugin_dyn_cb *cb,
                                TCGOp *begin_op, TCGOp *op,
                                int *unused)
 {
-    /* const_ptr */
+    op = copy_ld_i32(&begin_op, op);
+    op = copy_mul_i32(&begin_op, op, cb->userp_offset);
+    op = copy_ext_i32_ptr(&begin_op, op);
     op = copy_const_ptr(&begin_op, op, cb->userp);
-
-    /* ld_i64 */
+    op = copy_add_ptr(&begin_op, op);
     op = copy_ld_i64(&begin_op, op);
-
-    /* add_i64 */
     op = copy_add_i64(&begin_op, op, cb->inline_insn.imm);
-
-    /* st_i64 */
     op = copy_st_i64(&begin_op, op);
-
     return op;
 }
 
diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index 7fdc3a4849f..4548affc295 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -85,6 +85,7 @@ enum plugin_dyn_cb_subtype {
 struct qemu_plugin_dyn_cb {
     union qemu_plugin_cb_sig f;
     void *userp;
+    size_t userp_offset;
     enum plugin_dyn_cb_subtype type;
     /* @rw applies to mem callbacks only (both regular and inline) */
     enum qemu_plugin_mem_rw rw;
diff --git a/plugins/api.c b/plugins/api.c
index 5521b0ad36c..0fcce825680 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -99,7 +99,8 @@ void qemu_plugin_register_vcpu_tb_exec_inline(struct qemu_plugin_tb *tb,
                                               void *ptr, uint64_t imm)
 {
     if (!tb->mem_only) {
-        plugin_register_inline_op(&tb->cbs[PLUGIN_CB_INLINE], 0, op, ptr, imm);
+        plugin_register_inline_op(&tb->cbs[PLUGIN_CB_INLINE],
+                                  0, op, ptr, 0, imm);
     }
 }
 
@@ -120,7 +121,7 @@ void qemu_plugin_register_vcpu_insn_exec_inline(struct qemu_plugin_insn *insn,
 {
     if (!insn->mem_only) {
         plugin_register_inline_op(&insn->cbs[PLUGIN_CB_INSN][PLUGIN_CB_INLINE],
-                                  0, op, ptr, imm);
+                                  0, op, ptr, 0, imm);
     }
 }
 
@@ -145,7 +146,7 @@ void qemu_plugin_register_vcpu_mem_inline(struct qemu_plugin_insn *insn,
                                           uint64_t imm)
 {
     plugin_register_inline_op(&insn->cbs[PLUGIN_CB_MEM][PLUGIN_CB_INLINE],
-                              rw, op, ptr, imm);
+                              rw, op, ptr, 0, imm);
 }
 
 void qemu_plugin_register_vcpu_tb_trans_cb(qemu_plugin_id_t id,
diff --git a/plugins/core.c b/plugins/core.c
index 49588285dd0..cc6d7720b1f 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -280,13 +280,15 @@ static struct qemu_plugin_dyn_cb *plugin_get_dyn_cb(GArray **arr)
 
 void plugin_register_inline_op(GArray **arr,
                                enum qemu_plugin_mem_rw rw,
-                               enum qemu_plugin_op op, void *ptr,
+                               enum qemu_plugin_op op,
+                               void *ptr, size_t offset,
                                uint64_t imm)
 {
     struct qemu_plugin_dyn_cb *dyn_cb;
 
     dyn_cb = plugin_get_dyn_cb(arr);
     dyn_cb->userp = ptr;
+    dyn_cb->userp_offset = offset;
     dyn_cb->type = PLUGIN_CB_INLINE;
     dyn_cb->rw = rw;
     dyn_cb->inline_insn.op = op;
@@ -431,9 +433,10 @@ void qemu_plugin_flush_cb(void)
     plugin_cb__simple(QEMU_PLUGIN_EV_FLUSH);
 }
 
-void exec_inline_op(struct qemu_plugin_dyn_cb *cb)
+void exec_inline_op(struct qemu_plugin_dyn_cb *cb, int cpu_index)
 {
-    uint64_t *val = cb->userp;
+    const size_t offset = cpu_index * cb->userp_offset;
+    uint64_t *val = (uint64_t *)((char *) cb->userp + offset);
 
     switch (cb->inline_insn.op) {
     case QEMU_PLUGIN_INLINE_ADD_U64:
@@ -466,7 +469,7 @@ void qemu_plugin_vcpu_mem_cb(CPUState *cpu, uint64_t vaddr,
                            vaddr, cb->userp);
             break;
         case PLUGIN_CB_INLINE:
-            exec_inline_op(cb);
+            exec_inline_op(cb, cpu->cpu_index);
             break;
         default:
             g_assert_not_reached();
diff --git a/plugins/plugin.h b/plugins/plugin.h
index 5eb2fdbc85e..e597ef3c30e 100644
--- a/plugins/plugin.h
+++ b/plugins/plugin.h
@@ -66,7 +66,8 @@ struct qemu_plugin_ctx *plugin_id_to_ctx_locked(qemu_plugin_id_t id);
 
 void plugin_register_inline_op(GArray **arr,
                                enum qemu_plugin_mem_rw rw,
-                               enum qemu_plugin_op op, void *ptr,
+                               enum qemu_plugin_op op,
+                               void *ptr, size_t offset,
                                uint64_t imm);
 
 void plugin_reset_uninstall(qemu_plugin_id_t id,
@@ -95,6 +96,6 @@ void plugin_register_vcpu_mem_cb(GArray **arr,
                                  enum qemu_plugin_mem_rw rw,
                                  void *udata);
 
-void exec_inline_op(struct qemu_plugin_dyn_cb *cb);
+void exec_inline_op(struct qemu_plugin_dyn_cb *cb, int cpu_index);
 
 #endif /* PLUGIN_H */
-- 
2.43.0


