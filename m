Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC2E7B0E55
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 23:49:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlcOA-0007g4-Nd; Wed, 27 Sep 2023 17:48:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qlcO6-0007fr-F5
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 17:48:06 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qlcO3-0002Z9-Sz
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 17:48:05 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8924A21899;
 Wed, 27 Sep 2023 21:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1695851281; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=hcCA2ZXhnOjiBf4khZY7cyYizfByk/TJD41nglWUeU8=;
 b=S0y1MZN7dICY8CYdK94GXr6cuF/X51LmIz7iGos9SNsS9lMp7mYPw1NqsgIzf9pxwCVPi9
 aq6kaGopQk02mi9cErG3GSkhK3JABa60ecEpI6HWfqDB++kstsYbO4S1w7tUh3ARQmlp1p
 GiodVYGSQm+aYxoSa+vzMPbvlEK305g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1695851281;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=hcCA2ZXhnOjiBf4khZY7cyYizfByk/TJD41nglWUeU8=;
 b=EQsOBHPrInT2ht6GeB0sIBpn3TVWR5TslSIBlfk9zG5AOPao08qs9svXQ5/OfGKwYllwaj
 T8GKxc3a66A/qACA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5B9FD13479;
 Wed, 27 Sep 2023 21:47:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id hColCQ+jFGVSIwAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 27 Sep 2023 21:47:59 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] qtest/migration: Add a test for the analyze-migration script
Date: Wed, 27 Sep 2023 18:47:56 -0300
Message-Id: <20230927214756.14117-1-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:67c:2178:6::1c; envelope-from=farosas@suse.de;
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

Add a smoke test that migrates to a file and gives it to the
script. It should catch the most annoying errors such as changes in
the ram flags.

After code has been merged it becomes way harder to figure out what is
causing the script to fail, the person making the change is the most
likely to know right away what the problem is.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
I know this adds a python dependency to qtests and I'm not sure how
much we care about this script, but on the other hand it would be nice
to catch these errors early on.

This would also help with future work that touches the migration
stream (moving multifd out of ram.c and fixed-ram).

Let me know what you think.
---
 tests/qtest/meson.build      |  6 +++++
 tests/qtest/migration-test.c | 51 ++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 1fba07f4ed..d2511b3227 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -301,6 +301,10 @@ if gnutls.found()
   endif
 endif
 
+configure_file(input: meson.project_source_root() / 'scripts/analyze-migration.py',
+               output: 'analyze-migration.py',
+               configuration: configuration_data())
+
 qtests = {
   'bios-tables-test': [io, 'boot-sector.c', 'acpi-utils.c', 'tpm-emu.c'],
   'cdrom-test': files('boot-sector.c'),
@@ -356,6 +360,8 @@ foreach dir : target_dirs
     test_deps += [qsd]
   endif
 
+  qtest_env.set('PYTHON', python.full_path())
+
   foreach test : target_qtests
     # Executables are shared across targets, declare them only the first time we
     # encounter them
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 1b43df5ca7..122089522f 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -66,6 +66,8 @@ static bool got_dst_resume;
  */
 #define DIRTYLIMIT_TOLERANCE_RANGE  25  /* MB/s */
 
+#define ANALYZE_SCRIPT "tests/qtest/analyze-migration.py"
+
 #if defined(__linux__)
 #include <sys/syscall.h>
 #include <sys/vfs.h>
@@ -1486,6 +1488,52 @@ static void test_baddest(void)
     test_migrate_end(from, to, false);
 }
 
+#ifndef _WIN32
+static void test_analyze_script(void)
+{
+    MigrateStart args = {};
+    QTestState *from, *to;
+    g_autofree char *uri = NULL;
+    g_autofree char *file = NULL;
+    int pid, wstatus;
+    const char *python = g_getenv("PYTHON");
+
+    if (!python) {
+        g_test_skip("PYTHON variable not set");
+        return;
+    }
+
+    /* dummy url */
+    if (test_migrate_start(&from, &to, "tcp:127.0.0.1:0", &args)) {
+        return;
+    }
+
+    file = g_strdup_printf("%s/migfile", tmpfs);
+    uri = g_strdup_printf("exec:cat > %s", file);
+
+    migrate_ensure_converge(from);
+    migrate_qmp(from, uri, "{}");
+    wait_for_migration_complete(from);
+
+    pid = fork();
+    if (!pid) {
+        close(1);
+        open("/dev/null", O_WRONLY);
+        execl(python, python, ANALYZE_SCRIPT,
+              "-f", file, NULL);
+        g_assert_not_reached();
+    }
+
+    assert(waitpid(pid, &wstatus, 0) == pid);
+    if (WIFEXITED(wstatus) && WEXITSTATUS(wstatus) != 0) {
+        g_test_message("Failed to analyze the migration stream");
+        g_test_fail();
+    }
+    test_migrate_end(from, to, false);
+    cleanup("migfile");
+}
+#endif
+
 static void test_precopy_common(MigrateCommon *args)
 {
     QTestState *from, *to;
@@ -2828,6 +2876,9 @@ int main(int argc, char **argv)
     }
 
     qtest_add_func("/migration/bad_dest", test_baddest);
+#ifndef _WIN32
+    qtest_add_func("/migration/analyze-script", test_analyze_script);
+#endif
     qtest_add_func("/migration/precopy/unix/plain", test_precopy_unix_plain);
     qtest_add_func("/migration/precopy/unix/xbzrle", test_precopy_unix_xbzrle);
     /*
-- 
2.35.3


