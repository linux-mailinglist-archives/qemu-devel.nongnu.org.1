Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CA9A31039
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Feb 2025 16:51:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thsXT-0004NI-52; Tue, 11 Feb 2025 10:51:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1thsXN-0004Mp-7w
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 10:51:01 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1thsXK-00021F-Se
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 10:51:00 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A141933D23;
 Tue, 11 Feb 2025 15:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739286116; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=txrpGtX9wzvJUOHI8L8h0Eu791LPY9xU+W+qTejSGTc=;
 b=y2puX+ALlpvTcZCU9Znfb6CU4eNvUt39lykeDbIThQx1iM10//2TeOoFnEQfcottmh8mr8
 RQMNbacZDdwodPgE9eaGFex8R6Wxh/N4P3UV38+ZqhulWqt8eX4Zc3gfNFECHu2Dv/J5vY
 aNcPOGwGz5c/HYGj8+tSVkKcQVkJnKI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739286116;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=txrpGtX9wzvJUOHI8L8h0Eu791LPY9xU+W+qTejSGTc=;
 b=QxVEMOYcumVeTkGY0gsuGHPxHeQ7v3QTqCHnrN71Hvej40gq86IAe1alaeamFYiZQMVwtd
 XLm2GC4jiDrQI/AQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=y2puX+AL;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=QxVEMOYc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739286116; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=txrpGtX9wzvJUOHI8L8h0Eu791LPY9xU+W+qTejSGTc=;
 b=y2puX+ALlpvTcZCU9Znfb6CU4eNvUt39lykeDbIThQx1iM10//2TeOoFnEQfcottmh8mr8
 RQMNbacZDdwodPgE9eaGFex8R6Wxh/N4P3UV38+ZqhulWqt8eX4Zc3gfNFECHu2Dv/J5vY
 aNcPOGwGz5c/HYGj8+tSVkKcQVkJnKI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739286116;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=txrpGtX9wzvJUOHI8L8h0Eu791LPY9xU+W+qTejSGTc=;
 b=QxVEMOYcumVeTkGY0gsuGHPxHeQ7v3QTqCHnrN71Hvej40gq86IAe1alaeamFYiZQMVwtd
 XLm2GC4jiDrQI/AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A46E213715;
 Tue, 11 Feb 2025 15:01:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WAwoGWJmq2c8WwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 11 Feb 2025 15:01:54 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 8/9] tests/qtest/migration: Add a cancel test
Date: Tue, 11 Feb 2025 12:01:35 -0300
Message-Id: <20250211150136.6781-9-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250211150136.6781-1-farosas@suse.de>
References: <20250211150136.6781-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A141933D23
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

The qmp_migrate_cancel() command is poorly tested and code inspection
reveals that there might be concurrency issues with its usage. Add a
test that runs a migration and calls qmp_migrate_cancel() at specific
moments.

In order to make the test more deterministic, instead of calling
qmp_migrate_cancel() at random moments during migration, do it after
the migration status change events are seen.

The expected result is that qmp_migrate_cancel() on the source ends
migration on the source with the "cancelled" state and ends migration
on the destination with the "failed" state. The only exception is that
a failed migration should continue in the failed state.

Cancelling is not allowed during postcopy (no test is added for this
because it's a trivial check in the code).

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration/precopy-tests.c | 176 ++++++++++++++++++++++++++
 1 file changed, 176 insertions(+)

diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index 162fa69531..ba273d10b9 100644
--- a/tests/qtest/migration/precopy-tests.c
+++ b/tests/qtest/migration/precopy-tests.c
@@ -20,6 +20,7 @@
 #include "migration/migration-util.h"
 #include "ppc-util.h"
 #include "qobject/qlist.h"
+#include "qapi-types-migration.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
 #include "qemu/range.h"
@@ -536,6 +537,161 @@ static void test_multifd_tcp_cancel(void)
     migrate_end(from, to2, true);
 }
 
