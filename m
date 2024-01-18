Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE2D8311C2
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 04:25:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQJ0y-0003X1-L5; Wed, 17 Jan 2024 22:24:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rQJ0v-0003Wf-O3
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 22:24:21 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rQJ0t-0002Pa-Le
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 22:24:21 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40e8cc3b738so10673805e9.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 19:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705548257; x=1706153057; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BaxeeJgy+H1D/rDFzs4Zm7F3dDyijmRAjRzFwAHqBpY=;
 b=Qetw8A431ZNfIpQ0Ci8E0lamr6BTIge8EyKDMDr25OIYsDnyamqJ/HXfTItZl3NV1Y
 VhJVeNRBBa8iKPze3U9nPex4lQDyvuKk5FqgFL2PmimCnt/lo+jf0YX+rVO1py9BMdhW
 R7yj65tJrkHC+fFpVWVLwyUyQSNPMOGb5j4IjVS2v2rjlMPsplgnvVPj0shzeowFltJV
 I5Y22R8bQ+iE40yBYgz1dVHNQcbSR6a7duaH3U8T2QuGTWWJ3HuxIYR7ZVEDJNQi1NP4
 gj13eodoGMnup/2WkCtda0Z+bdZew/7jqW+xVkcbd0fmhdNJ6EE4voduKTlgkJmXMplT
 T8Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705548257; x=1706153057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BaxeeJgy+H1D/rDFzs4Zm7F3dDyijmRAjRzFwAHqBpY=;
 b=f/eUAm44kP1gWzaSjykAhkkT7kCAuT35SQ1+XS2Z9kZ97jnYH4S8zUgBSc5kBAzi4k
 /0y9os0bofCKc5tnqttFbq8psxrhgqK4xEcfbYVLcPN9EAHzp1KHogHLqXFne4klB5nx
 E3l4XaUHjUU8sIYBr5Lgx2XglBvm63/g1uVW1NrZazZWJ3Tync/z8kwL6LzUjo8PUyVt
 eKJ3kWSm/wj0qpVpQdL0EIOpIkbmEcNl6+y1JY8nTCBrkbKxT2A1n05oVAfPeS6nbtX6
 NkQKiOa12Y0ZFuLXM4z6QndUhlfg4ZrTizZQQCh/KRhBtFrbDd6RpEOiUFW/c4KMRrbz
 LSxA==
X-Gm-Message-State: AOJu0YywFoSy+2s0Rskhbi5YpBtqKcVkzcqP/AkUUYCVvOQhFBpj/3S7
 c5yCkTDY76FpfXGecYGgxOjaXzKvXMPcjO01hecKFBu7d1Y5K/0jFOyPR3d8w7Mq3XRQFhqtkra
 WNSY=
X-Google-Smtp-Source: AGHT+IFmZNOgnsjfnQT2eSEuqy28Xa1OQCK5jhRj17Vpb37lYdS7pCBA+D0c0PE9EE37oNxmgogHYg==
X-Received: by 2002:a7b:cc13:0:b0:40e:6948:3226 with SMTP id
 f19-20020a7bcc13000000b0040e69483226mr82431wmh.134.1705548257055; 
 Wed, 17 Jan 2024 19:24:17 -0800 (PST)
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 i2-20020adff302000000b0033788e357e1sm2894292wro.108.2024.01.17.19.24.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 19:24:16 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH v2 01/14] plugins: implement inline operation relative to
 cpu_index
Date: Thu, 18 Jan 2024 07:23:46 +0400
Message-ID: <20240118032400.3762658-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118032400.3762658-1-pierrick.bouvier@linaro.org>
References: <20240118032400.3762658-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x329.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 accel/tcg/plugin-gen.c | 67 +++++++++++++++++++++++++++++++++++-------
 include/qemu/plugin.h  |  3 ++
 plugins/api.c          |  7 +++--
 plugins/core.c         | 18 +++++++++---
 plugins/plugin.h       |  6 ++--
 5 files changed, 81 insertions(+), 20 deletions(-)

diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index b37ce7683e6..1a2375d7779 100644
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
@@ -395,18 +439,19 @@ static TCGOp *append_inline_cb(const struct qemu_plugin_dyn_cb *cb,
                                TCGOp *begin_op, TCGOp *op,
                                int *unused)
 {
-    /* const_ptr */
-    op = copy_const_ptr(&begin_op, op, cb->userp);
-
-    /* ld_i64 */
+    char *ptr = cb->userp;
+    if (!cb->inline_direct_ptr) {
+        /* dereference userp once to get access to memory location */
+        ptr = *(char **)cb->userp;
+    }
+    op = copy_ld_i32(&begin_op, op);
+    op = copy_mul_i32(&begin_op, op, cb->inline_element_size);
+    op = copy_ext_i32_ptr(&begin_op, op);
+    op = copy_const_ptr(&begin_op, op, ptr + cb->inline_offset);
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
index b0c5ac68293..9346249145d 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -86,6 +86,9 @@ enum plugin_dyn_cb_subtype {
 struct qemu_plugin_dyn_cb {
     union qemu_plugin_cb_sig f;
     void *userp;
+    size_t inline_offset;
+    size_t inline_element_size;
+    bool inline_direct_ptr;
     enum plugin_dyn_cb_subtype type;
     /* @rw applies to mem callbacks only (both regular and inline) */
     enum qemu_plugin_mem_rw rw;
diff --git a/plugins/api.c b/plugins/api.c
index 8d5cca53295..e777eb4e9fc 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -106,7 +106,8 @@ void qemu_plugin_register_vcpu_tb_exec_inline(struct qemu_plugin_tb *tb,
                                               void *ptr, uint64_t imm)
 {
     if (!tb->mem_only) {
-        plugin_register_inline_op(&tb->cbs[PLUGIN_CB_INLINE], 0, op, ptr, imm);
+        plugin_register_inline_op(&tb->cbs[PLUGIN_CB_INLINE],
+                                  0, op, ptr, 0, sizeof(uint64_t), true, imm);
     }
 }
 
@@ -131,7 +132,7 @@ void qemu_plugin_register_vcpu_insn_exec_inline(struct qemu_plugin_insn *insn,
 {
     if (!insn->mem_only) {
         plugin_register_inline_op(&insn->cbs[PLUGIN_CB_INSN][PLUGIN_CB_INLINE],
-                                  0, op, ptr, imm);
+                                  0, op, ptr, 0, sizeof(uint64_t), true, imm);
     }
 }
 
@@ -156,7 +157,7 @@ void qemu_plugin_register_vcpu_mem_inline(struct qemu_plugin_insn *insn,
                                           uint64_t imm)
 {
     plugin_register_inline_op(&insn->cbs[PLUGIN_CB_MEM][PLUGIN_CB_INLINE],
-                              rw, op, ptr, imm);
+                              rw, op, ptr, 0, sizeof(uint64_t), true, imm);
 }
 
 void qemu_plugin_register_vcpu_tb_trans_cb(qemu_plugin_id_t id,
diff --git a/plugins/core.c b/plugins/core.c
index 49588285dd0..e07b9cdf229 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -280,13 +280,18 @@ static struct qemu_plugin_dyn_cb *plugin_get_dyn_cb(GArray **arr)
 
 void plugin_register_inline_op(GArray **arr,
                                enum qemu_plugin_mem_rw rw,
-                               enum qemu_plugin_op op, void *ptr,
+                               enum qemu_plugin_op op,
+                               void *ptr, size_t offset, size_t element_size,
+                               bool direct_ptr,
                                uint64_t imm)
 {
     struct qemu_plugin_dyn_cb *dyn_cb;
 
     dyn_cb = plugin_get_dyn_cb(arr);
     dyn_cb->userp = ptr;
+    dyn_cb->inline_element_size = element_size;
+    dyn_cb->inline_offset = offset;
+    dyn_cb->inline_direct_ptr = direct_ptr;
     dyn_cb->type = PLUGIN_CB_INLINE;
     dyn_cb->rw = rw;
     dyn_cb->inline_insn.op = op;
@@ -431,9 +436,14 @@ void qemu_plugin_flush_cb(void)
     plugin_cb__simple(QEMU_PLUGIN_EV_FLUSH);
 }
 
-void exec_inline_op(struct qemu_plugin_dyn_cb *cb)
+void exec_inline_op(struct qemu_plugin_dyn_cb *cb, int cpu_index)
 {
-    uint64_t *val = cb->userp;
+    char *ptr = cb->userp;
+    if (!cb->inline_direct_ptr) {
+        ptr = *(char **) cb->userp;
+    }
+    ptr += cb->inline_offset;
+    uint64_t *val = (uint64_t *)(ptr + cpu_index * cb->inline_element_size);
 
     switch (cb->inline_insn.op) {
     case QEMU_PLUGIN_INLINE_ADD_U64:
@@ -466,7 +476,7 @@ void qemu_plugin_vcpu_mem_cb(CPUState *cpu, uint64_t vaddr,
                            vaddr, cb->userp);
             break;
         case PLUGIN_CB_INLINE:
-            exec_inline_op(cb);
+            exec_inline_op(cb, cpu->cpu_index);
             break;
         default:
             g_assert_not_reached();
diff --git a/plugins/plugin.h b/plugins/plugin.h
index 5eb2fdbc85e..2c278379b70 100644
--- a/plugins/plugin.h
+++ b/plugins/plugin.h
@@ -66,7 +66,9 @@ struct qemu_plugin_ctx *plugin_id_to_ctx_locked(qemu_plugin_id_t id);
 
 void plugin_register_inline_op(GArray **arr,
                                enum qemu_plugin_mem_rw rw,
-                               enum qemu_plugin_op op, void *ptr,
+                               enum qemu_plugin_op op,
+                               void *ptr, size_t offset, size_t element_size,
+                               bool direct_ptr,
                                uint64_t imm);
 
 void plugin_reset_uninstall(qemu_plugin_id_t id,
@@ -95,6 +97,6 @@ void plugin_register_vcpu_mem_cb(GArray **arr,
                                  enum qemu_plugin_mem_rw rw,
                                  void *udata);
 
-void exec_inline_op(struct qemu_plugin_dyn_cb *cb);
+void exec_inline_op(struct qemu_plugin_dyn_cb *cb, int cpu_index);
 
 #endif /* PLUGIN_H */
-- 
2.43.0


