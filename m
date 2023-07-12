Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 31EB07510F9
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 21:08:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJfC3-00088r-IV; Wed, 12 Jul 2023 15:08:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qJfC1-00087g-K1
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 15:08:05 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qJfBz-00085e-Qt
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 15:08:05 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BDD1D1FDE4;
 Wed, 12 Jul 2023 19:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1689188882; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zH2A8DEV14aRQX633GvI92B2kfAZe5Ig8Ii036Vji8k=;
 b=bDTe/4yc2kJKxDeVbqL6k7Nsc09L3uNrLXc6A6UPhU6PL5NX3FHPVaXQhsORLOweaWyKeP
 Pu8OZB2kt6AkHPHQr5KTmN8mYDnihFKjC4/Ss87TthngihsiadNON4FohOuPS+AVuvW/J4
 3RNd2lnB9aZo7HcBlwMOU+bfuzUHM40=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1689188882;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zH2A8DEV14aRQX633GvI92B2kfAZe5Ig8Ii036Vji8k=;
 b=pN5Y9RqKnU0pqDISKDM9KtEqrwN3HnW3aU6uHkk/X46Hdq43COKUMk/NjXqqL3nT5Ys4UA
 gWK3MiJO5naf5XDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 65F8413336;
 Wed, 12 Jul 2023 19:08:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id sCNNDBD6rmROOgAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 12 Jul 2023 19:08:00 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v5 6/6] tests/qtest: migration-test: Add tests for file-based
 migration
Date: Wed, 12 Jul 2023 16:07:42 -0300
Message-Id: <20230712190742.22294-7-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230712190742.22294-1-farosas@suse.de>
References: <20230712190742.22294-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.29; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

Add basic tests for file-based migration.

Note that we cannot use test_precopy_common because that routine
expects it to be possible to run the migration live. With the file
transport there is no live migration because we must wait for the
source to finish writing the migration data to the file before the
destination can start reading. Add a new migration function
specifically to handle the file migration.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-test.c | 146 +++++++++++++++++++++++++++++++++++
 1 file changed, 146 insertions(+)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 01a2a2ceb7..f4658814b1 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -66,6 +66,10 @@ static bool got_dst_resume;
  */
 #define DIRTYLIMIT_TOLERANCE_RANGE  25  /* MB/s */
 
+#define QEMU_VM_FILE_MAGIC 0x5145564d
+#define FILE_TEST_FILENAME "migfile"
+#define FILE_TEST_OFFSET 0x1000
+
 #if defined(__linux__)
 #include <sys/syscall.h>
 #include <sys/vfs.h>
@@ -864,6 +868,7 @@ static void test_migrate_end(QTestState *from, QTestState *to, bool test_dest)
     cleanup("migsocket");
     cleanup("src_serial");
     cleanup("dest_serial");
+    cleanup(FILE_TEST_FILENAME);
 }
 
 #ifdef CONFIG_GNUTLS
@@ -1590,6 +1595,70 @@ finish:
     test_migrate_end(from, to, args->result == MIG_TEST_SUCCEED);
 }
 
+static void test_file_common(MigrateCommon *args, bool stop_src)
+{
+    QTestState *from, *to;
+    void *data_hook = NULL;
+    g_autofree char *connect_uri = g_strdup(args->connect_uri);
+
+    if (test_migrate_start(&from, &to, args->listen_uri, &args->start)) {
+        return;
+    }
+
+    /*
+     * File migration is never live. We can keep the source VM running
+     * during migration, but the destination will not be running
+     * concurrently.
+     */
+    g_assert_false(args->live);
+
+    if (args->start_hook) {
+        data_hook = args->start_hook(from, to);
+    }
+
+    migrate_ensure_converge(from);
+    wait_for_serial("src_serial");
+
+    if (stop_src) {
+        qtest_qmp_assert_success(from, "{ 'execute' : 'stop'}");
+        if (!got_src_stop) {
+            qtest_qmp_eventwait(from, "STOP");
+        }
+    }
+
+    if (args->result == MIG_TEST_QMP_ERROR) {
+        migrate_qmp_fail(from, connect_uri, "{}");
+        goto finish;
+    }
+
+    migrate_qmp(from, connect_uri, "{}");
+    wait_for_migration_complete(from);
+
+    /*
+     * We need to wait for the source to finish before starting the
+     * destination.
+     */
+    migrate_incoming_qmp(to, connect_uri, "{}");
+    wait_for_migration_complete(to);
+
+    if (stop_src) {
+        qtest_qmp_assert_success(to, "{ 'execute' : 'cont'}");
+    }
+
+    if (!got_dst_resume) {
+        qtest_qmp_eventwait(to, "RESUME");
+    }
+
+    wait_for_serial("dest_serial");
+
+finish:
+    if (args->finish_hook) {
+        args->finish_hook(from, to, data_hook);
+    }
+
+    test_migrate_end(from, to, args->result == MIG_TEST_SUCCEED);
+}
+
 static void test_precopy_unix_plain(void)
 {
     g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
@@ -1785,6 +1854,75 @@ static void test_precopy_unix_compress_nowait(void)
     test_precopy_common(&args);
 }
 
