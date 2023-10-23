Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D287D4107
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 22:39:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qv1ez-0002j5-VS; Mon, 23 Oct 2023 16:36:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qv1ex-0002ie-By
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 16:36:23 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qv1es-0001mk-95
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 16:36:20 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4697521B24;
 Mon, 23 Oct 2023 20:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698093376; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2SO3JnEnMhOQJ8CPQPJIKFKAyEl5rYqk1sj5JESuE5w=;
 b=GY0XD0a7RJWyIJ0I+FIxKmLZwVuSoYtbzOyz7e/Dgf0DvGpXwOyczDtCsohPj6PE8BCiVb
 sw4t6cRqdYtH6++UzbzaNnxbNQnYR7TN9bR9kcHpbx3OJdTl+Ak6zazG21FLIMHB+lYsLE
 l2iXy6hEy970pqjSv4wlw5JvcgNCSMg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698093376;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2SO3JnEnMhOQJ8CPQPJIKFKAyEl5rYqk1sj5JESuE5w=;
 b=k9ilP6I/mT0tqPOVR/LcoPNoO3u4wzyG/FbHUN2jmoZP3n2xRpTmXNP13xrDXb6Fz5in7/
 4wn6LhDwHR7B2XCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 81A7B132FD;
 Mon, 23 Oct 2023 20:36:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 6HdREj3ZNmV1JQAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 23 Oct 2023 20:36:13 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Claudio Fontana <cfontana@suse.de>,
 Steve Sistare <steven.sistare@oracle.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 01/29] tests/qtest: migration events
