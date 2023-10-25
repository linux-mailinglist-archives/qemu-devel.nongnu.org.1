Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3E47D6125
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 07:30:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvWSO-0005Sd-6u; Wed, 25 Oct 2023 01:29:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qvWSD-000571-Ae
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 01:29:19 -0400
Received: from mail-qk1-x731.google.com ([2607:f8b0:4864:20::731])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qvWSA-0001GY-6k
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 01:29:15 -0400
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-778711ee748so394562485a.2
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 22:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1698211753; x=1698816553;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T9mieFdG9yfX1MKdeXe3uBNcgqFC4zw7yvemoQpAA3U=;
 b=t1EUk4ALvodWTHZkkA7TdTjh6neMOVQiY/ktluUzVinemT5+EE+cJiq9FQfhL+clj6
 46tZuVPOHgayxNGFBwBkUYJ4RIYp9tuVHyrImCbi3EovRjRRx/F9ig8Kd2ridewSwn4U
 r0Lk8YOb/fDO9w/QguPU11C8O7e4jGoKuceb2FJhMyptB912aeGqCE8Z8s64wcdAUsgT
 k7TZv+Ew8a8oVLRC49kQW+Cvu9JA/HwA6x57bbOUTrnn4HezTpl3KSahDfXbiBCEhn1A
 SYjJHR91ztgMCa06B/aZmTPGwVunhzRfFy5arOdtHC48VOnrzxEXlS1oA8qpSmIZ3q+1
 u8PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698211753; x=1698816553;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T9mieFdG9yfX1MKdeXe3uBNcgqFC4zw7yvemoQpAA3U=;
 b=Oqffa40tmNSNZaX5IrxwNtsvfsPon4pOAWHnLQEgOQGz6JH9gcIhfhSqsjWgWTNUvu
 N29IRqshufh14sw4kTXffJVLrHcVOtokrRF79Ig8ekWfKqbjLcFBDua8+RZdFZ0TIFvP
 XJC/DP7B9WbM08+5eBRaM2dN3pwsHtDYM1VGBVp9kCylX5+73orp3XCN1Z125pFsVRE8
 F57Z7LP6GdLOj310ISMdnsxzI1RorSk8VxF+MMqq+BWk0nnC1aUJQ7TzbCc71UV1562g
 JYaJl0tRXRE6gzaZE5OCIOu/LXIQrNsIoPneh4Kojygs5G0FZN3aRPNf8S4pePeuznv4
 y3vg==
X-Gm-Message-State: AOJu0YxNIw7/RJHCygRVkzMhYI2CBtbPPsMxa0xOdn9/7zKt9Ettpwjk
 cvHtTJL0uEKBn0jWqVTwYHGpKw==
X-Google-Smtp-Source: AGHT+IFkbgIhRmw46/TEEtOnVV1I6+01dAdcboedq0LwAlrSmLrXBvaz8GRpMTlwPHAvchJHj+e+KQ==
X-Received: by 2002:a05:620a:2b4d:b0:775:96c8:f560 with SMTP id
 dp13-20020a05620a2b4d00b0077596c8f560mr14376256qkb.31.1698211753335; 
 Tue, 24 Oct 2023 22:29:13 -0700 (PDT)
Received: from localhost ([157.82.204.207])
 by smtp.gmail.com with UTF8SMTPSA id
 a11-20020aa78e8b000000b006bd8f4e398csm8491094pfr.135.2023.10.24.22.29.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Oct 2023 22:29:12 -0700 (PDT)
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
Subject: [PATCH v15 16/19] plugins: Introduce CPU flags
Date: Wed, 25 Oct 2023 14:27:38 +0900
Message-ID: <20231025052744.20697-17-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231025052744.20697-1-akihiko.odaki@daynix.com>
References: <20231025052744.20697-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::731;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-qk1-x731.google.com
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

The capability to read registers is being added to plugins. Whether the
capability is enabled affects TCG translation.

Introduce "CPU flags" to represent a condition affecting TCG
translation.

The CPU flags replaces the plugin event bitmap held by CPUState; the
plugin event bitmap was needed because the presence of a
QEMU_PLUGIN_EV_VCPU_TB_TRANS callback affected TCG translation. We now
have a dedicated CPU flag for this, QEMU_PLUGIN_CPU_FLAG_CB_TRANS.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/hw/core/cpu.h  |  4 ++--
 include/qemu/plugin.h  |  2 ++
 plugins/plugin.h       |  1 +
 accel/tcg/plugin-gen.c |  2 +-
 plugins/core.c         | 26 ++++++++++++++++----------
 plugins/loader.c       |  6 ------
 6 files changed, 22 insertions(+), 19 deletions(-)

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
index 7fdc3a4849..b15fee39fd 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -16,6 +16,8 @@
 #include "exec/memopidx.h"
 #include "hw/core/cpu.h"
 
+#define QEMU_PLUGIN_CPU_FLAG_CB_TB_TRANS BIT(0)
+
 /*
  * Option parsing/processing.
  * Note that we can load an arbitrary number of plugins.
diff --git a/plugins/plugin.h b/plugins/plugin.h
index 5eb2fdbc85..db25e2650d 100644
--- a/plugins/plugin.h
+++ b/plugins/plugin.h
@@ -31,6 +31,7 @@ struct qemu_plugin_state {
      * but with the HT we avoid adding a field to CPUState.
      */
     GHashTable *cpu_ht;
