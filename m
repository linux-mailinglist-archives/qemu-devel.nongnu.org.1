Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7A19EEA4D
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Dec 2024 16:12:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLkq5-0004Ib-U0; Thu, 12 Dec 2024 10:10:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tLkpg-00047Q-Or
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 10:10:28 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tLkpf-0003Fg-0q
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 10:10:28 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CEC5D1F445;
 Thu, 12 Dec 2024 15:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734016225; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MJE1LSy//4E6nj5PqdAocp6G5jF9xMdurUACUC8K+C4=;
 b=Bv0df+xFQGflne1Cd1gcujorah3L0JdbFZE2EnTc6/aqSumVGyXR2VjhbbP2Y358PpAK//
 9u8CTZ1BfLpPXxNAqCr6MOkNOuNfW0QkAaANFGPQAFMxDfGrGwjV1nfkozeSwSOXdCFn+H
 PyYLc5KuFe5fYS8hy+lhryHhsWM+/zs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734016225;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MJE1LSy//4E6nj5PqdAocp6G5jF9xMdurUACUC8K+C4=;
 b=3Ay5ySmSJtIwPCE5no4LAEzH/AU5h08EoudAU+i/m2/0nDtIhNm/DF5tYRj2QG7VzHuGsH
 vVqvMWEKiuST4QCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734016225; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MJE1LSy//4E6nj5PqdAocp6G5jF9xMdurUACUC8K+C4=;
 b=Bv0df+xFQGflne1Cd1gcujorah3L0JdbFZE2EnTc6/aqSumVGyXR2VjhbbP2Y358PpAK//
 9u8CTZ1BfLpPXxNAqCr6MOkNOuNfW0QkAaANFGPQAFMxDfGrGwjV1nfkozeSwSOXdCFn+H
 PyYLc5KuFe5fYS8hy+lhryHhsWM+/zs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734016225;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MJE1LSy//4E6nj5PqdAocp6G5jF9xMdurUACUC8K+C4=;
 b=3Ay5ySmSJtIwPCE5no4LAEzH/AU5h08EoudAU+i/m2/0nDtIhNm/DF5tYRj2QG7VzHuGsH
 vVqvMWEKiuST4QCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A3AE613508;
 Thu, 12 Dec 2024 15:10:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CC/YGOD8WmcTfQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 12 Dec 2024 15:10:24 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Peter Xu <peterx@redhat.com>
Subject: [PULL 20/22] tests/qtest/migration: Split CPR tests
Date: Thu, 12 Dec 2024 12:09:47 -0300
Message-Id: <20241212150949.16806-21-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241212150949.16806-1-farosas@suse.de>
References: <20241212150949.16806-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
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

