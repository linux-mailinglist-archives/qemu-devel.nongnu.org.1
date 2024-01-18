Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC158311C4
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 04:25:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQJ17-0003cq-RP; Wed, 17 Jan 2024 22:24:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rQJ13-0003YF-NN
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 22:24:29 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rQJ11-0002cI-BJ
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 22:24:29 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-337c7148a71so711518f8f.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 19:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705548265; x=1706153065; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=avAAc0Vlx/SbBP3d3CcEQtIUcAU9hvFMhQ4VLfaD1p0=;
 b=bHccsBOOJpgBhVER1p4b65HUJ1X1S3iNEQYkC1DXToxnetF9XWgPhFB7zEo5X/+ceN
 U/T4IC1k5kJlfhQ+KcacPef7u1KlkMaDHxt/OZlDc8hNZ3fyN06aiKOkaEboPoCbqLxD
 Sns38/v6JLNKPxh1vRYDuJlvkN3ZKgqp6tFHAlPY+ETHrb/ljlFLVpKRFROCkhy128hj
 ybGUzGKMy4BMD5RS6LbEANN+fKNlBMcvfJEh8Nvq1bvncYDaVi+RaKOxcvVt/sGVUSIJ
 GLyMH7mlMFFoUPRoR6sMWeNVLwKuBoB03YCyTRWy9lOBLJi7FgfVINLhYLkJmPUc1ONf
 fX0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705548265; x=1706153065;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=avAAc0Vlx/SbBP3d3CcEQtIUcAU9hvFMhQ4VLfaD1p0=;
 b=WT0XUHaaL1hoJLmXtV+rTdj9g+boC2slQ4w/abwyATdMBC7vyh+Z8m7pUuRgVTPP/E
 fKfd/9IF1LKMe4AvYKxjcLK7463/0AhPJoEcIkr/8cuV7mGVR6STe7Wf/cYPzRP5CEIG
 YA6kMT8JSFqC4brWHPvO6iRPsgrrJb7xx91AyRERfEewDtW7QwsiXC2iruuZhPK042yz
 AOqllKz5MeXep3oGaPFCnyhu6WA9RF/xwLRwaITKuWlQu/fVKOwTtr5rRyvkmAUmDMxW
 Z8n2qfcckEV3sWJ5GK6tshODm4PzWKHVMHrjNQjc6uSwIuD4V49enQCqGV2qbaXGBSzF
 xPdA==
X-Gm-Message-State: AOJu0YxEetAAzA7338gjIO2SSdYQl7KZNOA8U25paFPHpAQ2Js1F5Tte
 b0WqB1uTVkTMNAU4AK+PSjKvNHZ3sYdGsXMJo/5OhTpYWYVKSErJmcaAw2EsHrmCYTNPy+Ia74R
 SGQ0=
X-Google-Smtp-Source: AGHT+IHcn28Mh4R/3QVP0SeguZWOf7+OEAVxVu2nl70YHBWURwJwYsJPftJwilSZYk49gQwyds6NPg==
X-Received: by 2002:a5d:4b88:0:b0:337:c134:61d5 with SMTP id
 b8-20020a5d4b88000000b00337c13461d5mr42542wrt.252.1705548265167; 
 Wed, 17 Jan 2024 19:24:25 -0800 (PST)
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 i2-20020adff302000000b0033788e357e1sm2894292wro.108.2024.01.17.19.24.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 19:24:24 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH v2 04/14] plugins: add inline operation per vcpu
Date: Thu, 18 Jan 2024 07:23:49 +0400
Message-ID: <20240118032400.3762658-5-pierrick.bouvier@linaro.org>
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

Extends API with three new functions:
qemu_plugin_register_vcpu_{tb, insn, mem}_exec_inline_per_vcpu().

Those functions takes a qemu_plugin_u64_t as input.

This allows to have a thread-safe and type-safe version of inline
operations.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/qemu/qemu-plugin.h   | 51 +++++++++++++++++++++++++++++++++++-
 plugins/api.c                | 43 +++++++++++++++++++++++++++++-
 plugins/qemu-plugins.symbols |  3 +++
 3 files changed, 95 insertions(+), 2 deletions(-)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 934059d64c2..55f918db1b0 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -330,6 +330,22 @@ void qemu_plugin_register_vcpu_tb_exec_inline(struct qemu_plugin_tb *tb,
                                               enum qemu_plugin_op op,
                                               void *ptr, uint64_t imm);
 
