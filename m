Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C7B9E0E4A
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Dec 2024 23:03:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIEUI-00075C-IN; Mon, 02 Dec 2024 17:01:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tIEUE-00074V-Uh
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 17:01:46 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tIEUD-0003c1-B9
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 17:01:46 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B0AFC21177;
 Mon,  2 Dec 2024 22:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733176903; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WzLMHCrbLXY3QNyPwgC950Z+m54pLA4bbQYlZGwnSro=;
 b=AbTdy8bO9HY+BMbOCtxHUQ3vHxnkLv8Y13iKK5XHiVbbvPboD1fHCp0F03m51KFwiImNev
 oQgMFReJf8L5pgKIPn/ogg/VJSPgBeO5PL+g2y7VWwhygR/J5wbdDSBusERx1ZAzw30NDW
 Gr20iPEcuAD/h/yH8zttI69J4Pt7NbI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733176903;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WzLMHCrbLXY3QNyPwgC950Z+m54pLA4bbQYlZGwnSro=;
 b=P2QEt2CHZEQTLvwWsTcC7fXhxS1Tka+aNQRqMBMshZzqxjzWWQD71MoXzKd5/dC1WQ4EGy
 jbcCei+Pawx7zfCA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=AbTdy8bO;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=P2QEt2CH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733176903; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WzLMHCrbLXY3QNyPwgC950Z+m54pLA4bbQYlZGwnSro=;
 b=AbTdy8bO9HY+BMbOCtxHUQ3vHxnkLv8Y13iKK5XHiVbbvPboD1fHCp0F03m51KFwiImNev
 oQgMFReJf8L5pgKIPn/ogg/VJSPgBeO5PL+g2y7VWwhygR/J5wbdDSBusERx1ZAzw30NDW
 Gr20iPEcuAD/h/yH8zttI69J4Pt7NbI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733176903;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WzLMHCrbLXY3QNyPwgC950Z+m54pLA4bbQYlZGwnSro=;
 b=P2QEt2CHZEQTLvwWsTcC7fXhxS1Tka+aNQRqMBMshZzqxjzWWQD71MoXzKd5/dC1WQ4EGy
 jbcCei+Pawx7zfCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8316913A40;
 Mon,  2 Dec 2024 22:01:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aNlgEkYuTmdlIAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 02 Dec 2024 22:01:42 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 1/6] tests/qtest/migration: Introduce migration_test_add_suffix
Date: Mon,  2 Dec 2024 19:01:32 -0300
Message-Id: <20241202220137.32584-2-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241202220137.32584-1-farosas@suse.de>
References: <20241202220137.32584-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B0AFC21177
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Introduce a new migration_test_add_suffix to allow programmatic
creation of tests based on a suffix. Pass the test name into the test
so it can know which variant to run.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-helpers.c | 24 ++++++++++++++++++++++++
 tests/qtest/migration-helpers.h |  2 ++
 2 files changed, 26 insertions(+)

diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index 3f8ba7fa8e..905f4c583d 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -437,6 +437,7 @@ char *resolve_machine_version(const char *alias, const char *var1,
 typedef struct {
     char *name;
     void (*func)(void);
+    void (*func_full)(void *);
 } MigrationTest;
 
 static void migration_test_destroy(gpointer data)
@@ -466,6 +467,29 @@ void migration_test_add(const char *path, void (*fn)(void))
                              migration_test_destroy);
 }
 
+static void migration_test_wrapper_full(const void *data)
+{
+    MigrationTest *test = (MigrationTest *)data;
+
+    g_test_message("Running /%s%s", qtest_get_arch(), test->name);
+    test->func_full(test->name);
+}
+
+void migration_test_add_suffix(const char *path, const char *suffix,
+                               void (*fn)(void *))
+{
+    MigrationTest *test = g_new0(MigrationTest, 1);
+
+    g_assert(g_str_has_suffix(path, "/"));
+    g_assert(!g_str_has_prefix(suffix, "/"));
+
+    test->func_full = fn;
+    test->name = g_strconcat(path, suffix, NULL);
+
+    qtest_add_data_func_full(test->name, test, migration_test_wrapper_full,
+                             migration_test_destroy);
+}
+
 #ifdef O_DIRECT
 /*
  * Probe for O_DIRECT support on the filesystem. Since this is used
diff --git a/tests/qtest/migration-helpers.h b/tests/qtest/migration-helpers.h
index 72dba369fb..391038f59b 100644
--- a/tests/qtest/migration-helpers.h
+++ b/tests/qtest/migration-helpers.h
@@ -63,6 +63,8 @@ static inline bool probe_o_direct_support(const char *tmpfs)
 }
 #endif
 void migration_test_add(const char *path, void (*fn)(void));
+void migration_test_add_suffix(const char *path, const char *suffix,
+                               void (*fn)(void *));
 void migration_event_wait(QTestState *s, const char *target);
 
 #endif /* MIGRATION_HELPERS_H */
-- 
2.35.3


