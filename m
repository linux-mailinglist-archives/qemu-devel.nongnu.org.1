Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA16D7DE1E3
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 15:08:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyBs3-0006WP-Sz; Wed, 01 Nov 2023 10:06:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qyBs2-0006W9-0f
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 10:06:58 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qyBs0-0004pK-8P
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 10:06:57 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1cc30bf9e22so8138935ad.1
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 07:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1698847493; x=1699452293;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SoKKZSy8bCcxji8AJ20Rtqn+SfxhXYyP1j5DNUJUxWo=;
 b=RqsebtoIsswhKyT2bVDVRkpEpzWYYM5hWYukOcHOxjgfQ6nepsfX4NLF7AEINTZOGa
 SHvP9JayFeDrtZ0NWLkOxeeAcO0LKl+9CrlzZ4rB/Kn46hDollM5WqgZjgZI6+HV5ntJ
 niwY5Au0TMRpd3Qg00+vrIMz364hmwrDjEJfdVW3PvNCqIIfbhF+zFzealTwy5EE3r8f
 nOEjFc53s2kvW0FDhaWoI7Mu292Sym/fmpyxzLXONvkYEfOI6RHZj1wBjapfFNaayRJm
 JFwDJrOwkc/R9YuQgDO6oJRdn0IYWifKb9ledo+20Zfm0QactBREKyrzxRCaF0YINNgQ
 zHYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698847493; x=1699452293;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SoKKZSy8bCcxji8AJ20Rtqn+SfxhXYyP1j5DNUJUxWo=;
 b=GiVdAH26wJw4sPiYSIdscCeyOmwy0QSdZZrui0T9JZIOg5g2c4YeoZgCACYKyyhDhF
 q+cNF5uUzltgR/zsVwshx44aQOsSwKdVfCson7Si1Z0CZGqDWVlF/5/pDEsncRnccu5Q
 R28lbGY5YTdD9l7p8NPpkFa2Tdv0HU1I5nq794yszexBUMtEcn8T/1k1PIUw/kGLukPq
 bhfvEDvjmJHqwMOckqQnHsbVzaiP/1n25grRFEyohUsDcLUH095KOiuDTz06dPfv7kjN
 hEoxZiy2BOwHmPNsjpkTqMoQ6kOevhQcGMxPJY6GnK0jqS9cS6xNGJt/AZzRwqGoPK8p
 kiow==
X-Gm-Message-State: AOJu0YzouQCsOydnW7XgoBqsP6aBggmJpiOZPVhxfNb2mEEOsV4NE0v5
 BUuqdcH++eGcH3NdCtqv77QDnimBnjuqrVzFEUswE1Kr
X-Google-Smtp-Source: AGHT+IGWq1JfMjbCp6ysRi8rMW34M/1P+wIww5KXhtY5j3TSlqm0JE1JBxbcHlUj+t6/vyKdplNxYQ==
X-Received: by 2002:a17:902:ea11:b0:1cc:4402:9e7c with SMTP id
 s17-20020a170902ea1100b001cc44029e7cmr7707403plg.15.1698847493353; 
 Wed, 01 Nov 2023 07:04:53 -0700 (PDT)
Received: from localhost.localdomain ([125.71.94.114])
 by smtp.gmail.com with ESMTPSA id
 jn7-20020a170903050700b001cc32261bdcsm1396118plb.248.2023.11.01.07.04.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 07:04:52 -0700 (PDT)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hyman Huang <yong.huang@smartx.com>
Subject: [v3 3/6] tests: Add migration dirty-limit capability test
Date: Wed,  1 Nov 2023 22:04:06 +0800
Message-Id: <e55a302df9da7dbc00ad825f47f57c1a756d303e.1698847223.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1698847223.git.yong.huang@smartx.com>
References: <cover.1698847223.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::635;
 envelope-from=yong.huang@smartx.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Add migration dirty-limit capability test if kernel support
dirty ring.

Migration dirty-limit capability introduce dirty limit
capability, two parameters: x-vcpu-dirty-limit-period and
vcpu-dirty-limit are introduced to implement the live
migration with dirty limit.

The test case does the following things:
1. start src, dst vm and enable dirty-limit capability
2. start migrate and set cancel it to check if dirty limit
   stop working.
3. restart dst vm
4. start migrate and enable dirty-limit capability
5. check if migration satisfy the convergence condition
   during pre-switchover phase.

Note that this test case involves many passes, so it runs
in slow mode only.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
Acked-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Message-Id: <a05e931ed147696bd5924e0582db67a734547a3f.1697815117.git.yong.huang@smartx.com>
---
 tests/qtest/migration-test.c | 164 +++++++++++++++++++++++++++++++++++
 1 file changed, 164 insertions(+)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index bc70a14642..0693078b07 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -2968,6 +2968,166 @@ static void test_vcpu_dirty_limit(void)
     dirtylimit_stop_vm(vm);
 }
 
