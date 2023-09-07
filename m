Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 367C379718F
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 12:51:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeCal-00005B-I0; Thu, 07 Sep 2023 06:50:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qeCaj-000052-3A
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 06:50:29 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qeCaU-0004k4-Nz
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 06:50:28 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-401b393df02so9619055e9.1
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 03:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694083813; x=1694688613; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8UPE02/7YQA/fj5qIs0xbVE8XkqTuGFuHRJC8n+RDZU=;
 b=Kamw+vzpoLMM1mW1dUh8Qh1miJ3VtCF0wgV1MBnyJJgF8V3bfieJJGuZ1GJTD7Jt0D
 1UXEPRQJAjn8gWqRM+iE1Vnmdo60eP6Qx8rl++yde4rji8ZvJXw+mDv2fmxLV6dVyGA0
 NAWQVJa54r57jN91S4mbIT3KVbIRCKuRNEPcBN3pnI7GNyH9A7gJOo+9HDr+IJZmhowH
 RZ2epVAd0cvoNW0R72xqesLrtvvlmBYAqX3dUTh9dxp2ytHRi8fQ3uDYGF/DjA4jWuHd
 8GYniqfYfOT1ghs8oQvY7wBxGmRznHpkDza7uDP+Mg/ZPXoTjfJmuh4yg8JHB5mMynR4
 DYYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694083813; x=1694688613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8UPE02/7YQA/fj5qIs0xbVE8XkqTuGFuHRJC8n+RDZU=;
 b=PXQ+fl/KDblJBUixdbWXgVfmLdv1ly7m5F13iVbkCPIIjrRlERaWZgs0MACyzxA1KE
 v7nREcuDGrMTXu6j/guuOqpQS42RwLGkf7mJl/uo4opkzsA7PeOZvB1bEc0/YaJfrqnm
 z71y56UOo9RdNjf6OvVlpRnNFdAInx1/TMhh1OotX8JJMmtpIiDaDDlqTcC7JR5BQd7u
 Qcm6XLpm5tp/6GN99U/L1rv/rXd1YQ4iQkL7Vjyd7qg0PGR8qQVIpHNNUvK4p0lIoddw
 uGmoSOqICMKuT8i7rXHgWv/64Qcu/4qCpHAUf+UUqOHB3FBMB/46GudvU3Lb8SsqZ/K2
 qFhg==
X-Gm-Message-State: AOJu0YziN1DWgYsWsd2y9W6tK8wRlEDeMECcCsPKmSz9z8RnZNEzrWrS
 0OZUODQG6GXZWfJjbkc5LZKZyTgVZ9apksEdF10=
X-Google-Smtp-Source: AGHT+IHXS2IIZBrzkM66DRDO5YR6xvjEBRwwT/J9IpzVBROw9r0JNWQ501wr3aPPdpsMXoJ+plYxsg==
X-Received: by 2002:adf:f689:0:b0:317:5d60:2fea with SMTP id
 v9-20020adff689000000b003175d602feamr4401345wrp.52.1694083813065; 
 Thu, 07 Sep 2023 03:50:13 -0700 (PDT)
Received: from m1x-phil.lan (176-131-222-226.abo.bbox.fr. [176.131.222.226])
 by smtp.gmail.com with ESMTPSA id
 f12-20020adffccc000000b003143c9beeaesm22901440wrs.44.2023.09.07.03.50.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 07 Sep 2023 03:50:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/5] contrib/plugins/cache: Fix string format
