Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BD886C071
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Feb 2024 06:55:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfZNC-0004jL-Pj; Thu, 29 Feb 2024 00:54:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rfZN5-0004hC-Ds
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 00:54:21 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rfZN3-00076X-17
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 00:54:19 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-412bb23e5c5so1884145e9.1
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 21:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709186054; x=1709790854; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FaXuH0vG+bw3ACjIfxCUU65VkKwdwFxlTkBxk6M0c2Y=;
 b=oQuBvHQsuD5G7xqsw9q2zpQB3aB6iDd4tQ6+zwUh8wkCHU0yTkd1SeDBWHhOvMZlLl
 +Ur0vydAgs5Vp0wdSqXE2tWuMWna8TxmiGckmvwrm56epSEWvsvnak8s1ukSsBUqMoCk
 QcmoRGI5hVjG4o6BpUNCMmDy0iYhAqiSe2Z7tNVhdWlIaplZQI0iiJ7KqEQ8qr685/bz
 2hfaJa3ILx8jTDa92+J5hZRwaBwazU/nkqgaJSMnpSAxlJ9Xl795lrUQYDBQ/ELJBAT1
 ud0Wzzvk2dIZyWrjRNjyWgh2pcT3g2A0SJm0gGoa+4aLgAW/6RuGe+HGkrDhXxPwa6le
 mxqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709186054; x=1709790854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FaXuH0vG+bw3ACjIfxCUU65VkKwdwFxlTkBxk6M0c2Y=;
 b=C2qgPqadddiHSM5PXY9TVtLOEzAEgcehmWmL0wmS0Pvbbv1ggTNTk1epbnexye9y6Z
 9lcl/fFz0+pYmgmaWSmKUeaRQ+7ZTGfz4ulsJHB5R89noxmdbW7wZ4X6AxjNHoLM8drJ
 bzfIeoqBM0J0XRYrIKPEy5PA+o/eoHDqkyshGyXGpqdr6Kgl9ybJhNV+3sbzy8NCaOPg
 FbkmMpycxWbK84SRz7M9T8wjlGEEcj2gMPqGYA7OerdXPvn2rOXTJt6GmChgq0Scg2ax
 WV5gDe6m8peHxvWdumgqf+qvlI+Gais4bwNihQ/ne/Gv2K5iizq7FQTNemMEeAVhLal+
 BXRA==
X-Gm-Message-State: AOJu0YzCu3655NOetGsrLkgXp3kwqD8rZtB0ah2PGKs4iuLdXca91w7/
 fYYX0cQfdJI8mh6NUHggD35Bf91b5VtEQ+NGQTumfSl2/X1jjzHniBkmPh82ImHZXpr/zzhQxk9
 PX+4=
X-Google-Smtp-Source: AGHT+IGhbvr2c6MaF3mRaLePzl5//v+HKdQEwmZJ8e1E2aYa0ZlULEMgRaLIwuH+cXiIML5qVVUiJA==
X-Received: by 2002:a05:600c:4f16:b0:410:78fb:bed2 with SMTP id
 l22-20020a05600c4f1600b0041078fbbed2mr751880wmq.19.1709186053931; 
 Wed, 28 Feb 2024 21:54:13 -0800 (PST)
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 ck12-20020a5d5e8c000000b0033d2541b3e1sm721589wrb.72.2024.02.28.21.54.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 21:54:13 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 1/5] plugins: prepare introduction of new inline ops
Date: Thu, 29 Feb 2024 09:53:55 +0400
Message-ID: <20240229055359.972151-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229055359.972151-1-pierrick.bouvier@linaro.org>
References: <20240229055359.972151-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x336.google.com
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

Until now, only add_u64 was available, and all functions assumed this or
were named uniquely.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/qemu/plugin.h  |  2 +-
 plugins/plugin.h       |  1 +
 accel/tcg/plugin-gen.c | 77 +++++++++++++++++++++---------------------
 plugins/api.c          | 23 ++++++++++---
 plugins/core.c         |  5 +--
 5 files changed, 61 insertions(+), 47 deletions(-)

diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index 12a96cea2a4..33a7cbe910c 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -74,7 +74,7 @@ enum plugin_dyn_cb_type {
 enum plugin_dyn_cb_subtype {
     PLUGIN_CB_REGULAR,
     PLUGIN_CB_REGULAR_R,
-    PLUGIN_CB_INLINE,
+    PLUGIN_CB_INLINE_ADD_U64,
     PLUGIN_N_CB_SUBTYPES,
 };
 
diff --git a/plugins/plugin.h b/plugins/plugin.h
index 7c34f23cfcb..696b1fa38b0 100644
--- a/plugins/plugin.h
+++ b/plugins/plugin.h
@@ -70,6 +70,7 @@ struct qemu_plugin_ctx *plugin_id_to_ctx_locked(qemu_plugin_id_t id);
 
 void plugin_register_inline_op_on_entry(GArray **arr,
                                         enum qemu_plugin_mem_rw rw,
+                                        enum plugin_dyn_cb_subtype type,
                                         enum qemu_plugin_op op,
                                         qemu_plugin_u64 entry,
                                         uint64_t imm);
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 8028786c7bb..494467e0833 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -81,7 +81,7 @@ enum plugin_gen_from {
 enum plugin_gen_cb {
     PLUGIN_GEN_CB_UDATA,
     PLUGIN_GEN_CB_UDATA_R,
-    PLUGIN_GEN_CB_INLINE,
+    PLUGIN_GEN_CB_INLINE_ADD_U64,
     PLUGIN_GEN_CB_MEM,
     PLUGIN_GEN_ENABLE_MEM_HELPER,
     PLUGIN_GEN_DISABLE_MEM_HELPER,
@@ -127,11 +127,7 @@ static void gen_empty_udata_cb_no_rwg(void)
     gen_empty_udata_cb(gen_helper_plugin_vcpu_udata_cb_no_rwg);
 }
 
-/*
- * For now we only support addi_i64.
- * When we support more ops, we can generate one empty inline cb for each.
- */
-static void gen_empty_inline_cb(void)
+static void gen_empty_inline_cb_add_u64(void)
 {
     TCGv_i32 cpu_index = tcg_temp_ebb_new_i32();
     TCGv_ptr cpu_index_as_ptr = tcg_temp_ebb_new_ptr();
@@ -219,9 +215,11 @@ static void plugin_gen_empty_callback(enum plugin_gen_from from)
                     gen_empty_mem_helper);
         /* fall through */
     case PLUGIN_GEN_FROM_TB:
+        /* emit inline op before any callback */
+        gen_wrapped(from, PLUGIN_GEN_CB_INLINE_ADD_U64,
+                    gen_empty_inline_cb_add_u64);
         gen_wrapped(from, PLUGIN_GEN_CB_UDATA, gen_empty_udata_cb_no_rwg);
         gen_wrapped(from, PLUGIN_GEN_CB_UDATA_R, gen_empty_udata_cb_no_wg);
-        gen_wrapped(from, PLUGIN_GEN_CB_INLINE, gen_empty_inline_cb);
         break;
     default:
         g_assert_not_reached();
@@ -232,13 +230,14 @@ void plugin_gen_empty_mem_callback(TCGv_i64 addr, uint32_t info)
 {
     enum qemu_plugin_mem_rw rw = get_plugin_meminfo_rw(info);
 
+    /* emit inline op before any callback */
+    gen_plugin_cb_start(PLUGIN_GEN_FROM_MEM, PLUGIN_GEN_CB_INLINE_ADD_U64, rw);
+    gen_empty_inline_cb_add_u64();
+    tcg_gen_plugin_cb_end();
+
     gen_plugin_cb_start(PLUGIN_GEN_FROM_MEM, PLUGIN_GEN_CB_MEM, rw);
     gen_empty_mem_cb(addr, info);
     tcg_gen_plugin_cb_end();
-
-    gen_plugin_cb_start(PLUGIN_GEN_FROM_MEM, PLUGIN_GEN_CB_INLINE, rw);
-    gen_empty_inline_cb();
-    tcg_gen_plugin_cb_end();
 }
 
 static TCGOp *find_op(TCGOp *op, TCGOpcode opc)
@@ -436,9 +435,9 @@ static TCGOp *append_udata_cb(const struct qemu_plugin_dyn_cb *cb,
     return op;
 }
 
-static TCGOp *append_inline_cb(const struct qemu_plugin_dyn_cb *cb,
-                               TCGOp *begin_op, TCGOp *op,
-                               int *unused)
+static TCGOp *append_inline_cb_add_u64(const struct qemu_plugin_dyn_cb *cb,
+                                       TCGOp *begin_op, TCGOp *op,
+                                       int *unused)
 {
     char *ptr = cb->inline_insn.entry.score->data->data;
     size_t elem_size = g_array_get_element_size(
@@ -538,9 +537,9 @@ inject_udata_cb(const GArray *cbs, TCGOp *begin_op)
 }
 
 static void
-inject_inline_cb(const GArray *cbs, TCGOp *begin_op, op_ok_fn ok)
+inject_inline_cb_add_u64(const GArray *cbs, TCGOp *begin_op, op_ok_fn ok)
 {
-    inject_cb_type(cbs, begin_op, append_inline_cb, ok);
+    inject_cb_type(cbs, begin_op, append_inline_cb_add_u64, ok);
 }
 
 static void
@@ -588,8 +587,9 @@ static void inject_mem_enable_helper(struct qemu_plugin_tb *ptb,
     GArray *arr;
     size_t n_cbs, i;
 
-    cbs[0] = plugin_insn->cbs[PLUGIN_CB_MEM][PLUGIN_CB_REGULAR];
-    cbs[1] = plugin_insn->cbs[PLUGIN_CB_MEM][PLUGIN_CB_INLINE];
+    /* emit inline op before any callback */
+    cbs[0] = plugin_insn->cbs[PLUGIN_CB_MEM][PLUGIN_CB_INLINE_ADD_U64];
+    cbs[1] = plugin_insn->cbs[PLUGIN_CB_MEM][PLUGIN_CB_REGULAR];
 
     n_cbs = 0;
     for (i = 0; i < ARRAY_SIZE(cbs); i++) {
@@ -655,10 +655,11 @@ static void plugin_gen_tb_udata_r(const struct qemu_plugin_tb *ptb,
     inject_udata_cb(ptb->cbs[PLUGIN_CB_REGULAR_R], begin_op);
 }
 
-static void plugin_gen_tb_inline(const struct qemu_plugin_tb *ptb,
-                                 TCGOp *begin_op)
+static void plugin_gen_tb_inline_add_u64(const struct qemu_plugin_tb *ptb,
+                                         TCGOp *begin_op)
 {
-    inject_inline_cb(ptb->cbs[PLUGIN_CB_INLINE], begin_op, op_ok);
+    inject_inline_cb_add_u64(ptb->cbs[PLUGIN_CB_INLINE_ADD_U64],
+                             begin_op, op_ok);
 }
 
 static void plugin_gen_insn_udata(const struct qemu_plugin_tb *ptb,
@@ -677,12 +678,12 @@ static void plugin_gen_insn_udata_r(const struct qemu_plugin_tb *ptb,
     inject_udata_cb(insn->cbs[PLUGIN_CB_INSN][PLUGIN_CB_REGULAR_R], begin_op);
 }
 
-static void plugin_gen_insn_inline(const struct qemu_plugin_tb *ptb,
-                                   TCGOp *begin_op, int insn_idx)
+static void plugin_gen_insn_inline_add_u64(const struct qemu_plugin_tb *ptb,
+                                           TCGOp *begin_op, int insn_idx)
 {
     struct qemu_plugin_insn *insn = g_ptr_array_index(ptb->insns, insn_idx);
-    inject_inline_cb(insn->cbs[PLUGIN_CB_INSN][PLUGIN_CB_INLINE],
-                     begin_op, op_ok);
+    inject_inline_cb_add_u64(
+        insn->cbs[PLUGIN_CB_INSN][PLUGIN_CB_INLINE_ADD_U64], begin_op, op_ok);
 }
 
 static void plugin_gen_mem_regular(const struct qemu_plugin_tb *ptb,
@@ -692,14 +693,12 @@ static void plugin_gen_mem_regular(const struct qemu_plugin_tb *ptb,
     inject_mem_cb(insn->cbs[PLUGIN_CB_MEM][PLUGIN_CB_REGULAR], begin_op);
 }
 
-static void plugin_gen_mem_inline(const struct qemu_plugin_tb *ptb,
-                                  TCGOp *begin_op, int insn_idx)
+static void plugin_gen_mem_inline_add_u64(const struct qemu_plugin_tb *ptb,
+                                          TCGOp *begin_op, int insn_idx)
 {
-    const GArray *cbs;
     struct qemu_plugin_insn *insn = g_ptr_array_index(ptb->insns, insn_idx);
-
-    cbs = insn->cbs[PLUGIN_CB_MEM][PLUGIN_CB_INLINE];
-    inject_inline_cb(cbs, begin_op, op_rw);
+    inject_inline_cb_add_u64(insn->cbs[PLUGIN_CB_MEM][PLUGIN_CB_INLINE_ADD_U64],
+                             begin_op, op_rw);
 }
 
 static void plugin_gen_enable_mem_helper(struct qemu_plugin_tb *ptb,
@@ -748,8 +747,8 @@ static void pr_ops(void)
             case PLUGIN_GEN_CB_UDATA:
                 type = "udata";
                 break;
-            case PLUGIN_GEN_CB_INLINE:
-                type = "inline";
+            case PLUGIN_GEN_CB_INLINE_ADD_U64:
+                type = "inline add u64";
                 break;
             case PLUGIN_GEN_CB_MEM:
                 type = "mem";
@@ -799,8 +798,8 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
                 case PLUGIN_GEN_CB_UDATA_R:
                     plugin_gen_tb_udata_r(plugin_tb, op);
                     break;
-                case PLUGIN_GEN_CB_INLINE:
-                    plugin_gen_tb_inline(plugin_tb, op);
+                case PLUGIN_GEN_CB_INLINE_ADD_U64:
+                    plugin_gen_tb_inline_add_u64(plugin_tb, op);
                     break;
                 default:
                     g_assert_not_reached();
@@ -818,8 +817,8 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
                 case PLUGIN_GEN_CB_UDATA_R:
                     plugin_gen_insn_udata_r(plugin_tb, op, insn_idx);
                     break;
-                case PLUGIN_GEN_CB_INLINE:
-                    plugin_gen_insn_inline(plugin_tb, op, insn_idx);
+                case PLUGIN_GEN_CB_INLINE_ADD_U64:
+                    plugin_gen_insn_inline_add_u64(plugin_tb, op, insn_idx);
                     break;
                 case PLUGIN_GEN_ENABLE_MEM_HELPER:
                     plugin_gen_enable_mem_helper(plugin_tb, op, insn_idx);
@@ -837,8 +836,8 @@ static void plugin_gen_inject(struct qemu_plugin_tb *plugin_tb)
                 case PLUGIN_GEN_CB_MEM:
                     plugin_gen_mem_regular(plugin_tb, op, insn_idx);
                     break;
-                case PLUGIN_GEN_CB_INLINE:
-                    plugin_gen_mem_inline(plugin_tb, op, insn_idx);
+                case PLUGIN_GEN_CB_INLINE_ADD_U64:
+                    plugin_gen_mem_inline_add_u64(plugin_tb, op, insn_idx);
                     break;
                 default:
                     g_assert_not_reached();
diff --git a/plugins/api.c b/plugins/api.c
index 58e851effdb..e3bcacfa99a 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -55,6 +55,16 @@
 #endif
 #endif
 
+static enum plugin_dyn_cb_subtype op_to_cb_subtype(enum qemu_plugin_op op)
+{
+    switch (op) {
+    case QEMU_PLUGIN_INLINE_ADD_U64:
+        return PLUGIN_CB_INLINE_ADD_U64;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 /* Uninstall and Reset handlers */
 
 void qemu_plugin_uninstall(qemu_plugin_id_t id, qemu_plugin_simple_cb_t cb)
@@ -108,8 +118,9 @@ void qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
     uint64_t imm)
 {
     if (!tb->mem_only) {
-        plugin_register_inline_op_on_entry(
-            &tb->cbs[PLUGIN_CB_INLINE], 0, op, entry, imm);
+        enum plugin_dyn_cb_subtype type = op_to_cb_subtype(op);
+        plugin_register_inline_op_on_entry(&tb->cbs[type],
+                                           0, type, op, entry, imm);
     }
 }
 
@@ -135,8 +146,9 @@ void qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
     uint64_t imm)
 {
     if (!insn->mem_only) {
-        plugin_register_inline_op_on_entry(
-            &insn->cbs[PLUGIN_CB_INSN][PLUGIN_CB_INLINE], 0, op, entry, imm);
+        enum plugin_dyn_cb_subtype type = op_to_cb_subtype(op);
+        plugin_register_inline_op_on_entry(&insn->cbs[PLUGIN_CB_INSN][type],
+                                           0, type, op, entry, imm);
     }
 }
 
@@ -162,8 +174,9 @@ void qemu_plugin_register_vcpu_mem_inline_per_vcpu(
     qemu_plugin_u64 entry,
     uint64_t imm)
 {
+    enum plugin_dyn_cb_subtype type = op_to_cb_subtype(op);
     plugin_register_inline_op_on_entry(
-        &insn->cbs[PLUGIN_CB_MEM][PLUGIN_CB_INLINE], rw, op, entry, imm);
+        &insn->cbs[PLUGIN_CB_MEM][type], rw, type, op, entry, imm);
 }
 
 void qemu_plugin_register_vcpu_tb_trans_cb(qemu_plugin_id_t id,
diff --git a/plugins/core.c b/plugins/core.c
index 11ca20e6267..a641a366ef9 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -318,6 +318,7 @@ static struct qemu_plugin_dyn_cb *plugin_get_dyn_cb(GArray **arr)
 
 void plugin_register_inline_op_on_entry(GArray **arr,
                                         enum qemu_plugin_mem_rw rw,
+                                        enum plugin_dyn_cb_subtype type,
                                         enum qemu_plugin_op op,
                                         qemu_plugin_u64 entry,
                                         uint64_t imm)
@@ -326,7 +327,7 @@ void plugin_register_inline_op_on_entry(GArray **arr,
 
     dyn_cb = plugin_get_dyn_cb(arr);
     dyn_cb->userp = NULL;
-    dyn_cb->type = PLUGIN_CB_INLINE;
+    dyn_cb->type = type;
     dyn_cb->rw = rw;
     dyn_cb->inline_insn.entry = entry;
     dyn_cb->inline_insn.op = op;
@@ -514,7 +515,7 @@ void qemu_plugin_vcpu_mem_cb(CPUState *cpu, uint64_t vaddr,
             cb->f.vcpu_mem(cpu->cpu_index, make_plugin_meminfo(oi, rw),
                            vaddr, cb->userp);
             break;
-        case PLUGIN_CB_INLINE:
+        case PLUGIN_CB_INLINE_ADD_U64:
             exec_inline_op(cb, cpu->cpu_index);
             break;
         default:
-- 
2.43.0


