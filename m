Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B0F82B09E
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 15:25:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNvyX-0004Mv-8l; Thu, 11 Jan 2024 09:24:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rNvyR-0004LP-Jo
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 09:24:00 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rNvyJ-0002Je-I7
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 09:23:57 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3376555b756so3138564f8f.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 06:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704983027; x=1705587827; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9c37JOuaNhDBeKaXx4tgumlULh1m5+dxPGdg6049b/w=;
 b=FkwwlSjzBenwbfpkxNVcPtlIrh37eXa7GUBIe7cEwSi4tBh6CQ5BlwVojTq4Gv/Y6X
 W+Q4R3BOH2VUbI7pv54SgRnQTgP+jSpIzU7G8RkbQ7v/Fnw938Y16Gac5Q6f0pdlc+4i
 ShX8NvTyQYYOj/x190hSr+rWMjKGs0No59tErrYNsuLC9UKBLRRn4Aj7WmEDQtwu1cPT
 c1qEm/OgDz//CCXUyhnu6vrK6fx/J9dl6ZhOtPYZg9FdgQDrb10nkhZ0aYiPh/0D1od/
 xigRQdNlBCTxb/Gj8hRy5hdJ06KcSeibUvDx9k3YjqxQLYJiozry5oXqb8Y31uGPseFj
 uhWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704983027; x=1705587827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9c37JOuaNhDBeKaXx4tgumlULh1m5+dxPGdg6049b/w=;
 b=t3z9vuFDbJ5MvnahYk8QO3OUU8/2ZS5cHxwF/p/PUU4Cm6uprUSPc6rf82dZaBSpsa
 CIn8dn8Hve14XS/agmjCluHNoB8U7X5t5NhySR7duNpqZs//I+ELDB03HsBYHo+8sgr8
 P23yqwZSb/VU/5OG43B3S6f7scgImqbvlfRjsrx6uq8A7q2xAS+iqKtjklIxC99DE1uN
 VCqlCb/QGeLDx1wc3/yMOzJt+tfdtaT0tBFob8eiegI7zXLm+4LIObgnrQFqywqv+5ce
 bgXVgcJfV9bV3q84EuFxm8d8g+YfnWGoPuwPAzV14aytwaqSbJHPWKuB+JVIufA2joiZ
 Pdrg==
X-Gm-Message-State: AOJu0YyzPHkrRPBiBDPtiou71Y8GCpwFXyiX50lL70WPx22HDq/pxPaQ
 rUyHvFpItP9/ofwfYyK273taBWaASf9zm/nJ0200R5Xulv5Qrg==
X-Google-Smtp-Source: AGHT+IFLVTS2r2J1dDqxVzx6y1UsSSuqnNccwWUAGiXomqiX8XONmHN88U2tjtrkaMuOU8iZh8ZKcQ==
X-Received: by 2002:adf:f811:0:b0:337:6208:99df with SMTP id
 s17-20020adff811000000b00337620899dfmr610967wrp.20.1704983027314; 
 Thu, 11 Jan 2024 06:23:47 -0800 (PST)
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 h7-20020adff4c7000000b0033677aae2e2sm1349000wrp.107.2024.01.11.06.23.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 06:23:47 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH 02/12] plugins: add inline operation per vcpu
Date: Thu, 11 Jan 2024 18:23:15 +0400
Message-ID: <20240111142326.1743444-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240111142326.1743444-1-pierrick.bouvier@linaro.org>
References: <20240111142326.1743444-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wr1-x42f.google.com
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

Extends API with three new functions:
qemu_plugin_register_vcpu_{tb, insn, mem}_exec_inline_per_vcpu().

Compared to non per_vcpu versions, ptr is now a base, and current
cpu_index and an offset are used to compute memory location on which
operation happens (ptr + cpu_index * offset).

This allows to have a thread-safe version of inline operations.

