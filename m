Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE2182B0A4
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 15:26:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNvyt-0004SI-1a; Thu, 11 Jan 2024 09:24:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rNvyl-0004Q1-TP
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 09:24:20 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rNvyc-0002ie-Pa
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 09:24:17 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3374eb61cbcso4837049f8f.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 06:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704983044; x=1705587844; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YWE1tVGsIn0zEV+TvKSOjYsl0DanjdWaNblTi9NxIMc=;
 b=Q7ddo9eMNb/c7HnnvX0iiEmQslCFcQRu1OyxsQ2XL8gi8Z50ZTp5Pwr5n/nDv+/qvZ
 VvTCUTI85APJzO/82XGW2gNyT7AiIBZgLdfPGNovg8OgQTicJB+DPKwI+nLrOrfZ8s53
 fk+BJ0YP6cQg08TtWCn+vtl61h5XE8HBC+hWwrEb5siPLmvZdQmialIEY911Jx3pi205
 /6ulw5iA2sCjnXJdMojeUY7OmGkY7/JNELfQEigYRS3yXpUGaU9ztUI97HAVQBpDa1c7
 mHygybgYGw9M3v4tbqei0wU11uOSPG8VwO7SO2f5vPCnaKNQ5M67buhiUDM/5pUchUom
 BOCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704983044; x=1705587844;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YWE1tVGsIn0zEV+TvKSOjYsl0DanjdWaNblTi9NxIMc=;
 b=c0Scj9XYfhcLsHSviudowrv38U/R2RNuB+CgqPQYDDe5qSdpPYHkzQVmunqTwuImIJ
 ZBdLqCJUNVX6R9SE77vMo3F26HwObiKmMcQT3s7gVCXWwCoQ/ZwPIlpgPUPPKLR6Vb66
 ZUwlXe8/+20se80x+TwCyvXA3YxRnKcQjJEX0kd8aIBH5WNVGi4IEI88mUe6a8lrS3b4
 kWJiMcuGwCY23lC5/Zj/SvF4QVWQmd+2RIhTC8dknbf7d4Gb2oPNGaxYMqFuEpcKpFQG
 eHUg5ur5ZbwAWGS02sI0kp07+KJ19m/S+gKCLJAGv5HQQoUX0vRtemYQHLRD9yXLNFjQ
 kqyQ==
X-Gm-Message-State: AOJu0YxTMgON6h55QbWST1Z0hA7snKog+CHzOEJXu2XHQDf8W4VNzNz0
 mDSGd2DH5nfkAjl6Vr6jxBw62AYI4/uR+A5WKZk+poXJDo/Keg==
X-Google-Smtp-Source: AGHT+IEhVAU1KEqAlVKB3rCG+gJ/kVcvhrenPSaNuctYuC6DktDJnJg9AY05JJ8iU8A6CT7B315xrg==
X-Received: by 2002:adf:ffc8:0:b0:337:76ae:34ca with SMTP id
 x8-20020adfffc8000000b0033776ae34camr762518wrs.77.1704983044702; 
 Thu, 11 Jan 2024 06:24:04 -0800 (PST)
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 h7-20020adff4c7000000b0033677aae2e2sm1349000wrp.107.2024.01.11.06.24.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 06:24:04 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH 08/12] tests/plugin/bb: migrate to new per_vcpu API
Date: Thu, 11 Jan 2024 18:23:21 +0400
Message-ID: <20240111142326.1743444-9-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240111142326.1743444-1-pierrick.bouvier@linaro.org>
References: <20240111142326.1743444-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wr1-x431.google.com
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

Since we need a fixed offset between count memory location, we now need
a contiguous array of CPUCount (instead of array of pointers).

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 tests/plugin/bb.c | 54 +++++++++++++++++++++++------------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/tests/plugin/bb.c b/tests/plugin/bb.c
index df50d1fd3bc..644a36f3128 100644
--- a/tests/plugin/bb.c
+++ b/tests/plugin/bb.c
@@ -16,6 +16,8 @@
 
 QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
 
