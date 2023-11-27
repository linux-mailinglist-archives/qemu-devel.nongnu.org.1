Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD557FAB75
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 21:28:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7iCo-0004yU-ET; Mon, 27 Nov 2023 15:27:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r7iCl-0004mu-VW
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 15:27:43 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r7iCi-0002vk-TF
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 15:27:43 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F03171FB7A;
 Mon, 27 Nov 2023 20:27:38 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 362411379A;
 Mon, 27 Nov 2023 20:27:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0FJHO7f7ZGVfIQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 27 Nov 2023 20:27:35 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Claudio Fontana <cfontana@suse.de>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH v3 30/30] tests/qtest: Add a test for fixed-ram with
 passing of fds
Date: Mon, 27 Nov 2023 17:26:12 -0300
Message-Id: <20231127202612.23012-31-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231127202612.23012-1-farosas@suse.de>
References: <20231127202612.23012-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++++
Authentication-Results: smtp-out2.suse.de; dkim=none;
 dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.de
 (policy=none); 
 spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:97 is neither
 permitted nor denied by domain of farosas@suse.de)
 smtp.mailfrom=farosas@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [7.80 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; R_SPF_SOFTFAIL(4.60)[~all:c];
 NEURAL_HAM_LONG(-0.99)[-0.988]; RCVD_COUNT_THREE(0.00)[3];
 MX_GOOD(-0.01)[]; RCPT_COUNT_SEVEN(0.00)[10];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 R_DKIM_NA(2.20)[]; MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%];
 DMARC_POLICY_SOFTFAIL(0.10)[suse.de : No valid SPF, No valid DKIM,none]
X-Spam-Score: 7.80
X-Rspamd-Queue-Id: F03171FB7A
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Add a multifd test for fixed-ram with passing of fds into QEMU. This
is how libvirt will consume the feature.

There are a couple of details to the fdset mechanism:

- multifd needs two distinct file descriptors (not duplicated with
  dup()) on the outgoing side so it can enable O_DIRECT only on the
  channels that write with alignment. The dup() system call creates
  file descriptors that share status flags, of which O_DIRECT is one.

  the incoming side doesn't set O_DIRECT, so it can dup() fds and
  therefore can receive only one in the fdset.

- the open() access mode flags used for the fds passed into QEMU need
  to match the flags QEMU uses to open the file. Currently O_WRONLY
  for src and O_RDONLY for dst.

O_DIRECT is not supported on all systems/filesystems, so run the fdset
test without O_DIRECT if that's the case. The migration code should
still work in that scenario.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-helpers.c |  7 ++-
 tests/qtest/migration-test.c    | 87 +++++++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index 02b92f0cb6..3013094800 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -302,7 +302,7 @@ char *resolve_machine_version(const char *alias, const char *var1,
 bool probe_o_direct_support(const char *tmpfs)
 {
     g_autofree char *filename = g_strdup_printf("%s/probe-o-direct", tmpfs);
-    int fd, flags = O_CREAT | O_RDWR | O_DIRECT;
+    int fd, flags = O_CREAT | O_RDWR | O_TRUNC | O_DIRECT;
     void *buf;
     ssize_t ret, len;
     uint64_t offset;
@@ -320,9 +320,12 @@ bool probe_o_direct_support(const char *tmpfs)
     len = 0x100000;
     offset = 0x100000;
 
-    buf = g_malloc0(len);
+    buf = aligned_alloc(len, len);
+    g_assert(buf);
+
     ret = pwrite(fd, buf, len, offset);
     unlink(filename);
+    g_free(buf);
 
     if (ret < 0) {
         return false;
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 192b8ec993..bb2dd805fc 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -2251,8 +2251,90 @@ static void test_multifd_file_fixed_ram_dio(void)
 
     test_file_common(&args, true);
 }
+
+static void migrate_multifd_fixed_ram_fdset_dio_end(QTestState *from,
+                                                    QTestState *to,
+                                                    void *opaque)
+{
+    QDict *resp;
+    QList *fdsets;
+
+    /*
+     * Check that we removed the fdsets after migration, otherwise a
+     * second migration would fail due to too many fdsets.
+     */
+
+    resp = qtest_qmp(from, "{'execute': 'query-fdsets', "
+                     "'arguments': {}}");
+    g_assert(qdict_haskey(resp, "return"));
+    fdsets = qdict_get_qlist(resp, "return");
+    g_assert(fdsets && qlist_empty(fdsets));
+}
+#endif /* O_DIRECT */
+
+#ifndef _WIN32
+static void *migrate_multifd_fixed_ram_fdset(QTestState *from, QTestState *to)
+{
+    g_autofree char *file = g_strdup_printf("%s/%s", tmpfs, FILE_TEST_FILENAME);
+    int fds[3];
+    int src_flags = O_CREAT | O_WRONLY;
+    int dst_flags = O_CREAT | O_RDONLY;
+
+    /* main outgoing channel: no O_DIRECT */
+    fds[0] = open(file, src_flags, 0660);
+    assert(fds[0] != -1);
+
+#ifdef O_DIRECT
+    src_flags |= O_DIRECT;
 #endif
 
+    /* secondary outgoing channels */
+    fds[1] = open(file, src_flags, 0660);
+    assert(fds[1] != -1);
+
+    qtest_qmp_fds_assert_success(from, &fds[0], 1, "{'execute': 'add-fd', "
+                                 "'arguments': {'fdset-id': 1}}");
+
+    qtest_qmp_fds_assert_success(from, &fds[1], 1, "{'execute': 'add-fd', "
+                                 "'arguments': {'fdset-id': 1}}");
+
+    /* incoming channel */
+    fds[2] = open(file, dst_flags, 0660);
+    assert(fds[2] != -1);
+
+    qtest_qmp_fds_assert_success(to, &fds[2], 1, "{'execute': 'add-fd', "
+                                 "'arguments': {'fdset-id': 1}}");
+
+#ifdef O_DIRECT
+        migrate_multifd_fixed_ram_dio_start(from, to);
+#else
+        migrate_multifd_fixed_ram_start(from, to);
+#endif
+
+    return NULL;
+}
+
+static void test_multifd_file_fixed_ram_fdset(void)
+{
+    g_autofree char *uri = g_strdup_printf("file:/dev/fdset/1,offset=0x100");
+    MigrateCommon args = {
+        .connect_uri = uri,
+        .listen_uri = "defer",
+        .start_hook = migrate_multifd_fixed_ram_fdset,
+#ifdef O_DIRECT
+        .finish_hook = migrate_multifd_fixed_ram_fdset_dio_end,
+#endif
+    };
+
+    if (!probe_o_direct_support(tmpfs)) {
+        g_test_skip("Filesystem does not support O_DIRECT");
+        return;
+    }
+
+    test_file_common(&args, true);
+}
+#endif /* _WIN32 */
+
 static void test_precopy_tcp_plain(void)
 {
     MigrateCommon args = {
@@ -3511,6 +3593,11 @@ int main(int argc, char **argv)
                    test_multifd_file_fixed_ram_dio);
 #endif
 
+#ifndef _WIN32
+    qtest_add_func("/migration/multifd/file/fixed-ram/fdset",
+                   test_multifd_file_fixed_ram_fdset);
+#endif
+
 #ifdef CONFIG_GNUTLS
     qtest_add_func("/migration/precopy/unix/tls/psk",
                    test_precopy_unix_tls_psk);
-- 
2.35.3


