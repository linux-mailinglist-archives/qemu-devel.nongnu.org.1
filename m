Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CEAE88CDA7F
	for <lists+qemu-devel@lfdr.de>; Thu, 23 May 2024 21:08:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sADmN-0002oM-4L; Thu, 23 May 2024 15:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sADls-0002G6-5w
 for qemu-devel@nongnu.org; Thu, 23 May 2024 15:06:36 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sADlg-0004Jy-Ti
 for qemu-devel@nongnu.org; Thu, 23 May 2024 15:06:35 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A977622B7D;
 Thu, 23 May 2024 19:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716491183; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qPONvFeKbrPhZNJo/pMWwmXaBvgYfqthr1wvcEaHRu8=;
 b=ghh3I/AHxO4uJnVve+BowpoO5G3mMSmQPMDGB8usf+0jLLXGkTp95O+ZgV8+uiGsNH7Xk0
 IwquriwCP57HTTkkCLV29jFL4TJ5MYutXGFmhRMFIuMsezbktmwW03jQG78QfhxaqwhXWN
 jMhlfp3DmlGZ0aqjUJaUemjE5aq2VZs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716491183;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qPONvFeKbrPhZNJo/pMWwmXaBvgYfqthr1wvcEaHRu8=;
 b=FqGCzEgRe7qD4BhxBb1BgfYsjIn2PqveN5i9fVDRwlxgBqT8ZhB2MmS8t7dr7I4wo5YqcF
 7n2yBumezdz+4oBQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="ghh3I/AH";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=FqGCzEgR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716491183; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qPONvFeKbrPhZNJo/pMWwmXaBvgYfqthr1wvcEaHRu8=;
 b=ghh3I/AHxO4uJnVve+BowpoO5G3mMSmQPMDGB8usf+0jLLXGkTp95O+ZgV8+uiGsNH7Xk0
 IwquriwCP57HTTkkCLV29jFL4TJ5MYutXGFmhRMFIuMsezbktmwW03jQG78QfhxaqwhXWN
 jMhlfp3DmlGZ0aqjUJaUemjE5aq2VZs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716491183;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qPONvFeKbrPhZNJo/pMWwmXaBvgYfqthr1wvcEaHRu8=;
 b=FqGCzEgRe7qD4BhxBb1BgfYsjIn2PqveN5i9fVDRwlxgBqT8ZhB2MmS8t7dr7I4wo5YqcF
 7n2yBumezdz+4oBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2898613A6B;
 Thu, 23 May 2024 19:06:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kLQFOKyTT2bUEQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 23 May 2024 19:06:20 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 12/18] tests/qtest/migration: Add tests for file migration
 with direct-io
Date: Thu, 23 May 2024 16:05:42 -0300
Message-Id: <20240523190548.23977-13-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240523190548.23977-1-farosas@suse.de>
References: <20240523190548.23977-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCPT_COUNT_SEVEN(0.00)[9];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.de:email,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: A977622B7D
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -3.01
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

The tests are only allowed to run in systems that know about the
O_DIRECT flag and in filesystems which support it.

Note: this also brings back migrate_set_parameter_bool() which went
away when we removed the compression tests. I copied it verbatim.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
- updated the aligment comment

- added an inline version of probe function so were able to call it
  without any ifdef

- simplified the _start function that sets the capability

- used qemu_try_memalign instead of aligned_alloc
---
 tests/qtest/migration-helpers.c | 44 +++++++++++++++++++++++
 tests/qtest/migration-helpers.h |  8 +++++
 tests/qtest/migration-test.c    | 62 +++++++++++++++++++++++++++++++++
 3 files changed, 114 insertions(+)

diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index ce6d6615b5..0ac49ceb54 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -18,6 +18,7 @@
 #include "qapi/error.h"
 #include "qapi/qmp/qlist.h"
 #include "qemu/cutils.h"
+#include "qemu/memalign.h"
 
 #include "migration-helpers.h"
 
