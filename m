Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C797FAB93
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 21:31:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7iCW-0003bm-Nd; Mon, 27 Nov 2023 15:27:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r7iCV-0003b9-2Z
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 15:27:27 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r7iCS-0002tH-BJ
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 15:27:26 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1A4C221B4D;
 Mon, 27 Nov 2023 20:27:23 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 47DE11379A;
 Mon, 27 Nov 2023 20:27:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GIXmA6j7ZGVfIQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 27 Nov 2023 20:27:20 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Claudio Fontana <cfontana@suse.de>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH v3 24/30] tests/qtest: Add a test for migration with
 direct-io and multifd
Date: Mon, 27 Nov 2023 17:26:06 -0300
Message-Id: <20231127202612.23012-25-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231127202612.23012-1-farosas@suse.de>
References: <20231127202612.23012-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++++
Authentication-Results: smtp-out1.suse.de; dkim=none;
 dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.de
 (policy=none); 
 spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:97 is neither
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
X-Rspamd-Queue-Id: 1A4C221B4D
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

The test is only allowed to run in systems that know and in
filesystems which support O_DIRECT.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
- added ifdefs for O_DIRECT and a probing function
---
 tests/qtest/migration-helpers.c | 39 +++++++++++++++++++++++++++++++++
 tests/qtest/migration-helpers.h |  1 +
 tests/qtest/migration-test.c    | 35 +++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+)

diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index 24fb7b3525..02b92f0cb6 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -292,3 +292,42 @@ char *resolve_machine_version(const char *alias, const char *var1,
 
     return find_common_machine_version(machine_name, var1, var2);
 }
+
+#ifdef O_DIRECT
+/*
+ * Probe for O_DIRECT support on the filesystem. Since this is used
+ * for tests, be conservative, if anything fails, assume it's
+ * unsupported.
+ */
+bool probe_o_direct_support(const char *tmpfs)
+{
+    g_autofree char *filename = g_strdup_printf("%s/probe-o-direct", tmpfs);
+    int fd, flags = O_CREAT | O_RDWR | O_DIRECT;
+    void *buf;
+    ssize_t ret, len;
+    uint64_t offset;
+
+    fd = open(filename, flags, 0660);
+    if (fd < 0) {
+        unlink(filename);
+        return false;
+    }
+
+    /*
+     * Assuming 4k should be enough to satisfy O_DIRECT alignment
+     * requirements. The migration code uses 1M to be conservative.
+     */
+    len = 0x100000;
+    offset = 0x100000;
+
+    buf = g_malloc0(len);
+    ret = pwrite(fd, buf, len, offset);
+    unlink(filename);
+
+    if (ret < 0) {
+        return false;
+    }
+
+    return true;
+}
+#endif
diff --git a/tests/qtest/migration-helpers.h b/tests/qtest/migration-helpers.h
index e31dc85cc7..15df009d35 100644
--- a/tests/qtest/migration-helpers.h
+++ b/tests/qtest/migration-helpers.h
@@ -47,4 +47,5 @@ char *find_common_machine_version(const char *mtype, const char *var1,
                                   const char *var2);
 char *resolve_machine_version(const char *alias, const char *var1,
                               const char *var2);
+bool probe_o_direct_support(const char *tmpfs);
 #endif /* MIGRATION_HELPERS_H */
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 5c5725687c..192b8ec993 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -2222,6 +2222,36 @@ static void test_multifd_file_fixed_ram(void)
     test_file_common(&args, true);
 }
 
+#ifdef O_DIRECT
+static void *migrate_multifd_fixed_ram_dio_start(QTestState *from,
+                                                 QTestState *to)
+{
+    migrate_multifd_fixed_ram_start(from, to);
+
+    migrate_set_parameter_bool(from, "direct-io", true);
+    migrate_set_parameter_bool(to, "direct-io", true);
+
+    return NULL;
+}
+
+static void test_multifd_file_fixed_ram_dio(void)
+{
+    g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
+                                           FILE_TEST_FILENAME);
+    MigrateCommon args = {
+        .connect_uri = uri,
+        .listen_uri = "defer",
+        .start_hook = migrate_multifd_fixed_ram_dio_start,
+    };
+
+    if (!probe_o_direct_support(tmpfs)) {
+        g_test_skip("Filesystem does not support O_DIRECT");
+        return;
+    }
+
+    test_file_common(&args, true);
+}
+#endif
 
 static void test_precopy_tcp_plain(void)
 {
@@ -3476,6 +3506,11 @@ int main(int argc, char **argv)
     qtest_add_func("/migration/multifd/file/fixed-ram/live",
                    test_multifd_file_fixed_ram_live);
 
+#ifdef O_DIRECT
+    qtest_add_func("/migration/multifd/file/fixed-ram/dio",
+                   test_multifd_file_fixed_ram_dio);
+#endif
+
 #ifdef CONFIG_GNUTLS
     qtest_add_func("/migration/precopy/unix/tls/psk",
                    test_precopy_unix_tls_psk);
-- 
2.35.3