Date: Thu,  7 Sep 2023 12:50:00 +0200
Message-ID: <20230907105004.88600-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230907105004.88600-1-philmd@linaro.org>
References: <20230907105004.88600-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This fixes on Darwin:

  plugins/cache.c:550:28: warning: format specifies type 'unsigned long' but the argument has type 'uint64_t' (aka 'unsigned long long') [-Wformat]
                             l1_daccess,
                             ^~~~~~~~~~
  plugins/cache.c:551:28: warning: format specifies type 'unsigned long' but the argument has type 'uint64_t' (aka 'unsigned long long') [-Wformat]
                             l1_dmisses,
                             ^~~~~~~~~~
  plugins/cache.c:553:28: warning: format specifies type 'unsigned long' but the argument has type 'uint64_t' (aka 'unsigned long long') [-Wformat]
                             l1_iaccess,
                             ^~~~~~~~~~
  plugins/cache.c:554:28: warning: format specifies type 'unsigned long' but the argument has type 'uint64_t' (aka 'unsigned long long') [-Wformat]
                             l1_imisses,
                             ^~~~~~~~~~
  plugins/cache.c:560:32: warning: format specifies type 'unsigned long' but the argument has type 'uint64_t' (aka 'unsigned long long') [-Wformat]
                                 l2_access,
                                 ^~~~~~~~~
  plugins/cache.c:561:32: warning: format specifies type 'unsigned long' but the argument has type 'uint64_t' (aka 'unsigned long long') [-Wformat]
                                 l2_misses,
                                 ^~~~~~~~~
  plugins/cache.c:665:52: warning: format specifies type 'long' but the argument has type 'uint64_t' (aka 'unsigned long long') [-Wformat]
          g_string_append_printf(rep, ", %ld, %s\n", insn->l1_dmisses,
                                         ~~~         ^~~~~~~~~~~~~~~~
                                         %llu
  plugins/cache.c:678:52: warning: format specifies type 'long' but the argument has type 'uint64_t' (aka 'unsigned long long') [-Wformat]
          g_string_append_printf(rep, ", %ld, %s\n", insn->l1_imisses,
                                         ~~~         ^~~~~~~~~~~~~~~~
                                         %llu
  plugins/cache.c:695:52: warning: format specifies type 'long' but the argument has type 'uint64_t' (aka 'unsigned long long') [-Wformat]
          g_string_append_printf(rep, ", %ld, %s\n", insn->l2_misses,
                                         ~~~         ^~~~~~~~~~~~~~~
                                         %llu

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 contrib/plugins/cache.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/contrib/plugins/cache.c b/contrib/plugins/cache.c
index dea4a56c8d..4fca3edd07 100644
--- a/contrib/plugins/cache.c
+++ b/contrib/plugins/cache.c
@@ -545,8 +545,8 @@ static void append_stats_line(GString *line, uint64_t l1_daccess,
     l1_dmiss_rate = ((double) l1_dmisses) / (l1_daccess) * 100.0;
     l1_imiss_rate = ((double) l1_imisses) / (l1_iaccess) * 100.0;
 
-    g_string_append_printf(line, "%-14lu %-12lu %9.4lf%%  %-14lu %-12lu"
-                           " %9.4lf%%",
+    g_string_append_printf(line, "%-14" PRIu64 " %-12" PRIu64 " %9.4lf%%"
+                           "  %-14" PRIu64 " %-12" PRIu64 " %9.4lf%%",
                            l1_daccess,
                            l1_dmisses,
                            l1_daccess ? l1_dmiss_rate : 0.0,
@@ -556,7 +556,8 @@ static void append_stats_line(GString *line, uint64_t l1_daccess,
 
     if (use_l2) {
         l2_miss_rate =  ((double) l2_misses) / (l2_access) * 100.0;
-        g_string_append_printf(line, "  %-12lu %-11lu %10.4lf%%",
+        g_string_append_printf(line,
+                               "  %-12" PRIu64 " %-11" PRIu64 " %10.4lf%%",
                                l2_access,
                                l2_misses,
                                l2_access ? l2_miss_rate : 0.0);
@@ -662,8 +663,8 @@ static void log_top_insns(void)
         if (insn->symbol) {
             g_string_append_printf(rep, " (%s)", insn->symbol);
         }
-        g_string_append_printf(rep, ", %ld, %s\n", insn->l1_dmisses,
-                               insn->disas_str);
+        g_string_append_printf(rep, ", %" PRId64 ", %s\n",
+                               insn->l1_dmisses, insn->disas_str);
     }
 
     miss_insns = g_list_sort(miss_insns, icmp);
@@ -675,8 +676,8 @@ static void log_top_insns(void)
         if (insn->symbol) {
             g_string_append_printf(rep, " (%s)", insn->symbol);
         }
-        g_string_append_printf(rep, ", %ld, %s\n", insn->l1_imisses,
-                               insn->disas_str);
+        g_string_append_printf(rep, ", %" PRId64 ", %s\n",
+                               insn->l1_imisses, insn->disas_str);
     }
 
     if (!use_l2) {
@@ -692,8 +693,8 @@ static void log_top_insns(void)
         if (insn->symbol) {
             g_string_append_printf(rep, " (%s)", insn->symbol);
         }
-        g_string_append_printf(rep, ", %ld, %s\n", insn->l2_misses,
-                               insn->disas_str);
+        g_string_append_printf(rep, ", %" PRId64 ", %s\n",
+                               insn->l2_misses, insn->disas_str);
     }
 
 finish:
-- 
2.41.0


