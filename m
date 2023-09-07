Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1564779717E
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 12:34:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeCKz-0005oM-9k; Thu, 07 Sep 2023 06:34:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeCKx-0005oE-Ht
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 06:34:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeCKv-0000af-8n
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 06:34:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694082847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Ssb7YDyMu2kfePCtma4X0CGR8h33cCwrLhTpDda0Cnw=;
 b=bkOwXmrmqUxnYS3Lsp3OB4uVMidSjiViCGYSMgZ61WJDyYjKMHvyLh/M7nlXzEnbyvlUTL
 6mZKzh37fqbGvJHKbBOfK+z/02U0dh/+7fsWCrFIuKo9kRHUj6ooTyXgToeuasxtT6YdjD
 KcoMCeIuCYjjXRlbEaDA0OWlRBIVw4E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-mo2WP70LOvih6FBGBjBetQ-1; Thu, 07 Sep 2023 06:34:06 -0400
X-MC-Unique: mo2WP70LOvih6FBGBjBetQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3fef3606d8cso6546315e9.1
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 03:34:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694082845; x=1694687645;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ssb7YDyMu2kfePCtma4X0CGR8h33cCwrLhTpDda0Cnw=;
 b=azNU13iqu38+cdopNT0k7SL7FqAh8xyDTVAcTwDXu+EpiQmOfYmiXHmP2inN5M3UU2
 gqd5DDq2COczkenG6HmfMBraFgnrQnMVu5aGf/qgmnz2DKmtLaNk7cUWei7hRc9ZaXnx
 pz1nL6yWIuRQMtRc0MIfwMGRFPKiH1nUUPQ0Jrf3YEZ9clYZe+kUJtFZ8jD9vx9XjyCO
 8AsfwnjWG+/WahKHtGLGevZxz0b/ktNyr1mkJMr6OoDMOyOTennXT7dxfHlIJSw1dsPY
 FRt+wSCpnvHBU5hKRP47rmlNfNI5V1H4YfhlzjY9SQLGkbRlCYS/7BwlOqBMdbRt7uhg
 Ufyw==
X-Gm-Message-State: AOJu0YwvJjlZdk5HxHb8Bocfn6Ik5DqwImlyltUCd1r5faEQRXM4EDc+
 7yM8X4uG1Dvc2w0WzkMjKAOm+HZ0wdK4MUwyXyD6bWTfqAC9vCgX3iEu5Iz8/2Uh3QZGvqy9zRD
 uAxl+hi1/tETzDJLI636E91IjWeYsRRvATXCCPyqGkC9iLXYtSJDjSObhhqqqqWhm4Id9jYRPAn
 c=
X-Received: by 2002:a7b:cb8a:0:b0:401:bf62:9456 with SMTP id
 m10-20020a7bcb8a000000b00401bf629456mr4327974wmi.8.1694082845154; 
 Thu, 07 Sep 2023 03:34:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIvTIMgusRnp0PXj2vu1okQK0ggQ4ORu/Wu6kmjcClwun9SZcoUJW8ESG8DCNGi4BTndP8LQ==
X-Received: by 2002:a7b:cb8a:0:b0:401:bf62:9456 with SMTP id
 m10-20020a7bcb8a000000b00401bf629456mr4327954wmi.8.1694082844754; 
 Thu, 07 Sep 2023 03:34:04 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312::1fc])
 by smtp.gmail.com with ESMTPSA id
 23-20020a05600c231700b003fed4fa0c19sm2149859wmo.5.2023.09.07.03.34.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 03:34:04 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
