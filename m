Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA0D9D8868
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Nov 2024 15:48:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFaMZ-0007X2-TL; Mon, 25 Nov 2024 09:46:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1tFaMA-0007Tr-Q7; Mon, 25 Nov 2024 09:46:35 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1tFaM7-00049u-4U; Mon, 25 Nov 2024 09:46:30 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 461121F399;
 Mon, 25 Nov 2024 14:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732545983; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/WuRI3WiXs/grSOHPdHKRDOMtKv8QhHZpH8bhU9RAQo=;
 b=TVI13yabKNMcyfdY1hiYX4DJIbSeSSwme/DQDa2J0aMmB4n/3opFlr2n0nnKkORf4gRDx0
 bkIHfZKpyq9MDxMCGHTYwKAaBWULGMcUfjPh1lUKi+u4sqxN+qTd4MQcSDtgtcJm1w8D9K
 B3Y2v57m9P2Sb8VdtY4QTuCvvXk7FoM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732545983;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/WuRI3WiXs/grSOHPdHKRDOMtKv8QhHZpH8bhU9RAQo=;
 b=aFTIBaZ3URe4OtM1wpJS4WzqDZ9SwGHl3h5ufDaRhBtXN0zveZnZ+kZk440+utKrBmeKuu
 XuMRFvI9QRlTOUCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732545983; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/WuRI3WiXs/grSOHPdHKRDOMtKv8QhHZpH8bhU9RAQo=;
 b=TVI13yabKNMcyfdY1hiYX4DJIbSeSSwme/DQDa2J0aMmB4n/3opFlr2n0nnKkORf4gRDx0
 bkIHfZKpyq9MDxMCGHTYwKAaBWULGMcUfjPh1lUKi+u4sqxN+qTd4MQcSDtgtcJm1w8D9K
 B3Y2v57m9P2Sb8VdtY4QTuCvvXk7FoM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732545983;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/WuRI3WiXs/grSOHPdHKRDOMtKv8QhHZpH8bhU9RAQo=;
 b=aFTIBaZ3URe4OtM1wpJS4WzqDZ9SwGHl3h5ufDaRhBtXN0zveZnZ+kZk440+utKrBmeKuu
 XuMRFvI9QRlTOUCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 30D5A137D4;
 Mon, 25 Nov 2024 14:46:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uMDoObyNRGdRTgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 25 Nov 2024 14:46:20 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 andrey.drobyshev@virtuozzo.com, den@virtuozzo.com,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH 2/5] tests/qtest/migration: Don't use hardcoded strings for
 -serial
Date: Mon, 25 Nov 2024 11:46:09 -0300
Message-Id: <20241125144612.16194-3-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241125144612.16194-1-farosas@suse.de>
References: <20241125144612.16194-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.995];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_SEVEN(0.00)[7];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Stop using hardcoded strings for -serial so we can in the next patches
perform more than one migration in a row. Having the serial path
hardcoded means we cannot reuse the code when dst becomes the new src.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-helpers.c |  8 ++++
 tests/qtest/migration-helpers.h |  2 +
 tests/qtest/migration-test.c    | 68 ++++++++++++++++++---------------
 3 files changed, 48 insertions(+), 30 deletions(-)

diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index 0025933883..16e940d910 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -528,3 +528,11 @@ void migration_event_wait(QTestState *s, const char *target)
         qobject_unref(response);
     } while (!found);
 }
