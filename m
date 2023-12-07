Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFA6808CCE
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 16:59:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBGlu-0000Do-AA; Thu, 07 Dec 2023 10:58:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rBGli-0000CM-K4
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 10:58:30 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rBGlc-0007JW-To
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 10:58:30 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BD8E1220B6;
 Thu,  7 Dec 2023 15:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1701964702; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MaScGdicoRo8t6G0OgtEynTGHpaFIjjE8+S0lN8XEi8=;
 b=eU0zXACd+8gDE1QAa41W7O+Zv2yX1WMPw2/884ewjrmnZtYzbs7w0WIEDrLWzbxjUVIoLE
 PmtyOYtRPZaR+PkwVYGntEeVSW6rN6FR2wUEhZsYpuumwmDJSTXj5uP1r7qVseeWaJ4rUG
 BWexUn+fd1eLBq06OZUpUptHvKMReWs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1701964702;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MaScGdicoRo8t6G0OgtEynTGHpaFIjjE8+S0lN8XEi8=;
 b=iWy+xXcx2SgT+hMY0TIbM+15c9B/mRa7kVxsn6XF1kTBU7Nxdge5gaoJtxjZfXZtRipAtW
 A59kO7+EXkHtarDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 44BDD13B6A;
 Thu,  7 Dec 2023 15:58:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kM+DA5zrcWXDVgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 07 Dec 2023 15:58:20 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v1 3/5] tests/qtest/migration: Adapt tests to use older QEMUs
Date: Thu,  7 Dec 2023 12:58:07 -0300
Message-Id: <20231207155809.25673-4-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231207155809.25673-1-farosas@suse.de>
References: <20231207155809.25673-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.90 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_SEVEN(0.00)[9]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: 1.90
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Add the 'since' annotations to recently added tests and adapt the
postcopy test to use the older "uri" API when needed.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-test.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index b3ce288a73..f16e71d821 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -1337,14 +1337,21 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
     migrate_ensure_non_converge(from);
 
     migrate_prepare_for_dirty_mem(from);
-    qtest_qmp_assert_success(to, "{ 'execute': 'migrate-incoming',"
-                             "  'arguments': { "
-                             "      'channels': [ { 'channel-type': 'main',"
-                             "      'addr': { 'transport': 'socket',"
-                             "                'type': 'inet',"
-                             "                'host': '127.0.0.1',"
-                             "                'port': '0' } } ] } }");
 
+    /* New syntax was introduced in 8.2 */
+    if (migration_vercmp(to, "8.2") < 0) {
+        qtest_qmp_assert_success(to, "{ 'execute': 'migrate-incoming',"
+                                 "  'arguments': { "
+                                 "      'uri': 'tcp:127.0.0.1:0' } }");
+    } else {
+        qtest_qmp_assert_success(to, "{ 'execute': 'migrate-incoming',"
+                                 "  'arguments': { "
+                                 "      'channels': [ { 'channel-type': 'main',"
+                                 "      'addr': { 'transport': 'socket',"
+                                 "                'type': 'inet',"
+                                 "                'host': '127.0.0.1',"
+                                 "                'port': '0' } } ] } }");
+    }
     /* Wait for the first serial output from the source */
     wait_for_serial("src_serial");
 
@@ -1602,6 +1609,9 @@ static void test_postcopy_recovery_double_fail(void)
 {
     MigrateCommon args = {
         .postcopy_recovery_test_fail = true,
+        .start = {
+            .since = "8.2",
+        },
     };
 
     test_postcopy_recovery_common(&args);
@@ -1664,6 +1674,7 @@ static void test_analyze_script(void)
 {
     MigrateStart args = {
         .opts_source = "-uuid 11111111-1111-1111-1111-111111111111",
+        .since = "8.2",
     };
     QTestState *from, *to;
     g_autofree char *uri = NULL;
@@ -2089,6 +2100,9 @@ static void test_precopy_file(void)
     MigrateCommon args = {
         .connect_uri = uri,
         .listen_uri = "defer",
+        .start = {
+            .since = "8.2"
+        },
     };
 
     test_file_common(&args, true);
@@ -2133,6 +2147,9 @@ static void test_precopy_file_offset(void)
         .connect_uri = uri,
         .listen_uri = "defer",
         .finish_hook = file_offset_finish_hook,
+        .start = {
+            .since = "8.2"
+        },
     };
 
     test_file_common(&args, false);
@@ -2147,6 +2164,9 @@ static void test_precopy_file_offset_bad(void)
         .connect_uri = uri,
         .listen_uri = "defer",
         .result = MIG_TEST_QMP_ERROR,
+        .start = {
+            .since = "8.2"
+        },
     };
 
     test_file_common(&args, false);
-- 
2.35.3


