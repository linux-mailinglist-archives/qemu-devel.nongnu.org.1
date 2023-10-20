Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 436277D12A1
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 17:27:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtrOD-0003Ac-Nx; Fri, 20 Oct 2023 11:26:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qtrO9-0002xi-Na
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 11:26:13 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qtrO7-00065A-Pu
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 11:26:13 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1ca215cc713so6912625ad.3
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 08:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1697815450; x=1698420250;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EK74mlAI7dxIh9RPbUZnzOduNjpDoFgT9Je4rl8rE8M=;
 b=Tp06cpfk73vHMjWIvLCSydI5qPnzB0ZKqE+hlu0OrZ2YGhrKoFrizpEN0kljrDm3vA
 eh7ysFtxMMrDvSfJqvon7iTxBbTI5XIpEPodnCbgmErLuHX/Xy8SQvWjURAk/Pl/n61r
 pUBWFABRMa2Kon30gN8R3FlkZ578cvAL024SD5sLYXLAW3MG7CBr1xZLpCO9E5Mcr4UA
 OdNzjR1z+FWy6sKaff3KTbxrcY2A0OFGgr/G6W30COZ2Kjr13ORwdZe7cDtFGyPEkNGf
 ySoL81rtFsKFzCh/x1Z7JVvgeF37H9Qx5NeItSPdFBtDAOMJCG0CEe3IkiTNEwGVXNHj
 0a7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697815450; x=1698420250;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EK74mlAI7dxIh9RPbUZnzOduNjpDoFgT9Je4rl8rE8M=;
 b=m5GxAUlUyP+pMGSmk2uvtAyeZvCynqIxr2RwKch6T/QPyDVnt9kDI3oIDXQJaZE4/c
 8RdoByc/l6ehPOBy5Beu/bZ+yFqQa2yrPX+W0dlhPc5MwO6O+EmiiOSVvmaf7wfK+Efk
 2dl8X8H9SI7fT5UNjbBfGrGLa/bPkS5csuFUI3lre2C2wFopr/4fG9MsxMKJ0VNqvMpK
 /dfipMe2e/dZtg97FGDsbiUJj1MPr2CqxgIRGjiIEyXkMyh/8LZbtT6nGm7t1zfb30Bq
 jrF64U7UXFRZFwGpFA0yW6oztsAtBAhabzSD60BlhHqiWbiVMx9HgmMn8haHEKQg89az
 y0cA==
X-Gm-Message-State: AOJu0Yxl02wYyswAETaJIgANQLF3VXMCMF8PZ5NMUiKtD59JGbDSHMkc
 9KXxm9VTI9e8JWez08QPwLK2eUEAtd7J1ZuUkPPQ/6uM
X-Google-Smtp-Source: AGHT+IE9m22p3KPsNa5LK4QsxbS2EHuwkz9Qnj3MLGaDheJdz4HD4ZH+ZGftyNV0kHOWLT8qOFUayw==
X-Received: by 2002:a17:902:ca14:b0:1ca:8629:829b with SMTP id
 w20-20020a170902ca1400b001ca8629829bmr1781822pld.50.1697815449732; 
 Fri, 20 Oct 2023 08:24:09 -0700 (PDT)
Received: from localhost.localdomain ([171.216.79.181])
 by smtp.gmail.com with ESMTPSA id
 d4-20020a170902cec400b001c60d0a6d84sm1644824plg.127.2023.10.20.08.24.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 08:24:09 -0700 (PDT)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hyman Huang <yong.huang@smartx.com>
Subject: [v2 3/6] tests: Add migration dirty-limit capability test
Date: Fri, 20 Oct 2023 23:23:45 +0800
Message-Id: <a05e931ed147696bd5924e0582db67a734547a3f.1697815117.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1697815117.git.yong.huang@smartx.com>
References: <cover.1697815117.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::629;
 envelope-from=yong.huang@smartx.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
---
 tests/qtest/migration-test.c | 164 +++++++++++++++++++++++++++++++++++
 1 file changed, 164 insertions(+)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index e1c110537b..8f966c4d25 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -2943,6 +2943,166 @@ static void test_vcpu_dirty_limit(void)
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
@@ -3125,6 +3285,10 @@ int main(int argc, char **argv)
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


