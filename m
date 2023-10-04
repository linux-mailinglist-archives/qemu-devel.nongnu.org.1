Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6975B7B9718
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 00:04:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo9xQ-0004aB-Vh; Wed, 04 Oct 2023 18:03:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qo9xN-0004Nz-H1
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 18:03:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qo9xI-0003vP-E3
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 18:03:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696456975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CFhEl8wwd9dTqoVR02b8lIiRWMn2Dn8nrLJ9swljZms=;
 b=WlWPxArXgb8zM928A76fCte6Ubfakfw+0ueeZDpJIgpPduT5diFjsBq12vMTbWAz5lp+I/
 zqpHsBsdF5wXzqKSY5c2FMak/unD1ZWEglM+hD3GiRxSEPd7YUKMZ5jyrAAD3IXaLYBCpP
 I/4f/BlbkSKf2qolNvHJPVuBSYVlXpA=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-hOcWWHIsPiOLgvC22qK-DQ-1; Wed, 04 Oct 2023 18:02:54 -0400
X-MC-Unique: hOcWWHIsPiOLgvC22qK-DQ-1
Received: by mail-yb1-f198.google.com with SMTP id
 3f1490d57ef6-d81ad678f5aso78126276.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 15:02:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696456974; x=1697061774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CFhEl8wwd9dTqoVR02b8lIiRWMn2Dn8nrLJ9swljZms=;
 b=FC22RAredXj/k7xK7P51CkFDY6xpn1FazxnLdvX95SosxeJXadeBF0kcNBzYnFLV3B
 ZSn5/ornfJ5HWLysFUzpLMTchaO3PtGPOG7beSkoEiy1WZek0enuTkRraUplLX4Um1Ef
 DmDIf3i6R6Mk1SZrmtgs1Oq3lIjWAcPIKHiN10OiNb3BaNjNlsxau/IRPtOwOjbTMYpN
 XONDDVQTDN7vo2Xvb37RC+vTzWYsKBmsKH48ofz6Y4+zYZhpozqZzP2qrTK6OUKXFj4X
 a+X0Fomv1NGRECYgJiE1nRwJtExKncq9e7a+LcqSdcolheX+QMkgJoy7eK9T/SPeIKuR
 spdQ==
X-Gm-Message-State: AOJu0Yycbt8nRU0NXFuvFwNSd1N34zk7saC6tgoCQGlJmAl9ZVEban5R
 xEFOdG8HIUrdU/twdv5AokH+vjXUo9fnst2KDF7CVBas/+SgMHeVNFGCYAiaKRLfgx4/DTTPJGf
 jERr0/UOXdgddVdKCGdu38in1qltZM4TlCBMOQnarHsVa0bJ+xKYoUxUMyS9qm1apv5XWWyKj
X-Received: by 2002:a25:f446:0:b0:d90:e580:2b23 with SMTP id
 p6-20020a25f446000000b00d90e5802b23mr2776691ybe.4.1696456973824; 
 Wed, 04 Oct 2023 15:02:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeTibOH544rdIb8uLKt+bgYS98/fU7LsCvmduZr3WDm9KyEWOYeiKS8fCE3IIVZuG+2csOcw==
X-Received: by 2002:a25:f446:0:b0:d90:e580:2b23 with SMTP id
 p6-20020a25f446000000b00d90e5802b23mr2776654ybe.4.1696456973405; 
 Wed, 04 Oct 2023 15:02:53 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 w17-20020a0cdf91000000b0063d162a8b8bsm10821qvl.19.2023.10.04.15.02.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 15:02:52 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Juan Quintela <quintela@redhat.com>
Subject: [PATCH v3 10/10] tests/migration-test: Add a test for postcopy hangs
 during RECOVER
Date: Wed,  4 Oct 2023 18:02:40 -0400
Message-ID: <20231004220240.167175-11-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004220240.167175-1-peterx@redhat.com>
References: <20231004220240.167175-1-peterx@redhat.com>
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
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
index 46f1c275a2..fb7a3765e4 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -729,6 +729,7 @@ typedef struct {
     /* Postcopy specific fields */
     void *postcopy_data;
     bool postcopy_preempt;
+    bool postcopy_recovery_test_fail;
 } MigrateCommon;
 
 static int test_migrate_start(QTestState **from, QTestState **to,
@@ -1381,6 +1382,78 @@ static void test_postcopy_preempt_tls_psk(void)
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
@@ -1420,6 +1493,15 @@ static void test_postcopy_recovery_common(MigrateCommon *args)
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
@@ -1459,6 +1541,15 @@ static void test_postcopy_recovery_compress(void)
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
@@ -2841,6 +2932,9 @@ int main(int argc, char **argv)
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


