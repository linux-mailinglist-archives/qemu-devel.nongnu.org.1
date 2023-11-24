Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F0F7F78BA
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 17:16:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6YpV-0000Ao-2F; Fri, 24 Nov 2023 11:14:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r6YpQ-0008WB-Jd
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 11:14:52 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r6YpP-0001WN-1s
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 11:14:52 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 50DE31FF43;
 Fri, 24 Nov 2023 16:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1700842489; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kjDsiGcTRL/doeBccgNKHzTlrtxs4wmztKNqmuWls68=;
 b=ZNZXR0d0fijuGKDzAokKOZmen3SlljoYCTNlEezeOp9dYrMV0fS8xrU5iqEu6LxlauCLRX
 oWDNOsYO9zVmsr/PAE3UjtmWz4BbtRSI1SjJzu8qIb1yASTTEeiohnMFZP4a8zfMJUnrlt
 bcGrVukLUcHTHYH+mJkZ0jmZPTB2ku4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1700842489;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kjDsiGcTRL/doeBccgNKHzTlrtxs4wmztKNqmuWls68=;
 b=13TIaMXxAXSpOySQx/nJbw835YjAo5EfTsHmiShnuAEghVXch0PTGxoMKzlmdSRTtJqPF8
 dvB3DGfmBn3t1NAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4686513A98;
 Fri, 24 Nov 2023 16:14:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aGfNA/fLYGXdagAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 24 Nov 2023 16:14:47 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v1 6/7] tests/qtest/migration: Add a wrapper to print test
 names
Date: Fri, 24 Nov 2023 13:14:31 -0300
Message-Id: <20231124161432.3515-7-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231124161432.3515-1-farosas@suse.de>
References: <20231124161432.3515-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: 1.44
X-Spamd-Result: default: False [1.44 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 BROKEN_CONTENT_TYPE(1.50)[]; RCVD_COUNT_THREE(0.00)[3];
 RCPT_COUNT_SEVEN(0.00)[7]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; BAYES_HAM(-3.00)[100.00%];
 ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_SPAM_SHORT(0.54)[0.181];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Our usage of gtest results in us losing the very basic functionality
of "knowing which test failed". The issue is that gtest only prints
test names ("paths" in gtest parlance) once the test has finished, but
we use asserts in the tests and crash gtest itself before it can print
anything. We also use a final abort when the result of g_test_run is
not 0.

Depending on how the test failed/broke we can see the function that
trigged the abort, which may be representative of the test, but it
could also just be some generic function.

We have been relying on the primitive method of looking at the name of
the previous successful test and then looking at the code to figure
out which test should have come next.

Add a wrapper to the test registration that does the job of printing
the test name before running.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-helpers.c | 32 ++++++++++++++++++++++++++++++++
 tests/qtest/migration-helpers.h |  1 +
 2 files changed, 33 insertions(+)

diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index f1106128a9..164e09c299 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -298,3 +298,35 @@ char *resolve_machine_version(const char *alias, const char *var1,
 
     return find_common_machine_version(machine_name, var1, var2);
 }
+
+typedef struct {
+    char *name;
+    void (*func)(void);
+} MigrationTest;
+
+static void migration_test_destroy(gpointer data)
+{
+    MigrationTest *test = (MigrationTest *)data;
+
+    g_free(test->name);
+    g_free(test);
+}
+
+static void migration_test_wrapper(const void *data)
+{
+    MigrationTest *test = (MigrationTest *)data;
+
+    g_test_message("Running /%s%s", qtest_get_arch(), test->name);
+    test->func();
+}
+
+void migration_test_add(const char *path, void (*fn)(void))
+{
+    MigrationTest *test = g_new0(MigrationTest, 1);
+
+    test->func = fn;
+    test->name = g_strdup(path);
+
+    qtest_add_data_func_full(path, test, migration_test_wrapper,
+                             migration_test_destroy);
+}
diff --git a/tests/qtest/migration-helpers.h b/tests/qtest/migration-helpers.h
index e31dc85cc7..0d9a02edc7 100644
--- a/tests/qtest/migration-helpers.h
+++ b/tests/qtest/migration-helpers.h
@@ -47,4 +47,5 @@ char *find_common_machine_version(const char *mtype, const char *var1,
                                   const char *var2);
 char *resolve_machine_version(const char *alias, const char *var1,
                               const char *var2);
+void migration_test_add(const char *path, void (*fn)(void));
 #endif /* MIGRATION_HELPERS_H */
-- 
2.35.3


