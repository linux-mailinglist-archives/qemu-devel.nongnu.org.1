Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 551C88311BF
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 04:25:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQJ1F-0003k7-Jw; Wed, 17 Jan 2024 22:24:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rQJ1D-0003jl-Kt
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 22:24:39 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rQJ1B-0002pi-UX
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 22:24:39 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40e8ff22383so2068995e9.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 19:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705548275; x=1706153075; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q4Xlbv7w1QB06viMEvJrvyI5kfhMiq7AkgJexCqUX1c=;
 b=stWR7/3GPjWokEno9tr/fy8azeBY+Igq9dPuHlmt0q1VrsQJChu6g8By9LMHsaLjLR
 cPZkWoDdO81WIVy8iEeLGF5UmJZYVZ/mnYgktWRKrbXD0Usi7G4TAnlhlkSerqEELyVw
 P0BifO7N5T+XogS49qVUpdCkDA6VCAxQJvSq1MqdooGPtSLBiGfU7iVOeXbIgFVIeLuv
 X0jmKkTcV5ZuD87Xu5mWYFSWZmQHYVa6cq1p5W1M7zpIxAR16smPF2bm8yuOPKCaq5OM
 Vrj+uwkvaN3HjUKjzA5qBnQZPadrMCzGFgy8nVl36+hO4jjKqWALo5HjDvjzCEV8E0wU
 8Q8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705548275; x=1706153075;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q4Xlbv7w1QB06viMEvJrvyI5kfhMiq7AkgJexCqUX1c=;
 b=ww4CGTLzzidbzASRNybmfCA/nodNq47NX6c2UnotMUC26HPTFL0jbA4QO6UytVhNn6
 IoRYDA/jSZI+zC33ALa1BDUEkHhXKaX/xJkAR1wEOfSsDvFd7i4kxbgEblQXHI5Lqmek
 1dA0j2A/oSlky6e0GxlkOqdeugo7fDaTNqVW/eej1pvX1iI0lhZxB/Z/qawEXfGc1Nfw
 I8HN7PqXmgqwmesetfdyi04O77E4g0KwYlm93ubXxcFGyx7/7p4xVpe4W2SKKufObw/A
 nrsZOnxx8JwhUG5+QJtwMxDN05SRWlJmsmKDGid4UH3KzyJiJ6lv34W6QSnB/i6qmjXs
 9X1g==
X-Gm-Message-State: AOJu0YzSc3vOuU389OkEGzBOmJdrXP4gq35LxLuCvnwkQ5CT89YU1Os4
 k/aNn21Lu/WB/uk5qb3NC1lEjHhO5nReRFgnWNKVgrLtOEzoc0CqdAXXL8h5oluZ8KjfbCAVyra
 NrpQ=
X-Google-Smtp-Source: AGHT+IEfkjtxT+9Dm+BkcLAudkkUEw3lH5AqTVhW7JTZg6RiyAXlML9Wvb0OIx3+zVEMH872ADevAQ==
X-Received: by 2002:a05:600c:3782:b0:40d:5d9a:adc with SMTP id
 o2-20020a05600c378200b0040d5d9a0adcmr93116wmr.11.1705548275735; 
 Wed, 17 Jan 2024 19:24:35 -0800 (PST)
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 i2-20020adff302000000b0033788e357e1sm2894292wro.108.2024.01.17.19.24.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 19:24:35 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH v2 08/14] tests/plugin/bb: migrate to new per_vcpu API
Date: Thu, 18 Jan 2024 07:23:53 +0400
Message-ID: <20240118032400.3762658-9-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118032400.3762658-1-pierrick.bouvier@linaro.org>
References: <20240118032400.3762658-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x32a.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 tests/plugin/bb.c | 63 +++++++++++++++++++----------------------------
 1 file changed, 26 insertions(+), 37 deletions(-)

diff --git a/tests/plugin/bb.c b/tests/plugin/bb.c
index df50d1fd3bc..3f0c25883de 100644
--- a/tests/plugin/bb.c
+++ b/tests/plugin/bb.c
@@ -17,49 +17,51 @@
 QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
 
 typedef struct {
-    GMutex lock;
-    int index;
     uint64_t bb_count;
     uint64_t insn_count;
 } CPUCount;
 
-/* Used by the inline & linux-user counts */
-static bool do_inline;
-static CPUCount inline_count;
+static struct qemu_plugin_scoreboard *counts;
+static qemu_plugin_u64_t bb_count;
+static qemu_plugin_u64_t insn_count;
 