+    unsigned long cpu_flags;
     DECLARE_BITMAP(mask, QEMU_PLUGIN_EV_MAX);
     /*
      * @lock protects the struct as well as ctx->uninstalling.
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 78b331b251..4870433f3a 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -796,7 +796,7 @@ bool plugin_gen_tb_start(CPUState *cpu, const DisasContextBase *db,
 {
     bool ret = false;
 
-    if (test_bit(QEMU_PLUGIN_EV_VCPU_TB_TRANS, cpu->plugin_mask)) {
+    if (cpu->plugin_flags & QEMU_PLUGIN_CPU_FLAG_CB_TB_TRANS) {
         struct qemu_plugin_tb *ptb = tcg_ctx->plugin_tb;
         int i;
 
diff --git a/plugins/core.c b/plugins/core.c
index fcd33a2bff..368e2d1f54 100644
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
+    run_on_cpu_data flags = RUN_ON_CPU_HOST_ULONG(plugin.cpu_flags);
 
     if (DEVICE(cpu)->realized) {
-        async_run_on_cpu(cpu, plugin_cpu_update__async, mask);
+        async_run_on_cpu(cpu, plugin_cpu_update__async, flags);
     } else {
-        plugin_cpu_update__async(cpu, mask);
+        plugin_cpu_update__async(cpu, flags);
     }
 }
 
@@ -84,7 +84,11 @@ void plugin_unregister_cb__locked(struct qemu_plugin_ctx *ctx,
     ctx->callbacks[ev] = NULL;
     if (QLIST_EMPTY_RCU(&plugin.cb_lists[ev])) {
         clear_bit(ev, plugin.mask);
-        g_hash_table_foreach(plugin.cpu_ht, plugin_cpu_update__locked, NULL);
+        if (ev == QEMU_PLUGIN_EV_VCPU_TB_TRANS) {
+            plugin.cpu_flags &= ~QEMU_PLUGIN_CPU_FLAG_CB_TB_TRANS;
+            g_hash_table_foreach(plugin.cpu_ht, plugin_cpu_update__locked,
+                                 NULL);
+        }
     }
 }
 
@@ -186,8 +190,10 @@ do_plugin_register_cb(qemu_plugin_id_t id, enum qemu_plugin_event ev,
             cb->udata = udata;
             ctx->callbacks[ev] = cb;
             QLIST_INSERT_HEAD_RCU(&plugin.cb_lists[ev], cb, entry);
-            if (!test_bit(ev, plugin.mask)) {
-                set_bit(ev, plugin.mask);
+            set_bit(ev, plugin.mask);
+            if (ev == QEMU_PLUGIN_EV_VCPU_TB_TRANS &&
+                !(plugin.cpu_flags & QEMU_PLUGIN_CPU_FLAG_CB_TB_TRANS)) {
+                plugin.cpu_flags |= QEMU_PLUGIN_CPU_FLAG_CB_TB_TRANS;
                 g_hash_table_foreach(plugin.cpu_ht, plugin_cpu_update__locked,
                                      NULL);
             }
@@ -334,7 +340,7 @@ void qemu_plugin_tb_trans_cb(CPUState *cpu, struct qemu_plugin_tb *tb)
     struct qemu_plugin_cb *cb, *next;
     enum qemu_plugin_event ev = QEMU_PLUGIN_EV_VCPU_TB_TRANS;
 
-    /* no plugin_mask check here; caller should have checked */
+    /* no plugin.mask check here; caller should have checked */
 
     QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
         qemu_plugin_vcpu_tb_trans_cb_t func = cb->f.vcpu_tb_trans;
@@ -357,7 +363,7 @@ qemu_plugin_vcpu_syscall(CPUState *cpu, int64_t num, uint64_t a1, uint64_t a2,
     struct qemu_plugin_cb *cb, *next;
     enum qemu_plugin_event ev = QEMU_PLUGIN_EV_VCPU_SYSCALL;
 
-    if (!test_bit(ev, cpu->plugin_mask)) {
+    if (!test_bit(ev, plugin.mask)) {
         return;
     }
 
@@ -379,7 +385,7 @@ void qemu_plugin_vcpu_syscall_ret(CPUState *cpu, int64_t num, int64_t ret)
     struct qemu_plugin_cb *cb, *next;
     enum qemu_plugin_event ev = QEMU_PLUGIN_EV_VCPU_SYSCALL_RET;
 
-    if (!test_bit(ev, cpu->plugin_mask)) {
+    if (!test_bit(ev, plugin.mask)) {
         return;
     }
 
diff --git a/plugins/loader.c b/plugins/loader.c
index 734c11cae0..2c6e60c5d0 100644
--- a/plugins/loader.c
+++ b/plugins/loader.c
@@ -37,12 +37,6 @@
 
 #include "plugin.h"
 
-/*
- * For convenience we use a bitmap for plugin.mask, but really all we need is a
- * u32, which is what we store in TranslationBlock.
- */
-QEMU_BUILD_BUG_ON(QEMU_PLUGIN_EV_MAX > 32);
-
 struct qemu_plugin_desc {
     char *path;
     char **argv;
-- 
2.42.0


