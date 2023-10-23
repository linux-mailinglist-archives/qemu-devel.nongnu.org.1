Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E797B7D4114
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 22:40:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qv1fI-0002mu-UW; Mon, 23 Oct 2023 16:36:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qv1fB-0002lp-RN
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 16:36:39 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qv1fA-0001oV-78
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 16:36:37 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DD7A21FE33;
 Mon, 23 Oct 2023 20:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698093394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LIpQJ0V6For/p0/u5J+CsEBzz8Un4GWJz64HkeebkKs=;
 b=o4EBRf86ozj+VvNIymWVjB2jwv8hIPvKf7T4vU0VrrZM6tYftSVuWU1LNYhSfJWBm3bZDV
 qK6iPc8Jd5Ih21zONqswP42HHJRS9qIuTUi8mhzUPlKv8X8sxe7rFJ7Dk+qt4Jg3CNtX88
 0DliPjywzBJmSM9CKFgIQ+ltFMfAYoE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698093394;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LIpQJ0V6For/p0/u5J+CsEBzz8Un4GWJz64HkeebkKs=;
 b=D7oVELd/r7KORX0g/y40N2/p7bvEpH2mWI7MzGD38kwxOmodpwcsueJnB3XYkrgCJLQYnu
 Iq4QLiYfikck2CDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 59B46132FD;
 Mon, 23 Oct 2023 20:36:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id UE0xCVDZNmV1JQAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 23 Oct 2023 20:36:32 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Claudio Fontana <cfontana@suse.de>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 08/29] tests/qtest: File migration auto-pause tests
Date: Mon, 23 Oct 2023 17:35:47 -0300
Message-Id: <20231023203608.26370-9-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231023203608.26370-1-farosas@suse.de>
References: <20231023203608.26370-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: 0.90
X-Spamd-Result: default: False [0.90 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_SEVEN(0.00)[10];
 MID_CONTAINS_FROM(1.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[43.90%]
Received-SPF: pass client-ip=2001:67c:2178:6::1d; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Adapt the file migration tests to take into account the auto-pause
feature.

The test currently has a flag 'stop_src' that is used to know if the
test itself should stop the VM. Add a new flag 'auto_pause' to enable
QEMU to stop the VM instead.. The two in combination allow us to
migrate a already stopped VM and check that it is still stopped on the
destination (auto-pause in effect restoring the original state).

By adding a more precise tracking of migration state changes, we can
also make sure that auto-pause is actually stopping the VM right after
qmp_migrate(), as opposed to the vm_stop() that happens at
migration_complete().

When resuming the destination a similar situation occurs, we use
'stop_src' to have a stopped VM and check that the destination does
not get a "resume" event.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-test.c | 41 ++++++++++++++++++++++++++++++------
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 88e611e98f..06a7dd3c0a 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -1679,7 +1679,7 @@ finish:
     test_migrate_end(from, to, args->result == MIG_TEST_SUCCEED);
 }
 
-static void test_file_common(MigrateCommon *args, bool stop_src)
+static void test_file_common(MigrateCommon *args, bool stop_src, bool auto_pause)
 {
     QTestState *from, *to;
     void *data_hook = NULL;
@@ -1689,6 +1689,13 @@ static void test_file_common(MigrateCommon *args, bool stop_src)
         return;
     }
 
+    migrate_set_capability(from, "events", true);
+    migrate_set_capability(to, "events", true);
+
+    if (!auto_pause) {
+        migrate_set_capability(from, "auto-pause", false);
+    }
+
     /*
      * File migration is never live. We can keep the source VM running
      * during migration, but the destination will not be running
@@ -1712,8 +1719,24 @@ static void test_file_common(MigrateCommon *args, bool stop_src)
         migrate_qmp_fail(from, connect_uri, "{}");
         goto finish;
     }
-
     migrate_qmp(from, connect_uri, "{}");
+
+    wait_for_setup(from);
+
+    /* auto-pause stops the VM right after setup */
+    if (auto_pause && !stop_src) {
+        wait_for_stop(from);
+    }
+
+    wait_for_active(from);
+
+    /*
+     * If the VM is not already stop by the test or auto-pause,
+     * migration completion will stop it.
+     */
+    if (!stop_src && !auto_pause) {
+        wait_for_stop(from);
+    }
     wait_for_migration_complete(from);
 
     /*
@@ -1721,9 +1744,15 @@ static void test_file_common(MigrateCommon *args, bool stop_src)
      * destination.
      */
     migrate_incoming_qmp(to, connect_uri, "{}");
+    wait_for_active(to);
     wait_for_migration_complete(to);
 
-    if (stop_src) {
+    if (stop_src || auto_pause) {
+        /*
+         * The VM has been paused on source by either the test or
+         * auto-pause, re-start on destination to make sure it won't
+         * crash.
+         */
         qtest_qmp_assert_success(to, "{ 'execute' : 'cont'}");
     }
 
@@ -1940,7 +1969,7 @@ static void test_precopy_file(void)
         .listen_uri = "defer",
     };
 
-    test_file_common(&args, true);
+    test_file_common(&args, true, true);
 }
 
 static void file_offset_finish_hook(QTestState *from, QTestState *to,
@@ -1984,7 +2013,7 @@ static void test_precopy_file_offset(void)
         .finish_hook = file_offset_finish_hook,
     };
 
-    test_file_common(&args, false);
+    test_file_common(&args, false, true);
 }
 
 static void test_precopy_file_offset_bad(void)
@@ -1998,7 +2027,7 @@ static void test_precopy_file_offset_bad(void)
         .result = MIG_TEST_QMP_ERROR,
     };
 
-    test_file_common(&args, false);
+    test_file_common(&args, false, false);
 }
 
 static void test_precopy_tcp_plain(void)
-- 
2.35.3


