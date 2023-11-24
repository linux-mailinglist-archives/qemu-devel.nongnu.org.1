Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E477F78B7
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 17:15:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6YpY-0000J9-O3; Fri, 24 Nov 2023 11:15:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r6YpU-0000BJ-Ro
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 11:14:56 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r6YpR-0001Wj-O7
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 11:14:56 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D24F91FF6D;
 Fri, 24 Nov 2023 16:14:51 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C1ED713A98;
 Fri, 24 Nov 2023 16:14:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KKgDIvnLYGXdagAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 24 Nov 2023 16:14:49 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v1 7/7] tests/qtest/migration: Use the new migration_test_add
Date: Fri, 24 Nov 2023 13:14:32 -0300
Message-Id: <20231124161432.3515-8-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231124161432.3515-1-farosas@suse.de>
References: <20231124161432.3515-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++++++
X-Spam-Score: 10.94
X-Rspamd-Server: rspamd1
X-Rspamd-Queue-Id: D24F91FF6D
Authentication-Results: smtp-out2.suse.de; dkim=none;
 dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.de
 (policy=none); 
 spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:97 is neither
 permitted nor denied by domain of farosas@suse.de)
 smtp.mailfrom=farosas@suse.de
X-Spamd-Result: default: False [10.94 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_SPAM_SHORT(3.00)[0.999];
 BROKEN_CONTENT_TYPE(1.50)[]; R_SPF_SOFTFAIL(4.60)[~all:c];
 NEURAL_HAM_LONG(-0.84)[-0.845]; RCVD_COUNT_THREE(0.00)[3];
 MX_GOOD(-0.01)[]; RCPT_COUNT_SEVEN(0.00)[7];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 R_DKIM_NA(2.20)[]; MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%];
 DMARC_POLICY_SOFTFAIL(0.10)[suse.de : No valid SPF, No valid DKIM,none]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Replace the tests registration with the new function that prints tests
names.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-test.c | 201 ++++++++++++++++++-----------------
 1 file changed, 104 insertions(+), 97 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 0fbaa6a90f..4884a40be2 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -3339,62 +3339,65 @@ int main(int argc, char **argv)
     module_call_init(MODULE_INIT_QOM);
 
     if (has_uffd) {
-        qtest_add_func("/migration/postcopy/plain", test_postcopy);
-        qtest_add_func("/migration/postcopy/recovery/plain",
-                       test_postcopy_recovery);
-        qtest_add_func("/migration/postcopy/preempt/plain", test_postcopy_preempt);
-        qtest_add_func("/migration/postcopy/preempt/recovery/plain",
-                       test_postcopy_preempt_recovery);
+        migration_test_add("/migration/postcopy/plain", test_postcopy);
+        migration_test_add("/migration/postcopy/recovery/plain",
+                           test_postcopy_recovery);
+        migration_test_add("/migration/postcopy/preempt/plain",
+                           test_postcopy_preempt);
+        migration_test_add("/migration/postcopy/preempt/recovery/plain",
+                           test_postcopy_preempt_recovery);
         if (getenv("QEMU_TEST_FLAKY_TESTS")) {
-            qtest_add_func("/migration/postcopy/compress/plain",
-                           test_postcopy_compress);
-            qtest_add_func("/migration/postcopy/recovery/compress/plain",
-                           test_postcopy_recovery_compress);
+            migration_test_add("/migration/postcopy/compress/plain",
+                               test_postcopy_compress);
+            migration_test_add("/migration/postcopy/recovery/compress/plain",
+                               test_postcopy_recovery_compress);
         }
 #ifndef _WIN32
-        qtest_add_func("/migration/postcopy/recovery/double-failures",
-                       test_postcopy_recovery_double_fail);
+        migration_test_add("/migration/postcopy/recovery/double-failures",
+                           test_postcopy_recovery_double_fail);
 #endif /* _WIN32 */
 
     }
 
-    qtest_add_func("/migration/bad_dest", test_baddest);
+    migration_test_add("/migration/bad_dest", test_baddest);
 #ifndef _WIN32
     if (!g_str_equal(arch, "s390x")) {
-        qtest_add_func("/migration/analyze-script", test_analyze_script);
+        migration_test_add("/migration/analyze-script", test_analyze_script);
     }
 #endif