Date: Mon, 23 Oct 2023 17:35:40 -0300
Message-Id: <20231023203608.26370-2-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231023203608.26370-1-farosas@suse.de>
References: <20231023203608.26370-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -2.10
X-Spamd-Result: default: False [-2.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_SEVEN(0.00)[11];
 MID_CONTAINS_FROM(1.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
Received-SPF: pass client-ip=195.135.220.28; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

From: Steve Sistare <steven.sistare@oracle.com>

Define a state object to capture events seen by migration tests, to allow
more events to be captured in a subsequent patch, and simplify event
checking in wait_for_migration_pass.  No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 tests/qtest/migration-helpers.c | 24 ++++-------
 tests/qtest/migration-helpers.h |  8 ++--
 tests/qtest/migration-test.c    | 74 +++++++++++++++------------------
 3 files changed, 46 insertions(+), 60 deletions(-)

diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index 24fb7b3525..fd3b94efa2 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -24,26 +24,16 @@
  */
 #define MIGRATION_STATUS_WAIT_TIMEOUT 120
 
-bool migrate_watch_for_stop(QTestState *who, const char *name,
-                            QDict *event, void *opaque)
-{
-    bool *seen = opaque;
-
-    if (g_str_equal(name, "STOP")) {
-        *seen = true;
-        return true;
-    }
-
-    return false;
-}
-
-bool migrate_watch_for_resume(QTestState *who, const char *name,
+bool migrate_watch_for_events(QTestState *who, const char *name,
                               QDict *event, void *opaque)
 {
-    bool *seen = opaque;
+    QTestMigrationState *state = opaque;
 
-    if (g_str_equal(name, "RESUME")) {
-        *seen = true;
+    if (g_str_equal(name, "STOP")) {
+        state->stop_seen = true;
+        return true;
+    } else if (g_str_equal(name, "RESUME")) {
+        state->resume_seen = true;
         return true;
     }
 
diff --git a/tests/qtest/migration-helpers.h b/tests/qtest/migration-helpers.h
index e31dc85cc7..c1d4c84995 100644
--- a/tests/qtest/migration-helpers.h
+++ b/tests/qtest/migration-helpers.h
@@ -15,9 +15,11 @@
 
 #include "libqtest.h"
 
-bool migrate_watch_for_stop(QTestState *who, const char *name,
-                            QDict *event, void *opaque);
-bool migrate_watch_for_resume(QTestState *who, const char *name,
+typedef struct QTestMigrationState {
+    bool stop_seen, resume_seen;
+} QTestMigrationState;
+
+bool migrate_watch_for_events(QTestState *who, const char *name,
                               QDict *event, void *opaque);
 
 G_GNUC_PRINTF(3, 4)
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 35e0ded9d7..0425d1d527 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -43,8 +43,8 @@
 unsigned start_address;
 unsigned end_address;
 static bool uffd_feature_thread_id;
-static bool got_src_stop;
-static bool got_dst_resume;
+static QTestMigrationState src_state;
+static QTestMigrationState dst_state;
 
 /*
  * An initial 3 MB offset is used as that corresponds
@@ -230,6 +230,13 @@ static void wait_for_serial(const char *side)
     } while (true);
 }
 
+static void wait_for_stop(QTestState *who, QTestMigrationState *state)
+{
+    if (!state->stop_seen) {
+        qtest_qmp_eventwait(who, "STOP");
+    }
+}
+
 /*
  * It's tricky to use qemu's migration event capability with qtest,
  * events suddenly appearing confuse the qmp()/hmp() responses.
@@ -277,21 +284,19 @@ static void read_blocktime(QTestState *who)
     qobject_unref(rsp_return);
 }
 
+/*
+ * Wait for two changes in the migration pass count, but bail if we stop.
+ */
 static void wait_for_migration_pass(QTestState *who)
 {
-    uint64_t initial_pass = get_migration_pass(who);
-    uint64_t pass;
+    uint64_t pass, prev_pass = 0, changes = 0;
 
-    /* Wait for the 1st sync */
-    while (!got_src_stop && !initial_pass) {
-        usleep(1000);
-        initial_pass = get_migration_pass(who);
-    }
-
-    do {
+    while (changes < 2 && !src_state.stop_seen) {
         usleep(1000);
         pass = get_migration_pass(who);
-    } while (pass == initial_pass && !got_src_stop);
+        changes += (pass != prev_pass);
+        prev_pass = pass;
+    }
 }
 
 static void check_guests_ram(QTestState *who)
@@ -617,10 +622,7 @@ static void migrate_postcopy_start(QTestState *from, QTestState *to)
 {
     qtest_qmp_assert_success(from, "{ 'execute': 'migrate-start-postcopy' }");
 
-    if (!got_src_stop) {
-        qtest_qmp_eventwait(from, "STOP");
-    }
-
+    wait_for_stop(from, &src_state);
     qtest_qmp_eventwait(to, "RESUME");
 }
 
@@ -755,8 +757,9 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         }
     }
 
-    got_src_stop = false;
-    got_dst_resume = false;
+    dst_state = (QTestMigrationState) { };
+    src_state = (QTestMigrationState) { };
+
     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
         memory_size = "150M";
 
@@ -847,8 +850,8 @@ static int test_migrate_start(QTestState **from, QTestState **to,
     if (!args->only_target) {
         *from = qtest_init_with_env(QEMU_ENV_SRC, cmd_source);
         qtest_qmp_set_event_callback(*from,
-                                     migrate_watch_for_stop,
-                                     &got_src_stop);
+                                     migrate_watch_for_events,
+                                     &src_state);
     }
 
     cmd_target = g_strdup_printf("-accel kvm%s -accel tcg "
@@ -868,8 +871,8 @@ static int test_migrate_start(QTestState **from, QTestState **to,
                                  ignore_stderr);
     *to = qtest_init_with_env(QEMU_ENV_DST, cmd_target);
     qtest_qmp_set_event_callback(*to,
-                                 migrate_watch_for_resume,
-                                 &got_dst_resume);
+                                 migrate_watch_for_events,
+                                 &dst_state);
 
     /*
      * Remove shmem file immediately to avoid memory leak in test failed case.
@@ -1619,9 +1622,7 @@ static void test_precopy_common(MigrateCommon *args)
          */
         if (args->result == MIG_TEST_SUCCEED) {
             qtest_qmp_assert_success(from, "{ 'execute' : 'stop'}");
-            if (!got_src_stop) {
-                qtest_qmp_eventwait(from, "STOP");
-            }
+            wait_for_stop(from, &src_state);
             migrate_ensure_converge(from);
         }
     }
@@ -1667,9 +1668,8 @@ static void test_precopy_common(MigrateCommon *args)
              */
             wait_for_migration_complete(from);
 
-            if (!got_src_stop) {
-                qtest_qmp_eventwait(from, "STOP");
-            }
+            wait_for_stop(from, &src_state);
+
         } else {
             wait_for_migration_complete(from);
             /*
@@ -1682,7 +1682,7 @@ static void test_precopy_common(MigrateCommon *args)
             qtest_qmp_assert_success(to, "{ 'execute' : 'cont'}");
         }
 
-        if (!got_dst_resume) {
+        if (!dst_state.resume_seen) {
             qtest_qmp_eventwait(to, "RESUME");
         }
 
@@ -1723,9 +1723,7 @@ static void test_file_common(MigrateCommon *args, bool stop_src)
 
     if (stop_src) {
         qtest_qmp_assert_success(from, "{ 'execute' : 'stop'}");
-        if (!got_src_stop) {
-            qtest_qmp_eventwait(from, "STOP");
-        }
+        wait_for_stop(from, &src_state);
     }
 
     if (args->result == MIG_TEST_QMP_ERROR) {
@@ -1747,7 +1745,7 @@ static void test_file_common(MigrateCommon *args, bool stop_src)
         qtest_qmp_assert_success(to, "{ 'execute' : 'cont'}");
     }
 
-    if (!got_dst_resume) {
+    if (!dst_state.resume_seen) {
         qtest_qmp_eventwait(to, "RESUME");
     }
 
@@ -1868,9 +1866,7 @@ static void test_ignore_shared(void)
 
     migrate_wait_for_dirty_mem(from, to);
 
-    if (!got_src_stop) {
-        qtest_qmp_eventwait(from, "STOP");
-    }
+    wait_for_stop(from, &src_state);
 
     qtest_qmp_eventwait(to, "RESUME");
 
@@ -2380,7 +2376,7 @@ static void test_migrate_auto_converge(void)
             break;
         }
         usleep(20);
-        g_assert_false(got_src_stop);
+        g_assert_false(src_state.stop_seen);
     } while (true);
     /* The first percentage of throttling should be at least init_pct */
     g_assert_cmpint(percentage, >=, init_pct);
@@ -2719,9 +2715,7 @@ static void test_multifd_tcp_cancel(void)
 
     migrate_ensure_converge(from);
 
-    if (!got_src_stop) {
-        qtest_qmp_eventwait(from, "STOP");
-    }
+    wait_for_stop(from, &src_state);
     qtest_qmp_eventwait(to2, "RESUME");
 
     wait_for_serial("dest_serial");
-- 
2.35.3


