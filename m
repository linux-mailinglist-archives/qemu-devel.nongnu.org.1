Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC7F7D612C
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 07:30:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvWSQ-0005VC-55; Wed, 25 Oct 2023 01:29:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qvWSJ-0005K4-Lz
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 01:29:24 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qvWSF-0001Gz-UP
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 01:29:23 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6934202b8bdso5118480b3a.1
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 22:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1698211758; x=1698816558;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b1TpavFbEkSNOtLuXJHpW9kNCD9pujY6Cfmd5Kb30aA=;
 b=aJf9KnTN2DrClndXz/tkcbCCa6JJZLATRRGFZhDG31UxcDj83yRepYeLYRg8HbdmWn
 RGSHQEyTSp+efpnIP1SvJSIPVuqglJFVuMKj+N71PfrMoMnqyI5IbW3E2MInjNiMlPR9
 lXrBy6kxxNJjndXvjzvCqxK59CWW7vMOla+COK1oYKOG3xktVT6PuktKxr/e6niseooh
 1cFN00yN2vN2+h59Y33FuFYWXJ6vPt5g0YOKcrePbJ2GgR+/DX4OqlWmbmfI16AivQpx
 wVbF/hUNNkWXf2lxvVWSQDlgRZwFMe3ibfHbaYkzTCslN9Ky/TfPlkTw7utWRTFagSZl
 +3/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698211758; x=1698816558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b1TpavFbEkSNOtLuXJHpW9kNCD9pujY6Cfmd5Kb30aA=;
 b=SF3bI0mfMcgQBi/a94TnMfx+Ug4GeKA4Qi5YIGQ9/j/qckcYo7NO9r54/5hfRhcIlW
 Xkx3ki5do+kE92AAppNcRFJqVEZmsdT0TgM45zUtMb1MvJhGzhrtB0z4DAp92p3wIxyR
 govGjrsGTvqa1OPUxAel/U6lR2LE/ckk+zNYZE9YXCdnnx+m+GcUw8XAlqfDFiVNWfdn
 a7rWHIpSd4tlspMmE2NqHjbGIbZmUUG5/cpNao4Yiy8ND1hc0yykUXazb5wrWReeXuzv
 FU7senMRiEGByAQssdeLZ3GY9b+XlXKtBHrCUZeQKBSN5C4KfZc/xqaxm1Z9zDG+4igs
 /2fQ==
X-Gm-Message-State: AOJu0Yzn6Zli5o9C4IMtPSbvp9hw2BneHQv62uvta5/b/kLYLCFE9OQu
 cgXGkuZMHLU3VPLyTz+ohTxAmQ==
X-Google-Smtp-Source: AGHT+IFwjWAi2T8ZY7UBbuj3PWdgILpUGcO6+OWz7Zrb5l+zRimvsxAdapF2BSJLwBa6vqymavenoQ==
X-Received: by 2002:aa7:9622:0:b0:68b:eb3d:8030 with SMTP id
 r2-20020aa79622000000b0068beb3d8030mr14634239pfg.1.1698211758421; 
 Tue, 24 Oct 2023 22:29:18 -0700 (PDT)
Received: from localhost ([157.82.204.207])
 by smtp.gmail.com with UTF8SMTPSA id
 t22-20020aa79476000000b0068e49cb1692sm8462531pfq.1.2023.10.24.22.29.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Oct 2023 22:29:17 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH v15 17/19] plugins: Use different helpers when reading
 registers
Date: Wed, 25 Oct 2023 14:27:39 +0900
Message-ID: <20231025052744.20697-18-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231025052744.20697-1-akihiko.odaki@daynix.com>
References: <20231025052744.20697-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

This avoids optimizations incompatible when reading registers.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 accel/tcg/plugin-helpers.h |  3 ++-
 include/exec/plugin-gen.h  |  4 ++--
 include/qemu/plugin.h      |  2 ++
 plugins/plugin.h           |  2 +-
 accel/tcg/plugin-gen.c     | 39 ++++++++++++++++++++++++++++----------
 accel/tcg/translator.c     |  2 +-
 plugins/api.c              | 14 ++++++++++++--
 plugins/core.c             | 10 ++++++++--
 8 files changed, 57 insertions(+), 19 deletions(-)

