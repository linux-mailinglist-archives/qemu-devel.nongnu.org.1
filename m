Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8543E8239C8
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 01:47:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLBs9-0008O2-Vu; Wed, 03 Jan 2024 19:46:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rLBs3-0008KA-78
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 19:46:03 -0500
Received: from mail-qk1-x72b.google.com ([2607:f8b0:4864:20::72b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rLBs0-0007Vu-TG
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 19:46:02 -0500
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-781edcbb495so2481885a.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 16:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1704329155; x=1704933955; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iV4PgkJQCBjOjHLlGt6Y0z+gHc+AIOk6/dQWg4LlpEs=;
 b=Tn4mypZQ+o8/19qGK4/rW3g+or660S2u5JL5TotLH7oxJCnmHuyO6SaW/lYxbDqb+d
 J3F0ezxIJaxuf//oxIYnrd12J6ulJ0V1Mr1jiRfNPnwHcimMAG5ZCG72bQqxMMUlsw7A
 4jFK2+uUzSDbhh3TOpC/BSy9yOKMHi2quYjd+wLFnFUDPvlGqD4D7LTgIDgLyhcs7i8M
 ZSiaL5oAu+27v41lHf2HZqZoB4vw4ROGQ/yKMDCyOIFonQdbvaO/PR0iqN6InR48FhRn
 mM+qm9VaPA7SI71TCKWXYz8pYncDY8zbeRxykpif4PO+TCioth6s0KOdOVaC069ML2Rr
 r4SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704329155; x=1704933955;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iV4PgkJQCBjOjHLlGt6Y0z+gHc+AIOk6/dQWg4LlpEs=;
 b=AU7PEod86efp9NWvCqC+cdpNzvhpwE0NxcBM58K/KHQ4ueiSLC6FZcwRpAktu6+FCU
 r6Ooy9Qa9d3hj5wG+YCr3MeLDFSEaD49MjUyVtv0Qtyh07yNMdost953hV2JZ0AVmXj4
 QcC4YKnfeStwY7N3Om9ajKIjFbZuPfTaLXSeGf2t7rJr5Vr/8WdQ1syihptHkY7aZCS0
 Bfso1ld+o+BlJcuSNQpmqg2zSbcLfGnPqgxJn44X9aPoump1TKy5/x/ZlakThmkiVb20
 VkmaIuZqKZtZNLByQ+Nv9ymAl8PcruMjaeqw+c1rwiVZs+ixrOGP2X+Mk+veduaW67qX
 X0Ow==
X-Gm-Message-State: AOJu0YxlZKulFoZsls+yxZBM1WWDdWV8tda/5cM7V55wvjT8NGwecIQU
 NtiKmnyu7b7S08ubwUXp0fzPYD69VlUVKWH0LC0flH/50O4=
X-Google-Smtp-Source: AGHT+IHZnBk+n4c0Ru5KX+LnEX6CL210BH1whDbpgqPDCqVNdrPn6WLDoXP58xPVaIBTLOHmHRTZ8Q==
X-Received: by 2002:a05:620a:100b:b0:781:72f:56fb with SMTP id
 z11-20020a05620a100b00b00781072f56fbmr15914785qkj.8.1704329155015; 
 Wed, 03 Jan 2024 16:45:55 -0800 (PST)
Received: from n231-230-216.byted.org ([147.160.184.87])
 by smtp.gmail.com with ESMTPSA id
 x19-20020ae9f813000000b0077d66e5b2e6sm10646087qkh.3.2024.01.03.16.45.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jan 2024 16:45:54 -0800 (PST)
From: Hao Xiang <hao.xiang@bytedance.com>
To: farosas@suse.de, peter.maydell@linaro.org, peterx@redhat.com,
 marcandre.lureau@redhat.com, bryan.zhang@bytedance.com,
 qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH v3 20/20] migration/multifd: Add integration tests for multifd
 with Intel DSA offloading.
Date: Thu,  4 Jan 2024 00:44:52 +0000
Message-Id: <20240104004452.324068-21-hao.xiang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240104004452.324068-1-hao.xiang@bytedance.com>
References: <20240104004452.324068-1-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72b;
 envelope-from=hao.xiang@bytedance.com; helo=mail-qk1-x72b.google.com
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
index d520c587f7..ab3db94326 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -639,6 +639,12 @@ typedef struct {
     const char *opts_target;
 } MigrateStart;
 
+/*
+ * It requires separate steps to configure and enable DSA device.
+ * This test assumes that the configuration is done already.
+ */
+static const char *dsa_dev_path = "/dev/dsa/wq4.0";
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
@@ -3466,6 +3531,16 @@ int main(int argc, char **argv)
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