-    qtest_add_func("/migration/precopy/unix/plain", test_precopy_unix_plain);
-    qtest_add_func("/migration/precopy/unix/xbzrle", test_precopy_unix_xbzrle);
+    migration_test_add("/migration/precopy/unix/plain",
+                       test_precopy_unix_plain);
+    migration_test_add("/migration/precopy/unix/xbzrle",
+                       test_precopy_unix_xbzrle);
     /*
      * Compression fails from time to time.
      * Put test here but don't enable it until everything is fixed.
      */
     if (getenv("QEMU_TEST_FLAKY_TESTS")) {
-        qtest_add_func("/migration/precopy/unix/compress/wait",
-                       test_precopy_unix_compress);
-        qtest_add_func("/migration/precopy/unix/compress/nowait",
-                       test_precopy_unix_compress_nowait);
+        migration_test_add("/migration/precopy/unix/compress/wait",
+                           test_precopy_unix_compress);
+        migration_test_add("/migration/precopy/unix/compress/nowait",
+                           test_precopy_unix_compress_nowait);
     }
 
-    qtest_add_func("/migration/precopy/file",
-                   test_precopy_file);
-    qtest_add_func("/migration/precopy/file/offset",
-                   test_precopy_file_offset);
-    qtest_add_func("/migration/precopy/file/offset/bad",
-                   test_precopy_file_offset_bad);
+    migration_test_add("/migration/precopy/file",
+                       test_precopy_file);
+    migration_test_add("/migration/precopy/file/offset",
+                       test_precopy_file_offset);
+    migration_test_add("/migration/precopy/file/offset/bad",
+                       test_precopy_file_offset_bad);
 
     /*
      * Our CI system has problems with shared memory.
      * Don't run this test until we find a workaround.
      */
     if (getenv("QEMU_TEST_FLAKY_TESTS")) {
-        qtest_add_func("/migration/mode/reboot", test_mode_reboot);
+        migration_test_add("/migration/mode/reboot", test_mode_reboot);
     }
 
 #ifdef CONFIG_GNUTLS
-    qtest_add_func("/migration/precopy/unix/tls/psk",
-                   test_precopy_unix_tls_psk);
+    migration_test_add("/migration/precopy/unix/tls/psk",
+                       test_precopy_unix_tls_psk);
 
     if (has_uffd) {
         /*
@@ -3402,110 +3405,114 @@ int main(int argc, char **argv)
          * channels are tested under precopy.  Here what we want to test is the
          * general postcopy path that has TLS channel enabled.
          */
-        qtest_add_func("/migration/postcopy/tls/psk", test_postcopy_tls_psk);
-        qtest_add_func("/migration/postcopy/recovery/tls/psk",
-                       test_postcopy_recovery_tls_psk);
-        qtest_add_func("/migration/postcopy/preempt/tls/psk",
-                       test_postcopy_preempt_tls_psk);
-        qtest_add_func("/migration/postcopy/preempt/recovery/tls/psk",
-                       test_postcopy_preempt_all);
+        migration_test_add("/migration/postcopy/tls/psk",
+                           test_postcopy_tls_psk);
+        migration_test_add("/migration/postcopy/recovery/tls/psk",
+                           test_postcopy_recovery_tls_psk);
+        migration_test_add("/migration/postcopy/preempt/tls/psk",
+                           test_postcopy_preempt_tls_psk);
+        migration_test_add("/migration/postcopy/preempt/recovery/tls/psk",
+                           test_postcopy_preempt_all);
     }
 #ifdef CONFIG_TASN1
-    qtest_add_func("/migration/precopy/unix/tls/x509/default-host",
-                   test_precopy_unix_tls_x509_default_host);
-    qtest_add_func("/migration/precopy/unix/tls/x509/override-host",
-                   test_precopy_unix_tls_x509_override_host);
+    migration_test_add("/migration/precopy/unix/tls/x509/default-host",
+                       test_precopy_unix_tls_x509_default_host);
+    migration_test_add("/migration/precopy/unix/tls/x509/override-host",
+                       test_precopy_unix_tls_x509_override_host);
 #endif /* CONFIG_TASN1 */
 #endif /* CONFIG_GNUTLS */
 
-    qtest_add_func("/migration/precopy/tcp/plain", test_precopy_tcp_plain);
+    migration_test_add("/migration/precopy/tcp/plain", test_precopy_tcp_plain);
 
-    qtest_add_func("/migration/precopy/tcp/plain/switchover-ack",
-                   test_precopy_tcp_switchover_ack);
+    migration_test_add("/migration/precopy/tcp/plain/switchover-ack",
+                       test_precopy_tcp_switchover_ack);
 
 #ifdef CONFIG_GNUTLS
