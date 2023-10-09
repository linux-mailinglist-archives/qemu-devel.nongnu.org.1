Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B123B7BE9FD
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 20:44:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpvEa-0007tt-Tl; Mon, 09 Oct 2023 14:44:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qpvEY-0007qE-CC
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 14:44:02 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qpvEJ-0000nm-DL
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 14:44:02 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 549AF21862;
 Mon,  9 Oct 2023 18:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1696877026; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SHlHU+z+b4XLedLtcJpxo64YZUYx8SZJtBXtDAA/+X8=;
 b=RhcvyCl71KK2q53sKKxaAW4FJKc2E5LvamnJ9XHbBiUwFOfNJchrACa/G2FTdzl91VhN38
 WCqgv/UppY5Cl3csH9cVgNTu73iwNunxrIarp+6/DdO5HEBMYL3HqobKwhdJeFA+bS4iRX
 hChw7d/ryn6bC0du2GZvI1C0WyfftKA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1696877026;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SHlHU+z+b4XLedLtcJpxo64YZUYx8SZJtBXtDAA/+X8=;
 b=GaxEEI+GfO9B1AAmkFb4pWXj2c8cRKfjWXlCqDGJlz/t9l+D9Bg0xwxjzArfJJQuBcFsFg
 TjpnvM3YCGy7NNCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2C07213586;
 Mon,  9 Oct 2023 18:43:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id oFu7Od9JJGWFEgAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 09 Oct 2023 18:43:43 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 6/6] tests/qtest/migration: Add a test for the
 analyze-migration script
Date: Mon,  9 Oct 2023 15:43:26 -0300
Message-Id: <20231009184326.15777-7-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231009184326.15777-1-farosas@suse.de>
References: <20231009184326.15777-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.28; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
 tests/qtest/meson.build      |  2 ++
 tests/qtest/migration-test.c | 60 ++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 1fba07f4ed..5e82eccb62 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -356,6 +356,8 @@ foreach dir : target_dirs
     test_deps += [qsd]
   endif
 
+  qtest_env.set('PYTHON', python.full_path())
+
   foreach test : target_qtests
     # Executables are shared across targets, declare them only the first time we
     # encounter them
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 46f1c275a2..cb1b6e890c 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -66,6 +66,8 @@ static bool got_dst_resume;
  */
 #define DIRTYLIMIT_TOLERANCE_RANGE  25  /* MB/s */
 
+#define ANALYZE_SCRIPT "scripts/analyze-migration.py"
+
 #if defined(__linux__)
 #include <sys/syscall.h>
 #include <sys/vfs.h>
@@ -1510,6 +1512,61 @@ static void test_baddest(void)
     test_migrate_end(from, to, false);
 }
 
+#ifndef _WIN32
+static void test_analyze_script(void)
+{
+    MigrateStart args = {
+        .opts_source = "-uuid 11111111-1111-1111-1111-111111111111",
+    };
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
+    /*
+     * Setting these two capabilities causes the "configuration"
+     * vmstate to include subsections for them. The script needs to
+     * parse those subsections properly.
+     */
+    migrate_set_capability(from, "validate-uuid", true);
+    migrate_set_capability(from, "x-ignore-shared", true);
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
+        execl(python, python, ANALYZE_SCRIPT, "-f", file, NULL);
+        g_assert_not_reached();
+    }
+
+    g_assert(waitpid(pid, &wstatus, 0) == pid);
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
@@ -2844,6 +2901,9 @@ int main(int argc, char **argv)
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


