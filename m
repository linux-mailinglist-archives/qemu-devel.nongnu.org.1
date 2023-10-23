Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC087D410D
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 22:39:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qv1f1-0002jg-2k; Mon, 23 Oct 2023 16:36:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qv1ez-0002j0-7Y
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 16:36:25 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qv1ex-0001n5-Dx
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 16:36:24 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3BF8A21B28;
 Mon, 23 Oct 2023 20:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698093382; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/acRSj9Gns6BPDskwHG2W/5R6DDTgO/bxnL85AIt0Po=;
 b=OGI0tyyYVOZBeQ6qc4tQDzRfOJ3NCtzTO5SNmX7lCy3VSQNQ9LcZTXJFTCI+ySgP7RAZbZ
 MYVbrt52DT4nMHdiQM2eJUZEV1oaoaSkmXhj/QsnkMXWvX2nSZEaLhyLHmSFd918oBbdOr
 y587dCHYhvR2T7UPMA3z4nD9hQGKk64=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698093382;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/acRSj9Gns6BPDskwHG2W/5R6DDTgO/bxnL85AIt0Po=;
 b=cXmrf+YIRbsKSjTwgISRQoPkotDWyUatbYiovwiOoX7HWhmLC4g86di1kDOwpPITO6pjje
 K9MgLkMCbgdAZ6Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AC3EF132FD;
 Mon, 23 Oct 2023 20:36:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id kPWxHUPZNmV1JQAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 23 Oct 2023 20:36:19 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Claudio Fontana <cfontana@suse.de>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 03/29] tests/qtest: Allow waiting for migration events
Date: Mon, 23 Oct 2023 17:35:42 -0300
Message-Id: <20231023203608.26370-4-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231023203608.26370-1-farosas@suse.de>
References: <20231023203608.26370-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -2.10
X-Spamd-Result: default: False [-2.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_SEVEN(0.00)[10];
 MID_CONTAINS_FROM(1.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
Received-SPF: pass client-ip=195.135.220.28; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

Add support for waiting for a migration state change event to
happen. This can help disambiguate between runstate changes that
happen during VM lifecycle.

Specifically, the next couple of patches want to know whether STOP
events happened at the migration start or end. Add the "setup" and
"active" migration states for that purpose.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/libqtest.h          |  2 +
 tests/qtest/migration-helpers.c | 66 ++++++++++++++++++++++++++++-----
 tests/qtest/migration-helpers.h |  2 +
 3 files changed, 61 insertions(+), 9 deletions(-)

diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
index 0421a1da24..67fc2ae487 100644
--- a/tests/qtest/libqtest.h
+++ b/tests/qtest/libqtest.h
@@ -26,6 +26,8 @@ typedef struct QTestState QTestState;
 struct QTestMigrationState {
     bool stop_seen;
     bool resume_seen;
+    bool setup_seen;
+    bool active_seen;
 };
 typedef struct QTestMigrationState QTestMigrationState;
 
diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index cffa525c81..a3beff8b57 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -34,6 +34,22 @@ bool migrate_watch_for_events(QTestState *who, const char *name,
         return true;
     } else if (g_str_equal(name, "RESUME")) {
         state->resume_seen = true;
+        return true;
+    } else if (g_str_equal(name, "MIGRATION")) {
+        QDict *data;
+        g_assert(qdict_haskey(event, "data"));
+
+        data = qdict_get_qdict(event, "data");
+        g_assert(qdict_haskey(data, "status"));
+
+        if (g_str_equal(qdict_get_str(data, "status"), "setup")) {
+            state->setup_seen = true;
+        } else if (g_str_equal(qdict_get_str(data, "status"), "active")) {
+            state->active_seen = true;
+        } else {
+            return false;
+        }
+
         return true;
     }
 
@@ -110,10 +126,49 @@ void wait_for_resume(QTestState *who)
     }
 }
 
+static void wait_for_migration_state(QTestState *who, const char* state)
+{
+        QDict *rsp, *data;
+
+        for (;;) {
+            rsp = qtest_qmp_eventwait_ref(who, "MIGRATION");
+            g_assert(qdict_haskey(rsp, "data"));
+
+            data = qdict_get_qdict(rsp, "data");
+            g_assert(qdict_haskey(data, "status"));
+
+            if (g_str_equal(qdict_get_str(data, "status"), state)) {
+                break;
+            }
+            qobject_unref(rsp);
+        }
+
+        qobject_unref(rsp);
+        return;
+}
+
+void wait_for_setup(QTestState *who)
+{
+    QTestMigrationState *state = qtest_migration_state(who);
+
+    if (!state->setup_seen) {
+        wait_for_migration_state(who, "setup");
+    }
+}
+
+void wait_for_active(QTestState *who)
+{
+    QTestMigrationState *state = qtest_migration_state(who);
+
+    if (!state->active_seen) {
+        wait_for_migration_state(who, "active");
+    }
+}
+
 void migrate_incoming_qmp(QTestState *to, const char *uri, const char *fmt, ...)
 {
     va_list ap;
-    QDict *args, *rsp, *data;
+    QDict *args, *rsp;
 
     va_start(ap, fmt);
     args = qdict_from_vjsonf_nofail(fmt, ap);
@@ -129,14 +184,7 @@ void migrate_incoming_qmp(QTestState *to, const char *uri, const char *fmt, ...)
     g_assert(qdict_haskey(rsp, "return"));
     qobject_unref(rsp);
 
-    rsp = qtest_qmp_eventwait_ref(to, "MIGRATION");
-    g_assert(qdict_haskey(rsp, "data"));
-
-    data = qdict_get_qdict(rsp, "data");
-    g_assert(qdict_haskey(data, "status"));
-    g_assert_cmpstr(qdict_get_str(data, "status"), ==, "setup");
-
-    qobject_unref(rsp);
+    wait_for_setup(to);
 }
 
 /*
diff --git a/tests/qtest/migration-helpers.h b/tests/qtest/migration-helpers.h
index 7297f1ff2c..11a93dd48d 100644
--- a/tests/qtest/migration-helpers.h
+++ b/tests/qtest/migration-helpers.h
@@ -21,6 +21,8 @@ bool migrate_watch_for_events(QTestState *who, const char *name,
 
 void wait_for_stop(QTestState *who);
 void wait_for_resume(QTestState *who);
+void wait_for_setup(QTestState *who);
+void wait_for_active(QTestState *who);
 
 G_GNUC_PRINTF(3, 4)
 void migrate_qmp(QTestState *who, const char *uri, const char *fmt, ...);
-- 
2.35.3


