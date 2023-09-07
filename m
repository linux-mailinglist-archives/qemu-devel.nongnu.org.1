Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 323507972C0
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 15:14:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeEdH-00034Q-AO; Thu, 07 Sep 2023 09:01:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEd2-0002sG-IG
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:01:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEcu-0007Im-HU
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:00:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694091651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YUBmQE/WZcRmgCjgL8iIiSyqO6NGliX6M17Mh1v8/jk=;
 b=O2nwXzzk1eS+Q3NUMWLDhu8pCtXrQKkLq+fLkBD44MBbszbRgls4uT+MGY7aU8OZupKk8G
 bfwQJxObBbXfm4z9kA3f9YEwWuvFoQ4hkAIkGaz6e2HKVio594J19dnH+80a48yG0znbXG
 /+Meeztp9FhWK2qt+4sru8eacg1Zveo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-dzICH9lANAiFpPb4ZWOk7A-1; Thu, 07 Sep 2023 09:00:46 -0400
X-MC-Unique: dzICH9lANAiFpPb4ZWOk7A-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-31c5c47807aso580450f8f.1
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 06:00:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694091640; x=1694696440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YUBmQE/WZcRmgCjgL8iIiSyqO6NGliX6M17Mh1v8/jk=;
 b=Wlelh/cNIvRdG5P4K8f8LbeNRh+FxbrAYU4VC0OGZGjzTzxvfXxqU9cB45PNCfek4W
 t1+ZZSgUwYAictjpNMKfGszReZsIhXFm3rDQYT605JtJDy+lTSjRkmr2h82jId50poZD
 O/M1xphFCzv6J0YfpOEfBlvjeen4q3Dy3RCDHJ6XWZM6rJsdWhMmDxx+KgoFnx50Z3Oz
 YOIwBcFLaB0oOdrW32bmgUTR72sg8fviVBHwLDQiUfvE5WB/FUbfWXubNlCRbAPsiKmY
 Pm4sR5ZlSYDCchzwPwGNIvHxyPU+yIgSRqPc10wZ8erRaaShFljDUSeHbND7V4O/z2fi
 bUZg==
X-Gm-Message-State: AOJu0YxX2bhT0NZNvzYfxq0rPpGv09NaS6CF+W1zepmOxv2Ea0EuinI1
 VgaxxYIFVxty7me/Hq034zgm8ehih0Gq5sRFGW2Fe8aRVtrMkh9sHWtvaFEf/cIiOnIdczeYJdm
 br9HhhEoTMiQG/DcIuZvxLszIxgpJEIUtb4Pacf8eYXCHWLkwztH7PZ748Zh1v9fPC5XXka6Rqj
 s=
X-Received: by 2002:adf:dc8e:0:b0:317:634c:46e9 with SMTP id
 r14-20020adfdc8e000000b00317634c46e9mr4898581wrj.43.1694091640090; 
 Thu, 07 Sep 2023 06:00:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IES1+35XqUUMoWIo7m/NtEp23RxaJLxv1trYjRr5Ecvr0/Wc6nwy7isZEt4y0e23nbLW8k1FQ==
X-Received: by 2002:adf:dc8e:0:b0:317:634c:46e9 with SMTP id
 r14-20020adfdc8e000000b00317634c46e9mr4898553wrj.43.1694091639788; 
 Thu, 07 Sep 2023 06:00:39 -0700 (PDT)
Received: from [192.168.1.174] ([151.48.237.81])
 by smtp.gmail.com with ESMTPSA id
 b4-20020adfde04000000b0031aef72a021sm23106658wrm.86.2023.09.07.06.00.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 06:00:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 15/51] contrib/plugins/cache: Fix string format
Date: Thu,  7 Sep 2023 14:59:24 +0200
Message-ID: <20230907130004.500601-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230907130004.500601-1-pbonzini@redhat.com>
References: <20230907130004.500601-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

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
Message-ID: <20230907105004.88600-2-philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 contrib/plugins/cache.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/contrib/plugins/cache.c b/contrib/plugins/cache.c
index 5036213f1b8..0b636d53ae9 100644
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


