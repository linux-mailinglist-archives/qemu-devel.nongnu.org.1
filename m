Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 612749EEB0A
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Dec 2024 16:20:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLkpM-0003us-D6; Thu, 12 Dec 2024 10:10:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tLkpK-0003uA-Dx
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 10:10:06 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tLkpI-00030r-22
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 10:10:06 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C9F141F394;
 Thu, 12 Dec 2024 15:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734016202; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tdSBox6Rf/fHjeaR5r4WxMwiZ8SYCk3cEdLNGcMepOE=;
 b=DWKlfC2MfepYUVfOYZibE5eHNHqcTb9xbVhVlzXaEeF02TsA3KnzG+HdkduwokPN//I5bl
 9QNue5L0SGP5q5skcFv1kAi+a7aAT4Gjzoy5xg7u38Jo9oMRPZDDO8HoBtU1RuIrdp/d5C
 NyndF5O84GB6PgCYDiVP5O+yVCORW9U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734016202;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tdSBox6Rf/fHjeaR5r4WxMwiZ8SYCk3cEdLNGcMepOE=;
 b=deLCCPH9Q9GhIDCqnNVHKGUHyOkTHE/x+/O4GXYItX3usddbiOSFpD57Wmhp0O5HNYFbsp
 hoUwltIMP5LFB/Bw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DWKlfC2M;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=deLCCPH9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734016202; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tdSBox6Rf/fHjeaR5r4WxMwiZ8SYCk3cEdLNGcMepOE=;
 b=DWKlfC2MfepYUVfOYZibE5eHNHqcTb9xbVhVlzXaEeF02TsA3KnzG+HdkduwokPN//I5bl
 9QNue5L0SGP5q5skcFv1kAi+a7aAT4Gjzoy5xg7u38Jo9oMRPZDDO8HoBtU1RuIrdp/d5C
 NyndF5O84GB6PgCYDiVP5O+yVCORW9U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734016202;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tdSBox6Rf/fHjeaR5r4WxMwiZ8SYCk3cEdLNGcMepOE=;
 b=deLCCPH9Q9GhIDCqnNVHKGUHyOkTHE/x+/O4GXYItX3usddbiOSFpD57Wmhp0O5HNYFbsp
 hoUwltIMP5LFB/Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9443513508;
 Thu, 12 Dec 2024 15:10:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ACxFFsn8WmcTfQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 12 Dec 2024 15:10:01 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Peter Xu <peterx@redhat.com>
Subject: [PULL 06/22] tests/qtest/migration: Stop calling everything "test"
Date: Thu, 12 Dec 2024 12:09:33 -0300
Message-Id: <20241212150949.16806-7-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241212150949.16806-1-farosas@suse.de>
References: <20241212150949.16806-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C9F141F394
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, suse.de:dkim, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Test frameworks usually prefix "test_" to the entry point of the test
code. Having every function prefixed with test_ makes it hard to
understand the code and to grep for the actual tests.

Remove the "test" prefix from everything that is not a test.

In order to still keep some namespacing, stick to the "migrate_"
prefix, which is the most used currently.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-test.c | 72 ++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index f0f3145c59..30bc965b28 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -710,8 +710,8 @@ typedef struct {
     PostcopyRecoveryFailStage postcopy_recovery_fail_stage;
 } MigrateCommon;
 
-static int test_migrate_start(QTestState **from, QTestState **to,
-                              const char *uri, MigrateStart *args)
+static int migrate_start(QTestState **from, QTestState **to,
+                         const char *uri, MigrateStart *args)
 {
     g_autofree gchar *arch_source = NULL;
     g_autofree gchar *arch_target = NULL;
@@ -876,7 +876,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
     return 0;
 }
 
-static void test_migrate_end(QTestState *from, QTestState *to, bool test_dest)
+static void migrate_end(QTestState *from, QTestState *to, bool test_dest)
 {
     unsigned char dest_byte_a, dest_byte_b, dest_byte_c, dest_byte_d;
 
@@ -1255,7 +1255,7 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
 {
     QTestState *from, *to;
 
-    if (test_migrate_start(&from, &to, "defer", &args->start)) {
+    if (migrate_start(&from, &to, "defer", &args->start)) {
         return -1;
     }
 
@@ -1319,7 +1319,7 @@ static void migrate_postcopy_complete(QTestState *from, QTestState *to,
         args->postcopy_data = NULL;
     }
 
-    test_migrate_end(from, to, true);
+    migrate_end(from, to, true);
 }
 
 static void test_postcopy_common(MigrateCommon *args)
@@ -1635,12 +1635,12 @@ static void test_baddest(void)
     };
     QTestState *from, *to;
 
-    if (test_migrate_start(&from, &to, "tcp:127.0.0.1:0", &args)) {
+    if (migrate_start(&from, &to, "tcp:127.0.0.1:0", &args)) {
         return;
     }
     migrate_qmp(from, to, "tcp:127.0.0.1:0", NULL, "{}");
     wait_for_migration_fail(from, false);
-    test_migrate_end(from, to, false);
+    migrate_end(from, to, false);
 }
 
 #ifndef _WIN32
@@ -1661,7 +1661,7 @@ static void test_analyze_script(void)
     }
 
     /* dummy url */
