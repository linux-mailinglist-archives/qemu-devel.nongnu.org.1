Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 284807443EC
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 23:30:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFLgQ-0005lZ-T9; Fri, 30 Jun 2023 17:29:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qFLgF-0005je-C4
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 17:29:28 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qFLgC-0002hl-Tn
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 17:29:27 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A874E1F88D;
 Fri, 30 Jun 2023 21:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1688160563; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RXAsNQ3Q7Q4D9DSQwh3Ub/qcAnn+avYq7OfGBhSSR2M=;
 b=w/ksWty/sjxcdA9ktF+v/LSPzLpV6QcEpCKBvNU01nduMb4O9HNTWuqNa3nfEiKxNac25Q
 AgB8GF+DTXKZeaqinPzth7Vk9Q/nU6Uvu0Rt/mDQE0hhMBXQL+efQBD0M13wZwlT6jYN74
 2cGmgzf+RmzKvybSTse07p5wSW3J1KQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1688160563;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RXAsNQ3Q7Q4D9DSQwh3Ub/qcAnn+avYq7OfGBhSSR2M=;
 b=uAYApIrbd0saG5YxEHe7m9WtRHqWS85xQ0cOW4dUzLIO+MOJPrs04NEV7lkcYExhpArJi8
 QqVyGly6cUQpheDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4043113915;
 Fri, 30 Jun 2023 21:29:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 8KwkAjFJn2TRKAAAMHmgww
 (envelope-from <farosas@suse.de>); Fri, 30 Jun 2023 21:29:21 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 6/6] tests/qtest: migration-test: Add tests for file-based
 migration
Date: Fri, 30 Jun 2023 18:29:02 -0300
Message-Id: <20230630212902.19925-7-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230630212902.19925-1-farosas@suse.de>
References: <20230630212902.19925-1-farosas@suse.de>
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

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-test.c | 99 ++++++++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 2fdf6a115e..a180f53b5a 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -52,6 +52,10 @@ static bool got_dst_resume;
  */
 #define DIRTYLIMIT_TOLERANCE_RANGE  25  /* MB/s */
 
+#define QEMU_VM_FILE_MAGIC 0x5145564d
+#define FILE_TEST_FILENAME "migfile"
+#define FILE_TEST_OFFSET 0x1000
+
 #if defined(__linux__)
 #include <sys/syscall.h>
 #include <sys/vfs.h>
@@ -762,6 +766,7 @@ static void test_migrate_end(QTestState *from, QTestState *to, bool test_dest)
     cleanup("migsocket");
     cleanup("src_serial");
     cleanup("dest_serial");
+    cleanup(FILE_TEST_FILENAME);
 }
 
 #ifdef CONFIG_GNUTLS
@@ -1459,11 +1464,28 @@ static void test_precopy_common(MigrateCommon *args)
              */
             wait_for_migration_complete(from);
 
+            /*
+             * For file based migration the target must begin its
+             * migration after the source has finished.
+             */
+            if (strstr(connect_uri, "file:")) {
+                migrate_incoming_qmp(to, connect_uri, "{}");
+            }
+
             if (!got_src_stop) {
                 qtest_qmp_eventwait(from, "STOP");
             }
         } else {
             wait_for_migration_complete(from);
+
+            /*
+             * For file based migration the target must begin its
+             * migration after the source has finished.
+             */
+            if (strstr(connect_uri, "file:")) {
+                migrate_incoming_qmp(to, connect_uri, "{}");
+            }
+
             /*
              * Must wait for dst to finish reading all incoming
              * data on the socket before issuing 'cont' otherwise
@@ -1681,6 +1703,75 @@ static void test_precopy_unix_compress_nowait(void)
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
+    test_precopy_common(&args);
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
+    test_precopy_common(&args);
+}
+
+static void test_precopy_file_offset_bad(void)
+{
+    /* using a value not supported by qemu_strtosz() */
+    g_autofree char *uri = g_strdup_printf("file:%s/migfile,offset=0x20M",
+                                           tmpfs);
+    MigrateCommon args = {
+        .connect_uri = uri,
+        .listen_uri = "defer",
+        .result = MIG_TEST_QMP_ERROR,
+    };
+
+    test_precopy_common(&args);
+}
+
 static void test_precopy_tcp_plain(void)
 {
     MigrateCommon args = {
@@ -2730,6 +2821,14 @@ int main(int argc, char **argv)
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


