Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1EA7CDE69
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 16:09:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt7ED-00057p-I8; Wed, 18 Oct 2023 10:08:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qt7Db-0003vF-8D
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 10:08:16 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qt7DY-0003f1-RC
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 10:08:14 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0EE1C1F383;
 Wed, 18 Oct 2023 14:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1697638091; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FSjEJgo+bsXB1tZY0/WtfH/sQcdFC9Em8BFh6mt228s=;
 b=LA7o5Dtv0gvUxs0C3ZLV7JFxCNfk82UhXpbLQQp4QtyjtHk5XZzO5PPwS4P5kNrgsGWk7b
 ///5OCKc2mH+BN7hSyV5E7EMWs19aASnfmX6nBkbErCa72dGPPGORvnEfXOpmt4XuA3cWB
 0Jl0dt5NlWI23K96Y+6+tecOH5byv3g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1697638091;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FSjEJgo+bsXB1tZY0/WtfH/sQcdFC9Em8BFh6mt228s=;
 b=MAU49uObk9zUc/vjE9OQjZeBw60rofnE7HadCqC+WJu9HZUYrx+TSxVN/7kMP20XKYOfaY
 5J+T+xiBFM8pXgAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7BE4A13915;
 Wed, 18 Oct 2023 14:08:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id aLdCEcjmL2WuTQAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 18 Oct 2023 14:08:08 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 10/11] tests/qtest/migration: Support more than one QEMU
 binary
Date: Wed, 18 Oct 2023 11:07:35 -0300
Message-Id: <20231018140736.3618-11-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231018140736.3618-1-farosas@suse.de>
References: <20231018140736.3618-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -0.06
X-Spamd-Result: default: False [-0.06 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 R_RATELIMIT(0.00)[to_ip_from(RLg3q9sbp57ska6k3y17j3rnax)];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_SEVEN(0.00)[10];
 MID_CONTAINS_FROM(1.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.96)[86.68%]
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

Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-test.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 209e611061..11ac414e56 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -71,6 +71,8 @@ static bool got_dst_resume;
 #define QEMU_VM_FILE_MAGIC 0x5145564d
 #define FILE_TEST_FILENAME "migfile"
 #define FILE_TEST_OFFSET 0x1000
+#define QEMU_ENV_SRC "QTEST_QEMU_BINARY_SRC"
+#define QEMU_ENV_DST "QTEST_QEMU_BINARY_DST"
 
 #if defined(__linux__)
 #include <sys/syscall.h>
@@ -744,6 +746,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
     const char *arch = qtest_get_arch();
     const char *memory_size;
     const char *machine;
+    g_autofree char *machine_type = NULL;
 
     if (args->use_shmem) {
         if (!g_file_test("/dev/shm", G_FILE_TEST_IS_DIR)) {
@@ -821,6 +824,10 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         kvm_opts = ",dirty-ring-size=4096";
     }
 
+    machine_type = find_common_machine_version(machine, QEMU_ENV_SRC,
+                                               QEMU_ENV_DST);
+    g_test_message("Using machine type: %s", machine_type);
+
     cmd_source = g_strdup_printf("-accel kvm%s -accel tcg "
                                  "-machine %s "
                                  "-name source,debug-threads=on "
@@ -828,7 +835,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
                                  "-serial file:%s/src_serial "
                                  "%s %s %s %s %s",
                                  kvm_opts ? kvm_opts : "",
-                                 machine,
+                                 machine_type,
                                  memory_size, tmpfs,
                                  arch_opts ? arch_opts : "",
                                  arch_source ? arch_source : "",
@@ -836,7 +843,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
                                  args->opts_source ? args->opts_source : "",
                                  ignore_stderr);
     if (!args->only_target) {
-        *from = qtest_init(cmd_source);
+        *from = qtest_init_with_env(QEMU_ENV_SRC, cmd_source);
         qtest_qmp_set_event_callback(*from,
                                      migrate_watch_for_stop,
                                      &got_src_stop);
@@ -850,14 +857,14 @@ static int test_migrate_start(QTestState **from, QTestState **to,
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
@@ -2988,10 +2995,23 @@ int main(int argc, char **argv)
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