-    if (test_migrate_start(&from, &to, "tcp:127.0.0.1:0", &args)) {
+    if (migrate_start(&from, &to, "tcp:127.0.0.1:0", &args)) {
         return;
     }
 
@@ -1693,7 +1693,7 @@ static void test_analyze_script(void)
         g_test_message("Failed to analyze the migration stream");
         g_test_fail();
     }
-    test_migrate_end(from, to, false);
+    migrate_end(from, to, false);
     cleanup("migfile");
 }
 #endif
@@ -1703,7 +1703,7 @@ static void test_precopy_common(MigrateCommon *args)
     QTestState *from, *to;
     void *data_hook = NULL;
 
-    if (test_migrate_start(&from, &to, args->listen_uri, &args->start)) {
+    if (migrate_start(&from, &to, args->listen_uri, &args->start)) {
         return;
     }
 
@@ -1798,7 +1798,7 @@ finish:
         args->end_hook(from, to, data_hook);
     }
 
-    test_migrate_end(from, to, args->result == MIG_TEST_SUCCEED);
+    migrate_end(from, to, args->result == MIG_TEST_SUCCEED);
 }
 
 static void file_dirty_offset_region(void)
@@ -1839,7 +1839,7 @@ static void test_file_common(MigrateCommon *args, bool stop_src)
     void *data_hook = NULL;
     bool check_offset = false;
 
-    if (test_migrate_start(&from, &to, args->listen_uri, &args->start)) {
+    if (migrate_start(&from, &to, args->listen_uri, &args->start)) {
         return;
     }
 
@@ -1903,7 +1903,7 @@ finish:
         args->end_hook(from, to, data_hook);
     }
 
-    test_migrate_end(from, to, args->result == MIG_TEST_SUCCEED);
+    migrate_end(from, to, args->result == MIG_TEST_SUCCEED);
 }
 
 static void test_precopy_unix_plain(void)
@@ -2024,7 +2024,7 @@ static void test_ignore_shared(void)
     g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
     QTestState *from, *to;
 
-    if (test_migrate_start(&from, &to, uri, false, true, NULL, NULL)) {
+    if (migrate_start(&from, &to, uri, false, true, NULL, NULL)) {
         return;
     }
 
@@ -2051,7 +2051,7 @@ static void test_ignore_shared(void)
     /* Check whether shared RAM has been really skipped */
     g_assert_cmpint(read_ram_property_int(from, "transferred"), <, 1024 * 1024);
 
-    test_migrate_end(from, to, true);
+    migrate_end(from, to, true);
 }
 #endif
 
@@ -2600,7 +2600,7 @@ static void migrate_hook_end_fd(QTestState *from,
     qobject_unref(rsp);
 }
 