Subject: [PATCH] contrib/plugins: fix -Wformat issues
Date: Thu,  7 Sep 2023 12:34:02 +0200
Message-ID: <20230907103403.471248-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On macOS, compiling contrib/plugins incurs several -Wformat
warnings; fix them.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 contrib/plugins/cache.c    | 10 +++++-----
 contrib/plugins/drcov.c    |  2 +-
 contrib/plugins/howvec.c   |  4 ++--
 contrib/plugins/lockstep.c |  6 +++---
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/contrib/plugins/cache.c b/contrib/plugins/cache.c
index 5036213f1b8..4be909848d7 100644
--- a/contrib/plugins/cache.c
+++ b/contrib/plugins/cache.c
@@ -545,7 +545,7 @@ static void append_stats_line(GString *line, uint64_t l1_daccess,
     l1_dmiss_rate = ((double) l1_dmisses) / (l1_daccess) * 100.0;
     l1_imiss_rate = ((double) l1_imisses) / (l1_iaccess) * 100.0;
 
-    g_string_append_printf(line, "%-14lu %-12lu %9.4lf%%  %-14lu %-12lu"
+    g_string_append_printf(line, "%-14" PRIu64 " %-12" PRIu64 " %9.4lf%%  %-14" PRIu64 " %-12" PRIu64
                            " %9.4lf%%",
                            l1_daccess,
                            l1_dmisses,
@@ -556,7 +556,7 @@ static void append_stats_line(GString *line, uint64_t l1_daccess,
 
     if (use_l2) {
         l2_miss_rate =  ((double) l2_misses) / (l2_access) * 100.0;
-        g_string_append_printf(line, "  %-12lu %-11lu %10.4lf%%",
+        g_string_append_printf(line, "  %-12" PRIu64 " %-11" PRIu64 " %10.4lf%%",
                                l2_access,
                                l2_misses,
                                l2_access ? l2_miss_rate : 0.0);
@@ -662,7 +662,7 @@ static void log_top_insns(void)
         if (insn->symbol) {
             g_string_append_printf(rep, " (%s)", insn->symbol);
         }
-        g_string_append_printf(rep, ", %ld, %s\n", insn->l1_dmisses,
+        g_string_append_printf(rep, ", %" PRId64 ", %s\n", insn->l1_dmisses,
                                insn->disas_str);
     }
 
@@ -675,7 +675,7 @@ static void log_top_insns(void)
         if (insn->symbol) {
             g_string_append_printf(rep, " (%s)", insn->symbol);
         }
-        g_string_append_printf(rep, ", %ld, %s\n", insn->l1_imisses,
+        g_string_append_printf(rep, ", %" PRId64 ", %s\n", insn->l1_imisses,
                                insn->disas_str);
     }
 
@@ -692,7 +692,7 @@ static void log_top_insns(void)
         if (insn->symbol) {
             g_string_append_printf(rep, " (%s)", insn->symbol);
         }
-        g_string_append_printf(rep, ", %ld, %s\n", insn->l2_misses,
+        g_string_append_printf(rep, ", %" PRId64 ", %s\n", insn->l2_misses,
                                insn->disas_str);
     }
 
diff --git a/contrib/plugins/drcov.c b/contrib/plugins/drcov.c
index 686ae0a537d..5edc94dcaf6 100644
--- a/contrib/plugins/drcov.c
+++ b/contrib/plugins/drcov.c
@@ -48,7 +48,7 @@ static void printf_header(unsigned long count)
     uint64_t start_code = qemu_plugin_start_code();
     uint64_t end_code = qemu_plugin_end_code();
     uint64_t entry = qemu_plugin_entry_code();
-    fprintf(fp, "0, 0x%lx, 0x%lx, 0x%lx, %s\n",
+    fprintf(fp, "0, 0x%" PRIx64 ", 0x%" PRIx64 ", 0x%" PRIx64 ", %s\n",
             start_code, end_code, entry, path);
     fprintf(fp, "BB Table: %ld bbs\n", count);
 }
diff --git a/contrib/plugins/howvec.c b/contrib/plugins/howvec.c
index 0ed01ea931e..930d27bce7d 100644
--- a/contrib/plugins/howvec.c
+++ b/contrib/plugins/howvec.c
@@ -181,7 +181,7 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
         switch (class->what) {
         case COUNT_CLASS:
             if (class->count || verbose) {
-                g_string_append_printf(report, "Class: %-24s\t(%ld hits)\n",
+                g_string_append_printf(report, "Class: %-24s\t(%" PRId64 " hits)\n",
                                        class->class,
                                        class->count);
             }
@@ -208,7 +208,7 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
              i++, counts = g_list_next(counts)) {
             InsnExecCount *rec = (InsnExecCount *) counts->data;
             g_string_append_printf(report,
-                                   "Instr: %-24s\t(%ld hits)\t(op=0x%08x/%s)\n",
+                                   "Instr: %-24s\t(%" PRId64 " hits)\t(op=0x%08x/%s)\n",
                                    rec->insn,
                                    rec->count,
                                    rec->opcode,
diff --git a/contrib/plugins/lockstep.c b/contrib/plugins/lockstep.c
index 3614c3564c2..bcd3d33535c 100644
--- a/contrib/plugins/lockstep.c
+++ b/contrib/plugins/lockstep.c
@@ -134,7 +134,7 @@ static void report_divergance(ExecState *us, ExecState *them)
 
     /* Output short log entry of going out of sync... */
     if (verbose || divrec.distance == 1 || diverged) {
-        g_string_printf(out, "@ 0x%016lx vs 0x%016lx (%d/%d since last)\n",
+        g_string_printf(out, "@ 0x%016" PRIx64 " vs 0x%016" PRIx64 " (%d/%d since last)\n",
                         us->pc, them->pc, g_slist_length(divergence_log),
                         divrec.distance);
         qemu_plugin_outs(out->str);
@@ -144,7 +144,7 @@ static void report_divergance(ExecState *us, ExecState *them)
         int i;
         GSList *entry;
 
-        g_string_printf(out, "Δ insn_count @ 0x%016lx (%ld) vs 0x%016lx (%ld)\n",
+        g_string_printf(out, "Δ insn_count @ 0x%016" PRIx64 " (%ld) vs 0x%016" PRIx64 " (%ld)\n",
                         us->pc, us->insn_count, them->pc, them->insn_count);
 
         for (entry = log, i = 0;
@@ -152,7 +152,7 @@ static void report_divergance(ExecState *us, ExecState *them)
              entry = g_slist_next(entry), i++) {
             ExecInfo *prev = (ExecInfo *) entry->data;
             g_string_append_printf(out,
-                                   "  previously @ 0x%016lx/%ld (%ld insns)\n",
+                                   "  previously @ 0x%016" PRIx64 "/%" PRId64 " (%ld insns)\n",
                                    prev->block->pc, prev->block->insns,
                                    prev->insn_count);
         }
-- 
2.41.0