Move the mode/reboot test into a separate file to hold all the CPR
tests. Currently there's just one test, but we're adding more CPR
modes and the feature is different enough from live migration that
it's worth it to have a separate file for it.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/meson.build           |  1 +
 tests/qtest/migration-test.c      | 34 +-----------------
 tests/qtest/migration/cpr-tests.c | 58 +++++++++++++++++++++++++++++++
 tests/qtest/migration/framework.h |  1 +
 4 files changed, 61 insertions(+), 33 deletions(-)
 create mode 100644 tests/qtest/migration/cpr-tests.c

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index fc38c80b43..cda1a84122 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -338,6 +338,7 @@ migration_files = [files(
   'migration/migration-qmp.c',
   'migration/migration-util.c',
   'migration/compression-tests.c',
+  'migration/cpr-tests.c',
   'migration/file-tests.c',
   'migration/precopy-tests.c',
   'migration/postcopy-tests.c',
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 76ba820fe4..0d1c8154d7 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -145,31 +145,6 @@ static void test_ignore_shared(void)
 }
 #endif
 
-static void *migrate_hook_start_mode_reboot(QTestState *from, QTestState *to)
-{
-    migrate_set_parameter_str(from, "mode", "cpr-reboot");
-    migrate_set_parameter_str(to, "mode", "cpr-reboot");
-
-    migrate_set_capability(from, "x-ignore-shared", true);
-    migrate_set_capability(to, "x-ignore-shared", true);
-
-    return NULL;
-}
-
-static void test_mode_reboot(void)
-{
-    g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
-                                           FILE_TEST_FILENAME);
-    MigrateCommon args = {
-        .start.use_shmem = true,
-        .connect_uri = uri,
-        .listen_uri = "defer",
-        .start_hook = migrate_hook_start_mode_reboot,
-    };
-
-    test_file_common(&args, true);
-}
-
 static void do_test_validate_uuid(MigrateStart *args, bool should_fail)
 {
     g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
@@ -308,20 +283,13 @@ int main(int argc, char **argv)
     migration_test_add_postcopy(env);
     migration_test_add_file(env);
     migration_test_add_precopy(env);
+    migration_test_add_cpr(env);
 
     migration_test_add("/migration/bad_dest", test_baddest);
 #ifndef _WIN32
     migration_test_add("/migration/analyze-script", test_analyze_script);
 #endif
 
-    /*
-     * Our CI system has problems with shared memory.
-     * Don't run this test until we find a workaround.
-     */
-    if (getenv("QEMU_TEST_FLAKY_TESTS")) {
-        migration_test_add("/migration/mode/reboot", test_mode_reboot);
-    }
-
     /* migration_test_add("/migration/ignore_shared", test_ignore_shared); */
 
     migration_test_add("/migration/validate_uuid", test_validate_uuid);
diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
new file mode 100644
index 0000000000..44ce89aa5b
--- /dev/null
+++ b/tests/qtest/migration/cpr-tests.c
@@ -0,0 +1,58 @@
+/*
+ * QTest testcases for CPR
+ *
+ * Copyright (c) 2016-2018 Red Hat, Inc. and/or its affiliates
+ *   based on the vhost-user-test.c that is:
+ *      Copyright (c) 2014 Virtual Open Systems Sarl.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "migration/framework.h"
+#include "migration/migration-qmp.h"
+#include "migration/migration-util.h"
+
+
+static char *tmpfs;
+
+static void *migrate_hook_start_mode_reboot(QTestState *from, QTestState *to)
+{
+    migrate_set_parameter_str(from, "mode", "cpr-reboot");
+    migrate_set_parameter_str(to, "mode", "cpr-reboot");
+
+    migrate_set_capability(from, "x-ignore-shared", true);
+    migrate_set_capability(to, "x-ignore-shared", true);
+
+    return NULL;
+}
+
+static void test_mode_reboot(void)
+{
+    g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
+                                           FILE_TEST_FILENAME);
+    MigrateCommon args = {
+        .start.use_shmem = true,
+        .connect_uri = uri,
+        .listen_uri = "defer",
+        .start_hook = migrate_hook_start_mode_reboot,
+    };
+
+    test_file_common(&args, true);
+}
+
+void migration_test_add_cpr(MigrationTestEnv *env)
+{
+    tmpfs = env->tmpfs;
+
+    /*
+     * Our CI system has problems with shared memory.
+     * Don't run this test until we find a workaround.
+     */
+    if (getenv("QEMU_TEST_FLAKY_TESTS")) {
+        migration_test_add("/migration/mode/reboot", test_mode_reboot);
+    }
+}
diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
index 52c715781f..b264be76eb 100644
--- a/tests/qtest/migration/framework.h
+++ b/tests/qtest/migration/framework.h
@@ -224,5 +224,6 @@ void migration_test_add_compression(MigrationTestEnv *env);
 void migration_test_add_postcopy(MigrationTestEnv *env);
 void migration_test_add_file(MigrationTestEnv *env);
 void migration_test_add_precopy(MigrationTestEnv *env);
+void migration_test_add_cpr(MigrationTestEnv *env);
 
 #endif /* TEST_FRAMEWORK_H */
-- 
2.35.3


