Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA03852C90
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Feb 2024 10:41:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZpHk-0001KM-B0; Tue, 13 Feb 2024 04:41:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rZpHj-0001JB-2N
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 04:41:03 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rZpHh-0000FT-0E
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 04:41:02 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-33cd57b86bfso326838f8f.1
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 01:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707817259; x=1708422059; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hcoN95NgjKvlQ9/9phTtzGHXlAEFGIlm3GnYnG6dWRc=;
 b=py1Ih5CuSprOCGf2O5+wOKHv3aU4Z/BfoBGGDfP9cLnYJVStoZYz0xZnjRyEETW138
 41l9BFS1x8Ber320jJgNTBkAGDdk7yaHuXOUZmcy31Yf6xzcfC8joBXg/o3VIU6xoddt
 a/vXUrG49ui18ssEBkxxrja4auZ+aUb7S2HnvpS1DR7ck+BCrHVIMVU7hoNaraM8icJy
 do5eSzNcViW8UW4/HDuwQcLZPKAL9WuM4QrvuY9ZlaEbhonzhPEO23UZ1MUCTqDkqiC5
 D+gyuJDVEM5onf2R0U+8KztdBrisGqKiUeXxLMqiD7gABfqBN3e5QO5gvCLMQqH/eQcq
 mMRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707817259; x=1708422059;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hcoN95NgjKvlQ9/9phTtzGHXlAEFGIlm3GnYnG6dWRc=;
 b=RNRpFM9yNAT+Qkpr6WCYK/iVK6c5ZSXnzJSxRMGPCo/jeYdu6Yc2hnYTY5AToAQfzw
 HzSTuBdc5bkrrnT3L6ccSP7Q9GURyefiT/WjqtH/kp26OteP6xpvoJUkme7yxINQDGN/
 XpjXAS1hUse3Dqg+HalGXJKkBUbi69IK/NQcFeWaxletuzRV7FEOqpEPlo/ks2PotIg+
 GBlwplwExVfvQLFf2y3IUxzM1yVX2vvNWAnmzaDv4RmQaiPMsCsU5fZw8rn0Fgjiavd+
 NtuQntOsUHFU5VsYOsLPTn+oNmhbSpfLGQnQQUL2JpRT3qtTfoe2DSi7Z1wCSbffke5t
 UJ/g==
X-Gm-Message-State: AOJu0Yy0O9GDoVv6B11UUnNFEeV6S7GYbwZlfB+wmLBt0ErQR1rsTSs5
 A1MO8HuJpIZUBW15rxD1pzBhlBIw3tc4O1ByoAOVPQxb0IFtwaCZ5XIDECpStyIbMLePtq0Djg3
 Z
X-Google-Smtp-Source: AGHT+IFvctnXzSsYVGzDmggSZF2VPj5cbZMIJR3Htmhd/SqEHZoOB+Pg1Lqnm/87L0kVx4u9/hxwdA==
X-Received: by 2002:a5d:4384:0:b0:33b:65a7:6b87 with SMTP id
 i4-20020a5d4384000000b0033b65a76b87mr6422656wrq.49.1707817259312; 
 Tue, 13 Feb 2024 01:40:59 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVGg47e7vB/EmBY0Eskvjl545d1z/BEKtEMg72hfOWeZWkl/PS/sRJxk1Bq0Bhom7W2kX1E0he2QEbLppTKSqbYYuDWwc06R9x7qb9GJ8/SE7S5E82jmCuq74fdr0dKegTD5Wy2d7/988+QKL/Bd3RiDtcc2paou7Bv4ZdsmS5ECkZ0IVREy6KhOU3SgBt25b+Ln2yH6t8d/o2ptGJS/hxZEOuZYmBSrigEJvrKJRSrekmBWXLY0EBNrBmUf5SM0E32smnQpyVLZrIeHu9g6ylt+F8ipEZ6oMCxOQNsFzjdc3WFeMq4tWuZuW2HOKZp6MYu5M+OdC9me2uVG021Ne2cu4vZgg==
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 cc19-20020a5d5c13000000b0033b728190c1sm8550261wrb.79.2024.02.13.01.40.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 01:40:59 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v4 08/18] plugins: implement inline operation relative to
 cpu_index
Date: Tue, 13 Feb 2024 13:39:58 +0400
Message-ID: <20240213094009.150349-9-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213094009.150349-1-pierrick.bouvier@linaro.org>
References: <20240213094009.150349-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wr1-x433.google.com
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

Instead of working on a fixed memory location, allow to address it based
on cpu_index, an element size and a given offset.
Result address: ptr + offset + cpu_index * element_size.

With this, we can target a member in a struct array from a base pointer.

Current semantic is not modified, thus inline operation still targets
always the same memory location.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 plugins/plugin.h       |  2 +-
 accel/tcg/plugin-gen.c | 69 ++++++++++++++++++++++++++++++++++--------
 plugins/api.c          |  3 +-
 plugins/core.c         | 12 +++++---
 4 files changed, 67 insertions(+), 19 deletions(-)

diff --git a/plugins/plugin.h b/plugins/plugin.h
index 043c740067d..3bf1aaf5c2d 100644
--- a/plugins/plugin.h
+++ b/plugins/plugin.h
@@ -99,7 +99,7 @@ void plugin_register_vcpu_mem_cb(GArray **arr,
                                  enum qemu_plugin_mem_rw rw,
                                  void *udata);
 