-    qtest_add_func("/migration/precopy/tcp/tls/psk/match",
-                   test_precopy_tcp_tls_psk_match);
-    qtest_add_func("/migration/precopy/tcp/tls/psk/mismatch",
-                   test_precopy_tcp_tls_psk_mismatch);
+    migration_test_add("/migration/precopy/tcp/tls/psk/match",
+                       test_precopy_tcp_tls_psk_match);
+    migration_test_add("/migration/precopy/tcp/tls/psk/mismatch",
+                       test_precopy_tcp_tls_psk_mismatch);
 #ifdef CONFIG_TASN1
-    qtest_add_func("/migration/precopy/tcp/tls/x509/default-host",
-                   test_precopy_tcp_tls_x509_default_host);
-    qtest_add_func("/migration/precopy/tcp/tls/x509/override-host",
-                   test_precopy_tcp_tls_x509_override_host);
-    qtest_add_func("/migration/precopy/tcp/tls/x509/mismatch-host",
-                   test_precopy_tcp_tls_x509_mismatch_host);
-    qtest_add_func("/migration/precopy/tcp/tls/x509/friendly-client",
-                   test_precopy_tcp_tls_x509_friendly_client);
-    qtest_add_func("/migration/precopy/tcp/tls/x509/hostile-client",
-                   test_precopy_tcp_tls_x509_hostile_client);
-    qtest_add_func("/migration/precopy/tcp/tls/x509/allow-anon-client",
-                   test_precopy_tcp_tls_x509_allow_anon_client);
-    qtest_add_func("/migration/precopy/tcp/tls/x509/reject-anon-client",
-                   test_precopy_tcp_tls_x509_reject_anon_client);
+    migration_test_add("/migration/precopy/tcp/tls/x509/default-host",
+                       test_precopy_tcp_tls_x509_default_host);
+    migration_test_add("/migration/precopy/tcp/tls/x509/override-host",
+                       test_precopy_tcp_tls_x509_override_host);
+    migration_test_add("/migration/precopy/tcp/tls/x509/mismatch-host",
+                       test_precopy_tcp_tls_x509_mismatch_host);
+    migration_test_add("/migration/precopy/tcp/tls/x509/friendly-client",
+                       test_precopy_tcp_tls_x509_friendly_client);
+    migration_test_add("/migration/precopy/tcp/tls/x509/hostile-client",
+                       test_precopy_tcp_tls_x509_hostile_client);
+    migration_test_add("/migration/precopy/tcp/tls/x509/allow-anon-client",
+                       test_precopy_tcp_tls_x509_allow_anon_client);
+    migration_test_add("/migration/precopy/tcp/tls/x509/reject-anon-client",
+                       test_precopy_tcp_tls_x509_reject_anon_client);
 #endif /* CONFIG_TASN1 */
 #endif /* CONFIG_GNUTLS */
 
-    /* qtest_add_func("/migration/ignore_shared", test_ignore_shared); */
+    /* migration_test_add("/migration/ignore_shared", test_ignore_shared); */
 #ifndef _WIN32
-    qtest_add_func("/migration/fd_proto", test_migrate_fd_proto);
+    migration_test_add("/migration/fd_proto", test_migrate_fd_proto);
 #endif
-    qtest_add_func("/migration/validate_uuid", test_validate_uuid);
-    qtest_add_func("/migration/validate_uuid_error", test_validate_uuid_error);
-    qtest_add_func("/migration/validate_uuid_src_not_set",
-                   test_validate_uuid_src_not_set);
-    qtest_add_func("/migration/validate_uuid_dst_not_set",
-                   test_validate_uuid_dst_not_set);
+    migration_test_add("/migration/validate_uuid", test_validate_uuid);
+    migration_test_add("/migration/validate_uuid_error",
+                       test_validate_uuid_error);
+    migration_test_add("/migration/validate_uuid_src_not_set",
+                       test_validate_uuid_src_not_set);
+    migration_test_add("/migration/validate_uuid_dst_not_set",
+                       test_validate_uuid_dst_not_set);
     /*
      * See explanation why this test is slow on function definition
      */
     if (g_test_slow()) {
-        qtest_add_func("/migration/auto_converge", test_migrate_auto_converge);
+        migration_test_add("/migration/auto_converge",
+                           test_migrate_auto_converge);
         if (g_str_equal(arch, "x86_64") &&
             has_kvm && kvm_dirty_ring_supported()) {
-            qtest_add_func("/migration/dirty_limit", test_migrate_dirty_limit);
+            migration_test_add("/migration/dirty_limit",
+                               test_migrate_dirty_limit);
         }
     }