-static void test_migrate_precopy_fd_socket(void)
+static void test_precopy_fd_socket(void)
 {
     MigrateCommon args = {
         .listen_uri = "defer",
@@ -2639,7 +2639,7 @@ static void *migrate_hook_start_precopy_fd_file(QTestState *from, QTestState *to
     return NULL;
 }
 
-static void test_migrate_precopy_fd_file(void)
+static void test_precopy_fd_file(void)
 {
     MigrateCommon args = {
         .listen_uri = "defer",
@@ -2656,7 +2656,7 @@ static void do_test_validate_uuid(MigrateStart *args, bool should_fail)
     g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
     QTestState *from, *to;
 
-    if (test_migrate_start(&from, &to, uri, args)) {
+    if (migrate_start(&from, &to, uri, args)) {
         return;
     }
 
@@ -2680,7 +2680,7 @@ static void do_test_validate_uuid(MigrateStart *args, bool should_fail)
         wait_for_migration_complete(from);
     }
 
-    test_migrate_end(from, to, false);
+    migrate_end(from, to, false);
 }
 
 static void test_validate_uuid(void)
@@ -2728,7 +2728,7 @@ static void do_test_validate_uri_channel(MigrateCommon *args)
 {
     QTestState *from, *to;
 
-    if (test_migrate_start(&from, &to, args->listen_uri, &args->start)) {
+    if (migrate_start(&from, &to, args->listen_uri, &args->start)) {
         return;
     }
 
@@ -2740,7 +2740,7 @@ static void do_test_validate_uri_channel(MigrateCommon *args)
      * starts.
      */
     migrate_qmp_fail(from, args->connect_uri, args->connect_channels, "{}");
-    test_migrate_end(from, to, false);
+    migrate_end(from, to, false);
 }
 
 static void test_validate_uri_channels_both_set(void)
@@ -2788,7 +2788,7 @@ static void test_validate_uri_channels_none_set(void)
  * To make things even worse, we need to run the initial stage at
  * 3MB/s so we enter autoconverge even when host is (over)loaded.
  */
-static void test_migrate_auto_converge(void)
+static void test_auto_converge(void)
 {
     g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
     MigrateStart args = {};
@@ -2804,7 +2804,7 @@ static void test_migrate_auto_converge(void)
     uint64_t prev_dirty_sync_cnt, dirty_sync_cnt;
     int max_try_count, hit = 0;
 
-    if (test_migrate_start(&from, &to, uri, &args)) {
+    if (migrate_start(&from, &to, uri, &args)) {
         return;
     }
 
@@ -2888,7 +2888,7 @@ static void test_migrate_auto_converge(void)
     wait_for_serial("dest_serial");
     wait_for_migration_complete(from);
 
-    test_migrate_end(from, to, true);
+    migrate_end(from, to, true);
 }
 
 static void *
@@ -3279,7 +3279,7 @@ static void test_multifd_tcp_cancel(void)
     };
     QTestState *from, *to, *to2;
 
-    if (test_migrate_start(&from, &to, "defer", &args)) {
+    if (migrate_start(&from, &to, "defer", &args)) {
         return;
     }
 
@@ -3311,7 +3311,7 @@ static void test_multifd_tcp_cancel(void)
 
     /*
      * Ensure the source QEMU finishes its cancellation process before we
-     * proceed with the setup of the next migration. The test_migrate_start()
+     * proceed with the setup of the next migration. The migrate_start()
      * function and others might want to interact with the source in a way that
      * is not possible while the migration is not canceled properly. For
      * example, setting migration capabilities when the migration is still
@@ -3323,7 +3323,7 @@ static void test_multifd_tcp_cancel(void)
         .only_target = true,
     };
 
-    if (test_migrate_start(&from, &to2, "defer", &args)) {
+    if (migrate_start(&from, &to2, "defer", &args)) {
         return;
     }
 
@@ -3347,7 +3347,7 @@ static void test_multifd_tcp_cancel(void)
 
     wait_for_serial("dest_serial");
     wait_for_migration_complete(from);
-    test_migrate_end(from, to2, true);
+    migrate_end(from, to2, true);
 }
 
 static void calc_dirty_rate(QTestState *who, uint64_t calc_time)
@@ -3633,7 +3633,7 @@ static void migrate_dirty_limit_wait_showup(QTestState *from,
  * And see if dirty limit migration works correctly.
  * This test case involves many passes, so it runs in slow mode only.
  */
-static void test_migrate_dirty_limit(void)
+static void test_dirty_limit(void)
 {
     g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
     QTestState *from, *to;
@@ -3664,7 +3664,7 @@ static void test_migrate_dirty_limit(void)
     };
 
     /* Start src, dst vm */
-    if (test_migrate_start(&from, &to, args.listen_uri, &args.start)) {
+    if (migrate_start(&from, &to, args.listen_uri, &args.start)) {
         return;
     }
 
@@ -3710,7 +3710,7 @@ static void test_migrate_dirty_limit(void)
     };
 
     /* Restart dst vm, src vm already show up so we needn't wait anymore */
-    if (test_migrate_start(&from, &to, args.listen_uri, &args.start)) {
+    if (migrate_start(&from, &to, args.listen_uri, &args.start)) {
         return;
     }
 
@@ -3754,7 +3754,7 @@ static void test_migrate_dirty_limit(void)
     wait_for_serial("dest_serial");
     wait_for_migration_complete(from);
 
-    test_migrate_end(from, to, true);
+    migrate_end(from, to, true);
 }
 
 static bool kvm_dirty_ring_supported(void)
@@ -3957,9 +3957,9 @@ int main(int argc, char **argv)
     /* migration_test_add("/migration/ignore_shared", test_ignore_shared); */
 #ifndef _WIN32
     migration_test_add("/migration/precopy/fd/tcp",
-                       test_migrate_precopy_fd_socket);
+                       test_precopy_fd_socket);
     migration_test_add("/migration/precopy/fd/file",
-                       test_migrate_precopy_fd_file);
+                       test_precopy_fd_file);
 #endif
     migration_test_add("/migration/validate_uuid", test_validate_uuid);
     migration_test_add("/migration/validate_uuid_error",
@@ -3977,11 +3977,11 @@ int main(int argc, char **argv)
      */
     if (g_test_slow()) {
         migration_test_add("/migration/auto_converge",
-                           test_migrate_auto_converge);
+                           test_auto_converge);
         if (g_str_equal(arch, "x86_64") &&
             has_kvm && kvm_dirty_ring_supported()) {
             migration_test_add("/migration/dirty_limit",
-                               test_migrate_dirty_limit);
+                               test_dirty_limit);
         }
     }
     migration_test_add("/migration/multifd/tcp/uri/plain/none",
-- 
2.35.3