@@ -473,3 +474,46 @@ void migration_test_add(const char *path, void (*fn)(void))
     qtest_add_data_func_full(path, test, migration_test_wrapper,
                              migration_test_destroy);
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
+    int fd, flags = O_CREAT | O_RDWR | O_TRUNC | O_DIRECT;
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
+     * Using 1MB alignment as conservative choice to satisfy any
+     * plausible architecture default page size, and/or filesystem
+     * alignment restrictions.
+     */
+    len = 0x100000;
+    offset = 0x100000;
+
+    buf = qemu_try_memalign(len, len);
+    g_assert(buf);
+
+    ret = pwrite(fd, buf, len, offset);
+    unlink(filename);
+    g_free(buf);
+
+    if (ret < 0) {
+        return false;
+    }
+
+    return true;
+}
+#endif
diff --git a/tests/qtest/migration-helpers.h b/tests/qtest/migration-helpers.h
index 1339835698..50095fca4a 100644
--- a/tests/qtest/migration-helpers.h
+++ b/tests/qtest/migration-helpers.h
@@ -54,5 +54,13 @@ char *find_common_machine_version(const char *mtype, const char *var1,
                                   const char *var2);
 char *resolve_machine_version(const char *alias, const char *var1,
                               const char *var2);
+#ifdef O_DIRECT
+bool probe_o_direct_support(const char *tmpfs);
+#else
+static inline bool probe_o_direct_support(const char *tmpfs)
+{
+    return false;
+}
+#endif
 void migration_test_add(const char *path, void (*fn)(void));
 #endif /* MIGRATION_HELPERS_H */
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 5bb53f4839..37017ff2d5 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -428,6 +428,38 @@ static void migrate_set_parameter_str(QTestState *who, const char *parameter,
     migrate_check_parameter_str(who, parameter, value);
 }
 
+static long long migrate_get_parameter_bool(QTestState *who,
+                                           const char *parameter)
+{
+    QDict *rsp;
+    int result;
+
+    rsp = qtest_qmp_assert_success_ref(
+        who, "{ 'execute': 'query-migrate-parameters' }");
+    result = qdict_get_bool(rsp, parameter);
+    qobject_unref(rsp);
+    return !!result;
+}
+
+static void migrate_check_parameter_bool(QTestState *who, const char *parameter,
+                                        int value)
+{
+    int result;
+
+    result = migrate_get_parameter_bool(who, parameter);
+    g_assert_cmpint(result, ==, value);
+}
+
+static void migrate_set_parameter_bool(QTestState *who, const char *parameter,
+                                      int value)
+{
+    qtest_qmp_assert_success(who,
+                             "{ 'execute': 'migrate-set-parameters',"
+                             "'arguments': { %s: %i } }",
+                             parameter, value);
+    migrate_check_parameter_bool(who, parameter, value);
+}
+
 static void migrate_ensure_non_converge(QTestState *who)
 {
     /* Can't converge with 1ms downtime + 3 mbs bandwidth limit */
@@ -2178,6 +2210,33 @@ static void test_multifd_file_mapped_ram(void)
     test_file_common(&args, true);
 }
 
+static void *multifd_mapped_ram_dio_start(QTestState *from, QTestState *to)
+{
+    migrate_multifd_mapped_ram_start(from, to);
+
+    migrate_set_parameter_bool(from, "direct-io", true);
+    migrate_set_parameter_bool(to, "direct-io", true);
+
+    return NULL;
+}
+
+static void test_multifd_file_mapped_ram_dio(void)
+{
+    g_autofree char *uri = g_strdup_printf("file:%s/%s", tmpfs,
+                                           FILE_TEST_FILENAME);
+    MigrateCommon args = {
+        .connect_uri = uri,
+        .listen_uri = "defer",
+        .start_hook = multifd_mapped_ram_dio_start,
+    };
+
+    if (!probe_o_direct_support(tmpfs)) {
+        g_test_skip("Filesystem does not support O_DIRECT");
+        return;
+    }
+
+    test_file_common(&args, true);
+}
 
 static void test_precopy_tcp_plain(void)
 {
@@ -3586,6 +3645,9 @@ int main(int argc, char **argv)
     migration_test_add("/migration/multifd/file/mapped-ram/live",
                        test_multifd_file_mapped_ram_live);
 
+    migration_test_add("/migration/multifd/file/mapped-ram/dio",
+                       test_multifd_file_mapped_ram_dio);
+
 #ifdef CONFIG_GNUTLS
     migration_test_add("/migration/precopy/unix/tls/psk",
                        test_precopy_unix_tls_psk);
-- 
2.35.3


