Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A80F88243AB
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 15:23:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLOcJ-0001m4-Rf; Thu, 04 Jan 2024 09:22:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rLOcB-0001ch-Es
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 09:22:33 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rLOc8-000056-13
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 09:22:30 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C7D291F814;
 Thu,  4 Jan 2024 14:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1704378146; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xnpu3DA0GrvhfskEhM1zT5+7Q/70EkWdo5FmmXU/Z9I=;
 b=dvHW2qo6f5Ci0+Br6iUUXRPhFxHdDYHvdzioDykxY8ACbCj4nMl2PGjpKccf7jQ/SyBmsh
 4XdarT/G2Fc0kAqt6/AVE/1YukczTViLWSnV/Oieye01CjjJh/zA72wd+FpeCWJPbPefza
 afwPtVc92rXilvSVkpKinJ+mLMDZKNk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1704378146;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xnpu3DA0GrvhfskEhM1zT5+7Q/70EkWdo5FmmXU/Z9I=;
 b=phWXvFx1X0oKWbTs5UMLCOUuW9g1bjNlMAMGN6DlRhMPKM4GBiTlHi97usCpLL8KH1cEXB
 noxV5xNLiyK9b3BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1704378146; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xnpu3DA0GrvhfskEhM1zT5+7Q/70EkWdo5FmmXU/Z9I=;
 b=dvHW2qo6f5Ci0+Br6iUUXRPhFxHdDYHvdzioDykxY8ACbCj4nMl2PGjpKccf7jQ/SyBmsh
 4XdarT/G2Fc0kAqt6/AVE/1YukczTViLWSnV/Oieye01CjjJh/zA72wd+FpeCWJPbPefza
 afwPtVc92rXilvSVkpKinJ+mLMDZKNk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1704378146;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xnpu3DA0GrvhfskEhM1zT5+7Q/70EkWdo5FmmXU/Z9I=;
 b=phWXvFx1X0oKWbTs5UMLCOUuW9g1bjNlMAMGN6DlRhMPKM4GBiTlHi97usCpLL8KH1cEXB
 noxV5xNLiyK9b3BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2BDFD137E8;
 Thu,  4 Jan 2024 14:22:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kOR6OCC/lmUfPAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 04 Jan 2024 14:22:24 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 6/7] tests/qtest/migration: Add a wrapper to print test
 names
Date: Thu,  4 Jan 2024 11:21:43 -0300
Message-Id: <20240104142144.9680-7-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240104142144.9680-1-farosas@suse.de>
References: <20240104142144.9680-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: C7D291F814
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=dvHW2qo6;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=phWXvFx1
X-Spam-Score: -1.81
X-Spamd-Result: default: False [-1.81 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 BROKEN_CONTENT_TYPE(1.50)[]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.de:+];
 MX_GOOD(-0.01)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; BAYES_HAM(-3.00)[100.00%];
 ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[suse.de:email,suse.de:dkim];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain];
 DWL_DNSWL_HI(-3.50)[suse.de:dkim];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration-helpers.c | 32 ++++++++++++++++++++++++++++++++
 tests/qtest/migration-helpers.h |  1 +
 2 files changed, 33 insertions(+)

diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index 19384e3fa6..e451dbdbed 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -291,3 +291,35 @@ char *resolve_machine_version(const char *alias, const char *var1,
 
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
index b478549096..3bf7ded1b9 100644
--- a/tests/qtest/migration-helpers.h
+++ b/tests/qtest/migration-helpers.h
@@ -52,4 +52,5 @@ char *find_common_machine_version(const char *mtype, const char *var1,
                                   const char *var2);
 char *resolve_machine_version(const char *alias, const char *var1,
                               const char *var2);
+void migration_test_add(const char *path, void (*fn)(void));
 #endif /* MIGRATION_HELPERS_H */
-- 
2.35.3