+/**
+ * qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu() - execution inline op
+ * @tb: the opaque qemu_plugin_tb handle for the translation
+ * @op: the type of qemu_plugin_op (e.g. ADD_U64)
+ * @entry: entry to run op
+ * @imm: the op data (e.g. 1)
+ *
+ * Insert an inline op on a given scoreboard entry.
+ */
+QEMU_PLUGIN_API
+void qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
+    struct qemu_plugin_tb *tb,
+    enum qemu_plugin_op op,
+    qemu_plugin_u64_t entry,
+    uint64_t imm);
+
 /**
  * qemu_plugin_register_vcpu_insn_exec_cb() - register insn execution cb
  * @insn: the opaque qemu_plugin_insn handle for an instruction
@@ -360,6 +376,22 @@ void qemu_plugin_register_vcpu_insn_exec_inline(struct qemu_plugin_insn *insn,
                                                 enum qemu_plugin_op op,
                                                 void *ptr, uint64_t imm);
 
+/**
+ * qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu() - insn exec inline op
+ * @insn: the opaque qemu_plugin_insn handle for an instruction
+ * @op: the type of qemu_plugin_op (e.g. ADD_U64)
+ * @entry: entry to run op
+ * @imm: the op data (e.g. 1)
+ *
+ * Insert an inline op to every time an instruction executes.
+ */
+QEMU_PLUGIN_API
+void qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
+    struct qemu_plugin_insn *insn,
+    enum qemu_plugin_op op,
+    qemu_plugin_u64_t entry,
+    uint64_t imm);
+
 /**
  * qemu_plugin_tb_n_insns() - query helper for number of insns in TB
  * @tb: opaque handle to TB passed to callback
@@ -585,7 +617,24 @@ void qemu_plugin_register_vcpu_mem_inline(struct qemu_plugin_insn *insn,
                                           enum qemu_plugin_op op, void *ptr,
                                           uint64_t imm);
 
-
+/**
+ * qemu_plugin_register_vcpu_mem_inline_per_vcpu() - inline op for mem access
+ * @insn: handle for instruction to instrument
+ * @rw: apply to reads, writes or both
+ * @op: the op, of type qemu_plugin_op
+ * @entry: entry to run op
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
+    qemu_plugin_u64_t entry,
+    uint64_t imm);
 
 typedef void
 (*qemu_plugin_vcpu_syscall_cb_t)(qemu_plugin_id_t id, unsigned int vcpu_index,
diff --git a/plugins/api.c b/plugins/api.c
index 4de94e798c6..132d5e0bec1 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -111,6 +111,20 @@ void qemu_plugin_register_vcpu_tb_exec_inline(struct qemu_plugin_tb *tb,
     }
 }
 
+void qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
+    struct qemu_plugin_tb *tb,
+    enum qemu_plugin_op op,
+    qemu_plugin_u64_t entry,
+    uint64_t imm)
+{
+    if (!tb->mem_only) {
+        plugin_register_inline_op(&tb->cbs[PLUGIN_CB_INLINE],
+                                  0, op, entry.score->data,
+                                  entry.offset, entry.score->element_size,
+                                  false, imm);
+    }
+}
+
 void qemu_plugin_register_vcpu_insn_exec_cb(struct qemu_plugin_insn *insn,
                                             qemu_plugin_vcpu_udata_cb_t cb,
                                             enum qemu_plugin_cb_flags flags,
@@ -136,6 +150,20 @@ void qemu_plugin_register_vcpu_insn_exec_inline(struct qemu_plugin_insn *insn,
     }
 }
 
+void qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
+    struct qemu_plugin_insn *insn,
+    enum qemu_plugin_op op,
+    qemu_plugin_u64_t entry,
+    uint64_t imm)
+{
+    if (!insn->mem_only) {
+        plugin_register_inline_op(&insn->cbs[PLUGIN_CB_INSN][PLUGIN_CB_INLINE],
+                                  0, op, entry.score->data,
+                                  entry.offset, entry.score->element_size,
+                                  false, imm);
+    }
+}
+
 
 /*
  * We always plant memory instrumentation because they don't finalise until
@@ -148,7 +176,7 @@ void qemu_plugin_register_vcpu_mem_cb(struct qemu_plugin_insn *insn,
                                       void *udata)
 {
     plugin_register_vcpu_mem_cb(&insn->cbs[PLUGIN_CB_MEM][PLUGIN_CB_REGULAR],
-                                    cb, flags, rw, udata);
+                                cb, flags, rw, udata);
 }
 
 void qemu_plugin_register_vcpu_mem_inline(struct qemu_plugin_insn *insn,
@@ -160,6 +188,19 @@ void qemu_plugin_register_vcpu_mem_inline(struct qemu_plugin_insn *insn,
                               rw, op, ptr, 0, sizeof(uint64_t), true, imm);
 }
 
+void qemu_plugin_register_vcpu_mem_inline_per_vcpu(
+    struct qemu_plugin_insn *insn,
+    enum qemu_plugin_mem_rw rw,
+    enum qemu_plugin_op op,
+    qemu_plugin_u64_t entry,
+    uint64_t imm)
+{
+    plugin_register_inline_op(&insn->cbs[PLUGIN_CB_MEM][PLUGIN_CB_INLINE],
+                              rw, op, entry.score->data,
+                              entry.offset, entry.score->element_size,
+                              false, imm);
+}
+
 void qemu_plugin_register_vcpu_tb_trans_cb(qemu_plugin_id_t id,
                                            qemu_plugin_vcpu_tb_trans_cb_t cb)
 {
diff --git a/plugins/qemu-plugins.symbols b/plugins/qemu-plugins.symbols
index 93866d1b5f2..a499cee06d5 100644
--- a/plugins/qemu-plugins.symbols
+++ b/plugins/qemu-plugins.symbols
@@ -29,13 +29,16 @@
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
   qemu_plugin_scoreboard_free;
-- 
2.43.0


