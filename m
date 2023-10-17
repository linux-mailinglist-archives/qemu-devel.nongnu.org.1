Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE517CCE01
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 22:27:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsqeO-0000Og-PX; Tue, 17 Oct 2023 16:26:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qsqeM-0000Jj-DI
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 16:26:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qsqeK-0000lS-FE
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 16:26:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697574403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fDK+2dORsbSKQM++BPpMxFWX+JtgmThkw7TH+ydtup0=;
 b=V+nioVTKfrhQvUxNc/fkIRrtLCB6ZsW74t2octUtZNLu+HV1SwVgXBYF7m3Aqosq8F+4zA
 VIZkfyrxyw3CGiB0C5go3pBBR3OWaD9evkYyG6Yqa5/SOTa5x5FGS2selyBx0SdVuscMxq
 mhBe+UsdAyINKkRHlAKppPf+jOR/BjY=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-3JsdwfttMyKNOONIaHd6oA-1; Tue, 17 Oct 2023 16:26:39 -0400
X-MC-Unique: 3JsdwfttMyKNOONIaHd6oA-1
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-3ae112530b7so1900707b6e.0
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 13:26:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697574399; x=1698179199;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fDK+2dORsbSKQM++BPpMxFWX+JtgmThkw7TH+ydtup0=;
 b=xAkZF+FUzHst6iHVerGTGduKAXzAu7jZ9q8X0FVAKVLVBvtMx48hz9cU7n1P/5OrSx
 p3h+VDpeLwsk1eI4ufBfYRdXlfs+8XvU0ou+tmAFpXSTd87QPYg2tpNk+tnhVOarrNUY
 ivd6n8d8SGCL9R01gsvK02VGpAUohj3/C60p4CCf6l9oRuF0GOy1oiwrH7DhXYbyW7L8
 hpzT70oTL+d3Ea5djJahU09MgAGo4fEGYKt0BHKraMvAKPtD+D4rc8LR2jp+hIxH0Ssh
 /ER+iBeJTJYQA01fVrAlXoBdvGFVka9tT/0CrvX9iWVoZEM6XZhEzq1KoSGyfbXUQ/PL
 vTkg==
X-Gm-Message-State: AOJu0YwJMjW8SuWKV7HdZrmG0FI5pNhT3Oy84fyCnf0H7qxj+hPiIVcz
 6NW5/ab4l0D1a3+pu8d6FsVm1X13VO9liGM8zKYTQk8O+rBwV2cpIGy9EFnApFZUAMwirYtik1C
 imWc3JP6Z+zDBg9959nuEhRRtVkjmVapiqx5j1DhZan8fYVCzGoDvvGoCJ4zfc2Q1b9v4QCcn
X-Received: by 2002:a05:6808:17a0:b0:3ae:108d:acee with SMTP id
 bg32-20020a05680817a000b003ae108daceemr4509454oib.1.1697574398782; 
 Tue, 17 Oct 2023 13:26:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHe7g/tvUL2qMETO2koxe7j7z/7uES2LrADYTS7k0vEBWxGI6rgO6/sTlgXD5pE9mSmJiPBwg==
X-Received: by 2002:a05:6808:17a0:b0:3ae:108d:acee with SMTP id
 bg32-20020a05680817a000b003ae108daceemr4509426oib.1.1697574398301; 
 Tue, 17 Oct 2023 13:26:38 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 s17-20020ae9f711000000b0076f16e98851sm931879qkg.102.2023.10.17.13.26.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 13:26:37 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Juan Quintela <quintela@redhat.com>
Subject: [PATCH v4 3/5] tests/migration-test: Add a test for postcopy hangs
 during RECOVER
Date: Tue, 17 Oct 2023 16:26:31 -0400
Message-ID: <20231017202633.296756-4-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231017202633.296756-1-peterx@redhat.com>
References: <20231017202633.296756-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Fabiano Rosas <farosas@suse.de>

To do so, create two paired sockets, but make them not providing real data.
Feed those fake sockets to src/dst QEMUs for recovery to let them go into
RECOVER stage without going out.  Test that we can always kick it out and
recover again with the right ports.

This patch is based on Fabiano's version here:

https://lore.kernel.org/r/877cowmdu0.fsf@suse.de

Signed-off-by: Fabiano Rosas <farosas@suse.de>
[peterx: write commit message, remove case 1, fix bugs, and more]
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration-test.c | 102 ++++++++++++++++++++++++++++++++---
 1 file changed, 96 insertions(+), 6 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index e1c110537b..e81d6de000 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -726,6 +726,7 @@ typedef struct {
     /* Postcopy specific fields */
     void *postcopy_data;
     bool postcopy_preempt;
+    bool postcopy_recovery_test_fail;
 } MigrateCommon;
 
 static int test_migrate_start(QTestState **from, QTestState **to,
@@ -1379,6 +1380,78 @@ static void test_postcopy_preempt_tls_psk(void)
 }
 #endif
 
