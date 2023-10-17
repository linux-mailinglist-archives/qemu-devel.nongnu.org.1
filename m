Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DEE67CBDA6
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 10:35:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsfU3-0005Xu-1h; Tue, 17 Oct 2023 04:31:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsfTY-0004rG-DN
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 04:30:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsfTV-0005GP-OZ
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 04:30:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697531446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TBm34SBQaYGjUawsfdN4dpvR3hN23fc4tYU76QICZc8=;
 b=Aualg8xK4CI8ZgBSKIia0OS7hvNIaSTxtBV2sZiXpeUW924UiRbPdsPEmPW03VPhMwHSbp
 i7Cbd8JR6duGanP4/C/+iEdgK2XNYhLGJA0rSSgeFXMSHDPxCUAZ2S5bbkQ9fvJ06ujgw7
 IWT1cK1vq3a1uoeRC2TOlT2zi1FPYkA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-232-hrpmhoidNzagyP8hHx0GVg-1; Tue, 17 Oct 2023 04:30:42 -0400
X-MC-Unique: hrpmhoidNzagyP8hHx0GVg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 91A8838116EA;
 Tue, 17 Oct 2023 08:30:41 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A9BC81C060B0;
 Tue, 17 Oct 2023 08:30:38 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Stefan Hajnoczi <stefanha@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PULL 11/38] tests/qtest: migration-test: Add tests for file-based
 migration
Date: Tue, 17 Oct 2023 10:29:36 +0200
Message-ID: <20231017083003.15951-12-quintela@redhat.com>
In-Reply-To: <20231017083003.15951-1-quintela@redhat.com>
References: <20231017083003.15951-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Fabiano Rosas <farosas@suse.de>

Add basic tests for file-based migration.

Note that we cannot use test_precopy_common because that routine
expects it to be possible to run the migration live. With the file
transport there is no live migration because we must wait for the
source to finish writing the migration data to the file before the
destination can start reading. Add a new migration function
specifically to handle the file migration.

Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20230712190742.22294-7-farosas@suse.de>
---
 tests/qtest/migration-test.c | 147 +++++++++++++++++++++++++++++++++++
 1 file changed, 147 insertions(+)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index cef5081f8c..e1c110537b 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -68,6 +68,10 @@ static bool got_dst_resume;
 
 #define ANALYZE_SCRIPT "scripts/analyze-migration.py"
 
+#define QEMU_VM_FILE_MAGIC 0x5145564d
+#define FILE_TEST_FILENAME "migfile"
+#define FILE_TEST_OFFSET 0x1000
+
 #if defined(__linux__)
 #include <sys/syscall.h>
 #include <sys/vfs.h>
@@ -884,6 +888,7 @@ static void test_migrate_end(QTestState *from, QTestState *to, bool test_dest)
     cleanup("migsocket");
     cleanup("src_serial");
     cleanup("dest_serial");
+    cleanup(FILE_TEST_FILENAME);
 }
 
 #ifdef CONFIG_GNUTLS
@@ -1667,6 +1672,70 @@ finish:
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
@@ -1862,6 +1931,76 @@ static void test_precopy_unix_compress_nowait(void)
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
+static void file_offset_finish_hook(QTestState *from, QTestState *to,
+                                    void *opaque)
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
+    g_assert_cmpint(cpu_to_be64(*p) >> 32, ==, QEMU_VM_FILE_MAGIC);
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
@@ -2909,6 +3048,14 @@ int main(int argc, char **argv)
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
2.41.0