+
+char *migrate_get_unique_serial(const char *tmpfs)
+{
+    static int i;
+
+    assert(i < INT_MAX);
+    return g_strdup_printf("%s/serial_%d", tmpfs, i++);
+}
diff --git a/tests/qtest/migration-helpers.h b/tests/qtest/migration-helpers.h
index 72dba369fb..c7a36a33d6 100644
--- a/tests/qtest/migration-helpers.h
+++ b/tests/qtest/migration-helpers.h
@@ -20,6 +20,7 @@ typedef struct QTestMigrationState {
     bool resume_seen;
     bool suspend_seen;
     bool suspend_me;
+    char *serial;
 } QTestMigrationState;
 
 bool migrate_watch_for_events(QTestState *who, const char *name,
@@ -64,5 +65,6 @@ static inline bool probe_o_direct_support(const char *tmpfs)
 #endif
 void migration_test_add(const char *path, void (*fn)(void));
 void migration_event_wait(QTestState *s, const char *target);
+char *migrate_get_unique_serial(const char *tmpfs);
 
 #endif /* MIGRATION_HELPERS_H */
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index d56894dd97..f8919a083b 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -192,9 +192,8 @@ static void bootfile_create(char *dir, bool suspend_me)
  * we get an 'A' followed by an endless string of 'B's
  * but on the destination we won't have the A (unless we enabled suspend/resume)
  */
-static void wait_for_serial(const char *side)
+static void wait_for_serial(const char *serialpath)
 {
-    g_autofree char *serialpath = g_strdup_printf("%s/%s", tmpfs, side);
     FILE *serialfile = fopen(serialpath, "r");
 
     do {
@@ -216,7 +215,7 @@ static void wait_for_serial(const char *side)
             break;
 
         default:
-            fprintf(stderr, "Unexpected %d on %s serial\n", readvalue, side);
+            fprintf(stderr, "Unexpected %d on %s\n", readvalue, serialpath);
             g_assert_not_reached();
         }
     } while (true);
@@ -818,16 +817,17 @@ static int test_migrate_start(QTestState **from, QTestState **to,
 
         src_state = (QTestMigrationState) { };
         src_state.suspend_me = args->suspend_me;
+        src_state.serial = migrate_get_unique_serial(tmpfs);
 
         cmd_source = g_strdup_printf("-accel kvm%s -accel tcg "
                                      "-machine %s,%s "
                                      "-name source,debug-threads=on "
                                      "-m %s "
-                                     "-serial file:%s/src_serial "
+                                     "-serial file:%s "
                                      "%s %s %s %s %s",
                                      kvm_opts ? kvm_opts : "",
                                      machine, machine_opts,
-                                     memory_size, tmpfs,
+                                     memory_size, src_state.serial,
                                      arch_opts ? arch_opts : "",
                                      arch_source ? arch_source : "",
                                      shmem_opts ? shmem_opts : "",
@@ -841,17 +841,18 @@ static int test_migrate_start(QTestState **from, QTestState **to,
     }
 
     dst_state = (QTestMigrationState) { };
+    dst_state.serial = migrate_get_unique_serial(tmpfs);
 
     cmd_target = g_strdup_printf("-accel kvm%s -accel tcg "
                                  "-machine %s,%s "
                                  "-name target,debug-threads=on "
                                  "-m %s "
-                                 "-serial file:%s/dest_serial "
+                                 "-serial file:%s "
                                  "-incoming %s "
                                  "%s %s %s %s %s",
                                  kvm_opts ? kvm_opts : "",
                                  machine, machine_opts,
-                                 memory_size, tmpfs, uri,
+                                 memory_size, dst_state.serial, uri,
                                  arch_opts ? arch_opts : "",
                                  arch_target ? arch_target : "",
                                  shmem_opts ? shmem_opts : "",
@@ -911,8 +912,10 @@ static void test_migrate_end(QTestState *from, QTestState *to, bool test_dest)
     qtest_quit(to);
 
     cleanup("migsocket");
-    cleanup("src_serial");
-    cleanup("dest_serial");
+    unlink(src_state.serial);
+    g_free(src_state.serial);
+    unlink(dst_state.serial);
+    g_free(dst_state.serial);
     cleanup(FILE_TEST_FILENAME);
 }
 
@@ -1290,7 +1293,7 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
                              "                'port': '0' } } ] } }");
 
     /* Wait for the first serial output from the source */
-    wait_for_serial("src_serial");
+    wait_for_serial(src_state.serial);
     wait_for_suspend(from, &src_state);
 
     migrate_qmp(from, to, NULL, NULL, "{}");
@@ -1314,7 +1317,7 @@ static void migrate_postcopy_complete(QTestState *from, QTestState *to,
     }
 
     /* Make sure we get at least one "B" on destination */
-    wait_for_serial("dest_serial");
+    wait_for_serial(dst_state.serial);
 
     if (uffd_feature_thread_id) {
         read_blocktime(to);
@@ -1717,7 +1720,7 @@ static void test_precopy_common(MigrateCommon *args)
 
     /* Wait for the first serial output from the source */
     if (args->result == MIG_TEST_SUCCEED) {
-        wait_for_serial("src_serial");
+        wait_for_serial(src_state.serial);
         wait_for_suspend(from, &src_state);
     }
 
@@ -1794,7 +1797,7 @@ static void test_precopy_common(MigrateCommon *args)
             qtest_qmp_assert_success(to, "{'execute': 'system_wakeup'}");
         }
 
-        wait_for_serial("dest_serial");
+        wait_for_serial(dst_state.serial);
     }
 
 finish:
@@ -1869,7 +1872,7 @@ static void test_file_common(MigrateCommon *args, bool stop_src)
     }
 
     migrate_ensure_converge(from);
-    wait_for_serial("src_serial");
+    wait_for_serial(src_state.serial);
 
     if (stop_src) {
         qtest_qmp_assert_success(from, "{ 'execute' : 'stop'}");
@@ -1896,7 +1899,7 @@ static void test_file_common(MigrateCommon *args, bool stop_src)
     }
     wait_for_resume(to, &dst_state);
 
