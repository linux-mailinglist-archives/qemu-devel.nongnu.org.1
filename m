Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 951A07D7490
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 21:41:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvjjW-0001Eq-8d; Wed, 25 Oct 2023 15:40:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1qvjjT-00015m-Nx
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 15:39:59 -0400
Received: from mail-qk1-x72c.google.com ([2607:f8b0:4864:20::72c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1qvjjP-0006Bn-QR
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 15:39:59 -0400
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7789aed0e46so10857085a.0
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 12:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1698262793; x=1698867593; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3XxU3oAzYcKmZXIlYaVmAqvLOIxUOOXKqDQ3MzE30CQ=;
 b=W7WlYCRSpTznFbyu+k5Igo5AhdoUgjA3dwcbxeUqOZ2KSVEfh62Opph2CP1TAA4EK7
 2Ry1PyXaHk8AXgiplnEjwNw9T/nbsPhQtPYKU1Hj/gNIESqXJt2kSUyAUWNuEqm1dgpD
 QdGcghg1c9v3rWbUg3ong6jgciQ0sf46fbSU86TGaoo6LCo51N94UF8X6YhVzNsHFWc2
 xSoWVIDukdp1DfgKm1Dn8Km2qwLVHaZdXP/vQGAVVIHPtPVS/845NU7Cl5NC4rQAceae
 1c6YYcUwcj3rRcJvqyJY73Dh5kk3MQpbzDSZeDb8p6mmgRoYG8DPK8q2V5qLQNLF5Sz4
 S0JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698262793; x=1698867593;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3XxU3oAzYcKmZXIlYaVmAqvLOIxUOOXKqDQ3MzE30CQ=;
 b=IJLqSeJ0zd3yEYIDfxCchQr3eKTbqkXL0LwASk4QvTImQDbg4qKmIGtI7jG3MJ80eT
 GlokYrjoHeXKkQ3BSQHd73oHJDU2OhJiVZqsznLznX3ls1pPTKArIfAvqiDC0eB2OG6B
 kfCuiLVNSpUQ2R0QrOZnmTeeQfS1zpqpNOLAbK2CFwSrAFIdU7zPn6ozFd1gA3GfGvuz
 vOjOondWroX0oylYLqDx1d0wvCw7VLay/e4s1TAJm8bA+PP9BQxn9lydeK7xDWxgIOEH
 0gmbW7/U7XrDOl5Y/8EV+g5TbxLztMXJm5m6C9nt2zfpF3LnOLch0lI+bVjk3Cdeps6D
 XyBw==
X-Gm-Message-State: AOJu0Yzs6OIPxEOCgzQ3O60IcW/dF4wpCJwJXc6pSrCOuBzXAjOCGO9P
 5KOtPy5IXmuzsfdFpWFY8nZ5kg==
X-Google-Smtp-Source: AGHT+IFD/4kuM9OYTKovknJ8MGs00PLLznX+f69oG0rk0upaAwVW/84oeVvXaq4ESQ6gX2UtLxPVvg==
X-Received: by 2002:a05:620a:880f:b0:778:9072:e45a with SMTP id
 qj15-20020a05620a880f00b007789072e45amr15730831qkn.74.1698262792872; 
 Wed, 25 Oct 2023 12:39:52 -0700 (PDT)
Received: from n231-230-216.byted.org ([147.160.184.135])
 by smtp.gmail.com with ESMTPSA id
 o8-20020a05620a228800b0076cdc3b5beasm4453721qkh.86.2023.10.25.12.39.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 12:39:52 -0700 (PDT)
From: Hao Xiang <hao.xiang@bytedance.com>
To: quintela@redhat.com, peterx@redhat.com, marcandre.lureau@redhat.com,
 bryan.zhang@bytedance.com, qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH 16/16] migration/multifd: Add integration tests for multifd
 with Intel DSA offloading.
Date: Wed, 25 Oct 2023 19:38:22 +0000
Message-Id: <20231025193822.2813204-17-hao.xiang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231025193822.2813204-1-hao.xiang@bytedance.com>
References: <20231025193822.2813204-1-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72c;
 envelope-from=hao.xiang@bytedance.com; helo=mail-qk1-x72c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

* Add test case to start and complete multifd live migration with DSA
offloading enabled.
* Add test case to start and cancel multifd live migration with DSA
offloading enabled.

Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
---
 tests/qtest/migration-test.c | 66 +++++++++++++++++++++++++++++++++++-
 1 file changed, 65 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 8eb2053dbb..f22d39e72e 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -631,6 +631,12 @@ typedef struct {
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
@@ -2431,7 +2437,7 @@ static void test_multifd_tcp_tls_x509_reject_anon_client(void)
  *
  *  And see that it works
  */
-static void test_multifd_tcp_cancel(void)
+static void test_multifd_tcp_cancel_common(bool use_dsa)
 {
     MigrateStart args = {
         .hide_stderr = true,
@@ -2452,6 +2458,10 @@ static void test_multifd_tcp_cancel(void)
     migrate_set_capability(from, "multifd", true);
     migrate_set_capability(to, "multifd", true);
 
+    if (use_dsa) {
+        migrate_set_parameter_str(from, "multifd-dsa-accel", dsa_dev_path);
+    }
+
     /* Start incoming migration from the 1st socket */
     migrate_incoming_qmp(to, "tcp:127.0.0.1:0", "{}");
 
@@ -2508,6 +2518,48 @@ static void test_multifd_tcp_cancel(void)
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
@@ -2921,6 +2973,18 @@ int main(int argc, char **argv)
     }
     qtest_add_func("/migration/multifd/tcp/plain/none",
                    test_multifd_tcp_none);
+
+#ifdef CONFIG_DSA_OPT
+    if (g_str_equal(arch, "x86_64")) {
+        qtest_add_func("/migration/multifd/tcp/plain/none/dsa",
+                       test_multifd_tcp_none_dsa);
+    }
+    if (getenv("QEMU_TEST_FLAKY_TESTS")) {
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