diff --git a/accel/tcg/plugin-helpers.h b/accel/tcg/plugin-helpers.h
index 8e685e0654..11796436f3 100644
--- a/accel/tcg/plugin-helpers.h
+++ b/accel/tcg/plugin-helpers.h
@@ -1,4 +1,5 @@
 #ifdef CONFIG_PLUGIN
-DEF_HELPER_FLAGS_2(plugin_vcpu_udata_cb, TCG_CALL_NO_RWG | TCG_CALL_PLUGIN, void, i32, ptr)
+DEF_HELPER_FLAGS_2(plugin_vcpu_udata_cb_no_wg, TCG_CALL_NO_WG | TCG_CALL_PLUGIN, void, i32, ptr)
+DEF_HELPER_FLAGS_2(plugin_vcpu_udata_cb_no_rwg, TCG_CALL_NO_RWG | TCG_CALL_PLUGIN, void, i32, ptr)
 DEF_HELPER_FLAGS_4(plugin_vcpu_mem_cb, TCG_CALL_NO_RWG | TCG_CALL_PLUGIN, void, i32, i32, i64, ptr)
 #endif
diff --git a/include/exec/plugin-gen.h b/include/exec/plugin-gen.h
index c4552b5061..b964e1eb5c 100644
--- a/include/exec/plugin-gen.h
+++ b/include/exec/plugin-gen.h
@@ -22,7 +22,7 @@ bool plugin_gen_tb_start(CPUState *cpu, const struct DisasContextBase *db,
                          bool supress);
 void plugin_gen_tb_end(CPUState *cpu, size_t num_insns);
 void plugin_gen_insn_start(CPUState *cpu, const struct DisasContextBase *db);
-void plugin_gen_insn_end(void);
+void plugin_gen_insn_end(CPUState *cpu);
 
 void plugin_gen_disable_mem_helpers(void);
 void plugin_gen_empty_mem_callback(TCGv_i64 addr, uint32_t info);
@@ -39,7 +39,7 @@ static inline
 void plugin_gen_insn_start(CPUState *cpu, const struct DisasContextBase *db)
 { }
 
-static inline void plugin_gen_insn_end(void)
+static inline void plugin_gen_insn_end(CPUState *cpu)
 { }
 
 static inline void plugin_gen_tb_end(CPUState *cpu, size_t num_insns)
diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index b15fee39fd..1228562fa7 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -17,6 +17,8 @@
 #include "hw/core/cpu.h"
 
 #define QEMU_PLUGIN_CPU_FLAG_CB_TB_TRANS BIT(0)
+#define QEMU_PLUGIN_CPU_FLAG_CB_TB_READ BIT(1)
+#define QEMU_PLUGIN_CPU_FLAG_CB_INSN_READ BIT(2)
 
 /*
  * Option parsing/processing.
diff --git a/plugins/plugin.h b/plugins/plugin.h
index db25e2650d..c9f602316c 100644
--- a/plugins/plugin.h
+++ b/plugins/plugin.h
@@ -87,7 +87,7 @@ plugin_register_cb_udata(qemu_plugin_id_t id, enum qemu_plugin_event ev,
 void
 plugin_register_dyn_cb__udata(GArray **arr,
                               qemu_plugin_vcpu_udata_cb_t cb,
-                              enum qemu_plugin_cb_flags flags, void *udata);
+                              unsigned int flags, void *udata);
 
 
 void plugin_register_vcpu_mem_cb(GArray **arr,
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 4870433f3a..6d33b2bf24 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -90,7 +90,10 @@ enum plugin_gen_cb {
  * These helpers are stubs that get dynamically switched out for calls
  * direct to the plugin if they are subscribed to.
  */