Having a flexible offset is useful in case a user wants to target a
memory location embedded into a struct. In this case, the offset between
two memory locations will be bigger than sizeof(uint64_t).

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/qemu/qemu-plugin.h   | 56 +++++++++++++++++++++++++++++++++++-
 plugins/api.c                | 36 ++++++++++++++++++++---
 plugins/qemu-plugins.symbols |  3 ++
 3 files changed, 90 insertions(+), 5 deletions(-)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 4daab6efd29..8a0691a760e 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -312,6 +312,25 @@ void qemu_plugin_register_vcpu_tb_exec_inline(struct qemu_plugin_tb *tb,
                                               enum qemu_plugin_op op,
                                               void *ptr, uint64_t imm);
 
+/**
+ * qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu() - execution inline op
+ * @tb: the opaque qemu_plugin_tb handle for the translation
+ * @op: the type of qemu_plugin_op (e.g. ADD_U64)
+ * @ptr: point to memory location for the op
+ * @offset: offset between two memory locations
+ * @imm: the op data (e.g. 1)
+ *
+ * Insert an inline op, on a memory location associated to a given
+ * vcpu (whose address is ptr + offset * cpu_index),
+ * every time a translated unit executes.
+ */
+QEMU_PLUGIN_API
+void qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
+    struct qemu_plugin_tb *tb,
+    enum qemu_plugin_op op,
+    void *ptr, size_t offset,
+    uint64_t imm);
+
 /**
  * qemu_plugin_register_vcpu_insn_exec_cb() - register insn execution cb
  * @insn: the opaque qemu_plugin_insn handle for an instruction
@@ -342,6 +361,23 @@ void qemu_plugin_register_vcpu_insn_exec_inline(struct qemu_plugin_insn *insn,
                                                 enum qemu_plugin_op op,
                                                 void *ptr, uint64_t imm);
 
+/**
+ * qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu() - insn exec inline op
+ * @insn: the opaque qemu_plugin_insn handle for an instruction
+ * @op: the type of qemu_plugin_op (e.g. ADD_U64)
+ * @ptr: point to array of memory locations for the op
+ * @offset: offset between two memory locations
+ * @imm: the op data (e.g. 1)
+ *
+ * Insert an inline op to every time an instruction executes.
+ */
+QEMU_PLUGIN_API
+void qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
+    struct qemu_plugin_insn *insn,
+    enum qemu_plugin_op op,
+    void *ptr, size_t offset,
+    uint64_t imm);
+
 /**
  * qemu_plugin_tb_n_insns() - query helper for number of insns in TB
  * @tb: opaque handle to TB passed to callback
@@ -567,7 +603,25 @@ void qemu_plugin_register_vcpu_mem_inline(struct qemu_plugin_insn *insn,
                                           enum qemu_plugin_op op, void *ptr,
                                           uint64_t imm);
 
-
+/**
+ * qemu_plugin_register_vcpu_mem_inline_per_vcpu() - inline op for mem access
+ * @insn: handle for instruction to instrument
+ * @rw: apply to reads, writes or both
+ * @op: the op, of type qemu_plugin_op
+ * @ptr: point to array of memory locations for the op
+ * @offset: offset between two memory locations
+ * @imm: immediate data for @op
+ *
+ * This registers a inline op every memory access generated by the
+ * instruction.
+ */
+QEMU_PLUGIN_API
+void qemu_plugin_register_vcpu_mem_inline_per_vcpu(
+    struct qemu_plugin_insn *insn,
+    enum qemu_plugin_mem_rw rw,
+    enum qemu_plugin_op op,
+    void *ptr, size_t offset,
+    uint64_t imm);
 
 typedef void
 (*qemu_plugin_vcpu_syscall_cb_t)(qemu_plugin_id_t id, unsigned int vcpu_index,
diff --git a/plugins/api.c b/plugins/api.c
index 0fcce825680..fd6ce678501 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -97,10 +97,19 @@ void qemu_plugin_register_vcpu_tb_exec_cb(struct qemu_plugin_tb *tb,
 void qemu_plugin_register_vcpu_tb_exec_inline(struct qemu_plugin_tb *tb,
                                               enum qemu_plugin_op op,
                                               void *ptr, uint64_t imm)
+{
+    qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(tb, op, ptr, 0, imm);
+}
+
+void qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
+    struct qemu_plugin_tb *tb,
+    enum qemu_plugin_op op,
+    void *ptr, size_t offset,
+    uint64_t imm)
 {
     if (!tb->mem_only) {
         plugin_register_inline_op(&tb->cbs[PLUGIN_CB_INLINE],
-                                  0, op, ptr, 0, imm);
+                                  0, op, ptr, offset, imm);
     }
 }
 
