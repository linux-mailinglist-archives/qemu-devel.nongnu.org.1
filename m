Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B7F7CC1EA
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 13:39:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsiQ5-0003Ew-GR; Tue, 17 Oct 2023 07:39:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qsiQ1-0003Cq-WE
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 07:39:26 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qsiPz-00016V-4z
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 07:39:25 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6c7b3adbeb6so3945383a34.0
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 04:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1697542641; x=1698147441;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ehp1MYiOGlbtKEcRvBdXtOiByY73o/NtSPCzDl6hhJ8=;
 b=vBibL7CBPlNH8UhnBrgzGWT8X2krnxjuMZ41QzPgzGGqAqEZx+rkIh9h2+S/Z5ySKk
 ISCCuwPTwWCwXpbZnyW/I4CDFnrcTOUJDDK3HsinLXxlYEA9FAXZAkymm7n8+Gps+UBA
 rBQ4y5RJlCJ8qHqNL6eBiLu4lkm6hM6cHMpLkaz6Ju8WZ6xc08q04p21o7nRTUPdrpQZ
 QLqsVnxfm11jem2EZWBpGtU1k2Lt6i/ZAtyKrbnqHsFVPosOxgDVuq6NB1SSfb72n4IU
 uOr/UJgIACYxCsWg+J/va8EdsGEJJ2GDjoqA58HbI3Ar1OCUjRIVp6ZKIOWLwlMXJvHh
 KHOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697542641; x=1698147441;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ehp1MYiOGlbtKEcRvBdXtOiByY73o/NtSPCzDl6hhJ8=;
 b=jaUXSy4LwMCV7TIvqicXe6kGj40wl+PvRfArJksb6ZGrvOjl7HVbkCwyx3HSljDC1/
 qV18xFfhjEZWRl9BTbPgdJZGHjckSmnZ3wdrcPs4OQGcjbf/iQJxDjQBnz3KNtcO9l4z
 yjDGsKwq0jG1QZ10KTY49lkwq5sJ6E8zO0CMsGS2PIIRit2VwW49MKCss8xb7oGFp1+A
 XRu9NkCkT48QMf59lpxTrrruo/c8eOi+P4T+EJJxabJzT02fSFUFOmns55OU12WsHLen
 U3Ve8GNrHaql/muxpVrBbVXVWqEnFxkQOvj6cFkGDwaldUc+CwOL2t3NRcrHBRBhqVAe
 Gg4g==
X-Gm-Message-State: AOJu0Yx+0zKO9X+b1MB4Vo+CQo+V/YXfyi5SJW3Mjf1Nbzj2ahr+oi1k
 KrNdOe/GiUeXiUjPlYK8nMLL3Bgvq9nqcpDzwBmgMaAp
X-Google-Smtp-Source: AGHT+IHo4r5o67YWjySquA+A9UK/qcveypt7GXwojTLJ7wI32blG9Sc02RYWXHOTpCuOpGkWlyU3nQ==
X-Received: by 2002:a9d:7cc4:0:b0:6b9:b600:589 with SMTP id
 r4-20020a9d7cc4000000b006b9b6000589mr1916699otn.15.1697542641586; 
 Tue, 17 Oct 2023 04:37:21 -0700 (PDT)
Received: from localhost.localdomain ([171.216.79.181])
 by smtp.gmail.com with ESMTPSA id
 x28-20020aa79a5c000000b00692c5b1a731sm1198647pfj.186.2023.10.17.04.37.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 04:37:19 -0700 (PDT)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hyman Huang <yong.huang@smartx.com>
Subject: [PATCH 3/6] tests: Add migration dirty-limit capability test
Date: Tue, 17 Oct 2023 19:36:06 +0800
Message-Id: <c7c45ef33d46e9594e935a03c54a0a6f42639e17.1697502089.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1697502089.git.yong.huang@smartx.com>
References: <cover.1697502089.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::32f;
 envelope-from=yong.huang@smartx.com; helo=mail-ot1-x32f.google.com
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
---
 tests/qtest/migration-test.c | 164 +++++++++++++++++++++++++++++++++++
 1 file changed, 164 insertions(+)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 8eb2053dbb..5bd105f1a6 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -2747,6 +2747,166 @@ static void test_vcpu_dirty_limit(void)
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
@@ -2918,6 +3078,10 @@ int main(int argc, char **argv)
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


