Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 89AC582B0A0
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 15:25:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNvyV-0004M3-8c; Thu, 11 Jan 2024 09:24:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rNvyR-0004LQ-Jh
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 09:24:00 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rNvyL-0002OV-QO
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 09:23:59 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3373bc6d625so4635703f8f.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 06:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704983030; x=1705587830; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uz8JV8pCaZV1R2zPKE6qluGGJZ0UQ4yZCw51RxB81hM=;
 b=z8Fd4pSPGJDC7q+zO7bfmdtfnLXCPrj2PV4yhL7WThdkjyI4h01oN+OZdTyyTZU8fZ
 1W7eBh85Rj7Rf2rv68Tw4SkzpGTPuaM1BMAP0gR+Cd8F8bd7txxSdbwjMmbfxrozJNge
 PoEc8TwWlEvt6wsY+oYnt/YNerPueAVXJrEE48J5J06QB5gorFBWTDVVEwIDxYWVCi+p
 4ZnaQXxWhA6erbO0ahqvDRonXi/8MIiQMRTJl00mh42S+/ntBKi4vOkvEk1hHV3vVkF2
 J7li879BI6SZNg9AYsqIgz/wqAe+vRecLVT9OVT7NGEYyiobMDF6OCuf/RQMHuxOWu0q
 Bgiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704983030; x=1705587830;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Uz8JV8pCaZV1R2zPKE6qluGGJZ0UQ4yZCw51RxB81hM=;
 b=mwvRlZXpJnsU/M8j1KVcbs8P54IjTwfMDaNhmcDby/CNuvQWulfJJTxYwbFCYDXZVA
 +jAxrLuEM5NVLwT6RTTSxCOiv1wFmQXreanp6kpSYL3DYOL1DPw3BIG0/QE69TVjfc5M
 PMd307JjSIGGAvug97BNv1ost73TTilejvhmqDleRPTHOMpgbAq0Hzm0LiWqL+XHlnit
 PscJOEad5q2MT/eX5HSOuA/EYWXq5zkJ5Ae20iC4xdcv55NP3W3Xjcnl/R+KXBxky+yy
 OLHF6o+BuZh02WQd6uO766vNujIyfmeXO0j5Wqn9lEHRoDvPGVR6zd0KhmwFuqQns/pn
 yREg==
X-Gm-Message-State: AOJu0Yyj9pou2drFFn0QYPbYS9gzL1qLoS+hO/rOBTEeItWIVy6VUXxJ
 KnRNChnOIZXRR+gE6LcJ9DhVeEQPlQw1fr/sb2UHVokLri2PPw==
X-Google-Smtp-Source: AGHT+IEAH0aL1j46YIMUZVn4p6Gc+I60280gsbAE3h74CoEkGdp6MmnkQcJRPMVgWUR+rU6NWEZFMg==
X-Received: by 2002:a5d:4449:0:b0:336:96d:475c with SMTP id
 x9-20020a5d4449000000b00336096d475cmr758971wrr.5.1704983030205; 
 Thu, 11 Jan 2024 06:23:50 -0800 (PST)
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 h7-20020adff4c7000000b0033677aae2e2sm1349000wrp.107.2024.01.11.06.23.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 06:23:49 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH 03/12] tests/plugin: add test plugin for inline operations
Date: Thu, 11 Jan 2024 18:23:16 +0400
Message-ID: <20240111142326.1743444-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240111142326.1743444-1-pierrick.bouvier@linaro.org>
References: <20240111142326.1743444-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wr1-x42d.google.com
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

For now, it simply performs instruction, bb and mem count, and ensure
that inline vs callback versions have the same result. Later, we'll
extend it when new inline operations are added.

Use existing plugins to test everything works is a bit cumbersome, as
different events are treated in different plugins. Thus, this new one.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 tests/plugin/inline.c    | 183 +++++++++++++++++++++++++++++++++++++++
 tests/plugin/meson.build |   2 +-
 2 files changed, 184 insertions(+), 1 deletion(-)
 create mode 100644 tests/plugin/inline.c

