Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6338311C5
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 04:26:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQJ1D-0003jc-AJ; Wed, 17 Jan 2024 22:24:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rQJ1B-0003hl-1W
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 22:24:37 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rQJ19-0002n6-6F
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 22:24:36 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-337bcf021a4so1565600f8f.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 19:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705548273; x=1706153073; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k5p6lYRvka4FY/ZAhzAOUj9HGQolA6nHRzKa6RDIFjg=;
 b=Wq1wlxvmRvvb4VUa9r/V++mjCyC1XD7B06oBcg02qSxhyjYKHDr2Bjy7UtqgOz4PPv
 huTnZg0rjr6S+3eHqly4Tc/pqgOfd+oh7E5NFDpqgjw3a/tFD8Z2BC1nYwvsrYe/xoX7
 NLH0yjtoCgakn/F6gL3O/1cwdywItvbEb6KObP2yVB/EE5TFIaScfWr2EI+jaJApcjh2
 WA5PIw0Hm1QrteUBJS0Tz5Y0TlDrQeP26l8gq67ZuHR/WHyIFJ49jwPtbNkrLpN1qklB
 cB3Uj/JND6qMqGTNXJoTitBScBFt7ohCM9jqFiUKop1enGi/9EOVMtHvrW7/YQWw+2CT
 q0zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705548273; x=1706153073;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k5p6lYRvka4FY/ZAhzAOUj9HGQolA6nHRzKa6RDIFjg=;
 b=BqxzWdQF3chRC0dNUjzczzaOiWbNfPFRuEkNloWHvIctB7jRiYZZNGAHUmub9kz/JT
 1x6mrYjX9zDZAB/u2FwpyPaJNrvn+kwfNr/7nIy8pAzwiP/S5weB40uftpCIPhGv5TeR
 ajBNhjPlxkkFJ+b3xX2+uJuemwIXnklDzprt2kkmhi7RWUPoI8QPPl2P4mppoLDLgKTS
 rIvyHrTMzN9dBYS+H74Ubw4mfR03YUURuKz8huQReHPanS3u47XhjRaj46xH3dB02Ld/
 TSx5wHFeQMaOkOp8zyMu+toYquP1Mt8a6uOulHQbaxheZJ1BRnrw6LYXDcT3DMp23sUq
 xfnw==
X-Gm-Message-State: AOJu0YwNgOWAsG1nCKvdL5gFuTwB72TjgzB2RVkN4hFGCAjtj1wOsDhF
 GB2MkvKfG6qtLvxBJ2plVb91Jouko4jHyG2qqlJiZmGITz+EOs/FEA2cgi1I9PTYMQw5TF+0UXn
 5G7s=
X-Google-Smtp-Source: AGHT+IGto5q+5YhCAl9bMtsHInwsM5QzW3owJ9QbLEu2YLz895yiENMBWNnpmFihktFSrggdyM473g==
X-Received: by 2002:adf:d1e7:0:b0:337:5588:801f with SMTP id
 g7-20020adfd1e7000000b003375588801fmr105820wrd.57.1705548273147; 
 Wed, 17 Jan 2024 19:24:33 -0800 (PST)
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 i2-20020adff302000000b0033788e357e1sm2894292wro.108.2024.01.17.19.24.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 19:24:32 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH v2 07/14] tests/plugin/insn: migrate to new per_vcpu API
Date: Thu, 18 Jan 2024 07:23:52 +0400
Message-ID: <20240118032400.3762658-8-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118032400.3762658-1-pierrick.bouvier@linaro.org>
References: <20240118032400.3762658-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wr1-x433.google.com
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
 tests/plugin/insn.c | 106 +++++++++++++++++++++-----------------------
 1 file changed, 50 insertions(+), 56 deletions(-)

diff --git a/tests/plugin/insn.c b/tests/plugin/insn.c
index 5fd3017c2b3..6fff51121d4 100644
--- a/tests/plugin/insn.c
+++ b/tests/plugin/insn.c
@@ -16,25 +16,21 @@
 
 QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
 
-#define MAX_CPUS 8 /* lets not go nuts */
-
-typedef struct {
-    uint64_t insn_count;
-} InstructionCount;
-
-static InstructionCount counts[MAX_CPUS];
-static uint64_t inline_insn_count;
+static qemu_plugin_u64_t insn_count;
 
 static bool do_inline;
 static bool do_size;
 static GArray *sizes;
 
+typedef struct {
+    uint64_t hits;
+    uint64_t last_hit;
+    uint64_t total_delta;
+} MatchCount;
+
 typedef struct {
     char *match_string;
-    uint64_t hits[MAX_CPUS];
-    uint64_t last_hit[MAX_CPUS];
-    uint64_t total_delta[MAX_CPUS];
-    GPtrArray *history[MAX_CPUS];
+    struct qemu_plugin_scoreboard *counts; /* MatchCount */
 } Match;
 
 static GArray *matches;