-    wait_for_serial("dest_serial");
+    wait_for_serial(dst_state.serial);
 
     if (check_offset) {
         file_check_offset_region();
@@ -2039,7 +2042,7 @@ static void test_ignore_shared(void)
     migrate_set_capability(to, "x-ignore-shared", true);
 
     /* Wait for the first serial output from the source */
-    wait_for_serial("src_serial");
+    wait_for_serial(src_state.serial);
 
     migrate_qmp(from, to, uri, NULL, "{}");
 
@@ -2049,7 +2052,7 @@ static void test_ignore_shared(void)
 
     qtest_qmp_eventwait(to, "RESUME");
 
-    wait_for_serial("dest_serial");
+    wait_for_serial(dst_state.serial);
     wait_for_migration_complete(from);
 
     /* Check whether shared RAM has been really skipped */
@@ -2665,7 +2668,7 @@ static void do_test_validate_uuid(MigrateStart *args, bool should_fail)
     migrate_set_capability(from, "validate-uuid", true);
 
     /* Wait for the first serial output from the source */
-    wait_for_serial("src_serial");
+    wait_for_serial(src_state.serial);
 
     migrate_qmp(from, to, uri, NULL, "{}");
 
@@ -2729,7 +2732,7 @@ static void do_test_validate_uri_channel(MigrateCommon *args)
     }
 
     /* Wait for the first serial output from the source */
-    wait_for_serial("src_serial");
+    wait_for_serial(src_state.serial);
 
     /*
      * 'uri' and 'channels' validation is checked even before the migration
@@ -2819,7 +2822,7 @@ static void test_migrate_auto_converge(void)
     migrate_set_capability(from, "pause-before-switchover", true);
 
     /* Wait for the first serial output from the source */
-    wait_for_serial("src_serial");
+    wait_for_serial(src_state.serial);
 
     migrate_qmp(from, to, uri, NULL, "{}");
 
@@ -2881,7 +2884,7 @@ static void test_migrate_auto_converge(void)
 
     qtest_qmp_eventwait(to, "RESUME");
 
-    wait_for_serial("dest_serial");
+    wait_for_serial(dst_state.serial);
     wait_for_migration_complete(from);
 
     test_migrate_end(from, to, true);
@@ -3292,7 +3295,7 @@ static void test_multifd_tcp_cancel(void)
     migrate_incoming_qmp(to, "tcp:127.0.0.1:0", "{}");
 
     /* Wait for the first serial output from the source */
-    wait_for_serial("src_serial");
+    wait_for_serial(src_state.serial);
 
     migrate_qmp(from, to, NULL, NULL, "{}");
 
@@ -3303,7 +3306,8 @@ static void test_multifd_tcp_cancel(void)
     /* Make sure QEMU process "to" exited */
     qtest_set_expected_status(to, EXIT_FAILURE);
     qtest_wait_qemu(to);
-    qtest_quit(to);
+    unlink(dst_state.serial);
+    g_free(dst_state.serial);
 
     /*
      * Ensure the source QEMU finishes its cancellation process before we
@@ -3341,7 +3345,7 @@ static void test_multifd_tcp_cancel(void)
     wait_for_stop(from, &src_state);
     qtest_qmp_eventwait(to2, "RESUME");
 
-    wait_for_serial("dest_serial");
+    wait_for_serial(dst_state.serial);
     wait_for_migration_complete(from);
     test_migrate_end(from, to2, true);
 }
@@ -3484,13 +3488,16 @@ static QTestState *dirtylimit_start_vm(void)
     QTestState *vm = NULL;
     g_autofree gchar *cmd = NULL;
 
+    src_state = (QTestMigrationState) { };
+    src_state.serial = migrate_get_unique_serial(tmpfs);
+
     bootfile_create(tmpfs, false);
     cmd = g_strdup_printf("-accel kvm,dirty-ring-size=4096 "
                           "-name dirtylimit-test,debug-threads=on "
                           "-m 150M -smp 1 "
-                          "-serial file:%s/vm_serial "
+                          "-serial file:%s "
                           "-drive file=%s,format=raw ",
-                          tmpfs, bootpath);
+                          src_state.serial, bootpath);
 
     vm = qtest_init(cmd);
     return vm;
@@ -3499,7 +3506,8 @@ static QTestState *dirtylimit_start_vm(void)
 static void dirtylimit_stop_vm(QTestState *vm)
 {
     qtest_quit(vm);
-    cleanup("vm_serial");
+    unlink(src_state.serial);
+    g_free(src_state.serial);
 }
 
 static void test_vcpu_dirty_limit(void)
@@ -3515,7 +3523,7 @@ static void test_vcpu_dirty_limit(void)
     vm = dirtylimit_start_vm();
 
     /* Wait for the first serial output from the vm*/
-    wait_for_serial("vm_serial");
+    wait_for_serial(src_state.serial);
 
     /* Do dirtyrate measurement with calc time equals 1s */
     calc_dirty_rate(vm, 1);
@@ -3608,7 +3616,7 @@ static void migrate_dirty_limit_wait_showup(QTestState *from,
     migrate_set_capability(from, "pause-before-switchover", true);
 
     /* Wait for the serial output from the source */
-    wait_for_serial("src_serial");
+    wait_for_serial(src_state.serial);
 }
 
 /*
@@ -3744,7 +3752,7 @@ static void test_migrate_dirty_limit(void)
 
     qtest_qmp_eventwait(to, "RESUME");
 
-    wait_for_serial("dest_serial");
+    wait_for_serial(dst_state.serial);
     wait_for_migration_complete(from);
 
     test_migrate_end(from, to, true);
-- 
2.35.3


