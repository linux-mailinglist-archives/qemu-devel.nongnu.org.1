Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 91823747CB3
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 07:51:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGvOW-0005Ui-CO; Wed, 05 Jul 2023 01:49:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1qGvOJ-0005Sh-AA
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 01:49:27 -0400
Received: from mail-b.sr.ht ([173.195.146.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1qGvOG-000862-T3
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 01:49:26 -0400
Authentication-Results: mail-b.sr.ht; dkim=none 
Received: from git.sr.ht (unknown [173.195.146.142])
 by mail-b.sr.ht (Postfix) with ESMTPSA id 7F0C011F0CA;
 Wed,  5 Jul 2023 05:49:21 +0000 (UTC)
From: ~hyman <hyman@git.sr.ht>
Date: Thu, 08 Jun 2023 00:46:45 +0800
Subject: [PATCH QEMU v7 9/9] tests: Add migration dirty-limit capability test
MIME-Version: 1.0
Message-ID: <168853615963.17240.15832775267134683267-9@git.sr.ht>
X-Mailer: git.sr.ht
In-Reply-To: <168853615963.17240.15832775267134683267-0@git.sr.ht>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?utf-8?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Hyman =?utf-8?b?SHVhbmco6buE5YuHKQ==?= <yong.huang@smartx.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=173.195.146.151; envelope-from=outgoing@sr.ht;
 helo=mail-b.sr.ht
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
Reply-To: ~hyman <yong.huang@smartx.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.com>

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

Signed-off-by: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.com>
---
 tests/qtest/migration-test.c | 155 +++++++++++++++++++++++++++++++++++
 1 file changed, 155 insertions(+)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index b9cc194100..f55f95c9b0 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -2636,6 +2636,159 @@ static void test_vcpu_dirty_limit(void)
     dirtylimit_stop_vm(vm);
 }
=20
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
+ *  source               target
+ *                       migrate_incoming
+ *     migrate
+ *     migrate_cancel
+ *                       restart target
+ *     migrate
+ *
+ *  And see that if dirty limit works correctly
+ */
+static void test_migrate_dirty_limit(void)
+{
+    g_autofree char *uri =3D g_strdup_printf("unix:%s/migsocket", tmpfs);
+    QTestState *from, *to;
+    int64_t remaining;
+    uint64_t throttle_us_per_full;
+    /*
+     * We want the test to be stable and as fast as possible.
+     * E.g., with 1Gb/s bandwith migration may pass without dirty limit,
+     * so we need to decrease a bandwidth.
+     */
+    const int64_t dirtylimit_period =3D 1000, dirtylimit_value =3D 50;
+    const int64_t max_bandwidth =3D 400000000; /* ~400Mb/s */
+    const int64_t downtime_limit =3D 250; /* 250ms */
+    /*
+     * We migrate through unix-socket (> 500Mb/s).
+     * Thus, expected migration speed ~=3D bandwidth limit (< 500Mb/s).
+     * So, we can predict expected_threshold
+     */
+    const int64_t expected_threshold =3D max_bandwidth * downtime_limit / 10=
00;
+    int max_try_count =3D 10;
+    MigrateCommon args =3D {
+        .start =3D {
+            .hide_stderr =3D true,
+            .use_dirty_ring =3D true,
+        },
+        .listen_uri =3D uri,
+        .connect_uri =3D uri,
+    };
+
+    /* Start src, dst vm */
+    if (test_migrate_start(&from, &to, args.listen_uri, &args.start)) {
+        return;
+    }
+
+    /* Prepare for dirty limit migration and wait src vm show up */
+    migrate_dirty_limit_wait_showup(from, dirtylimit_period, dirtylimit_valu=
e);
+
+    /* Start migrate */
+    migrate_qmp(from, uri, "{}");
+
+    /* Wait for dirty limit throttle begin */
+    throttle_us_per_full =3D 0;
+    while (throttle_us_per_full =3D=3D 0) {
+        throttle_us_per_full =3D
+        read_migrate_property_int(from, "dirty-limit-throttle-time-per-round=
");
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
+        throttle_us_per_full =3D
+        read_migrate_property_int(from, "dirty-limit-throttle-time-per-round=
");
+        usleep(100);
+        g_assert_false(got_src_stop);
+    } while (throttle_us_per_full !=3D 0 && --max_try_count);
+
+    /* Assert dirty limit is not in service */
+    g_assert_cmpint(throttle_us_per_full, =3D=3D, 0);
+
+    args =3D (MigrateCommon) {
+        .start =3D {
+            .only_target =3D true,
+            .use_dirty_ring =3D true,
+        },
+        .listen_uri =3D uri,
+        .connect_uri =3D uri,
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
+    throttle_us_per_full =3D 0;
+    while (throttle_us_per_full =3D=3D 0) {
+        throttle_us_per_full =3D
+        read_migrate_property_int(from, "dirty-limit-throttle-time-per-round=
");
+        usleep(100);
+        g_assert_false(got_src_stop);
+    }
+
+    /*
+     * The dirty limit rate should equals the return value of
+     * query-vcpu-dirty-limit if dirty limit cap set
+     */
+    g_assert_cmpint(dirtylimit_value, =3D=3D, get_limit_rate(from));
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
+    remaining =3D read_ram_property_int(from, "remaining");
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
@@ -2847,6 +3000,8 @@ int main(int argc, char **argv)
                        test_precopy_unix_dirty_ring);
         qtest_add_func("/migration/vcpu_dirty_limit",
                        test_vcpu_dirty_limit);
+        qtest_add_func("/migration/dirty_limit",
+                       test_migrate_dirty_limit);
     }
=20
     ret =3D g_test_run();
--=20
2.38.5

