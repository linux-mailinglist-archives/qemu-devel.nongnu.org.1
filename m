Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CAB7C64ED
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 07:52:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqoay-0003n2-7N; Thu, 12 Oct 2023 01:50:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qqoaj-0003Xz-Kf
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 01:50:38 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qqoag-0007Um-A6
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 01:50:36 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-692779f583fso497153b3a.0
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 22:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697089833; x=1697694633;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vANTtQziqF5v2qa61GAnoolqyrM5SRRP55mzz4Snbow=;
 b=YilEt96QpRjpwi4K+aD6P/6uIoTLiihhA5D8jFW9qQh/M0zLzGPSqVDeri8fdusLWR
 Y9YiFdetan7FZQ5iruPQrMTJiPsR1egA+L9kdMidhjS168bPwrgYvTBQKPRhRwmWrahB
 ZOHYLiUz4QNOehzqcFnvpIfSbU/v+jY6d7k9/PFrg6IGuqrGw8cyp/lOgc5yvFqSxw+u
 0UAJQq38h++J/PJ5aO2aoVWFdQshEshOXnkq/ubZOnqGVprrYFSYo2np202CERJhB8Ex
 +qt58wBRQ+5Pnr/PKjzeR8FOXMdiluRgKyOe2WcHYGWCACsFz3Cxk6DA14Wj+c3eXggI
 0VEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697089833; x=1697694633;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vANTtQziqF5v2qa61GAnoolqyrM5SRRP55mzz4Snbow=;
 b=s9LJJ5qXXISwvPXA+YXpmhbxvWYm0/sQpWnI1QoT3Pr6RSmi7jTQjPGBd7VX5anlhj
 IDoxoq/rYGxvG9ZpB6H2+N2XwQqCURWsysiTLp9uhOnY2FNOQDsIyrXCxtkB1Kx+mLOS
 pwfdvMZnsnF0Vvj+Gfpo4ha4165kQ128IUYrmVihXbe6UO3GxnKz04VzBWU+srNNi4UT
 IGSej5WxWV5G45Ul7jNRpaun4aDE4sesHSviUNT08VP3LdbDpTllnEvqlSdx3baJ40CE
 yXsvjXeySYYFEsR/aSHKcGw4nDRmZ0EstiBZ6bixiDBXnTE9LHY+ISVF6VU9b+z5tz68
 wlIw==
X-Gm-Message-State: AOJu0YxlOn19Jn5h7i5gDBamiqxrI8YEYATOHl5Bhq73iLPdxl8abD51
 3ez0FZ2xBowGuvqCnRR6bql8Yw==
X-Google-Smtp-Source: AGHT+IHKZNGJCmVYPp0RWQw2GV4u8aL6DdYVBT1NuNyJLi4jRz8Ow2x/5oadZf2auBo99Q8wmPe7/g==
X-Received: by 2002:a05:6a20:1608:b0:14b:887a:6d70 with SMTP id
 l8-20020a056a20160800b0014b887a6d70mr25544102pzj.15.1697089832826; 
 Wed, 11 Oct 2023 22:50:32 -0700 (PDT)
Received: from localhost ([157.82.206.10]) by smtp.gmail.com with UTF8SMTPSA id
 u13-20020a170902e80d00b001c5fd2a28d3sm940315plg.28.2023.10.11.22.50.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 22:50:32 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH v10 16/18] plugins: Use different helpers when reading
 registers
Date: Thu, 12 Oct 2023 14:48:55 +0900
Message-ID: <20231012054902.38447-17-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231012054902.38447-1-akihiko.odaki@daynix.com>
References: <20231012054902.38447-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42e.google.com
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
 include/hw/core/cpu.h      |  4 ++--
 include/qemu/plugin.h      |  3 +++
 plugins/plugin.h           |  5 +++--
 accel/tcg/plugin-gen.c     | 41 ++++++++++++++++++++++++++++----------
 accel/tcg/translator.c     |  2 +-
 plugins/api.c              | 10 ++++++++--
 plugins/core.c             | 28 ++++++++++++++++----------
 9 files changed, 68 insertions(+), 32 deletions(-)

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
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index d2e70643f2..dbdca8b105 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -437,7 +437,7 @@ struct qemu_work_item;
  * @trace_dstate_delayed: Delayed changes to trace_dstate (includes all changes
  *                        to @trace_dstate).
  * @trace_dstate: Dynamic tracing state of events for this vCPU (bitmask).
- * @plugin_mask: Plugin event bitmap. Modified only via async work.
+ * @plugin_flags: Plugin flags. Modified only via async work.
  * @ignore_memory_transaction_failures: Cached copy of the MachineState
  *    flag of the same name: allows the board to suppress calling of the
  *    CPU do_transaction_failed hook function.