+static void wait_for_postcopy_status(QTestState *one, const char *status)
+{
+    wait_for_migration_status(one, status,
+                              (const char * []) { "failed", "active",
+                                                  "completed", NULL });
+}
+
+static void postcopy_recover_fail(QTestState *from, QTestState *to)
+{
+    int ret, pair1[2], pair2[2];
+    char c;
+
+    /* Create two unrelated socketpairs */
+    ret = qemu_socketpair(PF_LOCAL, SOCK_STREAM, 0, pair1);
+    g_assert_cmpint(ret, ==, 0);
+
+    ret = qemu_socketpair(PF_LOCAL, SOCK_STREAM, 0, pair2);
+    g_assert_cmpint(ret, ==, 0);
+
+    /*
+     * Give the guests unpaired ends of the sockets, so they'll all blocked
+     * at reading.  This mimics a wrong channel established.
+     */
+    qtest_qmp_fds_assert_success(from, &pair1[0], 1,
+                                 "{ 'execute': 'getfd',"
+                                 "  'arguments': { 'fdname': 'fd-mig' }}");
+    qtest_qmp_fds_assert_success(to, &pair2[0], 1,
+                                 "{ 'execute': 'getfd',"
+                                 "  'arguments': { 'fdname': 'fd-mig' }}");
+
+    /*
+     * Write the 1st byte as QEMU_VM_COMMAND (0x8) for the dest socket, to
+     * emulate the 1st byte of a real recovery, but stops from there to
+     * keep dest QEMU in RECOVER.  This is needed so that we can kick off
+     * the recover process on dest QEMU (by triggering the G_IO_IN event).
+     *
+     * NOTE: this trick is not needed on src QEMUs, because src doesn't
+     * rely on an pre-existing G_IO_IN event, so it will always trigger the
+     * upcoming recovery anyway even if it can read nothing.
+     */
+#define QEMU_VM_COMMAND              0x08
+    c = QEMU_VM_COMMAND;
+    ret = send(pair2[1], &c, 1, 0);
+    g_assert_cmpint(ret, ==, 1);
+
+    migrate_recover(to, "fd:fd-mig");
+    migrate_qmp(from, "fd:fd-mig", "{'resume': true}");
+
+    /*
+     * Make sure both QEMU instances will go into RECOVER stage, then test
+     * kicking them out using migrate-pause.
+     */
+    wait_for_postcopy_status(from, "postcopy-recover");
+    wait_for_postcopy_status(to, "postcopy-recover");
+
+    /*
+     * This would be issued by the admin upon noticing the hang, we should
+     * make sure we're able to kick this out.
+     */
+    migrate_pause(from);
+    wait_for_postcopy_status(from, "postcopy-paused");
+
+    /* Do the same test on dest */
+    migrate_pause(to);
+    wait_for_postcopy_status(to, "postcopy-paused");
+
+    close(pair1[0]);
+    close(pair1[1]);
+    close(pair2[0]);
+    close(pair2[1]);
+}
+
 static void test_postcopy_recovery_common(MigrateCommon *args)
 {
     QTestState *from, *to;
@@ -1414,9 +1487,17 @@ static void test_postcopy_recovery_common(MigrateCommon *args)
      * migrate-recover command can only succeed if destination machine
      * is in the paused state
      */
-    wait_for_migration_status(to, "postcopy-paused",
-                              (const char * []) { "failed", "active",
-                                                  "completed", NULL });
+    wait_for_postcopy_status(to, "postcopy-paused");
+    wait_for_postcopy_status(from, "postcopy-paused");
+
+    if (args->postcopy_recovery_test_fail) {
+        /*
+         * Test when a wrong socket specified for recover, and then the
+         * ability to kick it out, and continue with a correct socket.
+         */
+        postcopy_recover_fail(from, to);
+        /* continue with a good recovery */
+    }
 
     /*
      * Create a new socket to emulate a new channel that is different
@@ -1430,9 +1511,6 @@ static void test_postcopy_recovery_common(MigrateCommon *args)
      * Try to rebuild the migration channel using the resume flag and
      * the newly created channel
      */
-    wait_for_migration_status(from, "postcopy-paused",
-                              (const char * []) { "failed", "active",
-                                                  "completed", NULL });
     migrate_qmp(from, uri, "{'resume': true}");
 
     /* Restore the postcopy bandwidth to unlimited */
@@ -1457,6 +1535,15 @@ static void test_postcopy_recovery_compress(void)
     test_postcopy_recovery_common(&args);
 }
 
+static void test_postcopy_recovery_double_fail(void)
+{
+    MigrateCommon args = {
+        .postcopy_recovery_test_fail = true,
+    };
+
+    test_postcopy_recovery_common(&args);
+}
+
 #ifdef CONFIG_GNUTLS
 static void test_postcopy_recovery_tls_psk(void)
 {
@@ -3030,6 +3117,9 @@ int main(int argc, char **argv)
             qtest_add_func("/migration/postcopy/recovery/compress/plain",
                            test_postcopy_recovery_compress);
         }
+        qtest_add_func("/migration/postcopy/recovery/double-failures",
+                       test_postcopy_recovery_double_fail);
+
     }
 
     qtest_add_func("/migration/bad_dest", test_baddest);
-- 
2.41.0