-    qtest_add_func("/migration/multifd/tcp/plain/none",
-                   test_multifd_tcp_none);
+    migration_test_add("/migration/multifd/tcp/plain/none",
+                       test_multifd_tcp_none);
     /*
      * This test is flaky and sometimes fails in CI and otherwise:
      * don't run unless user opts in via environment variable.
      */
     if (getenv("QEMU_TEST_FLAKY_TESTS")) {
-        qtest_add_func("/migration/multifd/tcp/plain/cancel",
-                       test_multifd_tcp_cancel);
+        migration_test_add("/migration/multifd/tcp/plain/cancel",
+                           test_multifd_tcp_cancel);
     }
-    qtest_add_func("/migration/multifd/tcp/plain/zlib",
-                   test_multifd_tcp_zlib);
+    migration_test_add("/migration/multifd/tcp/plain/zlib",
+                       test_multifd_tcp_zlib);
 #ifdef CONFIG_ZSTD
-    qtest_add_func("/migration/multifd/tcp/plain/zstd",
-                   test_multifd_tcp_zstd);
+    migration_test_add("/migration/multifd/tcp/plain/zstd",
+                       test_multifd_tcp_zstd);
 #endif
 #ifdef CONFIG_GNUTLS
-    qtest_add_func("/migration/multifd/tcp/tls/psk/match",
-                   test_multifd_tcp_tls_psk_match);
-    qtest_add_func("/migration/multifd/tcp/tls/psk/mismatch",
-                   test_multifd_tcp_tls_psk_mismatch);
+    migration_test_add("/migration/multifd/tcp/tls/psk/match",
+                       test_multifd_tcp_tls_psk_match);
+    migration_test_add("/migration/multifd/tcp/tls/psk/mismatch",
+                       test_multifd_tcp_tls_psk_mismatch);
 #ifdef CONFIG_TASN1
-    qtest_add_func("/migration/multifd/tcp/tls/x509/default-host",
-                   test_multifd_tcp_tls_x509_default_host);
-    qtest_add_func("/migration/multifd/tcp/tls/x509/override-host",
-                   test_multifd_tcp_tls_x509_override_host);
-    qtest_add_func("/migration/multifd/tcp/tls/x509/mismatch-host",
-                   test_multifd_tcp_tls_x509_mismatch_host);
-    qtest_add_func("/migration/multifd/tcp/tls/x509/allow-anon-client",
-                   test_multifd_tcp_tls_x509_allow_anon_client);
-    qtest_add_func("/migration/multifd/tcp/tls/x509/reject-anon-client",
-                   test_multifd_tcp_tls_x509_reject_anon_client);
+    migration_test_add("/migration/multifd/tcp/tls/x509/default-host",
+                       test_multifd_tcp_tls_x509_default_host);
+    migration_test_add("/migration/multifd/tcp/tls/x509/override-host",
+                       test_multifd_tcp_tls_x509_override_host);
+    migration_test_add("/migration/multifd/tcp/tls/x509/mismatch-host",
+                       test_multifd_tcp_tls_x509_mismatch_host);
+    migration_test_add("/migration/multifd/tcp/tls/x509/allow-anon-client",
+                       test_multifd_tcp_tls_x509_allow_anon_client);
+    migration_test_add("/migration/multifd/tcp/tls/x509/reject-anon-client",
+                       test_multifd_tcp_tls_x509_reject_anon_client);
 #endif /* CONFIG_TASN1 */
 #endif /* CONFIG_GNUTLS */
 
     if (g_str_equal(arch, "x86_64") && has_kvm && kvm_dirty_ring_supported()) {
-        qtest_add_func("/migration/dirty_ring",
-                       test_precopy_unix_dirty_ring);
-        qtest_add_func("/migration/vcpu_dirty_limit",
-                       test_vcpu_dirty_limit);
+        migration_test_add("/migration/dirty_ring",
+                           test_precopy_unix_dirty_ring);
+        migration_test_add("/migration/vcpu_dirty_limit",
+                           test_vcpu_dirty_limit);
     }
 
     ret = g_test_run();
-- 
2.35.3