diff --git a/tests/plugin/inline.c b/tests/plugin/inline.c
new file mode 100644
index 00000000000..6114ebca545
--- /dev/null
+++ b/tests/plugin/inline.c
@@ -0,0 +1,183 @@
+/*
+ * Copyright (C) 2023, Pierrick Bouvier <pierrick.bouvier@linaro.org>
+ *
+ * Demonstrates and tests usage of inline ops.
+ *
+ * License: GNU GPL, version 2 or later.
+ *   See the COPYING file in the top-level directory.
+ */
+
+#include <glib.h>
+#include <stdint.h>
+#include <stdio.h>
+
+#include <qemu-plugin.h>
+
+#define MAX_CPUS 8
+
+static uint64_t count_tb;
+static uint64_t count_tb_per_vcpu[MAX_CPUS];
+static uint64_t count_tb_inline_per_vcpu[MAX_CPUS];
+static uint64_t count_tb_inline_racy;
+static uint64_t count_insn;
+static uint64_t count_insn_per_vcpu[MAX_CPUS];
+static uint64_t count_insn_inline_per_vcpu[MAX_CPUS];
+static uint64_t count_insn_inline_racy;
+static uint64_t count_mem;
+static uint64_t count_mem_per_vcpu[MAX_CPUS];
+static uint64_t count_mem_inline_per_vcpu[MAX_CPUS];
+static uint64_t count_mem_inline_racy;
+static GMutex tb_lock;
+static GMutex insn_lock;
+static GMutex mem_lock;
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
+
+static uint64_t collect_per_vcpu(uint64_t *values)
+{
+    uint64_t count = 0;
+    for (int i = 0; i < MAX_CPUS; ++i) {
+        count += values[i];
+    }
+    return count;
+}
+
+static void stats_insn(void)
+{
+    const uint64_t expected = count_insn;
+    const uint64_t per_vcpu = collect_per_vcpu(count_insn_per_vcpu);
+    const uint64_t inl_per_vcpu = collect_per_vcpu(count_insn_inline_per_vcpu);
+    printf("insn: %" PRIu64 "\n", expected);
+    printf("insn: %" PRIu64 " (per vcpu)\n", per_vcpu);
+    printf("insn: %" PRIu64 " (per vcpu inline)\n", inl_per_vcpu);
+    printf("insn: %" PRIu64 " (inline racy)\n", count_insn_inline_racy);
+    g_assert(expected > 0);
+    g_assert(per_vcpu == expected);
+    g_assert(inl_per_vcpu == expected);
+    g_assert(count_insn_inline_racy <= expected);
+}
+
+static void stats_tb(void)
+{
+    const uint64_t expected = count_tb;
+    const uint64_t per_vcpu = collect_per_vcpu(count_tb_per_vcpu);
+    const uint64_t inl_per_vcpu = collect_per_vcpu(count_tb_inline_per_vcpu);
+    printf("tb: %" PRIu64 "\n", expected);
+    printf("tb: %" PRIu64 " (per vcpu)\n", per_vcpu);
+    printf("tb: %" PRIu64 " (per vcpu inline)\n", inl_per_vcpu);
+    printf("tb: %" PRIu64 " (inline racy)\n", count_tb_inline_racy);
+    g_assert(expected > 0);
+    g_assert(per_vcpu == expected);
+    g_assert(inl_per_vcpu == expected);
+    g_assert(count_tb_inline_racy <= expected);
+}
+
+static void stats_mem(void)
+{
+    const uint64_t expected = count_mem;
+    const uint64_t per_vcpu = collect_per_vcpu(count_mem_per_vcpu);
+    const uint64_t inl_per_vcpu = collect_per_vcpu(count_mem_inline_per_vcpu);
+    printf("mem: %" PRIu64 "\n", expected);
+    printf("mem: %" PRIu64 " (per vcpu)\n", per_vcpu);
+    printf("mem: %" PRIu64 " (per vcpu inline)\n", inl_per_vcpu);
+    printf("mem: %" PRIu64 " (inline racy)\n", count_mem_inline_racy);
+    g_assert(expected > 0);
+    g_assert(per_vcpu == expected);
+    g_assert(inl_per_vcpu == expected);
+    g_assert(count_mem_inline_racy <= expected);
+}
+
+static void plugin_exit(qemu_plugin_id_t id, void *udata)
+{
+    for (int i = 0; i < MAX_CPUS; ++i) {
+        const uint64_t tb = count_tb_per_vcpu[i];
+        const uint64_t tb_inline = count_tb_inline_per_vcpu[i];
+        const uint64_t insn = count_insn_per_vcpu[i];
+        const uint64_t insn_inline = count_insn_inline_per_vcpu[i];
+        const uint64_t mem = count_mem_per_vcpu[i];
+        const uint64_t mem_inline = count_mem_inline_per_vcpu[i];
+        printf("cpu %d: tb (%" PRIu64 ", %" PRIu64 ") | "
+               "insn (%" PRIu64 ", %" PRIu64 ") | "
+               "mem (%" PRIu64 ", %" PRIu64 ")"
+               "\n",
+               i, tb, tb_inline, insn, insn_inline, mem, mem_inline);
+        g_assert(tb == tb_inline);
+        g_assert(insn == insn_inline);
+        g_assert(mem == mem_inline);
+    }
+
+    stats_tb();
+    stats_insn();
+    stats_mem();
+}
+
+static void vcpu_tb_exec(unsigned int cpu_index, void *udata)
+{
+    count_tb_per_vcpu[cpu_index]++;
+    g_mutex_lock(&tb_lock);
+    count_tb++;
+    g_mutex_unlock(&tb_lock);
+}
+
+static void vcpu_insn_exec(unsigned int cpu_index, void *udata)
+{
+    count_insn_per_vcpu[cpu_index]++;
+    g_mutex_lock(&insn_lock);
+    count_insn++;
+    g_mutex_unlock(&insn_lock);
+}
+
+static void vcpu_mem_access(unsigned int cpu_index,
+                            qemu_plugin_meminfo_t info,
+                            uint64_t vaddr,
+                            void *userdata)
+{
+    count_mem_per_vcpu[cpu_index]++;
+    g_mutex_lock(&mem_lock);
+    count_mem++;
+    g_mutex_unlock(&mem_lock);
+}
+
+static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
+{
+    qemu_plugin_register_vcpu_tb_exec_cb(tb, vcpu_tb_exec,
+                                         QEMU_PLUGIN_CB_NO_REGS, 0);
+    qemu_plugin_register_vcpu_tb_exec_inline(tb, QEMU_PLUGIN_INLINE_ADD_U64,
+                                             &count_tb_inline_racy, 1);
+    qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
+        tb, QEMU_PLUGIN_INLINE_ADD_U64,
+        count_tb_inline_per_vcpu, sizeof(uint64_t), 1);
+
+    for (int idx = 0; idx < qemu_plugin_tb_n_insns(tb); ++idx) {
+        struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, idx);
+        qemu_plugin_register_vcpu_insn_exec_cb(insn, vcpu_insn_exec,
+                                               QEMU_PLUGIN_CB_NO_REGS, 0);
+        qemu_plugin_register_vcpu_insn_exec_inline(
+            insn, QEMU_PLUGIN_INLINE_ADD_U64,
+            &count_insn_inline_racy, 1);
+        qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
+            insn, QEMU_PLUGIN_INLINE_ADD_U64,
+            count_insn_inline_per_vcpu, sizeof(uint64_t), 1);
+        qemu_plugin_register_vcpu_mem_cb(insn, &vcpu_mem_access,
+                                         QEMU_PLUGIN_CB_NO_REGS,
+                                         QEMU_PLUGIN_MEM_RW, 0);
+        qemu_plugin_register_vcpu_mem_inline(insn, QEMU_PLUGIN_MEM_RW,
+                                             QEMU_PLUGIN_INLINE_ADD_U64,
+                                             &count_mem_inline_racy, 1);
+        qemu_plugin_register_vcpu_mem_inline_per_vcpu(
+            insn, QEMU_PLUGIN_MEM_RW,
+            QEMU_PLUGIN_INLINE_ADD_U64,
+            count_mem_inline_per_vcpu, sizeof(uint64_t), 1);
+    }
+}
+
+QEMU_PLUGIN_EXPORT
+int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
+                        int argc, char **argv)
+{
+    g_assert(info->system.smp_vcpus <= MAX_CPUS);
+    qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
+    qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
+
+    return 0;
+}
diff --git a/tests/plugin/meson.build b/tests/plugin/meson.build
index e18183aaeda..9eece5bab51 100644
--- a/tests/plugin/meson.build
+++ b/tests/plugin/meson.build
@@ -1,6 +1,6 @@
 t = []
 if get_option('plugins')
-  foreach i : ['bb', 'empty', 'insn', 'mem', 'syscall']
+  foreach i : ['bb', 'empty', 'inline', 'insn', 'mem', 'syscall']
     if host_os == 'windows'
       t += shared_module(i, files(i + '.c') + '../../contrib/plugins/win32_linker.c',
                         include_directories: '../../include/qemu',
-- 
2.43.0