-void HELPER(plugin_vcpu_udata_cb)(uint32_t cpu_index, void *udata)
+void HELPER(plugin_vcpu_udata_cb_no_wg)(uint32_t cpu_index, void *udata)
+{ }
+
+void HELPER(plugin_vcpu_udata_cb_no_rwg)(uint32_t cpu_index, void *udata)
 { }
 
 void HELPER(plugin_vcpu_mem_cb)(unsigned int vcpu_index,
@@ -98,7 +101,7 @@ void HELPER(plugin_vcpu_mem_cb)(unsigned int vcpu_index,
                                 void *userdata)
 { }
 
-static void gen_empty_udata_cb(void)
+static void gen_empty_udata_cb(void (*gen_helper)(TCGv_i32, TCGv_ptr))
 {
     TCGv_i32 cpu_index = tcg_temp_ebb_new_i32();
     TCGv_ptr udata = tcg_temp_ebb_new_ptr();
@@ -106,12 +109,22 @@ static void gen_empty_udata_cb(void)
     tcg_gen_movi_ptr(udata, 0);
     tcg_gen_ld_i32(cpu_index, tcg_env,
                    -offsetof(ArchCPU, env) + offsetof(CPUState, cpu_index));
-    gen_helper_plugin_vcpu_udata_cb(cpu_index, udata);
+    gen_helper(cpu_index, udata);
 
     tcg_temp_free_ptr(udata);
     tcg_temp_free_i32(cpu_index);
 }
 
+static void gen_empty_udata_cb_no_wg(void)
+{
+    gen_empty_udata_cb(gen_helper_plugin_vcpu_udata_cb_no_wg);
+}
+
+static void gen_empty_udata_cb_no_rwg(void)
+{
+    gen_empty_udata_cb(gen_helper_plugin_vcpu_udata_cb_no_rwg);
+}
+
 /*
  * For now we only support addi_i64.
  * When we support more ops, we can generate one empty inline cb for each.
@@ -176,7 +189,7 @@ static void gen_wrapped(enum plugin_gen_from from,
     tcg_gen_plugin_cb_end();
 }
 
-static void plugin_gen_empty_callback(enum plugin_gen_from from)
+static void plugin_gen_empty_callback(CPUState *cpu, enum plugin_gen_from from)
 {
     switch (from) {
     case PLUGIN_GEN_AFTER_INSN:
@@ -190,9 +203,15 @@ static void plugin_gen_empty_callback(enum plugin_gen_from from)
          */
         gen_wrapped(from, PLUGIN_GEN_ENABLE_MEM_HELPER,
                     gen_empty_mem_helper);
-        /* fall through */
+        gen_wrapped(from, PLUGIN_GEN_CB_UDATA,
+                    cpu->plugin_flags & QEMU_PLUGIN_CPU_FLAG_CB_INSN_READ ?
+                    gen_empty_udata_cb_no_wg : gen_empty_udata_cb_no_rwg);
+        gen_wrapped(from, PLUGIN_GEN_CB_INLINE, gen_empty_inline_cb);
+        break;
     case PLUGIN_GEN_FROM_TB:
-        gen_wrapped(from, PLUGIN_GEN_CB_UDATA, gen_empty_udata_cb);
+        gen_wrapped(from, PLUGIN_GEN_CB_UDATA,
+                    cpu->plugin_flags & QEMU_PLUGIN_CPU_FLAG_CB_TB_READ ?
+                    gen_empty_udata_cb_no_wg : gen_empty_udata_cb_no_rwg);
         gen_wrapped(from, PLUGIN_GEN_CB_INLINE, gen_empty_inline_cb);
         break;
     default:
@@ -817,7 +836,7 @@ bool plugin_gen_tb_start(CPUState *cpu, const DisasContextBase *db,
         ptb->mem_only = mem_only;
         ptb->mem_helper = false;
 
-        plugin_gen_empty_callback(PLUGIN_GEN_FROM_TB);
+        plugin_gen_empty_callback(cpu, PLUGIN_GEN_FROM_TB);
     }
 
     tcg_ctx->plugin_insn = NULL;
@@ -832,7 +851,7 @@ void plugin_gen_insn_start(CPUState *cpu, const DisasContextBase *db)
 
     pinsn = qemu_plugin_tb_insn_get(ptb, db->pc_next);
     tcg_ctx->plugin_insn = pinsn;
-    plugin_gen_empty_callback(PLUGIN_GEN_FROM_INSN);
+    plugin_gen_empty_callback(cpu, PLUGIN_GEN_FROM_INSN);
 
     /*
      * Detect page crossing to get the new host address.
@@ -852,9 +871,9 @@ void plugin_gen_insn_start(CPUState *cpu, const DisasContextBase *db)
     }
 }
 
-void plugin_gen_insn_end(void)
+void plugin_gen_insn_end(CPUState *cpu)
 {
-    plugin_gen_empty_callback(PLUGIN_GEN_AFTER_INSN);
+    plugin_gen_empty_callback(cpu, PLUGIN_GEN_AFTER_INSN);
 }
 
 /*
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 575b9812ad..bec58dd93f 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -189,7 +189,7 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
          * to accurately track instrumented helpers that might access memory.
          */
         if (plugin_enabled) {
-            plugin_gen_insn_end();
+            plugin_gen_insn_end(cpu);
         }
 
         /* Stop translation if translate_insn so indicated.  */
diff --git a/plugins/api.c b/plugins/api.c
index 5521b0ad36..29c6fc788f 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -89,8 +89,13 @@ void qemu_plugin_register_vcpu_tb_exec_cb(struct qemu_plugin_tb *tb,
                                           void *udata)
 {
     if (!tb->mem_only) {
+        bool read = flags == QEMU_PLUGIN_CB_R_REGS ||
+                    flags == QEMU_PLUGIN_CB_RW_REGS;
+
         plugin_register_dyn_cb__udata(&tb->cbs[PLUGIN_CB_REGULAR],
-                                      cb, flags, udata);
+                                      cb,
+                                      read ? QEMU_PLUGIN_CPU_FLAG_CB_TB_READ : 0,
+                                      udata);
     }
 }
 
