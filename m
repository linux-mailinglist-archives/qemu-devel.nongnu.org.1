Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3939D9EEAA0
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Dec 2024 16:16:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLkpL-0003uW-L2; Thu, 12 Dec 2024 10:10:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tLkpK-0003u1-12
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 10:10:06 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tLkpG-0002zR-9t
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 10:10:05 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 25C2B1F383;
 Thu, 12 Dec 2024 15:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734016201; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c8bBxBLc9bu+QT6mHwmZOGN9I2/2NsTW87I80M8qWjI=;
 b=vo3y/PxgzTVWXe7CEtqnICLqPrSf7QSIB/1WiOTk+D8H+O+uCCJnzNR9T1JAgkZDCciUkx
 UBVZBM/CHp0s53fwvMoGhB3MUe/HSqFq8UZJoMxEFK/7+jZs+9y1SQ84t8dmoB7goJ4YIo
 b3+ZPyZSb+iqsORJuBtpgs9zhRDHFSg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734016201;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c8bBxBLc9bu+QT6mHwmZOGN9I2/2NsTW87I80M8qWjI=;
 b=Pb32yzbs14k4TtDCt2RWEej9StkNcprs595MGWoarNb5pyE8W6UyX6sEPaia7xoQLMtR1a
 Ip+WNSdXYVb07TDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734016201; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c8bBxBLc9bu+QT6mHwmZOGN9I2/2NsTW87I80M8qWjI=;
 b=vo3y/PxgzTVWXe7CEtqnICLqPrSf7QSIB/1WiOTk+D8H+O+uCCJnzNR9T1JAgkZDCciUkx
 UBVZBM/CHp0s53fwvMoGhB3MUe/HSqFq8UZJoMxEFK/7+jZs+9y1SQ84t8dmoB7goJ4YIo
 b3+ZPyZSb+iqsORJuBtpgs9zhRDHFSg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734016201;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c8bBxBLc9bu+QT6mHwmZOGN9I2/2NsTW87I80M8qWjI=;
 b=Pb32yzbs14k4TtDCt2RWEej9StkNcprs595MGWoarNb5pyE8W6UyX6sEPaia7xoQLMtR1a
 Ip+WNSdXYVb07TDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E6BD313508;
 Thu, 12 Dec 2024 15:09:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KLygKsf8WmcTfQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 12 Dec 2024 15:09:59 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Peter Xu <peterx@redhat.com>
Subject: [PULL 05/22] tests/qtest/migration: Standardize hook names
Date: Thu, 12 Dec 2024 12:09:32 -0300
Message-Id: <20241212150949.16806-6-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241212150949.16806-1-farosas@suse.de>
References: <20241212150949.16806-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:helo]
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

Standardize the hook names:

- change the names to .start|end_hook to match
  test_migrate_start|end()