+static void test_precopy_file(void)
+{
+    g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
+                                           FILE_TEST_FILENAME);
+    MigrateCommon args = {
+        .connect_uri = uri,
+        .listen_uri = "defer",
+    };
+
+    test_file_common(&args, true);
+}
+
+static void file_offset_finish_hook(QTestState *from, QTestState *to, void *opaque)
+{
+#if defined(__linux__)
+    g_autofree char *path = g_strdup_printf("%s/%s", tmpfs, FILE_TEST_FILENAME);
+    size_t size = FILE_TEST_OFFSET + sizeof(QEMU_VM_FILE_MAGIC);
+    uintptr_t *addr, *p;
+    int fd;
+
+    fd = open(path, O_RDONLY);
+    g_assert(fd != -1);
+    addr = mmap(NULL, size, PROT_READ, MAP_SHARED, fd, 0);
+    g_assert(addr != MAP_FAILED);
+
+    /*
+     * Ensure the skipped offset contains zeros and the migration
+     * stream starts at the right place.
+     */
+    p = addr;
+    while (p < addr + FILE_TEST_OFFSET / sizeof(uintptr_t)) {
+        g_assert(*p == 0);
+        p++;
+    }
+    g_assert_cmpint(cpu_to_be32(*p), ==, QEMU_VM_FILE_MAGIC);
+
+    munmap(addr, size);
+    close(fd);
+#endif
+}
+
+static void test_precopy_file_offset(void)
+{
+    g_autofree char *uri = g_strdup_printf("file:%s/%s,offset=%d", tmpfs,
+                                           FILE_TEST_FILENAME,
+                                           FILE_TEST_OFFSET);
+    MigrateCommon args = {
+        .connect_uri = uri,
+        .listen_uri = "defer",
+        .finish_hook = file_offset_finish_hook,
+    };
+
+    test_file_common(&args, false);
+}
+
+static void test_precopy_file_offset_bad(void)
+{
+    /* using a value not supported by qemu_strtosz() */
+    g_autofree char *uri = g_strdup_printf("file:%s/%s,offset=0x20M",
+                                           tmpfs, FILE_TEST_FILENAME);
+    MigrateCommon args = {
+        .connect_uri = uri,
+        .listen_uri = "defer",
+        .result = MIG_TEST_QMP_ERROR,
+    };
+
+    test_file_common(&args, false);
+}
+
 static void test_precopy_tcp_plain(void)
 {
     MigrateCommon args = {
@@ -2837,6 +2975,14 @@ int main(int argc, char **argv)
         qtest_add_func("/migration/precopy/unix/compress/nowait",
                        test_precopy_unix_compress_nowait);
     }
+
+    qtest_add_func("/migration/precopy/file",
+                   test_precopy_file);
+    qtest_add_func("/migration/precopy/file/offset",
+                   test_precopy_file_offset);
+    qtest_add_func("/migration/precopy/file/offset/bad",
+                   test_precopy_file_offset_bad);
+
 #ifdef CONFIG_GNUTLS
     qtest_add_func("/migration/precopy/unix/tls/psk",
                    test_precopy_unix_tls_psk);
-- 
2.35.3