-void exec_inline_op(struct qemu_plugin_dyn_cb *cb);
+void exec_inline_op(struct qemu_plugin_dyn_cb *cb, int cpu_index);
 
 int plugin_num_vcpus(void);
 
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index b37ce7683e6..c15627c5e47 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -132,16 +132,28 @@ static void gen_empty_udata_cb_no_rwg(void)
  */
 static void gen_empty_inline_cb(void)
 {
+    TCGv_i32 cpu_index = tcg_temp_ebb_new_i32();
+    TCGv_ptr cpu_index_as_ptr = tcg_temp_ebb_new_ptr();
     TCGv_i64 val = tcg_temp_ebb_new_i64();
     TCGv_ptr ptr = tcg_temp_ebb_new_ptr();
 
+    tcg_gen_ld_i32(cpu_index, tcg_env,
+                   -offsetof(ArchCPU, env) + offsetof(CPUState, cpu_index));
+    /* second operand will be replaced by immediate value */
+    tcg_gen_mul_i32(cpu_index, cpu_index, cpu_index);
+    tcg_gen_ext_i32_ptr(cpu_index_as_ptr, cpu_index);
+
     tcg_gen_movi_ptr(ptr, 0);
+    tcg_gen_add_ptr(ptr, ptr, cpu_index_as_ptr);
     tcg_gen_ld_i64(val, ptr, 0);
-    /* pass an immediate != 0 so that it doesn't get optimized away */
-    tcg_gen_addi_i64(val, val, 0xdeadface);
+    /* second operand will be replaced by immediate value */
+    tcg_gen_add_i64(val, val, val);
+
     tcg_gen_st_i64(val, ptr, 0);
     tcg_temp_free_ptr(ptr);
     tcg_temp_free_i64(val);
+    tcg_temp_free_ptr(cpu_index_as_ptr);
+    tcg_temp_free_i32(cpu_index);
 }
 
 static void gen_empty_mem_cb(TCGv_i64 addr, uint32_t info)
@@ -289,12 +301,37 @@ static TCGOp *copy_const_ptr(TCGOp **begin_op, TCGOp *op, void *ptr)
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
@@ -330,6 +367,13 @@ static TCGOp *copy_add_i64(TCGOp **begin_op, TCGOp *op, uint64_t v)
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
@@ -395,18 +439,17 @@ static TCGOp *append_inline_cb(const struct qemu_plugin_dyn_cb *cb,
                                TCGOp *begin_op, TCGOp *op,
                                int *unused)
 {
-    /* const_ptr */
-    op = copy_const_ptr(&begin_op, op, cb->userp);
-
-    /* ld_i64 */
+    char *ptr = cb->userp;
+    size_t elem_size = 0;
+    size_t offset = 0;
+    op = copy_ld_i32(&begin_op, op);
+    op = copy_mul_i32(&begin_op, op, elem_size);
+    op = copy_ext_i32_ptr(&begin_op, op);
+    op = copy_const_ptr(&begin_op, op, ptr + offset);
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
 
diff --git a/plugins/api.c b/plugins/api.c
index 15edad6769b..dedcbdfd30d 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -106,7 +106,8 @@ void qemu_plugin_register_vcpu_tb_exec_inline(struct qemu_plugin_tb *tb,
                                               void *ptr, uint64_t imm)
 {
     if (!tb->mem_only) {
-        plugin_register_inline_op(&tb->cbs[PLUGIN_CB_INLINE], 0, op, ptr, imm);
+        plugin_register_inline_op(&tb->cbs[PLUGIN_CB_INLINE],
+                                  0, op, ptr, imm);
     }
 }
 
diff --git a/plugins/core.c b/plugins/core.c
index cd0c717e291..5984bc2568c 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -312,7 +312,8 @@ static struct qemu_plugin_dyn_cb *plugin_get_dyn_cb(GArray **arr)
 
 void plugin_register_inline_op(GArray **arr,
                                enum qemu_plugin_mem_rw rw,
-                               enum qemu_plugin_op op, void *ptr,
+                               enum qemu_plugin_op op,
+                               void *ptr,
                                uint64_t imm)
 {
     struct qemu_plugin_dyn_cb *dyn_cb;
@@ -468,9 +469,12 @@ void qemu_plugin_flush_cb(void)
     plugin_cb__simple(QEMU_PLUGIN_EV_FLUSH);
 }
 
-void exec_inline_op(struct qemu_plugin_dyn_cb *cb)
+void exec_inline_op(struct qemu_plugin_dyn_cb *cb, int cpu_index)
 {
-    uint64_t *val = cb->userp;
+    char *ptr = cb->userp;
+    size_t elem_size = 0;
+    size_t offset = 0;
+    uint64_t *val = (uint64_t *)(ptr + offset + cpu_index * elem_size);
 
     switch (cb->inline_insn.op) {
     case QEMU_PLUGIN_INLINE_ADD_U64:
@@ -503,7 +507,7 @@ void qemu_plugin_vcpu_mem_cb(CPUState *cpu, uint64_t vaddr,
                            vaddr, cb->userp);
             break;
         case PLUGIN_CB_INLINE:
-            exec_inline_op(cb);
+            exec_inline_op(cb, cpu->cpu_index);
             break;
         default:
             g_assert_not_reached();
-- 
2.43.0