+static void test_cancel_src_after_failed(QTestState *from, QTestState *to,
+                                         const char *uri, const char *phase)
+{
+    /*
+     * No migrate_incoming_qmp() at the start to force source into
+     * failed state during migrate_qmp().
+     */
+
+    wait_for_serial("src_serial");
+    migrate_ensure_converge(from);
+
+    migrate_qmp(from, to, uri, NULL, "{}");
+
+    migration_event_wait(from, phase);
+    migrate_cancel(from);
+
+    /* cancelling will not move the migration out of 'failed' */
+
+    wait_for_migration_status(from, "failed",
+                              (const char * []) { "completed", NULL });
+
+    /*
+     * Not waiting for the destination because it never started
+     * migration.
+     */
+}
+
+static void test_cancel_src_after_cancelled(QTestState *from, QTestState *to,
+                                            const char *uri, const char *phase)
+{
+    migrate_incoming_qmp(to, uri, NULL, "{ 'exit-on-error': false }");
+
+    wait_for_serial("src_serial");
+    migrate_ensure_converge(from);
+
+    migrate_qmp(from, to, uri, NULL, "{}");
+
+    /* To move to cancelled/cancelling */
+    migrate_cancel(from);
+    migration_event_wait(from, phase);
+
+    /* The migrate_cancel under test */
+    migrate_cancel(from);
+
+    wait_for_migration_status(from, "cancelled",
+                              (const char * []) { "completed", NULL });
+
+    wait_for_migration_status(to, "failed",
+                              (const char * []) { "completed", NULL });
+}
+
+static void test_cancel_src_after_complete(QTestState *from, QTestState *to,
+                                           const char *uri, const char *phase)
+{
+    migrate_incoming_qmp(to, uri, NULL, "{ 'exit-on-error': false }");
+
+    wait_for_serial("src_serial");
+    migrate_ensure_converge(from);
+
+    migrate_qmp(from, to, uri, NULL, "{}");
+
+    migration_event_wait(from, phase);
+    migrate_cancel(from);
+
+    /*
+     * qmp_migrate_cancel() exits early if migration is not running
+     * anymore, the status will not change to cancelled.
+     */
+    wait_for_migration_complete(from);
+    wait_for_migration_complete(to);
+}
+
+static void test_cancel_src_after_none(QTestState *from, QTestState *to,
+                                       const char *uri, const char *phase)
+{
+    /*
+     * Test that cancelling without a migration happening does not
+     * affect subsequent migrations
+     */
+    migrate_cancel(to);
+
+    wait_for_serial("src_serial");
+    migrate_cancel(from);
+
+    migrate_incoming_qmp(to, uri, NULL, "{ 'exit-on-error': false }");
+
+    migrate_ensure_converge(from);
+    migrate_qmp(from, to, uri, NULL, "{}");
+
+    wait_for_migration_complete(from);
+    wait_for_migration_complete(to);
+}
+
+static void test_cancel_src_pre_switchover(QTestState *from, QTestState *to,
+                                           const char *uri, const char *phase)
+{
+    migrate_set_capability(from, "pause-before-switchover", true);
+    migrate_set_capability(to, "pause-before-switchover", true);
+
+    migrate_set_capability(from, "multifd", true);
+    migrate_set_capability(to, "multifd", true);
+
+    migrate_incoming_qmp(to, uri, NULL, "{ 'exit-on-error': false }");
+
+    wait_for_serial("src_serial");
+    migrate_ensure_converge(from);
+
+    migrate_qmp(from, to, uri, NULL, "{}");
+
+    migration_event_wait(from, phase);
+    migrate_cancel(from);
+    migration_event_wait(from, "cancelling");
+
+    wait_for_migration_status(from, "cancelled",
+                              (const char * []) { "completed", NULL });
+
+    wait_for_migration_status(to, "failed",
+                              (const char * []) { "completed", NULL });
+}
+
+static void test_cancel_src_after_status(void *opaque)
+{
+    const char *test_path = opaque;
+    g_autofree char *phase = g_path_get_basename(test_path);
+    g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
+    QTestState *from, *to;
+    MigrateStart args = {
+        .hide_stderr = true,
+    };
+
+    if (migrate_start(&from, &to, "defer", &args)) {
+        return;
+    }
+
+    if (g_str_equal(phase, "cancelling") ||
+        g_str_equal(phase, "cancelled")) {
+        test_cancel_src_after_cancelled(from, to, uri, phase);
+
+    } else if (g_str_equal(phase, "completed")) {
+        test_cancel_src_after_complete(from, to, uri, phase);
+
+    } else if (g_str_equal(phase, "failed")) {
+        test_cancel_src_after_failed(from, to, uri, phase);
+
+    } else if (g_str_equal(phase, "none")) {
+        test_cancel_src_after_none(from, to, uri, phase);
+
+    } else {
+        /* any state that comes before pre-switchover */
+        test_cancel_src_pre_switchover(from, to, uri, phase);
+    }
+
+    migrate_end(from, to, false);
+}
+
 static void calc_dirty_rate(QTestState *who, uint64_t calc_time)
 {
     qtest_qmp_assert_success(who,
@@ -1018,4 +1174,24 @@ void migration_test_add_precopy(MigrationTestEnv *env)
                                test_vcpu_dirty_limit);
         }
     }
+
+    /* ensure new status don't go unnoticed */
+    assert(MIGRATION_STATUS__MAX == 15);
+
+    for (int i = MIGRATION_STATUS_NONE; i < MIGRATION_STATUS__MAX; i++) {
+        switch (i) {
+        case MIGRATION_STATUS_DEVICE: /* happens too fast */
+        case MIGRATION_STATUS_WAIT_UNPLUG: /* no support in tests */
+        case MIGRATION_STATUS_COLO: /* no support in tests */
+        case MIGRATION_STATUS_POSTCOPY_ACTIVE: /* postcopy can't be cancelled */
+        case MIGRATION_STATUS_POSTCOPY_PAUSED:
+        case MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP:
+        case MIGRATION_STATUS_POSTCOPY_RECOVER:
+            continue;
+        default:
+            migration_test_add_suffix("/migration/cancel/src/after/",
+                                      MigrationStatus_str(i),
+                                      test_cancel_src_after_status);
+        }
+    }
 }
-- 
2.35.3