- use the migrate_hook_start_ and migrate_hook_end_ prefixes

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-test.c | 342 ++++++++++++++++++-----------------
 1 file changed, 174 insertions(+), 168 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 74d3000198..f0f3145c59 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -631,9 +631,9 @@ typedef void * (*TestMigrateStartHook)(QTestState *from,
  * @opaque is a pointer to state previously returned
  * by the TestMigrateStartHook if any, or NULL.
  */
-typedef void (*TestMigrateFinishHook)(QTestState *from,
-                                      QTestState *to,
-                                      void *opaque);
+typedef void (*TestMigrateEndHook)(QTestState *from,
+                                   QTestState *to,
+                                   void *opaque);
 
 typedef struct {
     /* Optional: fine tune start parameters */
@@ -660,7 +660,7 @@ typedef struct {
     /* Optional: callback to run at start to set migration parameters */
     TestMigrateStartHook start_hook;
     /* Optional: callback to run at finish to cleanup */
-    TestMigrateFinishHook finish_hook;
+    TestMigrateEndHook end_hook;
 
     /*
      * Optional: normally we expect the migration process to complete.
@@ -919,7 +919,7 @@ struct TestMigrateTLSPSKData {
 };
 
 static void *
-test_migrate_tls_psk_start_common(QTestState *from,
+migrate_hook_start_tls_psk_common(QTestState *from,
                                   QTestState *to,
                                   bool mismatch)
 {
@@ -964,23 +964,23 @@ test_migrate_tls_psk_start_common(QTestState *from,
 }
 
 static void *
-test_migrate_tls_psk_start_match(QTestState *from,
+migrate_hook_start_tls_psk_match(QTestState *from,
                                  QTestState *to)
 {
-    return test_migrate_tls_psk_start_common(from, to, false);
+    return migrate_hook_start_tls_psk_common(from, to, false);
 }
 
 static void *
-test_migrate_tls_psk_start_mismatch(QTestState *from,
+migrate_hook_start_tls_psk_mismatch(QTestState *from,
                                     QTestState *to)
 {
-    return test_migrate_tls_psk_start_common(from, to, true);
+    return migrate_hook_start_tls_psk_common(from, to, true);
 }
 
 static void
-test_migrate_tls_psk_finish(QTestState *from,
-                            QTestState *to,
-                            void *opaque)
+migrate_hook_end_tls_psk(QTestState *from,
+                         QTestState *to,
+                         void *opaque)
 {
     struct TestMigrateTLSPSKData *data = opaque;
 
@@ -1021,7 +1021,7 @@ typedef struct {
 } TestMigrateTLSX509;
 
 static void *
-test_migrate_tls_x509_start_common(QTestState *from,
+migrate_hook_start_tls_x509_common(QTestState *from,
                                    QTestState *to,
                                    TestMigrateTLSX509 *args)
 {
@@ -1114,7 +1114,7 @@ test_migrate_tls_x509_start_common(QTestState *from,
  * whatever host we were telling QEMU to connect to (if any)
  */
 static void *
-test_migrate_tls_x509_start_default_host(QTestState *from,
+migrate_hook_start_tls_x509_default_host(QTestState *from,
                                          QTestState *to)
 {
     TestMigrateTLSX509 args = {
@@ -1122,7 +1122,7 @@ test_migrate_tls_x509_start_default_host(QTestState *from,
         .clientcert = true,
         .certipaddr = "127.0.0.1"
     };
-    return test_migrate_tls_x509_start_common(from, to, &args);
+    return migrate_hook_start_tls_x509_common(from, to, &args);
 }
 
 /*
@@ -1131,7 +1131,7 @@ test_migrate_tls_x509_start_default_host(QTestState *from,
  * so we must give QEMU an explicit hostname to validate
  */
 static void *
-test_migrate_tls_x509_start_override_host(QTestState *from,
+migrate_hook_start_tls_x509_override_host(QTestState *from,
                                           QTestState *to)
 {
     TestMigrateTLSX509 args = {
@@ -1139,7 +1139,7 @@ test_migrate_tls_x509_start_override_host(QTestState *from,
         .clientcert = true,
         .certhostname = "qemu.org",
     };
-    return test_migrate_tls_x509_start_common(from, to, &args);
+    return migrate_hook_start_tls_x509_common(from, to, &args);
 }
 
 /*
@@ -1148,7 +1148,7 @@ test_migrate_tls_x509_start_override_host(QTestState *from,
  * expect the client to reject the server
  */
 static void *
-test_migrate_tls_x509_start_mismatch_host(QTestState *from,
+migrate_hook_start_tls_x509_mismatch_host(QTestState *from,
                                           QTestState *to)
 {
     TestMigrateTLSX509 args = {
@@ -1156,11 +1156,11 @@ test_migrate_tls_x509_start_mismatch_host(QTestState *from,
         .clientcert = true,
         .certipaddr = "10.0.0.1",
     };
-    return test_migrate_tls_x509_start_common(from, to, &args);
+    return migrate_hook_start_tls_x509_common(from, to, &args);
 }
 
 static void *
-test_migrate_tls_x509_start_friendly_client(QTestState *from,
+migrate_hook_start_tls_x509_friendly_client(QTestState *from,
                                             QTestState *to)
 {
     TestMigrateTLSX509 args = {
@@ -1169,11 +1169,11 @@ test_migrate_tls_x509_start_friendly_client(QTestState *from,
         .authzclient = true,
         .certipaddr = "127.0.0.1",
     };
-    return test_migrate_tls_x509_start_common(from, to, &args);
+    return migrate_hook_start_tls_x509_common(from, to, &args);
 }
 
 static void *
-test_migrate_tls_x509_start_hostile_client(QTestState *from,
+migrate_hook_start_tls_x509_hostile_client(QTestState *from,
                                            QTestState *to)
 {
     TestMigrateTLSX509 args = {
@@ -1183,7 +1183,7 @@ test_migrate_tls_x509_start_hostile_client(QTestState *from,
         .authzclient = true,
         .certipaddr = "127.0.0.1",
     };
-    return test_migrate_tls_x509_start_common(from, to, &args);
+    return migrate_hook_start_tls_x509_common(from, to, &args);
 }
 
 /*
@@ -1191,13 +1191,13 @@ test_migrate_tls_x509_start_hostile_client(QTestState *from,
  * and no server verification
  */
 static void *
-test_migrate_tls_x509_start_allow_anon_client(QTestState *from,
+migrate_hook_start_tls_x509_allow_anon_client(QTestState *from,
                                               QTestState *to)
 {
     TestMigrateTLSX509 args = {
         .certipaddr = "127.0.0.1",
     };
-    return test_migrate_tls_x509_start_common(from, to, &args);
+    return migrate_hook_start_tls_x509_common(from, to, &args);
 }
 
 /*
@@ -1205,20 +1205,20 @@ test_migrate_tls_x509_start_allow_anon_client(QTestState *from,
  * and server verification rejecting
  */
 static void *
-test_migrate_tls_x509_start_reject_anon_client(QTestState *from,
+migrate_hook_start_tls_x509_reject_anon_client(QTestState *from,
                                                QTestState *to)
 {
     TestMigrateTLSX509 args = {
         .verifyclient = true,
         .certipaddr = "127.0.0.1",
     };
-    return test_migrate_tls_x509_start_common(from, to, &args);
+    return migrate_hook_start_tls_x509_common(from, to, &args);
 }
 
 static void
-test_migrate_tls_x509_finish(QTestState *from,
-                             QTestState *to,
-                             void *opaque)
+migrate_hook_end_tls_x509(QTestState *from,
+                          QTestState *to,
+                          void *opaque)
 {
     TestMigrateTLSX509Data *data = opaque;
 
@@ -1314,8 +1314,8 @@ static void migrate_postcopy_complete(QTestState *from, QTestState *to,
         read_blocktime(to);
     }
 
-    if (args->finish_hook) {
-        args->finish_hook(from, to, args->postcopy_data);
+    if (args->end_hook) {
+        args->end_hook(from, to, args->postcopy_data);
         args->postcopy_data = NULL;
     }
 
@@ -1362,8 +1362,8 @@ static void test_postcopy_preempt(void)
 static void test_postcopy_tls_psk(void)
 {
     MigrateCommon args = {
-        .start_hook = test_migrate_tls_psk_start_match,
-        .finish_hook = test_migrate_tls_psk_finish,
+        .start_hook = migrate_hook_start_tls_psk_match,
+        .end_hook = migrate_hook_end_tls_psk,
     };
 
     test_postcopy_common(&args);
@@ -1373,8 +1373,8 @@ static void test_postcopy_preempt_tls_psk(void)
 {
     MigrateCommon args = {
         .postcopy_preempt = true,
-        .start_hook = test_migrate_tls_psk_start_match,
-        .finish_hook = test_migrate_tls_psk_finish,
+        .start_hook = migrate_hook_start_tls_psk_match,
+        .end_hook = migrate_hook_end_tls_psk,
     };
 
     test_postcopy_common(&args);
@@ -1596,8 +1596,8 @@ static void test_postcopy_recovery_fail_reconnect(void)
 static void test_postcopy_recovery_tls_psk(void)
 {
     MigrateCommon args = {
-        .start_hook = test_migrate_tls_psk_start_match,
-        .finish_hook = test_migrate_tls_psk_finish,
+        .start_hook = migrate_hook_start_tls_psk_match,
+        .end_hook = migrate_hook_end_tls_psk,
     };
 
     test_postcopy_recovery_common(&args);
@@ -1619,8 +1619,8 @@ static void test_postcopy_preempt_all(void)
 {
     MigrateCommon args = {
         .postcopy_preempt = true,
-        .start_hook = test_migrate_tls_psk_start_match,
-        .finish_hook = test_migrate_tls_psk_finish,
+        .start_hook = migrate_hook_start_tls_psk_match,
+        .end_hook = migrate_hook_end_tls_psk,
     };
 
     test_postcopy_recovery_common(&args);
@@ -1794,8 +1794,8 @@ static void test_precopy_common(MigrateCommon *args)
     }
 
 finish:
-    if (args->finish_hook) {
-        args->finish_hook(from, to, data_hook);
+    if (args->end_hook) {
+        args->end_hook(from, to, data_hook);
     }
 
     test_migrate_end(from, to, args->result == MIG_TEST_SUCCEED);
@@ -1899,8 +1899,8 @@ static void test_file_common(MigrateCommon *args, bool stop_src)
     }
 
 finish:
-    if (args->finish_hook) {
-        args->finish_hook(from, to, data_hook);
+    if (args->end_hook) {
+        args->end_hook(from, to, data_hook);
     }
 
     test_migrate_end(from, to, args->result == MIG_TEST_SUCCEED);
@@ -1977,8 +1977,8 @@ static void test_precopy_unix_tls_psk(void)
     MigrateCommon args = {
         .connect_uri = uri,
         .listen_uri = uri,
-        .start_hook = test_migrate_tls_psk_start_match,
-        .finish_hook = test_migrate_tls_psk_finish,
+        .start_hook = migrate_hook_start_tls_psk_match,
+        .end_hook = migrate_hook_end_tls_psk,
     };
 
     test_precopy_common(&args);
@@ -1994,8 +1994,8 @@ static void test_precopy_unix_tls_x509_default_host(void)
         },
         .connect_uri = uri,
         .listen_uri = uri,
-        .start_hook = test_migrate_tls_x509_start_default_host,
-        .finish_hook = test_migrate_tls_x509_finish,
+        .start_hook = migrate_hook_start_tls_x509_default_host,
+        .end_hook = migrate_hook_end_tls_x509,
         .result = MIG_TEST_FAIL_DEST_QUIT_ERR,
     };
 
@@ -2008,8 +2008,8 @@ static void test_precopy_unix_tls_x509_override_host(void)
     MigrateCommon args = {
         .connect_uri = uri,
         .listen_uri = uri,
-        .start_hook = test_migrate_tls_x509_start_override_host,
-        .finish_hook = test_migrate_tls_x509_finish,
+        .start_hook = migrate_hook_start_tls_x509_override_host,
+        .end_hook = migrate_hook_end_tls_x509,
     };
 
     test_precopy_common(&args);
@@ -2056,7 +2056,7 @@ static void test_ignore_shared(void)
 #endif
 
 static void *
-test_migrate_xbzrle_start(QTestState *from,
+migrate_hook_start_xbzrle(QTestState *from,
                           QTestState *to)
 {
     migrate_set_parameter_int(from, "xbzrle-cache-size", 33554432);
@@ -2073,7 +2073,7 @@ static void test_precopy_unix_xbzrle(void)
     MigrateCommon args = {
         .connect_uri = uri,
         .listen_uri = uri,
-        .start_hook = test_migrate_xbzrle_start,
+        .start_hook = migrate_hook_start_xbzrle,
         .iterations = 2,
         /*
          * XBZRLE needs pages to be modified when doing the 2nd+ round
@@ -2120,7 +2120,8 @@ static void fdset_add_fds(QTestState *qts, const char *file, int flags,
     }
 }
 
-static void *file_offset_fdset_start_hook(QTestState *from, QTestState *to)
+static void *migrate_hook_start_file_offset_fdset(QTestState *from,
+                                                  QTestState *to)
 {
     g_autofree char *file = g_strdup_printf("%s/%s", tmpfs, FILE_TEST_FILENAME);
 
@@ -2137,7 +2138,7 @@ static void test_precopy_file_offset_fdset(void)
     MigrateCommon args = {
         .connect_uri = uri,
         .listen_uri = "defer",
-        .start_hook = file_offset_fdset_start_hook,
+        .start_hook = migrate_hook_start_file_offset_fdset,
     };
 
     test_file_common(&args, false);
@@ -2171,7 +2172,7 @@ static void test_precopy_file_offset_bad(void)
     test_file_common(&args, false);
 }
 
-static void *test_mode_reboot_start(QTestState *from, QTestState *to)
+static void *migrate_hook_start_mode_reboot(QTestState *from, QTestState *to)
 {
     migrate_set_parameter_str(from, "mode", "cpr-reboot");
     migrate_set_parameter_str(to, "mode", "cpr-reboot");
@@ -2182,7 +2183,7 @@ static void *test_mode_reboot_start(QTestState *from, QTestState *to)
     return NULL;
 }
 
-static void *migrate_mapped_ram_start(QTestState *from, QTestState *to)
+static void *migrate_hook_start_mapped_ram(QTestState *from, QTestState *to)
 {
     migrate_set_capability(from, "mapped-ram", true);
     migrate_set_capability(to, "mapped-ram", true);
@@ -2198,7 +2199,7 @@ static void test_mode_reboot(void)
         .start.use_shmem = true,
         .connect_uri = uri,
         .listen_uri = "defer",
-        .start_hook = test_mode_reboot_start
+        .start_hook = migrate_hook_start_mode_reboot,
     };
 
     test_file_common(&args, true);
@@ -2211,7 +2212,7 @@ static void test_precopy_file_mapped_ram_live(void)
     MigrateCommon args = {
         .connect_uri = uri,
         .listen_uri = "defer",
-        .start_hook = migrate_mapped_ram_start,
+        .start_hook = migrate_hook_start_mapped_ram,
     };
 
     test_file_common(&args, false);
@@ -2224,15 +2225,16 @@ static void test_precopy_file_mapped_ram(void)
     MigrateCommon args = {
         .connect_uri = uri,
         .listen_uri = "defer",
-        .start_hook = migrate_mapped_ram_start,
+        .start_hook = migrate_hook_start_mapped_ram,
     };
 
     test_file_common(&args, true);
 }
 
-static void *migrate_multifd_mapped_ram_start(QTestState *from, QTestState *to)
+static void *migrate_hook_start_multifd_mapped_ram(QTestState *from,
+                                                   QTestState *to)
 {
-    migrate_mapped_ram_start(from, to);
+    migrate_hook_start_mapped_ram(from, to);
 
     migrate_set_parameter_int(from, "multifd-channels", 4);
     migrate_set_parameter_int(to, "multifd-channels", 4);
@@ -2250,7 +2252,7 @@ static void test_multifd_file_mapped_ram_live(void)
     MigrateCommon args = {
         .connect_uri = uri,
         .listen_uri = "defer",
-        .start_hook = migrate_multifd_mapped_ram_start,
+        .start_hook = migrate_hook_start_multifd_mapped_ram,
     };
 
     test_file_common(&args, false);
@@ -2263,15 +2265,16 @@ static void test_multifd_file_mapped_ram(void)
     MigrateCommon args = {
         .connect_uri = uri,
         .listen_uri = "defer",
-        .start_hook = migrate_multifd_mapped_ram_start,
+        .start_hook = migrate_hook_start_multifd_mapped_ram,
     };
 
     test_file_common(&args, true);
 }
 
-static void *multifd_mapped_ram_dio_start(QTestState *from, QTestState *to)
+static void *migrate_hook_start_multifd_mapped_ram_dio(QTestState *from,
+                                                       QTestState *to)
 {
-    migrate_multifd_mapped_ram_start(from, to);
+    migrate_hook_start_multifd_mapped_ram(from, to);
 
     migrate_set_parameter_bool(from, "direct-io", true);
     migrate_set_parameter_bool(to, "direct-io", true);
@@ -2286,7 +2289,7 @@ static void test_multifd_file_mapped_ram_dio(void)
     MigrateCommon args = {
         .connect_uri = uri,
         .listen_uri = "defer",
-        .start_hook = multifd_mapped_ram_dio_start,
+        .start_hook = migrate_hook_start_multifd_mapped_ram_dio,
     };
 
     if (!probe_o_direct_support(tmpfs)) {
@@ -2298,8 +2301,9 @@ static void test_multifd_file_mapped_ram_dio(void)
 }
 
 #ifndef _WIN32
-static void multifd_mapped_ram_fdset_end(QTestState *from, QTestState *to,
-                                         void *opaque)
+static void migrate_hook_end_multifd_mapped_ram_fdset(QTestState *from,
+                                                      QTestState *to,
+                                                      void *opaque)
 {
     QDict *resp;
     QList *fdsets;
@@ -2323,28 +2327,30 @@ static void multifd_mapped_ram_fdset_end(QTestState *from, QTestState *to,
     qobject_unref(resp);
 }
 
-static void *multifd_mapped_ram_fdset_dio(QTestState *from, QTestState *to)
+static void *migrate_hook_start_multifd_mapped_ram_fdset_dio(QTestState *from,
+                                                             QTestState *to)
 {
     g_autofree char *file = g_strdup_printf("%s/%s", tmpfs, FILE_TEST_FILENAME);
 
     fdset_add_fds(from, file, O_WRONLY, 2, true);
     fdset_add_fds(to, file, O_RDONLY, 2, true);
 
-    migrate_multifd_mapped_ram_start(from, to);
+    migrate_hook_start_multifd_mapped_ram(from, to);
     migrate_set_parameter_bool(from, "direct-io", true);
     migrate_set_parameter_bool(to, "direct-io", true);
 
     return NULL;
 }
 
-static void *multifd_mapped_ram_fdset(QTestState *from, QTestState *to)
+static void *migrate_hook_start_multifd_mapped_ram_fdset(QTestState *from,
+                                                         QTestState *to)
 {
     g_autofree char *file = g_strdup_printf("%s/%s", tmpfs, FILE_TEST_FILENAME);
 
     fdset_add_fds(from, file, O_WRONLY, 2, false);
     fdset_add_fds(to, file, O_RDONLY, 2, false);
 
-    migrate_multifd_mapped_ram_start(from, to);
+    migrate_hook_start_multifd_mapped_ram(from, to);
 
     return NULL;
 }
@@ -2356,8 +2362,8 @@ static void test_multifd_file_mapped_ram_fdset(void)
     MigrateCommon args = {
         .connect_uri = uri,
         .listen_uri = "defer",
-        .start_hook = multifd_mapped_ram_fdset,
-        .finish_hook = multifd_mapped_ram_fdset_end,
+        .start_hook = migrate_hook_start_multifd_mapped_ram_fdset,
+        .end_hook = migrate_hook_end_multifd_mapped_ram_fdset,
     };
 
     test_file_common(&args, true);
@@ -2370,8 +2376,8 @@ static void test_multifd_file_mapped_ram_fdset_dio(void)
     MigrateCommon args = {
         .connect_uri = uri,
         .listen_uri = "defer",
-        .start_hook = multifd_mapped_ram_fdset_dio,
-        .finish_hook = multifd_mapped_ram_fdset_end,
+        .start_hook = migrate_hook_start_multifd_mapped_ram_fdset_dio,
+        .end_hook = migrate_hook_end_multifd_mapped_ram_fdset,
     };
 
     if (!probe_o_direct_support(tmpfs)) {
@@ -2392,7 +2398,7 @@ static void test_precopy_tcp_plain(void)
     test_precopy_common(&args);
 }
 
-static void *test_migrate_switchover_ack_start(QTestState *from, QTestState *to)
+static void *migrate_hook_start_switchover_ack(QTestState *from, QTestState *to)
 {
 
     migrate_set_capability(from, "return-path", true);
@@ -2408,7 +2414,7 @@ static void test_precopy_tcp_switchover_ack(void)
 {
     MigrateCommon args = {
         .listen_uri = "tcp:127.0.0.1:0",
-        .start_hook = test_migrate_switchover_ack_start,
+        .start_hook = migrate_hook_start_switchover_ack,
         /*
          * Source VM must be running in order to consider the switchover ACK
          * when deciding to do switchover or not.
@@ -2424,8 +2430,8 @@ static void test_precopy_tcp_tls_psk_match(void)
 {
     MigrateCommon args = {
         .listen_uri = "tcp:127.0.0.1:0",
-        .start_hook = test_migrate_tls_psk_start_match,
-        .finish_hook = test_migrate_tls_psk_finish,
+        .start_hook = migrate_hook_start_tls_psk_match,
+        .end_hook = migrate_hook_end_tls_psk,
     };
 
     test_precopy_common(&args);
@@ -2438,8 +2444,8 @@ static void test_precopy_tcp_tls_psk_mismatch(void)
             .hide_stderr = true,
         },
         .listen_uri = "tcp:127.0.0.1:0",
-        .start_hook = test_migrate_tls_psk_start_mismatch,
-        .finish_hook = test_migrate_tls_psk_finish,
+        .start_hook = migrate_hook_start_tls_psk_mismatch,
+        .end_hook = migrate_hook_end_tls_psk,
         .result = MIG_TEST_FAIL,
     };
 
@@ -2451,8 +2457,8 @@ static void test_precopy_tcp_tls_x509_default_host(void)
 {
     MigrateCommon args = {
         .listen_uri = "tcp:127.0.0.1:0",
-        .start_hook = test_migrate_tls_x509_start_default_host,
-        .finish_hook = test_migrate_tls_x509_finish,
+        .start_hook = migrate_hook_start_tls_x509_default_host,
+        .end_hook = migrate_hook_end_tls_x509,
     };
 
     test_precopy_common(&args);
@@ -2462,8 +2468,8 @@ static void test_precopy_tcp_tls_x509_override_host(void)
 {
     MigrateCommon args = {
         .listen_uri = "tcp:127.0.0.1:0",
-        .start_hook = test_migrate_tls_x509_start_override_host,
-        .finish_hook = test_migrate_tls_x509_finish,
+        .start_hook = migrate_hook_start_tls_x509_override_host,
+        .end_hook = migrate_hook_end_tls_x509,
     };
 
     test_precopy_common(&args);
@@ -2476,8 +2482,8 @@ static void test_precopy_tcp_tls_x509_mismatch_host(void)
             .hide_stderr = true,
         },
         .listen_uri = "tcp:127.0.0.1:0",
-        .start_hook = test_migrate_tls_x509_start_mismatch_host,
-        .finish_hook = test_migrate_tls_x509_finish,
+        .start_hook = migrate_hook_start_tls_x509_mismatch_host,
+        .end_hook = migrate_hook_end_tls_x509,
         .result = MIG_TEST_FAIL_DEST_QUIT_ERR,
     };
 
@@ -2488,8 +2494,8 @@ static void test_precopy_tcp_tls_x509_friendly_client(void)
 {
     MigrateCommon args = {
         .listen_uri = "tcp:127.0.0.1:0",
-        .start_hook = test_migrate_tls_x509_start_friendly_client,
-        .finish_hook = test_migrate_tls_x509_finish,
+        .start_hook = migrate_hook_start_tls_x509_friendly_client,
+        .end_hook = migrate_hook_end_tls_x509,
     };
 
     test_precopy_common(&args);
@@ -2502,8 +2508,8 @@ static void test_precopy_tcp_tls_x509_hostile_client(void)
             .hide_stderr = true,
         },
         .listen_uri = "tcp:127.0.0.1:0",
-        .start_hook = test_migrate_tls_x509_start_hostile_client,
-        .finish_hook = test_migrate_tls_x509_finish,
+        .start_hook = migrate_hook_start_tls_x509_hostile_client,
+        .end_hook = migrate_hook_end_tls_x509,
         .result = MIG_TEST_FAIL,
     };
 
@@ -2514,8 +2520,8 @@ static void test_precopy_tcp_tls_x509_allow_anon_client(void)
 {
     MigrateCommon args = {
         .listen_uri = "tcp:127.0.0.1:0",
-        .start_hook = test_migrate_tls_x509_start_allow_anon_client,
-        .finish_hook = test_migrate_tls_x509_finish,
+        .start_hook = migrate_hook_start_tls_x509_allow_anon_client,
+        .end_hook = migrate_hook_end_tls_x509,
     };
 
     test_precopy_common(&args);
@@ -2528,8 +2534,8 @@ static void test_precopy_tcp_tls_x509_reject_anon_client(void)
             .hide_stderr = true,
         },
         .listen_uri = "tcp:127.0.0.1:0",
-        .start_hook = test_migrate_tls_x509_start_reject_anon_client,
-        .finish_hook = test_migrate_tls_x509_finish,
+        .start_hook = migrate_hook_start_tls_x509_reject_anon_client,
+        .end_hook = migrate_hook_end_tls_x509,
         .result = MIG_TEST_FAIL,
     };
 
@@ -2539,8 +2545,8 @@ static void test_precopy_tcp_tls_x509_reject_anon_client(void)
 #endif /* CONFIG_GNUTLS */
 
 #ifndef _WIN32
-static void *test_migrate_fd_start_hook(QTestState *from,
-                                        QTestState *to)
+static void *migrate_hook_start_fd(QTestState *from,
+                                   QTestState *to)
 {
     int ret;
     int pair[2];
@@ -2567,9 +2573,9 @@ static void *test_migrate_fd_start_hook(QTestState *from,
     return NULL;
 }
 
-static void test_migrate_fd_finish_hook(QTestState *from,
-                                        QTestState *to,
-                                        void *opaque)
+static void migrate_hook_end_fd(QTestState *from,
+                                QTestState *to,
+                                void *opaque)
 {
     QDict *rsp;
     const char *error_desc;
@@ -2599,13 +2605,13 @@ static void test_migrate_precopy_fd_socket(void)
     MigrateCommon args = {
         .listen_uri = "defer",
         .connect_uri = "fd:fd-mig",
-        .start_hook = test_migrate_fd_start_hook,
-        .finish_hook = test_migrate_fd_finish_hook
+        .start_hook = migrate_hook_start_fd,
+        .end_hook = migrate_hook_end_fd,
     };
     test_precopy_common(&args);
 }
 
-static void *migrate_precopy_fd_file_start(QTestState *from, QTestState *to)
+static void *migrate_hook_start_precopy_fd_file(QTestState *from, QTestState *to)
 {
     g_autofree char *file = g_strdup_printf("%s/%s", tmpfs, FILE_TEST_FILENAME);
     int src_flags = O_CREAT | O_RDWR;
@@ -2638,8 +2644,8 @@ static void test_migrate_precopy_fd_file(void)
     MigrateCommon args = {
         .listen_uri = "defer",
         .connect_uri = "fd:fd-mig",
-        .start_hook = migrate_precopy_fd_file_start,
-        .finish_hook = test_migrate_fd_finish_hook
+        .start_hook = migrate_hook_start_precopy_fd_file,
+        .end_hook = migrate_hook_end_fd,
     };
     test_file_common(&args, true);
 }
@@ -2886,7 +2892,7 @@ static void test_migrate_auto_converge(void)
 }
 
 static void *
-test_migrate_precopy_tcp_multifd_start_common(QTestState *from,
+migrate_hook_start_precopy_tcp_multifd_common(QTestState *from,
                                               QTestState *to,
                                               const char *method)
 {
@@ -2906,32 +2912,32 @@ test_migrate_precopy_tcp_multifd_start_common(QTestState *from,
 }
 
 static void *
-test_migrate_precopy_tcp_multifd_start(QTestState *from,
+migrate_hook_start_precopy_tcp_multifd(QTestState *from,
                                        QTestState *to)
 {
-    return test_migrate_precopy_tcp_multifd_start_common(from, to, "none");
+    return migrate_hook_start_precopy_tcp_multifd_common(from, to, "none");
 }
 
 static void *
-test_migrate_precopy_tcp_multifd_start_zero_page_legacy(QTestState *from,
+migrate_hook_start_precopy_tcp_multifd_zero_page_legacy(QTestState *from,
                                                         QTestState *to)
 {
-    test_migrate_precopy_tcp_multifd_start_common(from, to, "none");
+    migrate_hook_start_precopy_tcp_multifd_common(from, to, "none");
     migrate_set_parameter_str(from, "zero-page-detection", "legacy");
     return NULL;
 }
 
 static void *
-test_migration_precopy_tcp_multifd_start_no_zero_page(QTestState *from,
-                                                      QTestState *to)
+migrate_hook_start_precopy_tcp_multifd_no_zero_page(QTestState *from,
+                                                    QTestState *to)
 {
-    test_migrate_precopy_tcp_multifd_start_common(from, to, "none");
+    migrate_hook_start_precopy_tcp_multifd_common(from, to, "none");
     migrate_set_parameter_str(from, "zero-page-detection", "none");
     return NULL;
 }
 
 static void *
-test_migrate_precopy_tcp_multifd_zlib_start(QTestState *from,
+migrate_hook_start_precopy_tcp_multifd_zlib(QTestState *from,
                                             QTestState *to)
 {
     /*
@@ -2941,47 +2947,47 @@ test_migrate_precopy_tcp_multifd_zlib_start(QTestState *from,
     migrate_set_parameter_int(from, "multifd-zlib-level", 2);
     migrate_set_parameter_int(to, "multifd-zlib-level", 2);
 
-    return test_migrate_precopy_tcp_multifd_start_common(from, to, "zlib");
+    return migrate_hook_start_precopy_tcp_multifd_common(from, to, "zlib");
 }
 
 #ifdef CONFIG_ZSTD
 static void *
-test_migrate_precopy_tcp_multifd_zstd_start(QTestState *from,
+migrate_hook_start_precopy_tcp_multifd_zstd(QTestState *from,
                                             QTestState *to)
 {
     migrate_set_parameter_int(from, "multifd-zstd-level", 2);
     migrate_set_parameter_int(to, "multifd-zstd-level", 2);
 
-    return test_migrate_precopy_tcp_multifd_start_common(from, to, "zstd");
+    return migrate_hook_start_precopy_tcp_multifd_common(from, to, "zstd");
 }
 #endif /* CONFIG_ZSTD */
 
 #ifdef CONFIG_QATZIP
 static void *
-test_migrate_precopy_tcp_multifd_qatzip_start(QTestState *from,
+migrate_hook_start_precopy_tcp_multifd_qatzip(QTestState *from,
                                               QTestState *to)
 {
     migrate_set_parameter_int(from, "multifd-qatzip-level", 2);
     migrate_set_parameter_int(to, "multifd-qatzip-level", 2);
 
-    return test_migrate_precopy_tcp_multifd_start_common(from, to, "qatzip");
+    return migrate_hook_start_precopy_tcp_multifd_common(from, to, "qatzip");
 }
 #endif
 
 #ifdef CONFIG_QPL
 static void *
-test_migrate_precopy_tcp_multifd_qpl_start(QTestState *from,
+migrate_hook_start_precopy_tcp_multifd_qpl(QTestState *from,
                                            QTestState *to)
 {
-    return test_migrate_precopy_tcp_multifd_start_common(from, to, "qpl");
+    return migrate_hook_start_precopy_tcp_multifd_common(from, to, "qpl");
 }
 #endif /* CONFIG_QPL */
 #ifdef CONFIG_UADK
 static void *
-test_migrate_precopy_tcp_multifd_uadk_start(QTestState *from,
+migrate_hook_start_precopy_tcp_multifd_uadk(QTestState *from,
                                             QTestState *to)
 {
-    return test_migrate_precopy_tcp_multifd_start_common(from, to, "uadk");
+    return migrate_hook_start_precopy_tcp_multifd_common(from, to, "uadk");
 }
 #endif /* CONFIG_UADK */
 
@@ -2989,7 +2995,7 @@ static void test_multifd_tcp_uri_none(void)
 {
     MigrateCommon args = {
         .listen_uri = "defer",
-        .start_hook = test_migrate_precopy_tcp_multifd_start,
+        .start_hook = migrate_hook_start_precopy_tcp_multifd,
         /*
          * Multifd is more complicated than most of the features, it
          * directly takes guest page buffers when sending, make sure
@@ -3004,7 +3010,7 @@ static void test_multifd_tcp_zero_page_legacy(void)
 {
     MigrateCommon args = {
         .listen_uri = "defer",
-        .start_hook = test_migrate_precopy_tcp_multifd_start_zero_page_legacy,
+        .start_hook = migrate_hook_start_precopy_tcp_multifd_zero_page_legacy,
         /*
          * Multifd is more complicated than most of the features, it
          * directly takes guest page buffers when sending, make sure
@@ -3019,7 +3025,7 @@ static void test_multifd_tcp_no_zero_page(void)
 {
     MigrateCommon args = {
         .listen_uri = "defer",
-        .start_hook = test_migration_precopy_tcp_multifd_start_no_zero_page,
+        .start_hook = migrate_hook_start_precopy_tcp_multifd_no_zero_page,
         /*
          * Multifd is more complicated than most of the features, it
          * directly takes guest page buffers when sending, make sure
@@ -3034,7 +3040,7 @@ static void test_multifd_tcp_channels_none(void)
 {
     MigrateCommon args = {
         .listen_uri = "defer",
-        .start_hook = test_migrate_precopy_tcp_multifd_start,
+        .start_hook = migrate_hook_start_precopy_tcp_multifd,
         .live = true,
         .connect_channels = ("[ { 'channel-type': 'main',"
                              "    'addr': { 'transport': 'socket',"
@@ -3049,7 +3055,7 @@ static void test_multifd_tcp_zlib(void)
 {
     MigrateCommon args = {
         .listen_uri = "defer",
-        .start_hook = test_migrate_precopy_tcp_multifd_zlib_start,
+        .start_hook = migrate_hook_start_precopy_tcp_multifd_zlib,
     };
     test_precopy_common(&args);
 }
@@ -3059,7 +3065,7 @@ static void test_multifd_tcp_zstd(void)
 {
     MigrateCommon args = {
         .listen_uri = "defer",
-        .start_hook = test_migrate_precopy_tcp_multifd_zstd_start,
+        .start_hook = migrate_hook_start_precopy_tcp_multifd_zstd,
     };
     test_precopy_common(&args);
 }
@@ -3070,7 +3076,7 @@ static void test_multifd_tcp_qatzip(void)
 {
     MigrateCommon args = {
         .listen_uri = "defer",
-        .start_hook = test_migrate_precopy_tcp_multifd_qatzip_start,
+        .start_hook = migrate_hook_start_precopy_tcp_multifd_qatzip,
     };
     test_precopy_common(&args);
 }
@@ -3081,7 +3087,7 @@ static void test_multifd_tcp_qpl(void)
 {
     MigrateCommon args = {
         .listen_uri = "defer",
-        .start_hook = test_migrate_precopy_tcp_multifd_qpl_start,
+        .start_hook = migrate_hook_start_precopy_tcp_multifd_qpl,
     };
     test_precopy_common(&args);
 }
@@ -3092,7 +3098,7 @@ static void test_multifd_tcp_uadk(void)
 {
     MigrateCommon args = {
         .listen_uri = "defer",
-        .start_hook = test_migrate_precopy_tcp_multifd_uadk_start,
+        .start_hook = migrate_hook_start_precopy_tcp_multifd_uadk,
     };
     test_precopy_common(&args);
 }
@@ -3100,60 +3106,60 @@ static void test_multifd_tcp_uadk(void)
 
 #ifdef CONFIG_GNUTLS
 static void *
-test_migrate_multifd_tcp_tls_psk_start_match(QTestState *from,
+migrate_hook_start_multifd_tcp_tls_psk_match(QTestState *from,
                                              QTestState *to)
 {
-    test_migrate_precopy_tcp_multifd_start_common(from, to, "none");
-    return test_migrate_tls_psk_start_match(from, to);
+    migrate_hook_start_precopy_tcp_multifd_common(from, to, "none");
+    return migrate_hook_start_tls_psk_match(from, to);
 }
 
 static void *
-test_migrate_multifd_tcp_tls_psk_start_mismatch(QTestState *from,
+migrate_hook_start_multifd_tcp_tls_psk_mismatch(QTestState *from,
                                                 QTestState *to)
 {
-    test_migrate_precopy_tcp_multifd_start_common(from, to, "none");
-    return test_migrate_tls_psk_start_mismatch(from, to);
+    migrate_hook_start_precopy_tcp_multifd_common(from, to, "none");
+    return migrate_hook_start_tls_psk_mismatch(from, to);
 }
 
 #ifdef CONFIG_TASN1
 static void *
-test_migrate_multifd_tls_x509_start_default_host(QTestState *from,
+migrate_hook_start_multifd_tls_x509_default_host(QTestState *from,
                                                  QTestState *to)
 {
-    test_migrate_precopy_tcp_multifd_start_common(from, to, "none");
-    return test_migrate_tls_x509_start_default_host(from, to);
+    migrate_hook_start_precopy_tcp_multifd_common(from, to, "none");
+    return migrate_hook_start_tls_x509_default_host(from, to);
 }
 
 static void *
-test_migrate_multifd_tls_x509_start_override_host(QTestState *from,
+migrate_hook_start_multifd_tls_x509_override_host(QTestState *from,
                                                   QTestState *to)
 {
-    test_migrate_precopy_tcp_multifd_start_common(from, to, "none");
-    return test_migrate_tls_x509_start_override_host(from, to);
+    migrate_hook_start_precopy_tcp_multifd_common(from, to, "none");
+    return migrate_hook_start_tls_x509_override_host(from, to);
 }
 
 static void *
-test_migrate_multifd_tls_x509_start_mismatch_host(QTestState *from,
+migrate_hook_start_multifd_tls_x509_mismatch_host(QTestState *from,
                                                   QTestState *to)
 {
-    test_migrate_precopy_tcp_multifd_start_common(from, to, "none");
-    return test_migrate_tls_x509_start_mismatch_host(from, to);
+    migrate_hook_start_precopy_tcp_multifd_common(from, to, "none");
+    return migrate_hook_start_tls_x509_mismatch_host(from, to);
 }
 
 static void *
-test_migrate_multifd_tls_x509_start_allow_anon_client(QTestState *from,
+migrate_hook_start_multifd_tls_x509_allow_anon_client(QTestState *from,
                                                       QTestState *to)
 {
-    test_migrate_precopy_tcp_multifd_start_common(from, to, "none");
-    return test_migrate_tls_x509_start_allow_anon_client(from, to);
+    migrate_hook_start_precopy_tcp_multifd_common(from, to, "none");
+    return migrate_hook_start_tls_x509_allow_anon_client(from, to);
 }
 
 static void *
-test_migrate_multifd_tls_x509_start_reject_anon_client(QTestState *from,
+migrate_hook_start_multifd_tls_x509_reject_anon_client(QTestState *from,
                                                        QTestState *to)
 {
-    test_migrate_precopy_tcp_multifd_start_common(from, to, "none");
-    return test_migrate_tls_x509_start_reject_anon_client(from, to);
+    migrate_hook_start_precopy_tcp_multifd_common(from, to, "none");
+    return migrate_hook_start_tls_x509_reject_anon_client(from, to);
 }
 #endif /* CONFIG_TASN1 */
 
@@ -3161,8 +3167,8 @@ static void test_multifd_tcp_tls_psk_match(void)
 {
     MigrateCommon args = {
         .listen_uri = "defer",
-        .start_hook = test_migrate_multifd_tcp_tls_psk_start_match,
-        .finish_hook = test_migrate_tls_psk_finish,
+        .start_hook = migrate_hook_start_multifd_tcp_tls_psk_match,
+        .end_hook = migrate_hook_end_tls_psk,
     };
     test_precopy_common(&args);
 }
@@ -3174,8 +3180,8 @@ static void test_multifd_tcp_tls_psk_mismatch(void)
             .hide_stderr = true,
         },
         .listen_uri = "defer",
-        .start_hook = test_migrate_multifd_tcp_tls_psk_start_mismatch,
-        .finish_hook = test_migrate_tls_psk_finish,
+        .start_hook = migrate_hook_start_multifd_tcp_tls_psk_mismatch,
+        .end_hook = migrate_hook_end_tls_psk,
         .result = MIG_TEST_FAIL,
     };
     test_precopy_common(&args);
@@ -3186,8 +3192,8 @@ static void test_multifd_tcp_tls_x509_default_host(void)
 {
     MigrateCommon args = {
         .listen_uri = "defer",
-        .start_hook = test_migrate_multifd_tls_x509_start_default_host,
-        .finish_hook = test_migrate_tls_x509_finish,
+        .start_hook = migrate_hook_start_multifd_tls_x509_default_host,
+        .end_hook = migrate_hook_end_tls_x509,
     };
     test_precopy_common(&args);
 }
@@ -3196,8 +3202,8 @@ static void test_multifd_tcp_tls_x509_override_host(void)
 {
     MigrateCommon args = {
         .listen_uri = "defer",
-        .start_hook = test_migrate_multifd_tls_x509_start_override_host,
-        .finish_hook = test_migrate_tls_x509_finish,
+        .start_hook = migrate_hook_start_multifd_tls_x509_override_host,
+        .end_hook = migrate_hook_end_tls_x509,
     };
     test_precopy_common(&args);
 }
@@ -3222,8 +3228,8 @@ static void test_multifd_tcp_tls_x509_mismatch_host(void)
             .hide_stderr = true,
         },
         .listen_uri = "defer",
-        .start_hook = test_migrate_multifd_tls_x509_start_mismatch_host,
-        .finish_hook = test_migrate_tls_x509_finish,
+        .start_hook = migrate_hook_start_multifd_tls_x509_mismatch_host,
+        .end_hook = migrate_hook_end_tls_x509,
         .result = MIG_TEST_FAIL,
     };
     test_precopy_common(&args);
@@ -3233,8 +3239,8 @@ static void test_multifd_tcp_tls_x509_allow_anon_client(void)
 {
     MigrateCommon args = {
         .listen_uri = "defer",
-        .start_hook = test_migrate_multifd_tls_x509_start_allow_anon_client,
-        .finish_hook = test_migrate_tls_x509_finish,
+        .start_hook = migrate_hook_start_multifd_tls_x509_allow_anon_client,
+        .end_hook = migrate_hook_end_tls_x509,
     };
     test_precopy_common(&args);
 }
@@ -3246,8 +3252,8 @@ static void test_multifd_tcp_tls_x509_reject_anon_client(void)
             .hide_stderr = true,
         },
         .listen_uri = "defer",
-        .start_hook = test_migrate_multifd_tls_x509_start_reject_anon_client,
-        .finish_hook = test_migrate_tls_x509_finish,
+        .start_hook = migrate_hook_start_multifd_tls_x509_reject_anon_client,
+        .end_hook = migrate_hook_end_tls_x509,
         .result = MIG_TEST_FAIL,
     };
     test_precopy_common(&args);
-- 
2.35.3