@@ -109,8 +114,13 @@ void qemu_plugin_register_vcpu_insn_exec_cb(struct qemu_plugin_insn *insn,
                                             void *udata)
 {
     if (!insn->mem_only) {
+        bool read = flags == QEMU_PLUGIN_CB_R_REGS ||
+                    flags == QEMU_PLUGIN_CB_RW_REGS;
+
         plugin_register_dyn_cb__udata(&insn->cbs[PLUGIN_CB_INSN][PLUGIN_CB_REGULAR],
-                                      cb, flags, udata);
+                                      cb,
+                                      read ? QEMU_PLUGIN_CPU_FLAG_CB_INSN_READ : 0,
+                                      udata);
     }
 }
 
diff --git a/plugins/core.c b/plugins/core.c
index 368e2d1f54..8e436a424b 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -302,15 +302,20 @@ void plugin_register_inline_op(GArray **arr,
 
 void plugin_register_dyn_cb__udata(GArray **arr,
                                    qemu_plugin_vcpu_udata_cb_t cb,
-                                   enum qemu_plugin_cb_flags flags,
+                                   unsigned int flags,
                                    void *udata)
 {
     struct qemu_plugin_dyn_cb *dyn_cb = plugin_get_dyn_cb(arr);
 
     dyn_cb->userp = udata;
-    /* Note flags are discarded as unused. */
     dyn_cb->f.vcpu_udata = cb;
     dyn_cb->type = PLUGIN_CB_REGULAR;
+
+    if (flags) {
+        QEMU_LOCK_GUARD(&plugin.lock);
+        plugin.cpu_flags |= flags;
+        g_hash_table_foreach(plugin.cpu_ht, plugin_cpu_update__locked, NULL);
+    }
 }
 
 void plugin_register_vcpu_mem_cb(GArray **arr,
@@ -434,6 +439,7 @@ void qemu_plugin_flush_cb(void)
 {
     qht_iter_remove(&plugin.dyn_cb_arr_ht, free_dyn_cb_arr, NULL);
     qht_reset(&plugin.dyn_cb_arr_ht);
+    plugin.cpu_flags &= ~QEMU_PLUGIN_CPU_FLAG_CB_INSN_READ;
 
     plugin_cb__simple(QEMU_PLUGIN_EV_FLUSH);
 }
-- 
2.42.0


