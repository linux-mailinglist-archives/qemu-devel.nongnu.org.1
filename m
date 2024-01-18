Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80DCE8311CD
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 04:26:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQJ1N-0003mP-St; Wed, 17 Jan 2024 22:24:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rQJ1L-0003m1-LL
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 22:24:47 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rQJ1J-00037W-Oz
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 22:24:47 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-33770772136so7109635f8f.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 19:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705548283; x=1706153083; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZLvxeFqnyu9l57+cwcakx7h5EhmFm40PDnmxlZb5fZM=;
 b=GsmCWLWuHqqYaTcseaiPmeDZOtY8DJl/YRAzge0rXqj42DM4mNUiU5H+cqy9Tq5os/
 y+9w4j4jgG1eQ3x/o+OOiErctkZW4qJZJ0ZDOwexuLiu4zWGiGD8TNdQycp9xZV4yFw9
 twGHBGSmhqvnRfZ13GnXmai/YJxEz0FXfV3unjyLIIXeB7CmLXyNSHpBP6n4PGRRF208
 LvcFd70I5+1BhOevYkNuTarJhfAjeQ+Mq7GbnMUuEzE4/tzRHCZxm1BHGyp8gEIPVItx
 TlcEAocO4w8scWVHppigJPMDmOnJWMu1UDARXjczk1ymhFbSRqvFFcYUyhhQHf/yrB+L
 Yyfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705548283; x=1706153083;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZLvxeFqnyu9l57+cwcakx7h5EhmFm40PDnmxlZb5fZM=;
 b=Um0TW1bgz0XTr8oLDBHFRQmESgIuO+HhvqVd4n+2VT7/VZKInjCKRUeJp58Qs0LDVQ
 ByCg/f0JtrE/HpjuNmlwjeImyPUsoEh3qi3IxGXbh+6X8VCfmcTFhSoG9U/0O1MGcAkP
 Rcsu1oUtOvLRfceHDIWKbQvSPtm/mSDnX9F8nScpXD8XMHhkzRCxixeM0JPZ++PVlkEN
 PFdS8SSFiJeQQyJqODzYDQ/D5abR1d7O7qDqhgmfRKJV+tnoZPMlBDx6KnwclrLBXn6S
 lSYQ7z2wVPtyOCpBqPMh7KGmkIIRTyNz9gGCJ8KnqBt7aoPETqZ8NPHMGoD/rAFvVA2M
 WTFA==
X-Gm-Message-State: AOJu0Yz2chVzAFgkM+BZ845Lkm24g8dRAsvjzxuol9rtS3d/qNLWQNvx
 FEsohw4gfz/3rpoxb0AnfsPZej/NohKBbq+rFGSPOo3zD6FTsaupqgy3fmixihVSMMwMWWhlTzP
 PyM8=
X-Google-Smtp-Source: AGHT+IHEwapwz9z16JSm25vmNOys0ITmGC8Ju4F93OT2cscbRdqLeWPVVhOm1qv3KjrVL/2ccHgpsQ==
X-Received: by 2002:adf:d1e7:0:b0:337:5588:801f with SMTP id
 g7-20020adfd1e7000000b003375588801fmr105880wrd.57.1705548283664; 
 Wed, 17 Jan 2024 19:24:43 -0800 (PST)
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 i2-20020adff302000000b0033788e357e1sm2894292wro.108.2024.01.17.19.24.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 19:24:43 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH v2 11/14] plugins: remove non per_vcpu inline operation from
 API
Date: Thu, 18 Jan 2024 07:23:56 +0400
Message-ID: <20240118032400.3762658-12-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118032400.3762658-1-pierrick.bouvier@linaro.org>
References: <20240118032400.3762658-1-pierrick.bouvier@linaro.org>
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

Now we have a thread-safe equivalent of inline operation, and that all
plugins were changed to use it, there is no point to keep the old API.

In more, it will help when we implement more functionality (conditional
callbacks), as we can assume that we operate on a scoreboard.

Bump API version as it's a breaking change for existing plugins.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/qemu/qemu-plugin.h | 59 ++++----------------------------------
 plugins/api.c              | 29 -------------------
 2 files changed, 6 insertions(+), 82 deletions(-)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 55f918db1b0..3ee514f79cf 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -51,11 +51,16 @@ typedef uint64_t qemu_plugin_id_t;
  *
  * The plugins export the API they were built against by exposing the
  * symbol qemu_plugin_version which can be checked.
+ *
+ * Version 2:
+ * Remove qemu_plugin_register_vcpu_{tb, insn, mem}_exec_inline.
+ * Those functions are replaced by *_per_vcpu variants, which guarantees
+ * thread-safety for operations.
  */
 
 extern QEMU_PLUGIN_EXPORT int qemu_plugin_version;
 
