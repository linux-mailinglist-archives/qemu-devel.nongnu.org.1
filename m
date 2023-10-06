Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6847BB7E5
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 14:40:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qok7m-0002Xe-OT; Fri, 06 Oct 2023 08:40:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qok7L-0001uI-Jp
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 08:39:44 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qok7J-0007rC-QI
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 08:39:43 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 866AA1F74A;
 Fri,  6 Oct 2023 12:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1696595978; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6SiYVOCBmb5zun/5tqJ+tsDJ0cZWNsfTlRvi9LQk1nc=;
 b=IMzRhbzZ2aKSlyVejr25YKEhTfsjFDG2jDe+BUeCBBVQF2wb+U2URKnKsI2nhkd028mI9c
 edrciwi3aCZYizZW7KjMUjf7LlQHJOY4POxjsIpNJ7lvsOywijzspWn8b1uPusUeDlMANH
 uaVm7wtkrLnC7r2MPUXjduEgL0RnIHI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1696595978;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6SiYVOCBmb5zun/5tqJ+tsDJ0cZWNsfTlRvi9LQk1nc=;
 b=adboN9Dp8wL6RePIlc1W4vIJ9oMClP45ANAsuvQNooXRbm/27uxlDRrAZ+gOBXTnWkxz7G
 l8BKfO0WtjPIdKCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 03CE313A2E;
 Fri,  6 Oct 2023 12:39:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id kCYjMAcAIGULIgAAMHmgww
 (envelope-from <farosas@suse.de>); Fri, 06 Oct 2023 12:39:35 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 8/9] tests/qtest/migration: Support more than one QEMU
 binary
Date: Fri,  6 Oct 2023 09:39:09 -0300
Message-Id: <20231006123910.17759-9-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231006123910.17759-1-farosas@suse.de>
References: <20231006123910.17759-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:67c:2178:6::1d; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

We have strict rules around migration compatibility between different
QEMU versions but no test to validate the migration state between
different binaries.

Add infrastructure to allow running the migration tests with two
different QEMU binaries as migration source and destination.

The code now recognizes two new environment variables
QTEST_QEMU_BINARY_SRC and QTEST_QEMU_BINARY_DST. In the absence of
either of them, the test will use the QTEST_QEMU_BINARY variable. If
both are missing then the tests are run with single binary as
previously.

The machine type is selected automatically as the latest machine type
version that works with both binaries.

Usage:
QTEST_QEMU_BINARY_SRC=../build-8.2.0/qemu-system-x86_64 \
QTEST_QEMU_BINARY_DST=../build-8.1.0/qemu-system-x86_64 \
./tests/qtest/migration-test

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-test.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 7c10ac925b..984f52becd 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -66,6 +66,9 @@ static bool got_dst_resume;
  */
 #define DIRTYLIMIT_TOLERANCE_RANGE  25  /* MB/s */
 
+#define QEMU_ENV_SRC "QTEST_QEMU_BINARY_SRC"
+#define QEMU_ENV_DST "QTEST_QEMU_BINARY_DST"
+
 #if defined(__linux__)
 #include <sys/syscall.h>
 #include <sys/vfs.h>
@@ -747,6 +750,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
     const char *arch = qtest_get_arch();
     const char *memory_size;
     const char *machine;
+    g_autofree char *machine_type = NULL;
 
     if (args->use_shmem) {
         if (!g_file_test("/dev/shm", G_FILE_TEST_IS_DIR)) {
@@ -817,6 +821,10 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         kvm_opts = ",dirty-ring-size=4096";
     }
 
+    machine_type = find_common_machine_version(machine, QEMU_ENV_SRC,
+                                               QEMU_ENV_DST);
+    g_test_message("Using machine type: %s", machine_type);
+
     cmd_source = g_strdup_printf("-accel kvm%s -accel tcg "
                                  "-machine %s "
                                  "-name source,debug-threads=on "
@@ -824,7 +832,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
                                  "-serial file:%s/src_serial "
                                  "%s %s %s %s %s",
                                  kvm_opts ? kvm_opts : "",
-                                 machine,
+                                 machine_type,
                                  memory_size, tmpfs,
                                  arch_opts ? arch_opts : "",
                                  arch_source ? arch_source : "",
@@ -832,7 +840,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
                                  args->opts_source ? args->opts_source : "",
                                  ignore_stderr);
     if (!args->only_target) {
-        *from = qtest_init(cmd_source);
+        *from = qtest_init_with_env(QEMU_ENV_SRC, cmd_source);
         qtest_qmp_set_event_callback(*from,
                                      migrate_watch_for_stop,
                                      &got_src_stop);
@@ -846,14 +854,14 @@ static int test_migrate_start(QTestState **from, QTestState **to,
                                  "-incoming %s "
                                  "%s %s %s %s %s",
                                  kvm_opts ? kvm_opts : "",
-                                 machine,
+                                 machine_type,
                                  memory_size, tmpfs, uri,
                                  arch_opts ? arch_opts : "",
                                  arch_target ? arch_target : "",
                                  shmem_opts ? shmem_opts : "",
                                  args->opts_target ? args->opts_target : "",
                                  ignore_stderr);
-    *to = qtest_init(cmd_target);
+    *to = qtest_init_with_env(QEMU_ENV_DST, cmd_target);
     qtest_qmp_set_event_callback(*to,
                                  migrate_watch_for_resume,
                                  &got_dst_resume);
@@ -2792,10 +2800,23 @@ int main(int argc, char **argv)
     bool has_uffd;
     const char *arch;
     g_autoptr(GError) err = NULL;
+    const char *qemu_src = getenv(QEMU_ENV_SRC);
+    const char *qemu_dst = getenv(QEMU_ENV_DST);
     int ret;
 
     g_test_init(&argc, &argv, NULL);
 
+    /*
+     * The default QTEST_QEMU_BINARY must always be provided because
+     * that is what helpers use to query the accel type and
+     * architecture.
+     */
+    if (qemu_src && qemu_dst) {
+        g_test_message("Only one of %s, %s is allowed",
+                       QEMU_ENV_SRC, QEMU_ENV_DST);
+        exit(1);
+    }
+
     has_kvm = qtest_has_accel("kvm");
     has_tcg = qtest_has_accel("tcg");
 
-- 
2.35.3


