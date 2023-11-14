Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9009E7EAA32
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 06:43:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2mBo-0007Iu-7f; Tue, 14 Nov 2023 00:42:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1r2mBl-0007IS-P2
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 00:42:17 -0500
Received: from mail-qk1-x72a.google.com ([2607:f8b0:4864:20::72a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1r2mBk-0001aF-31
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 00:42:17 -0500
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-778a20df8c3so346027685a.3
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 21:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1699940535; x=1700545335; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PD8bVOanL2x2PbMmV65wnVcW5O4sSqOwwu6Aer32ebc=;
 b=GQrLHlizgMgnuD/EdL8LUTki0JN+nL49Djlg4fw0ZCSOmjikxRmhSp1iM3s7oy+oJe
 laHuDG6ax62faY81uz3HLYTHCT4ihi2tRepqXwTdH+kteWzWcusmB0HIdMfo4yMNpv2m
 sT+WZZljRrxYAEQyMOWOZSmP9XOWMafDmjF64zwASOKBc5BCtlmjBr2yy1WveFWaNzBH
 Tq/Yn+M2Vp03BrSXK0bSyfa2FzGYtNeiYmWpvxQaLBJRL8NEQ999+JcTj6TXs42PTFIW
 bAbM9ag8PmmqYvJR3D2xyMNYkSM1GveQPKC28XP2mjESaG2rJkyjFrk2v4fqZEwOUpS8
 c3fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699940535; x=1700545335;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PD8bVOanL2x2PbMmV65wnVcW5O4sSqOwwu6Aer32ebc=;
 b=ha66DzSXjnGBYt2slqzzydGOJ0RZrsrkO32S1Xy05nBjIlfFjM1YAr+FXxWhAUV328
 Qfoj3TjdrRLc/ueKwn1X5K7YwHIle5Kq7hBAqboUCdVsEOx0Aji+XIDhxEt6pFgUd44+
 SA6w9mXUPdO6Dx4RBCStv0+O+fbquh6E/Bw60JrDGet5W5h+RRZ+QpARrb6xpbMG712J
 +JDBheafqE/T3y1hVLJdvo+AfmqAzetoOtOCdpe5tnmQldYraB9ko+JZceYv32llVVYX
 FshYlC16y7H8iZUGJnmTaxoN1DwRVf1GmDwyaaZMRiUc0NgsbdBjJyrzqm8JgMX2AtF8
 auxw==
X-Gm-Message-State: AOJu0Yyr06ljACrfk6KUVZq85W1IRBu6V/ry/+o9r94B74excKTppIfN
 1kHs3uQk7VjxjxV591RVCV2XoA==
X-Google-Smtp-Source: AGHT+IFYpNTXN1qaT82DPlnCH3JSilmpGMJvP57FjLbZQQYLIorOZ1lmeUWPLNNOM1MveBNazzkSuQ==
X-Received: by 2002:a05:620a:8a8b:b0:777:1d46:fd4a with SMTP id
 qu11-20020a05620a8a8b00b007771d46fd4amr1007515qkn.29.1699940535175; 
 Mon, 13 Nov 2023 21:42:15 -0800 (PST)
Received: from n231-230-216.byted.org ([130.44.212.104])
 by smtp.gmail.com with ESMTPSA id
 w2-20020a05620a094200b0077891d2d12dsm2400367qkw.43.2023.11.13.21.42.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Nov 2023 21:42:14 -0800 (PST)
From: Hao Xiang <hao.xiang@bytedance.com>
To: farosas@suse.de, peter.maydell@linaro.org, quintela@redhat.com,
 peterx@redhat.com, marcandre.lureau@redhat.com, bryan.zhang@bytedance.com,
 qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH v2 20/20] migration/multifd: Add integration tests for multifd
 with Intel DSA offloading.
Date: Tue, 14 Nov 2023 05:40:32 +0000
Message-Id: <20231114054032.1192027-21-hao.xiang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231114054032.1192027-1-hao.xiang@bytedance.com>
References: <20231114054032.1192027-1-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72a;
 envelope-from=hao.xiang@bytedance.com; helo=mail-qk1-x72a.google.com
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

* Add test case to start and complete multifd live migration with DSA
offloading enabled.
* Add test case to start and cancel multifd live migration with DSA
offloading enabled.

Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
---
 tests/qtest/migration-test.c | 77 +++++++++++++++++++++++++++++++++++-
 1 file changed, 76 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 5752412b64..3ffbdd5a65 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -639,6 +639,12 @@ typedef struct {
     const char *opts_target;
 } MigrateStart;
 
+/*
+ * It requires separate steps to configure and enable DSA device.
+ * This test assumes that the configuration is done already.
+ */
+static const char* dsa_dev_path = "/dev/dsa/wq4.0";
+
 /*
  * A hook that runs after the src and dst QEMUs have been
  * created, but before the migration is started. This can
@@ -2775,7 +2781,7 @@ static void test_multifd_tcp_tls_x509_reject_anon_client(void)
  *
  *  And see that it works
  */
-static void test_multifd_tcp_cancel(void)
+static void test_multifd_tcp_cancel_common(bool use_dsa)
 {
     MigrateStart args = {
         .hide_stderr = true,
@@ -2796,6 +2802,10 @@ static void test_multifd_tcp_cancel(void)
     migrate_set_capability(from, "multifd", true);
     migrate_set_capability(to, "multifd", true);
 
+    if (use_dsa) {
+        migrate_set_parameter_str(from, "multifd-dsa-accel", dsa_dev_path);
+    }
+
     /* Start incoming migration from the 1st socket */
     migrate_incoming_qmp(to, "tcp:127.0.0.1:0", "{}");
 
@@ -2852,6 +2862,48 @@ static void test_multifd_tcp_cancel(void)
     test_migrate_end(from, to2, true);
 }
 
+/*
+ * This test does:
+ *  source               target
+ *                       migrate_incoming
+ *     migrate
+ *     migrate_cancel
+ *                       launch another target
+ *     migrate
+ *
+ *  And see that it works
+ */
+static void test_multifd_tcp_cancel(void)
+{
+    test_multifd_tcp_cancel_common(false);
+}
+
+#ifdef CONFIG_DSA_OPT
+
+static void *test_migrate_precopy_tcp_multifd_start_dsa(QTestState *from,
+                                                        QTestState *to)
+{
+    migrate_set_parameter_str(from, "multifd-dsa-accel", dsa_dev_path);
+    return test_migrate_precopy_tcp_multifd_start_common(from, to, "none");
+}
+
+static void test_multifd_tcp_none_dsa(void)
+{
+    MigrateCommon args = {
+        .listen_uri = "defer",
+        .start_hook = test_migrate_precopy_tcp_multifd_start_dsa,
+    };
+
+    test_precopy_common(&args);
+}
+
+static void test_multifd_tcp_cancel_dsa(void)
+{
+    test_multifd_tcp_cancel_common(true);
+}
+
+#endif
+
 static void calc_dirty_rate(QTestState *who, uint64_t calc_time)
 {
     qtest_qmp_assert_success(who,
@@ -3274,6 +3326,19 @@ static bool kvm_dirty_ring_supported(void)
 #endif
 }
 
+#ifdef CONFIG_DSA_OPT
+static int test_dsa_setup(void)
+{
+    int fd;
+    fd = open(dsa_dev_path, O_RDWR);
+    if (fd < 0) {
+        return -1;
+    }
+    close(fd);
+    return 0;
+}
+#endif
+
 int main(int argc, char **argv)
 {
     bool has_kvm, has_tcg;
@@ -3468,6 +3533,16 @@ int main(int argc, char **argv)
     }
     qtest_add_func("/migration/multifd/tcp/plain/none",
                    test_multifd_tcp_none);
+
+#ifdef CONFIG_DSA_OPT
+    if (g_str_equal(arch, "x86_64") && test_dsa_setup() == 0) {
+        qtest_add_func("/migration/multifd/tcp/plain/none/dsa",
+                       test_multifd_tcp_none_dsa);
+        qtest_add_func("/migration/multifd/tcp/plain/cancel/dsa",
+                       test_multifd_tcp_cancel_dsa);
+    }
+#endif
+
     /*
      * This test is flaky and sometimes fails in CI and otherwise:
      * don't run unless user opts in via environment variable.
-- 
2.30.2