+static bool do_inline;
 /* Dump running CPU total on idle? */
 static bool idle_report;
-static GPtrArray *counts;
-static int max_cpus;
 
-static void gen_one_cpu_report(CPUCount *count, GString *report)
+static void gen_one_cpu_report(CPUCount *count, GString *report,
+                               unsigned int cpu_index)
 {
     if (count->bb_count) {
         g_string_append_printf(report, "CPU%d: "
                                "bb's: %" PRIu64", insns: %" PRIu64 "\n",
-                               count->index,
+                               cpu_index,
                                count->bb_count, count->insn_count);
     }
 }
 
 static void plugin_exit(qemu_plugin_id_t id, void *p)
 {
+    const unsigned int num_cpus = qemu_plugin_scoreboard_size(counts);
     g_autoptr(GString) report = g_string_new("");
 
-    if (do_inline || !max_cpus) {
-        g_string_printf(report, "bb's: %" PRIu64", insns: %" PRIu64 "\n",
-                        inline_count.bb_count, inline_count.insn_count);
-    } else {
-        g_ptr_array_foreach(counts, (GFunc) gen_one_cpu_report, report);
+    for (int i = 0; i < num_cpus; ++i) {
+        CPUCount *count = qemu_plugin_scoreboard_get(counts, i);
+        gen_one_cpu_report(count, report, i);
     }
+    g_string_append_printf(report, "Total: "
+                           "bb's: %" PRIu64", insns: %" PRIu64 "\n",
+                           qemu_plugin_u64_sum(bb_count),
+                           qemu_plugin_u64_sum(insn_count));
     qemu_plugin_outs(report->str);
+    qemu_plugin_scoreboard_free(counts);
 }
 
 static void vcpu_idle(qemu_plugin_id_t id, unsigned int cpu_index)
 {
-    CPUCount *count = g_ptr_array_index(counts, cpu_index);
+    CPUCount *count = qemu_plugin_scoreboard_get(counts, cpu_index);
     g_autoptr(GString) report = g_string_new("");
-    gen_one_cpu_report(count, report);
+    gen_one_cpu_report(count, report, cpu_index);
 
     if (report->len > 0) {
         g_string_prepend(report, "Idling ");
@@ -69,14 +71,11 @@ static void vcpu_idle(qemu_plugin_id_t id, unsigned int cpu_index)
 
 static void vcpu_tb_exec(unsigned int cpu_index, void *udata)
 {
-    CPUCount *count = max_cpus ?
-        g_ptr_array_index(counts, cpu_index) : &inline_count;
+    CPUCount *count = qemu_plugin_scoreboard_get(counts, cpu_index);
 
     uintptr_t n_insns = (uintptr_t)udata;
-    g_mutex_lock(&count->lock);
     count->insn_count += n_insns;
     count->bb_count++;
-    g_mutex_unlock(&count->lock);
 }
 
 static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
@@ -84,11 +83,10 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
     size_t n_insns = qemu_plugin_tb_n_insns(tb);
 
     if (do_inline) {
-        qemu_plugin_register_vcpu_tb_exec_inline(tb, QEMU_PLUGIN_INLINE_ADD_U64,
-                                                 &inline_count.bb_count, 1);
-        qemu_plugin_register_vcpu_tb_exec_inline(tb, QEMU_PLUGIN_INLINE_ADD_U64,
-                                                 &inline_count.insn_count,
-                                                 n_insns);
+        qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
+            tb, QEMU_PLUGIN_INLINE_ADD_U64, bb_count, 1);
+        qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
+            tb, QEMU_PLUGIN_INLINE_ADD_U64, insn_count, n_insns);
     } else {
         qemu_plugin_register_vcpu_tb_exec_cb(tb, vcpu_tb_exec,
                                              QEMU_PLUGIN_CB_NO_REGS,
@@ -121,18 +119,9 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
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
-    }
+    counts = qemu_plugin_scoreboard_new(sizeof(CPUCount));
+    bb_count = qemu_plugin_u64_struct(counts, CPUCount, bb_count);
+    insn_count = qemu_plugin_u64_struct(counts, CPUCount, insn_count);
 
     if (idle_report) {
         qemu_plugin_register_vcpu_idle_cb(id, vcpu_idle);
-- 
2.43.0