@@ -529,7 +529,7 @@ struct CPUState {
     /* Use by accel-block: CPU is executing an ioctl() */
     QemuLockCnt in_ioctl_lock;
 
-    DECLARE_BITMAP(plugin_mask, QEMU_PLUGIN_EV_MAX);
+    unsigned long plugin_flags;
 
 #ifdef CONFIG_PLUGIN
     GArray *plugin_mem_cbs;
diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index 7fdc3a4849..a534b9127b 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -16,6 +16,9 @@
 #include "exec/memopidx.h"
 #include "hw/core/cpu.h"
 
+#define QEMU_PLUGIN_FLAG_TB_CB_READ QEMU_PLUGIN_EV_MAX
+#define QEMU_PLUGIN_FLAG_INSN_CB_READ (QEMU_PLUGIN_EV_MAX + 1)
+
 /*
  * Option parsing/processing.
  * Note that we can load an arbitrary number of plugins.
diff --git a/plugins/plugin.h b/plugins/plugin.h
index 5eb2fdbc85..ba0417194f 100644
--- a/plugins/plugin.h
+++ b/plugins/plugin.h
@@ -16,6 +16,7 @@
 #include "qemu/qht.h"
 
 #define QEMU_PLUGIN_MIN_VERSION 0
+#define QEMU_PLUGIN_FLAG_INSIN_CB_READ QEMU_PLUGIN_EV_MAX
 
 /* global state */
 struct qemu_plugin_state {
@@ -31,7 +32,7 @@ struct qemu_plugin_state {
      * but with the HT we avoid adding a field to CPUState.
      */
     GHashTable *cpu_ht;
-    DECLARE_BITMAP(mask, QEMU_PLUGIN_EV_MAX);
+    unsigned long flags;
     /*
      * @lock protects the struct as well as ctx->uninstalling.
      * The lock must be acquired by all API ops.
@@ -86,7 +87,7 @@ plugin_register_cb_udata(qemu_plugin_id_t id, enum qemu_plugin_event ev,
 void
 plugin_register_dyn_cb__udata(GArray **arr,
                               qemu_plugin_vcpu_udata_cb_t cb,
-                              enum qemu_plugin_cb_flags flags, void *udata);
+                              unsigned int flags, void *udata);
 
 
 void plugin_register_vcpu_mem_cb(GArray **arr,
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 78b331b251..3bddd4d3c5 100644
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
+                    cpu->plugin_flags & BIT(QEMU_PLUGIN_FLAG_INSN_CB_READ) ?
+                    gen_empty_udata_cb_no_wg : gen_empty_udata_cb_no_rwg);
+        gen_wrapped(from, PLUGIN_GEN_CB_INLINE, gen_empty_inline_cb);
+        break;
     case PLUGIN_GEN_FROM_TB:
-        gen_wrapped(from, PLUGIN_GEN_CB_UDATA, gen_empty_udata_cb);
+        gen_wrapped(from, PLUGIN_GEN_CB_UDATA,
+                    cpu->plugin_flags & BIT(QEMU_PLUGIN_FLAG_TB_CB_READ) ?
+                    gen_empty_udata_cb_no_wg : gen_empty_udata_cb_no_rwg);
         gen_wrapped(from, PLUGIN_GEN_CB_INLINE, gen_empty_inline_cb);
         break;
     default:
@@ -796,7 +815,7 @@ bool plugin_gen_tb_start(CPUState *cpu, const DisasContextBase *db,
 {
     bool ret = false;
 
-    if (test_bit(QEMU_PLUGIN_EV_VCPU_TB_TRANS, cpu->plugin_mask)) {
+    if (cpu->plugin_flags & BIT(QEMU_PLUGIN_EV_VCPU_TB_TRANS)) {
         struct qemu_plugin_tb *ptb = tcg_ctx->plugin_tb;
         int i;
 
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
index 5521b0ad36..3f7b5bbfdd 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -90,7 +90,10 @@ void qemu_plugin_register_vcpu_tb_exec_cb(struct qemu_plugin_tb *tb,
 {
     if (!tb->mem_only) {
         plugin_register_dyn_cb__udata(&tb->cbs[PLUGIN_CB_REGULAR],
-                                      cb, flags, udata);
+                                      cb,
+                                      flags == QEMU_PLUGIN_CB_R_REGS ?
+                                      BIT(QEMU_PLUGIN_FLAG_TB_CB_READ) : 0,
+                                      udata);
     }
 }
 
@@ -110,7 +113,10 @@ void qemu_plugin_register_vcpu_insn_exec_cb(struct qemu_plugin_insn *insn,
 {
     if (!insn->mem_only) {
         plugin_register_dyn_cb__udata(&insn->cbs[PLUGIN_CB_INSN][PLUGIN_CB_REGULAR],
-                                      cb, flags, udata);
+                                      cb,
+                                      flags == QEMU_PLUGIN_CB_R_REGS ?
+                                      BIT(QEMU_PLUGIN_FLAG_INSN_CB_READ) : 0,
+                                      udata);
     }
 }
 
diff --git a/plugins/core.c b/plugins/core.c
index fcd33a2bff..f461e84473 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -55,19 +55,19 @@ struct qemu_plugin_ctx *plugin_id_to_ctx_locked(qemu_plugin_id_t id)
 
 static void plugin_cpu_update__async(CPUState *cpu, run_on_cpu_data data)
 {
-    bitmap_copy(cpu->plugin_mask, &data.host_ulong, QEMU_PLUGIN_EV_MAX);
+    cpu->plugin_flags = data.host_ulong;
     tcg_flush_jmp_cache(cpu);
 }
 
 static void plugin_cpu_update__locked(gpointer k, gpointer v, gpointer udata)
 {
     CPUState *cpu = container_of(k, CPUState, cpu_index);
-    run_on_cpu_data mask = RUN_ON_CPU_HOST_ULONG(*plugin.mask);
+    run_on_cpu_data flags = RUN_ON_CPU_HOST_ULONG(plugin.flags);
 
     if (DEVICE(cpu)->realized) {
-        async_run_on_cpu(cpu, plugin_cpu_update__async, mask);
+        async_run_on_cpu(cpu, plugin_cpu_update__async, flags);
     } else {
-        plugin_cpu_update__async(cpu, mask);
+        plugin_cpu_update__async(cpu, flags);
     }
 }
 
@@ -83,7 +83,7 @@ void plugin_unregister_cb__locked(struct qemu_plugin_ctx *ctx,
     g_free(cb);
     ctx->callbacks[ev] = NULL;
     if (QLIST_EMPTY_RCU(&plugin.cb_lists[ev])) {
-        clear_bit(ev, plugin.mask);
+        plugin.flags &= ~BIT(ev);
         g_hash_table_foreach(plugin.cpu_ht, plugin_cpu_update__locked, NULL);
     }
 }
@@ -186,8 +186,8 @@ do_plugin_register_cb(qemu_plugin_id_t id, enum qemu_plugin_event ev,
             cb->udata = udata;
             ctx->callbacks[ev] = cb;
             QLIST_INSERT_HEAD_RCU(&plugin.cb_lists[ev], cb, entry);
-            if (!test_bit(ev, plugin.mask)) {
-                set_bit(ev, plugin.mask);
+            if (!(plugin.flags & BIT(ev))) {
+                plugin.flags |= BIT(ev);
                 g_hash_table_foreach(plugin.cpu_ht, plugin_cpu_update__locked,
                                      NULL);
             }
@@ -296,15 +296,20 @@ void plugin_register_inline_op(GArray **arr,
 
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
+        plugin.flags |= flags;
+        g_hash_table_foreach(plugin.cpu_ht, plugin_cpu_update__locked, NULL);
+    }
 }
 
 void plugin_register_vcpu_mem_cb(GArray **arr,
@@ -357,7 +362,7 @@ qemu_plugin_vcpu_syscall(CPUState *cpu, int64_t num, uint64_t a1, uint64_t a2,
     struct qemu_plugin_cb *cb, *next;
     enum qemu_plugin_event ev = QEMU_PLUGIN_EV_VCPU_SYSCALL;
 
-    if (!test_bit(ev, cpu->plugin_mask)) {
+    if (!(cpu->plugin_flags & BIT(ev))) {
         return;
     }
 
@@ -379,7 +384,7 @@ void qemu_plugin_vcpu_syscall_ret(CPUState *cpu, int64_t num, int64_t ret)
     struct qemu_plugin_cb *cb, *next;
     enum qemu_plugin_event ev = QEMU_PLUGIN_EV_VCPU_SYSCALL_RET;
 
-    if (!test_bit(ev, cpu->plugin_mask)) {
+    if (!(cpu->plugin_flags & BIT(ev))) {
         return;
     }
 
@@ -428,6 +433,7 @@ void qemu_plugin_flush_cb(void)
 {
     qht_iter_remove(&plugin.dyn_cb_arr_ht, free_dyn_cb_arr, NULL);
     qht_reset(&plugin.dyn_cb_arr_ht);
+    plugin.flags &= ~BIT(QEMU_PLUGIN_FLAG_INSIN_CB_READ);
 
     plugin_cb__simple(QEMU_PLUGIN_EV_FLUSH);
 }
-- 
2.42.0


