Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F20579DBD0
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 00:23:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgBlx-0007sv-CT; Tue, 12 Sep 2023 18:22:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qgBlk-0007rA-I0
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 18:22:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qgBlg-0003Ix-BR
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 18:22:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694557319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zl3/TH1FYRm4KdD1zzJyV2raVwp2h7PrZ4uuce+spTk=;
 b=ZSyEq6mTSETnHXAz+u73sAYKtBRDZ9qYOubg+YXxs++6l1SqV+HgOQUrMhWgX0ypHan+MI
 K0zr4wuilV6wHNAHdMjavYuAm66mc0unpoR7zL5enMyW5A3kszjQuYtNukv0HUOmUvbxW6
 4VJaAObsF/fjLm2XSgt/0NlPqvpXaGc=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-fTttTI7CMoGa8k80zzQC1w-1; Tue, 12 Sep 2023 18:21:58 -0400
X-MC-Unique: fTttTI7CMoGa8k80zzQC1w-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7708c1ae500so77148285a.0
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 15:21:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694557317; x=1695162117;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zl3/TH1FYRm4KdD1zzJyV2raVwp2h7PrZ4uuce+spTk=;
 b=U2/AG0L5axGmIMVORKmKMz5ZI6Ucwf5WJhCEQATjTPtvE34S0iXNW8w8Px11NoWdhM
 KM4kLMEsMLcYGEMDX8fW/Ry0j90RSfFvJAw0MXrgaWZL4kGaWz0Ot5vLqH1SKdUGZ1MK
 N9uJPzazSUzSWcq5lXI6mGoIQkvY58GsHip11F3RlrpSROTkNIIR+9q12Qwq4Sqkw7s1
 FUA/U8Df3B4ubjgO7dDj4inecy8j+KYUJBCzXDlzLcLMkjlgUdLXL7j+11osx0cwHmcB
 hJIgf0MfGOUbtskrH1cdn/5+F57QE0s1aW1O7Ai54E1c/GMi6g4N89l4mpEfw5+3T5Rj
 koFw==
X-Gm-Message-State: AOJu0Yy2WcnlDQwdkt55bKYQDp83Pnlb7g0Q3KGJwWf3YQvFfvx/s4m0
 mvl9FIa/Du7l0SqFWKGzgcvDu6nD06j7CbY+adNFqI9zKZ0omdlfxHT/nYzAhuYl8CQc2RyTlgT
 3Q7ZbcZwOWUCcYrhHrVmxL+PcGCZOVqv5GamBB/nGNX0ziSj8NgzGX50S8kva8EU7ei552tiE
X-Received: by 2002:a05:620a:1912:b0:76f:167a:cc5d with SMTP id
 bj18-20020a05620a191200b0076f167acc5dmr659375qkb.7.1694557317638; 
 Tue, 12 Sep 2023 15:21:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1L7kKXTwFC4vvmpvIAgo/LYjAfI4+CItZFjg11+YL1mCE49oTU/rRafD7EmSlf/XshILaGA==
X-Received: by 2002:a05:620a:1912:b0:76f:167a:cc5d with SMTP id
 bj18-20020a05620a191200b0076f167acc5dmr659359qkb.7.1694557317115; 
 Tue, 12 Sep 2023 15:21:57 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 d5-20020a05620a136500b0076f206cf16fsm3494272qkl.89.2023.09.12.15.21.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 15:21:56 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Juan Quintela <quintela@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2 11/11] tests/migration-test: Add a test for postcopy hangs
 during RECOVER
Date: Tue, 12 Sep 2023 18:21:45 -0400
Message-ID: <20230912222145.731099-12-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230912222145.731099-1-peterx@redhat.com>
References: <20230912222145.731099-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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
 tests/qtest/migration-test.c | 94 ++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 1b43df5ca7..6105c2da65 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -695,6 +695,7 @@ typedef struct {
     /* Postcopy specific fields */
     void *postcopy_data;
     bool postcopy_preempt;
+    bool postcopy_recovery_test_fail;
 } MigrateCommon;
 
 static int test_migrate_start(QTestState **from, QTestState **to,
@@ -1357,6 +1358,78 @@ static void test_postcopy_preempt_tls_psk(void)
 }
 #endif
 
+static void wait_for_postcopy_status(QTestStatus *one, const char *status)
+{
+    wait_for_migration_status(from, status,
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
+    wait_for_postcopy_status(from, "postcopy-recover")
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
@@ -1396,6 +1469,15 @@ static void test_postcopy_recovery_common(MigrateCommon *args)
                               (const char * []) { "failed", "active",
                                                   "completed", NULL });
 
+    if (args->postcopy_recovery_test_fail) {
+        /*
+         * Test when a wrong socket specified for recover, and then the
+         * ability to kick it out, and continue with a correct socket.
+         */
+        postcopy_recover_fail(from, to);
+        /* continue with a good recovery */
+    }
+
     /*
      * Create a new socket to emulate a new channel that is different
      * from the broken migration channel; tell the destination to
@@ -1435,6 +1517,15 @@ static void test_postcopy_recovery_compress(void)
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
@@ -2825,6 +2916,9 @@ int main(int argc, char **argv)
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