+#define MAX_CPUS 8
+
 typedef struct {
     GMutex lock;
     int index;
@@ -23,14 +25,10 @@ typedef struct {
     uint64_t insn_count;
 } CPUCount;
 
-/* Used by the inline & linux-user counts */
 static bool do_inline;
-static CPUCount inline_count;
-
 /* Dump running CPU total on idle? */
 static bool idle_report;
-static GPtrArray *counts;
-static int max_cpus;
+static CPUCount counts[MAX_CPUS];
 
 static void gen_one_cpu_report(CPUCount *count, GString *report)
 {
@@ -46,18 +44,26 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
 {
     g_autoptr(GString) report = g_string_new("");
 
-    if (do_inline || !max_cpus) {
+    if (do_inline) {
+        uint64_t total_bb = 0;
+        uint64_t total_insn = 0;
+        for (int i = 0; i < MAX_CPUS; ++i) {
+            total_bb += counts[i].bb_count;
+            total_insn += counts[i].insn_count;
+        }
         g_string_printf(report, "bb's: %" PRIu64", insns: %" PRIu64 "\n",
-                        inline_count.bb_count, inline_count.insn_count);
+                        total_bb, total_insn);
     } else {
-        g_ptr_array_foreach(counts, (GFunc) gen_one_cpu_report, report);
+        for (int i = 0; i < MAX_CPUS; ++i) {
+            gen_one_cpu_report(&counts[i], report);
+        }
     }
     qemu_plugin_outs(report->str);
 }
 
 static void vcpu_idle(qemu_plugin_id_t id, unsigned int cpu_index)
 {
-    CPUCount *count = g_ptr_array_index(counts, cpu_index);
+    CPUCount *count = &counts[cpu_index];
     g_autoptr(GString) report = g_string_new("");
     gen_one_cpu_report(count, report);
 
@@ -69,8 +75,7 @@ static void vcpu_idle(qemu_plugin_id_t id, unsigned int cpu_index)
 
 static void vcpu_tb_exec(unsigned int cpu_index, void *udata)
 {
-    CPUCount *count = max_cpus ?
-        g_ptr_array_index(counts, cpu_index) : &inline_count;
+    CPUCount *count = &counts[cpu_index];
 
     uintptr_t n_insns = (uintptr_t)udata;
     g_mutex_lock(&count->lock);
@@ -84,11 +89,13 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
     size_t n_insns = qemu_plugin_tb_n_insns(tb);
 
     if (do_inline) {
-        qemu_plugin_register_vcpu_tb_exec_inline(tb, QEMU_PLUGIN_INLINE_ADD_U64,
-                                                 &inline_count.bb_count, 1);
-        qemu_plugin_register_vcpu_tb_exec_inline(tb, QEMU_PLUGIN_INLINE_ADD_U64,
-                                                 &inline_count.insn_count,
-                                                 n_insns);
+        CPUCount *first_count = &counts[0];
+        qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
+            tb, QEMU_PLUGIN_INLINE_ADD_U64,
+            &first_count->bb_count, sizeof(CPUCount), 1);
+        qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
+            tb, QEMU_PLUGIN_INLINE_ADD_U64,
+            &first_count->insn_count, sizeof(CPUCount), n_insns);
     } else {
         qemu_plugin_register_vcpu_tb_exec_cb(tb, vcpu_tb_exec,
                                              QEMU_PLUGIN_CB_NO_REGS,
@@ -121,17 +128,10 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
         }
     }
 
-    if (info->system_emulation && !do_inline) {
-        max_cpus = info->system.max_vcpus;
-        counts = g_ptr_array_new();
-        for (i = 0; i < max_cpus; i++) {
-            CPUCount *count = g_new0(CPUCount, 1);
-            g_mutex_init(&count->lock);
-            count->index = i;
-            g_ptr_array_add(counts, count);
-        }
-    } else if (!do_inline) {
-        g_mutex_init(&inline_count.lock);
+    g_assert(info->system.smp_vcpus <= MAX_CPUS);
+    for (i = 0; i < MAX_CPUS; i++) {
+        CPUCount *count = &counts[i];
+        count->index = i;
     }
 
     if (idle_report) {
-- 
2.43.0