@@ -118,10 +127,19 @@ void qemu_plugin_register_vcpu_insn_exec_cb(struct qemu_plugin_insn *insn,
 void qemu_plugin_register_vcpu_insn_exec_inline(struct qemu_plugin_insn *insn,
                                                 enum qemu_plugin_op op,
                                                 void *ptr, uint64_t imm)
+{
+    qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(insn, op, ptr, 0, imm);
+}
+
+void qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
+    struct qemu_plugin_insn *insn,
+    enum qemu_plugin_op op,
+    void *ptr, size_t offset,
+    uint64_t imm)
 {
     if (!insn->mem_only) {
         plugin_register_inline_op(&insn->cbs[PLUGIN_CB_INSN][PLUGIN_CB_INLINE],
-                                  0, op, ptr, 0, imm);
+                                  0, op, ptr, offset, imm);
     }
 }
 
@@ -137,16 +155,26 @@ void qemu_plugin_register_vcpu_mem_cb(struct qemu_plugin_insn *insn,
                                       void *udata)
 {
     plugin_register_vcpu_mem_cb(&insn->cbs[PLUGIN_CB_MEM][PLUGIN_CB_REGULAR],
-                                    cb, flags, rw, udata);
+                                cb, flags, rw, udata);
 }
 
 void qemu_plugin_register_vcpu_mem_inline(struct qemu_plugin_insn *insn,
                                           enum qemu_plugin_mem_rw rw,
                                           enum qemu_plugin_op op, void *ptr,
                                           uint64_t imm)
+{
+    qemu_plugin_register_vcpu_mem_inline_per_vcpu(insn, rw, op, ptr, 0, imm);
+}
+
+void qemu_plugin_register_vcpu_mem_inline_per_vcpu(
+    struct qemu_plugin_insn *insn,
+    enum qemu_plugin_mem_rw rw,
+    enum qemu_plugin_op op,
+    void *ptr, size_t offset,
+    uint64_t imm)
 {
     plugin_register_inline_op(&insn->cbs[PLUGIN_CB_MEM][PLUGIN_CB_INLINE],
-                              rw, op, ptr, 0, imm);
+                              rw, op, ptr, offset, imm);
 }
 
 void qemu_plugin_register_vcpu_tb_trans_cb(qemu_plugin_id_t id,
diff --git a/plugins/qemu-plugins.symbols b/plugins/qemu-plugins.symbols
index 71f6c90549d..56ba30e5a81 100644
--- a/plugins/qemu-plugins.symbols
+++ b/plugins/qemu-plugins.symbols
@@ -27,13 +27,16 @@
   qemu_plugin_register_vcpu_init_cb;
   qemu_plugin_register_vcpu_insn_exec_cb;
   qemu_plugin_register_vcpu_insn_exec_inline;
+  qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu;
   qemu_plugin_register_vcpu_mem_cb;
   qemu_plugin_register_vcpu_mem_inline;
+  qemu_plugin_register_vcpu_mem_inline_per_vcpu;
   qemu_plugin_register_vcpu_resume_cb;
   qemu_plugin_register_vcpu_syscall_cb;
   qemu_plugin_register_vcpu_syscall_ret_cb;
   qemu_plugin_register_vcpu_tb_exec_cb;
   qemu_plugin_register_vcpu_tb_exec_inline;
+  qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu;
   qemu_plugin_register_vcpu_tb_trans_cb;
   qemu_plugin_reset;
   qemu_plugin_start_code;
-- 
2.43.0


