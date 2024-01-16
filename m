Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD6182E828
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 04:21:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPa0C-0005kY-Gy; Mon, 15 Jan 2024 22:20:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPZzz-0005gu-V1
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 22:20:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPZzw-0002xm-Sl
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 22:20:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705375219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0+o+MbL1QzF9Ussvv07NBtO6Oxt/PgpFeA0JIPJt2Z4=;
 b=dlIc1XR6g7oggaa00nYhg3yiH9QyXBLGzChav2o4Vfa2T5BC6DcSKD+04WNMBBNWxwUAHA
 imYG0GZl1Gpbv1tELbGeu9ZWBqTIJmODOGr4I0i8bfpYwpoSGPzWqssOPObu+gnep9VEpp
 W3MpxDdouZQ5uUHljUk6v0nSRgdM2Dc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-NEooLRA6PoaS3pm6BOJiew-1; Mon, 15 Jan 2024 22:20:17 -0500
X-MC-Unique: NEooLRA6PoaS3pm6BOJiew-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9A44785A58C;
 Tue, 16 Jan 2024 03:20:17 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 26F843C25;
 Tue, 16 Jan 2024 03:20:14 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: peterx@redhat.com,
	Fabiano Rosas <farosas@suse.de>
Subject: [PULL 08/20] tests/qtest/migration: Use the new migration_test_add
Date: Tue, 16 Jan 2024 11:19:35 +0800
Message-ID: <20240116031947.69017-9-peterx@redhat.com>
In-Reply-To: <20240116031947.69017-1-peterx@redhat.com>
References: <20240116031947.69017-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.531,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Replace the tests registration with the new function that prints tests
names.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/20240104142144.9680-8-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration-test.c | 215 ++++++++++++++++++-----------------
 1 file changed, 112 insertions(+), 103 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 136e5df06c..21da140aea 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -3404,70 +3404,75 @@ int main(int argc, char **argv)
     module_call_init(MODULE_INIT_QOM);
 
     if (is_x86) {
-        qtest_add_func("/migration/precopy/unix/suspend/live",
-                       test_precopy_unix_suspend_live);
-        qtest_add_func("/migration/precopy/unix/suspend/notlive",
-                       test_precopy_unix_suspend_notlive);
+        migration_test_add("/migration/precopy/unix/suspend/live",
+                           test_precopy_unix_suspend_live);
+        migration_test_add("/migration/precopy/unix/suspend/notlive",
+                           test_precopy_unix_suspend_notlive);
     }
 
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
         if (is_x86) {
-            qtest_add_func("/migration/postcopy/suspend",
-                           test_postcopy_suspend);
+            migration_test_add("/migration/postcopy/suspend",
+                               test_postcopy_suspend);
         }
     }
 
-    qtest_add_func("/migration/bad_dest", test_baddest);
+    migration_test_add("/migration/bad_dest", test_baddest);
 #ifndef _WIN32
-    qtest_add_func("/migration/analyze-script", test_analyze_script);
+    if (!g_str_equal(arch, "s390x")) {
+        migration_test_add("/migration/analyze-script", test_analyze_script);
+    }
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
@@ -3475,110 +3480,114 @@ int main(int argc, char **argv)
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
2.43.0