+static void migrate_dirty_limit_wait_showup(QTestState *from,
+                                            const int64_t period,
+                                            const int64_t value)
+{
+    /* Enable dirty limit capability */
+    migrate_set_capability(from, "dirty-limit", true);
+
+    /* Set dirty limit parameters */
+    migrate_set_parameter_int(from, "x-vcpu-dirty-limit-period", period);
+    migrate_set_parameter_int(from, "vcpu-dirty-limit", value);
+
+    /* Make sure migrate can't converge */
+    migrate_ensure_non_converge(from);
+
+    /* To check limit rate after precopy */
+    migrate_set_capability(from, "pause-before-switchover", true);
+
+    /* Wait for the serial output from the source */
+    wait_for_serial("src_serial");
+}
+
+/*
+ * This test does:
+ *  source                          destination
+ *  start vm
+ *                                  start incoming vm
+ *  migrate
+ *  wait dirty limit to begin
+ *  cancel migrate
+ *  cancellation check
+ *                                  restart incoming vm
+ *  migrate
+ *  wait dirty limit to begin
+ *  wait pre-switchover event
+ *  convergence condition check
+ *
+ * And see if dirty limit migration works correctly.
+ * This test case involves many passes, so it runs in slow mode only.
+ */
+static void test_migrate_dirty_limit(void)
+{
+    g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
+    QTestState *from, *to;
+    int64_t remaining;
+    uint64_t throttle_us_per_full;
+    /*
+     * We want the test to be stable and as fast as possible.
+     * E.g., with 1Gb/s bandwith migration may pass without dirty limit,
+     * so we need to decrease a bandwidth.
+     */
+    const int64_t dirtylimit_period = 1000, dirtylimit_value = 50;
+    const int64_t max_bandwidth = 400000000; /* ~400Mb/s */
+    const int64_t downtime_limit = 250; /* 250ms */
+    /*
+     * We migrate through unix-socket (> 500Mb/s).
+     * Thus, expected migration speed ~= bandwidth limit (< 500Mb/s).
+     * So, we can predict expected_threshold
+     */
+    const int64_t expected_threshold = max_bandwidth * downtime_limit / 1000;
+    int max_try_count = 10;
+    MigrateCommon args = {
+        .start = {
+            .hide_stderr = true,
+            .use_dirty_ring = true,
+        },
+        .listen_uri = uri,
+        .connect_uri = uri,
+    };
+
+    /* Start src, dst vm */
+    if (test_migrate_start(&from, &to, args.listen_uri, &args.start)) {
+        return;
+    }
+
+    /* Prepare for dirty limit migration and wait src vm show up */
+    migrate_dirty_limit_wait_showup(from, dirtylimit_period, dirtylimit_value);
+
+    /* Start migrate */
+    migrate_qmp(from, uri, "{}");
+
+    /* Wait for dirty limit throttle begin */
+    throttle_us_per_full = 0;
+    while (throttle_us_per_full == 0) {
+        throttle_us_per_full =
+        read_migrate_property_int(from, "dirty-limit-throttle-time-per-round");
+        usleep(100);
+        g_assert_false(got_src_stop);
+    }
+
+    /* Now cancel migrate and wait for dirty limit throttle switch off */
+    migrate_cancel(from);
+    wait_for_migration_status(from, "cancelled", NULL);
+
+    /* Check if dirty limit throttle switched off, set timeout 1ms */
+    do {
+        throttle_us_per_full =
+        read_migrate_property_int(from, "dirty-limit-throttle-time-per-round");
+        usleep(100);
+        g_assert_false(got_src_stop);
+    } while (throttle_us_per_full != 0 && --max_try_count);
+
+    /* Assert dirty limit is not in service */
+    g_assert_cmpint(throttle_us_per_full, ==, 0);
+
+    args = (MigrateCommon) {
+        .start = {
+            .only_target = true,
+            .use_dirty_ring = true,
+        },
+        .listen_uri = uri,
+        .connect_uri = uri,
+    };
+
+    /* Restart dst vm, src vm already show up so we needn't wait anymore */
+    if (test_migrate_start(&from, &to, args.listen_uri, &args.start)) {
+        return;
+    }
+
+    /* Start migrate */
+    migrate_qmp(from, uri, "{}");
+
+    /* Wait for dirty limit throttle begin */
+    throttle_us_per_full = 0;
+    while (throttle_us_per_full == 0) {
+        throttle_us_per_full =
+        read_migrate_property_int(from, "dirty-limit-throttle-time-per-round");
+        usleep(100);
+        g_assert_false(got_src_stop);
+    }
+
+    /*
+     * The dirty limit rate should equals the return value of
+     * query-vcpu-dirty-limit if dirty limit cap set
+     */
+    g_assert_cmpint(dirtylimit_value, ==, get_limit_rate(from));
+
+    /* Now, we have tested if dirty limit works, let it converge */
+    migrate_set_parameter_int(from, "downtime-limit", downtime_limit);
+    migrate_set_parameter_int(from, "max-bandwidth", max_bandwidth);
+
+    /*
+     * Wait for pre-switchover status to check if migration
+     * satisfy the convergence condition
+     */
+    wait_for_migration_status(from, "pre-switchover", NULL);
+
+    remaining = read_ram_property_int(from, "remaining");
+    g_assert_cmpint(remaining, <,
+                    (expected_threshold + expected_threshold / 100));
+
+    migrate_continue(from, "pre-switchover");
+
+    qtest_qmp_eventwait(to, "RESUME");
+
+    wait_for_serial("dest_serial");
+    wait_for_migration_complete(from);
+
+    test_migrate_end(from, to, true);
+}
+
 static bool kvm_dirty_ring_supported(void)
 {
 #if defined(__linux__) && defined(HOST_X86_64)
@@ -3165,6 +3325,10 @@ int main(int argc, char **argv)
      */
     if (g_test_slow()) {
         qtest_add_func("/migration/auto_converge", test_migrate_auto_converge);
+        if (g_str_equal(arch, "x86_64") &&
+            has_kvm && kvm_dirty_ring_supported()) {
+            qtest_add_func("/migration/dirty_limit", test_migrate_dirty_limit);
+        }
     }
     qtest_add_func("/migration/multifd/tcp/plain/none",
                    test_multifd_tcp_none);
-- 
2.39.1