-#define QEMU_PLUGIN_VERSION 1
+#define QEMU_PLUGIN_VERSION 2
 
 /**
  * struct qemu_info_t - system information for plugins
@@ -311,25 +316,6 @@ enum qemu_plugin_op {
     QEMU_PLUGIN_INLINE_ADD_U64,
 };
 
-/**
- * qemu_plugin_register_vcpu_tb_exec_inline() - execution inline op
- * @tb: the opaque qemu_plugin_tb handle for the translation
- * @op: the type of qemu_plugin_op (e.g. ADD_U64)
- * @ptr: the target memory location for the op
- * @imm: the op data (e.g. 1)
- *
- * Insert an inline op to every time a translated unit executes.
- * Useful if you just want to increment a single counter somewhere in
- * memory.
- *
- * Note: ops are not atomic so in multi-threaded/multi-smp situations
- * you will get inexact results.
- */
-QEMU_PLUGIN_API
-void qemu_plugin_register_vcpu_tb_exec_inline(struct qemu_plugin_tb *tb,
-                                              enum qemu_plugin_op op,
-                                              void *ptr, uint64_t imm);
-
 /**
  * qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu() - execution inline op
  * @tb: the opaque qemu_plugin_tb handle for the translation
@@ -361,21 +347,6 @@ void qemu_plugin_register_vcpu_insn_exec_cb(struct qemu_plugin_insn *insn,
                                             enum qemu_plugin_cb_flags flags,
                                             void *userdata);
 
-/**
- * qemu_plugin_register_vcpu_insn_exec_inline() - insn execution inline op
- * @insn: the opaque qemu_plugin_insn handle for an instruction
- * @op: the type of qemu_plugin_op (e.g. ADD_U64)
- * @ptr: the target memory location for the op
- * @imm: the op data (e.g. 1)
- *
- * Insert an inline op to every time an instruction executes. Useful
- * if you just want to increment a single counter somewhere in memory.
- */
-QEMU_PLUGIN_API
-void qemu_plugin_register_vcpu_insn_exec_inline(struct qemu_plugin_insn *insn,
-                                                enum qemu_plugin_op op,
-                                                void *ptr, uint64_t imm);
-
 /**
  * qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu() - insn exec inline op
  * @insn: the opaque qemu_plugin_insn handle for an instruction
@@ -599,24 +570,6 @@ void qemu_plugin_register_vcpu_mem_cb(struct qemu_plugin_insn *insn,
                                       enum qemu_plugin_mem_rw rw,
                                       void *userdata);
 
-/**
- * qemu_plugin_register_vcpu_mem_inline() - register an inline op to any memory access
- * @insn: handle for instruction to instrument
- * @rw: apply to reads, writes or both
- * @op: the op, of type qemu_plugin_op
- * @ptr: pointer memory for the op
- * @imm: immediate data for @op
- *
- * This registers a inline op every memory access generated by the
- * instruction. This provides for a lightweight but not thread-safe
- * way of counting the number of operations done.
- */
-QEMU_PLUGIN_API
-void qemu_plugin_register_vcpu_mem_inline(struct qemu_plugin_insn *insn,
-                                          enum qemu_plugin_mem_rw rw,
-                                          enum qemu_plugin_op op, void *ptr,
-                                          uint64_t imm);
-
 /**
  * qemu_plugin_register_vcpu_mem_inline_per_vcpu() - inline op for mem access
  * @insn: handle for instruction to instrument
diff --git a/plugins/api.c b/plugins/api.c
index 132d5e0bec1..29915d3c142 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -101,16 +101,6 @@ void qemu_plugin_register_vcpu_tb_exec_cb(struct qemu_plugin_tb *tb,
     }
 }
 
-void qemu_plugin_register_vcpu_tb_exec_inline(struct qemu_plugin_tb *tb,
-                                              enum qemu_plugin_op op,
-                                              void *ptr, uint64_t imm)
-{
-    if (!tb->mem_only) {
-        plugin_register_inline_op(&tb->cbs[PLUGIN_CB_INLINE],
-                                  0, op, ptr, 0, sizeof(uint64_t), true, imm);
-    }
-}
-
 void qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
     struct qemu_plugin_tb *tb,
     enum qemu_plugin_op op,
@@ -140,16 +130,6 @@ void qemu_plugin_register_vcpu_insn_exec_cb(struct qemu_plugin_insn *insn,
     }
 }
 
-void qemu_plugin_register_vcpu_insn_exec_inline(struct qemu_plugin_insn *insn,
-                                                enum qemu_plugin_op op,
-                                                void *ptr, uint64_t imm)
-{
-    if (!insn->mem_only) {
-        plugin_register_inline_op(&insn->cbs[PLUGIN_CB_INSN][PLUGIN_CB_INLINE],
-                                  0, op, ptr, 0, sizeof(uint64_t), true, imm);
-    }
-}
-
 void qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
     struct qemu_plugin_insn *insn,
     enum qemu_plugin_op op,
@@ -179,15 +159,6 @@ void qemu_plugin_register_vcpu_mem_cb(struct qemu_plugin_insn *insn,
                                 cb, flags, rw, udata);
 }
 
-void qemu_plugin_register_vcpu_mem_inline(struct qemu_plugin_insn *insn,
-                                          enum qemu_plugin_mem_rw rw,
-                                          enum qemu_plugin_op op, void *ptr,
-                                          uint64_t imm)
-{
-    plugin_register_inline_op(&insn->cbs[PLUGIN_CB_MEM][PLUGIN_CB_INLINE],
-                              rw, op, ptr, 0, sizeof(uint64_t), true, imm);
-}
-
 void qemu_plugin_register_vcpu_mem_inline_per_vcpu(
     struct qemu_plugin_insn *insn,
     enum qemu_plugin_mem_rw rw,
-- 
2.43.0


