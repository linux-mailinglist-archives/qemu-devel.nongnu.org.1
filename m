Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 473B37CE7B8
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 21:29:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtCDP-0003PT-TC; Wed, 18 Oct 2023 15:28:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qtCDK-0003Lq-Pp
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 15:28:18 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qtCDI-00056N-Oj
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 15:28:18 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 98B3B21BB1;
 Wed, 18 Oct 2023 19:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1697657295; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KN+Xldb/hZYy0BPGea5bgIrt4E/Eanf5p8NlS1aGhkc=;
 b=jcLDOydFqu+hthBI20fZ/tph8ZF5YOrpLBw66eghTGQL3jzY8RsWP3G5Ik9Efw5curff+W
 KiJDy2TLG8/lRwDPuFUyIOGXa4/6SAowslxW4EdD/Cz+z6jlWWaukkprm9cKmS7pDglKsI
 y31NTBR/U0GS1FmxvaJJtdLqMg5XOzY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1697657295;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KN+Xldb/hZYy0BPGea5bgIrt4E/Eanf5p8NlS1aGhkc=;
 b=PU+5REX2UfrDt3DxYxBlJw/oNKTYhSMvuEVSkhSqqUuLnujGPdqJut5Mmbk7iBM/SIfTHx
 OtzOwB9HEg5G8sBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 170C013780;
 Wed, 18 Oct 2023 19:28:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id yHSxNMwxMGVLaAAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 18 Oct 2023 19:28:12 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v4 10/12] tests/qtest/migration: Support more than one QEMU
 binary
Date: Wed, 18 Oct 2023 16:27:39 -0300
Message-Id: <20231018192741.25885-11-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231018192741.25885-1-farosas@suse.de>
References: <20231018192741.25885-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -2.10
X-Spamd-Result: default: False [-2.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_SEVEN(0.00)[10];
 MID_CONTAINS_FROM(1.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
Received-SPF: pass client-ip=195.135.220.28; envelope-from=farosas@suse.de;
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

Usage (only one of SRC|DST is allowed):

QTEST_QEMU_BINARY_SRC=../build-8.2.0/qemu-system-x86_64 \
QTEST_QEMU_BINARY=../build-8.1.0/qemu-system-x86_64 \
./tests/qtest/migration-test

Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-test.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index b718634b1c..51f5603aac 100644
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
     const char *machine_alias, *machine_opts = "";
+    g_autofree char *machine = NULL;
 
     if (args->use_shmem) {
         if (!g_file_test("/dev/shm", G_FILE_TEST_IS_DIR)) {
@@ -822,6 +825,10 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         kvm_opts = ",dirty-ring-size=4096";
     }
 
+    machine = find_common_machine_version(machine_alias, QEMU_ENV_SRC,
+                                          QEMU_ENV_DST);
+    g_test_message("Using machine type: %s", machine);
+
     cmd_source = g_strdup_printf("-accel kvm%s -accel tcg "
                                  "-machine %s,%s "
                                  "-name source,debug-threads=on "
@@ -829,7 +836,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
                                  "-serial file:%s/src_serial "
                                  "%s %s %s %s %s",
                                  kvm_opts ? kvm_opts : "",
-                                 machine_alias, machine_opts,
+                                 machine, machine_opts,
                                  memory_size, tmpfs,
                                  arch_opts ? arch_opts : "",
                                  arch_source ? arch_source : "",
@@ -837,7 +844,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
                                  args->opts_source ? args->opts_source : "",
                                  ignore_stderr);
     if (!args->only_target) {
-        *from = qtest_init(cmd_source);
+        *from = qtest_init_with_env(QEMU_ENV_SRC, cmd_source);
         qtest_qmp_set_event_callback(*from,
                                      migrate_watch_for_stop,
                                      &got_src_stop);
@@ -851,14 +858,14 @@ static int test_migrate_start(QTestState **from, QTestState **to,
                                  "-incoming %s "
                                  "%s %s %s %s %s",
                                  kvm_opts ? kvm_opts : "",
-                                 machine_alias, machine_opts,
+                                 machine, machine_opts,
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
@@ -2989,10 +2996,23 @@ int main(int argc, char **argv)
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


