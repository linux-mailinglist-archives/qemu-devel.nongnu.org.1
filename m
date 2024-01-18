Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8072B8311C7
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 04:26:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQJ1R-0003mn-44; Wed, 17 Jan 2024 22:24:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rQJ1N-0003mR-SL
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 22:24:49 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rQJ1L-0003DS-OJ
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 22:24:49 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-337bcaef29eso1792675f8f.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 19:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705548286; x=1706153086; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pjIwKEUqnfGsc/JPgZZdh73H3Cz5ZaisrsiAEjZH8J0=;
 b=D8BMsB1kjVEoGzhmtZ6WOPemLJ/5emIPucdvrw8BSYpxWXPyOa4ebJPvesPdhMhyZ1
 i8XhqUAhsgaorrZI9q7Fg9dJujbx668kOmSDKBvVXG3S+UeRumhI9kht+LshPCTi1Dyu
 eOQPre8Gcb9Z0j0RsQg/SHej3dOxZL2H/Fj6Z9/hvZNH+4ofBWrNMYQ5aNGIjd7gUgaV
 nMGJ7pjV1f+auu+CEtT62m39SQrmpiGM5cx3zbeI/99a6GFEnqftACDL1njWSlrYDNXA
 XZ4qfR1Mt/Jq16Ri0en96zZiCoFquJaDoO/ltYAnwsF6af25DXfdwoD9PYEOjimsDOUp
 e3fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705548286; x=1706153086;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pjIwKEUqnfGsc/JPgZZdh73H3Cz5ZaisrsiAEjZH8J0=;
 b=VLot+mUZ2pFNJX58ZG0hdJUc8U/8M7wDzR2ZK1TmlJppxb9ZXL1BRhDwzUPCzXjM07
 W3/je4n+kbUqonkyBlKyDZc4p30HTYyNe9mPYNawvNMfDGIhxUY9PYv9htIwvvD5Au3/
 nApbQypeffF3vyg8zOn1/Fqr17zjJY8Ws++gncmN5YTb8Yw1MQLTZKLgPUm84zRhYewW
 Icg7D37SPLDFmU7J3i62OM+4iN2qcHANAgxGblwyMD8O5WyQWagxFo3aNwlzR2waW79T
 7BXCn5RYINgpmSptkKJ4ktNKpH2LrpiQgT3MpQvUfeUC6VOjId3+c44LvLnrLp//W050
 /FUw==
X-Gm-Message-State: AOJu0YypSOhkP9HD1oP9XDJYIrqs465XIPHDy8sIFMqi6zow7lAMzpLR
 MympPDPzUtAaCmQBd5uqDCSdlaUlRwKhEbyiJYA0nPBKwfSz/5tGDCqhL3VrbLRXPAw/tYqaLOL
 UtOA=
X-Google-Smtp-Source: AGHT+IGIjgrpHrF61cZOYqQQqStAFvbqM/MPB8mCyIKVlTyOY4HUXSKH2HsbRRoQ6md1z41wuUKfaQ==
X-Received: by 2002:adf:ee03:0:b0:337:b4db:5a2a with SMTP id
 y3-20020adfee03000000b00337b4db5a2amr83922wrn.28.1705548286312; 
 Wed, 17 Jan 2024 19:24:46 -0800 (PST)
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 i2-20020adff302000000b0033788e357e1sm2894292wro.108.2024.01.17.19.24.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 19:24:46 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH v2 12/14] plugins: register inline op with a qemu_plugin_u64_t
Date: Thu, 18 Jan 2024 07:23:57 +0400
Message-ID: <20240118032400.3762658-13-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118032400.3762658-1-pierrick.bouvier@linaro.org>
References: <20240118032400.3762658-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wr1-x435.google.com
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

Now inline previous API was removed, we can cleanup code path
associated.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 accel/tcg/plugin-gen.c |  7 ++-----
 include/qemu/plugin.h  |  1 -
 plugins/api.c          | 12 +++---------
 plugins/core.c         | 17 ++++++-----------
 plugins/plugin.h       |  3 +--
 5 files changed, 12 insertions(+), 28 deletions(-)

diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 1a2375d7779..5e4938805e8 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -439,11 +439,8 @@ static TCGOp *append_inline_cb(const struct qemu_plugin_dyn_cb *cb,
                                TCGOp *begin_op, TCGOp *op,
                                int *unused)
 {
-    char *ptr = cb->userp;
-    if (!cb->inline_direct_ptr) {
-        /* dereference userp once to get access to memory location */
-        ptr = *(char **)cb->userp;
-    }
+    /* always dereference userp for inline operations */
+    char *ptr = *(char **)cb->userp;
     op = copy_ld_i32(&begin_op, op);
     op = copy_mul_i32(&begin_op, op, cb->inline_element_size);
     op = copy_ext_i32_ptr(&begin_op, op);
diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index 5f340192e56..b63631207cd 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -88,7 +88,6 @@ struct qemu_plugin_dyn_cb {
     void *userp;
     size_t inline_offset;
     size_t inline_element_size;
-    bool inline_direct_ptr;
     enum plugin_dyn_cb_subtype type;
     /* @rw applies to mem callbacks only (both regular and inline) */
     enum qemu_plugin_mem_rw rw;
diff --git a/plugins/api.c b/plugins/api.c
index 29915d3c142..d12fed6118e 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -109,9 +109,7 @@ void qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
 {
     if (!tb->mem_only) {
         plugin_register_inline_op(&tb->cbs[PLUGIN_CB_INLINE],
-                                  0, op, entry.score->data,
-                                  entry.offset, entry.score->element_size,
-                                  false, imm);
+                                  0, op, entry, imm);
     }
 }
 
@@ -138,9 +136,7 @@ void qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
 {
     if (!insn->mem_only) {
         plugin_register_inline_op(&insn->cbs[PLUGIN_CB_INSN][PLUGIN_CB_INLINE],
-                                  0, op, entry.score->data,
-                                  entry.offset, entry.score->element_size,
-                                  false, imm);
+                                  0, op, entry, imm);
     }
 }
 
@@ -167,9 +163,7 @@ void qemu_plugin_register_vcpu_mem_inline_per_vcpu(
     uint64_t imm)
 {
     plugin_register_inline_op(&insn->cbs[PLUGIN_CB_MEM][PLUGIN_CB_INLINE],
-                              rw, op, entry.score->data,
-                              entry.offset, entry.score->element_size,
-                              false, imm);
+                              rw, op, entry, imm);
 }
 
 void qemu_plugin_register_vcpu_tb_trans_cb(qemu_plugin_id_t id,
diff --git a/plugins/core.c b/plugins/core.c
index 0286a127810..46175d557f7 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -347,17 +347,15 @@ static struct qemu_plugin_dyn_cb *plugin_get_dyn_cb(GArray **arr)
 void plugin_register_inline_op(GArray **arr,
                                enum qemu_plugin_mem_rw rw,
                                enum qemu_plugin_op op,
-                               void *ptr, size_t offset, size_t element_size,
-                               bool direct_ptr,
+                               qemu_plugin_u64_t entry,
                                uint64_t imm)
 {
     struct qemu_plugin_dyn_cb *dyn_cb;
 
     dyn_cb = plugin_get_dyn_cb(arr);
-    dyn_cb->userp = ptr;
-    dyn_cb->inline_element_size = element_size;
-    dyn_cb->inline_offset = offset;
-    dyn_cb->inline_direct_ptr = direct_ptr;
+    dyn_cb->userp = entry.score->data;
+    dyn_cb->inline_element_size = entry.score->element_size;
+    dyn_cb->inline_offset = entry.offset;
     dyn_cb->type = PLUGIN_CB_INLINE;
     dyn_cb->rw = rw;
     dyn_cb->inline_insn.op = op;
@@ -504,11 +502,8 @@ void qemu_plugin_flush_cb(void)
 
 void exec_inline_op(struct qemu_plugin_dyn_cb *cb, int cpu_index)
 {
-    char *ptr = cb->userp;
-    if (!cb->inline_direct_ptr) {
-        ptr = *(char **) cb->userp;
-    }
-    ptr += cb->inline_offset;
+    /* always dereference userp for inline operations */
+    char *ptr = (*(char **) cb->userp) + cb->inline_offset;
     uint64_t *val = (uint64_t *)(ptr + cpu_index * cb->inline_element_size);
 
     switch (cb->inline_insn.op) {
diff --git a/plugins/plugin.h b/plugins/plugin.h
index 99829c40886..4c8f2ca3728 100644
--- a/plugins/plugin.h
+++ b/plugins/plugin.h
@@ -71,8 +71,7 @@ struct qemu_plugin_ctx *plugin_id_to_ctx_locked(qemu_plugin_id_t id);
 void plugin_register_inline_op(GArray **arr,
                                enum qemu_plugin_mem_rw rw,
                                enum qemu_plugin_op op,
-                               void *ptr, size_t offset, size_t element_size,
-                               bool direct_ptr,
+                               qemu_plugin_u64_t entry,
                                uint64_t imm);
 
 void plugin_reset_uninstall(qemu_plugin_id_t id,
-- 
2.43.0