@@ -48,41 +44,40 @@ typedef struct {
 
 static void vcpu_insn_exec_before(unsigned int cpu_index, void *udata)
 {
-    unsigned int i = cpu_index % MAX_CPUS;
-    InstructionCount *c = &counts[i];
-
-    c->insn_count++;
+    (*qemu_plugin_u64_get(insn_count, cpu_index))++;
 }
 
 static void vcpu_insn_matched_exec_before(unsigned int cpu_index, void *udata)
 {
-    unsigned int i = cpu_index % MAX_CPUS;
     Instruction *insn = (Instruction *) udata;
-    Match *match = insn->match;
+    Match *insn_match = insn->match;
+    MatchCount *match = qemu_plugin_scoreboard_get(insn_match->counts,
+                                                   cpu_index);
+
     g_autoptr(GString) ts = g_string_new("");
 
     insn->hits++;
     g_string_append_printf(ts, "0x%" PRIx64 ", '%s', %"PRId64 " hits",
                            insn->vaddr, insn->disas, insn->hits);
 
-    uint64_t icount = counts[i].insn_count;
-    uint64_t delta = icount - match->last_hit[i];
+    uint64_t icount = *qemu_plugin_u64_get(insn_count, cpu_index);
+    uint64_t delta = icount - match->last_hit;
 
-    match->hits[i]++;
-    match->total_delta[i] += delta;
+    match->hits++;
+    match->total_delta += delta;
 
     g_string_append_printf(ts,
-                           ", %"PRId64" match hits, "
-                           "Δ+%"PRId64 " since last match,"
+                           " , cpu %u,"
+                           " %"PRId64" match hits,"
+                           " Δ+%"PRId64 " since last match,"
                            " %"PRId64 " avg insns/match\n",
-                           match->hits[i], delta,
-                           match->total_delta[i] / match->hits[i]);
+                           cpu_index,
+                           match->hits, delta,
+                           match->total_delta / match->hits);
 
-    match->last_hit[i] = icount;
+    match->last_hit = icount;
 
     qemu_plugin_outs(ts->str);
-
-    g_ptr_array_add(match->history[i], insn);
 }
 
 static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
@@ -94,8 +89,8 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
         struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);
 
         if (do_inline) {
-            qemu_plugin_register_vcpu_insn_exec_inline(
-                insn, QEMU_PLUGIN_INLINE_ADD_U64, &inline_insn_count, 1);
+            qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
+                insn, QEMU_PLUGIN_INLINE_ADD_U64, insn_count, 1);
         } else {
             uint64_t vaddr = qemu_plugin_insn_vaddr(insn);
             qemu_plugin_register_vcpu_insn_exec_cb(
@@ -117,10 +112,9 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
          * information about the instruction which we also need to
          * save if there is a hit.
          */
-        if (matches) {
+        if (matches->len) {
             char *insn_disas = qemu_plugin_insn_disas(insn);
-            int j;
-            for (j = 0; j < matches->len; j++) {
+            for (int j = 0; j < matches->len; j++) {
                 Match *m = &g_array_index(matches, Match, j);
                 if (g_str_has_prefix(insn_disas, m->match_string)) {
                     Instruction *rec = g_new0(Instruction, 1);
@@ -150,36 +144,34 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
                                        "len %d bytes: %ld insns\n", i, *cnt);
             }
         }
-    } else if (do_inline) {
-        g_string_append_printf(out, "insns: %" PRIu64 "\n", inline_insn_count);
     } else {
-        uint64_t total_insns = 0;
-        for (i = 0; i < MAX_CPUS; i++) {
-            InstructionCount *c = &counts[i];
-            if (c->insn_count) {
-                g_string_append_printf(out, "cpu %d insns: %" PRIu64 "\n",
-                                       i, c->insn_count);
-                total_insns += c->insn_count;
-            }
+        unsigned int num_cpus = qemu_plugin_scoreboard_size(insn_count.score);
+        for (i = 0; i < num_cpus; i++) {
+            g_string_append_printf(out, "cpu %d insns: %" PRIu64 "\n",
+                                   i, *qemu_plugin_u64_get(insn_count, i));
         }
         g_string_append_printf(out, "total insns: %" PRIu64 "\n",
-                               total_insns);
+                               qemu_plugin_u64_sum(insn_count));
     }
     qemu_plugin_outs(out->str);
+
+    qemu_plugin_scoreboard_free(insn_count.score);
+    for (i = 0; i < matches->len; ++i) {
+        Match *m = &g_array_index(matches, Match, i);
+        g_free(m->match_string);
+        qemu_plugin_scoreboard_free(m->counts);
+    }
+    g_array_free(matches, TRUE);
+    g_array_free(sizes, TRUE);
 }
 
 
 /* Add a match to the array of matches */
 static void parse_match(char *match)
 {
-    Match new_match = { .match_string = match };
-    int i;
-    for (i = 0; i < MAX_CPUS; i++) {
-        new_match.history[i] = g_ptr_array_new();
-    }
-    if (!matches) {
-        matches = g_array_new(false, true, sizeof(Match));
-    }
+    Match new_match = {
+        .match_string = g_strdup(match),
+        .counts = qemu_plugin_scoreboard_new(sizeof(MatchCount)) };
     g_array_append_val(matches, new_match);
 }
 
@@ -187,6 +179,10 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
                                            const qemu_info_t *info,
                                            int argc, char **argv)
 {
+    matches = g_array_new(false, true, sizeof(Match));
+    /* null terminated so 0 is not a special case */
+    sizes = g_array_new(true, true, sizeof(unsigned long));
+
     for (int i = 0; i < argc; i++) {
         char *opt = argv[i];
         g_auto(GStrv) tokens = g_strsplit(opt, "=", 2);
@@ -208,9 +204,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
         }
     }
 
-    if (do_size) {
-        sizes = g_array_new(true, true, sizeof(unsigned long));
-    }
+    insn_count = qemu_plugin_u64(qemu_plugin_scoreboard_new(sizeof(uint64_t)));
 
     qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
-- 
2.43.0


