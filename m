Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD0C8BA18A
	for <lists+qemu-devel@lfdr.de>; Thu,  2 May 2024 22:25:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2cxw-0007y1-99; Thu, 02 May 2024 16:23:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s2cxs-0007wf-DY
 for qemu-devel@nongnu.org; Thu, 02 May 2024 16:23:36 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s2cxp-0002p0-Ph
 for qemu-devel@nongnu.org; Thu, 02 May 2024 16:23:35 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6296A1FD13;
 Thu,  2 May 2024 20:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714681412; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BAHwE825trCpKMyFR5xXx+etjxzD+Lv9Qo2ZTtlHp6U=;
 b=1jroDJ7xp/XJ6+CXFW80nx78dWotEFg43oeig/wNf5fEgMFJfk76TuCzGZPZlL13zw4Ugg
 mQw5ZbrvPbkIbv370V3wXQSnkCSag+Hb1KMJbxZZSS/pDSrag4406k0PVTOZkdIjCNAIrf
 fj/gKaWLUq+qhwlEqONvHokjJosJLRA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714681412;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BAHwE825trCpKMyFR5xXx+etjxzD+Lv9Qo2ZTtlHp6U=;
 b=dewM2SEv5RwE4MOVjknMC3liBdJFOiV8K3eyvBvA4hwCLctxSdmG1wvG5OLAsR/RvPxXGT
 V1DXWOoRnOCrr0AQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714681412; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BAHwE825trCpKMyFR5xXx+etjxzD+Lv9Qo2ZTtlHp6U=;
 b=1jroDJ7xp/XJ6+CXFW80nx78dWotEFg43oeig/wNf5fEgMFJfk76TuCzGZPZlL13zw4Ugg
 mQw5ZbrvPbkIbv370V3wXQSnkCSag+Hb1KMJbxZZSS/pDSrag4406k0PVTOZkdIjCNAIrf
 fj/gKaWLUq+qhwlEqONvHokjJosJLRA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714681412;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BAHwE825trCpKMyFR5xXx+etjxzD+Lv9Qo2ZTtlHp6U=;
 b=dewM2SEv5RwE4MOVjknMC3liBdJFOiV8K3eyvBvA4hwCLctxSdmG1wvG5OLAsR/RvPxXGT
 V1DXWOoRnOCrr0AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C4ABA13957;
 Thu,  2 May 2024 20:23:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6MKgIkL2M2ZZUQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 02 May 2024 20:23:30 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>
Subject: [PULL 06/13] qapi: introduce exit-on-error parameter for
 migrate-incoming
Date: Thu,  2 May 2024 17:23:09 -0300
Message-Id: <20240502202316.29924-7-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240502202316.29924-1-farosas@suse.de>
References: <20240502202316.29924-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Now we do set MIGRATION_FAILED state, but don't give a chance to
orchestrator to query migration state and get the error.

Let's provide a possibility for QMP-based orchestrators to get an error
like with outgoing migration.

For hmp_migrate_incoming(), let's enable the new behavior: HMP is not
and ABI, it's mostly intended to use by developer and it makes sense
not to stop the process.

For x-exit-preconfig, let's keep the old behavior:
 - it's called from init(), so here we want to keep current behavior by
   default
 - it does exit on error by itself as well
So, if we want to change the behavior of x-exit-preconfig, it should be
another patch.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Acked-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration-hmp-cmds.c |  2 +-
 migration/migration.c          | 33 +++++++++++++++++++++++++++------
 migration/migration.h          |  3 +++
 qapi/migration.json            |  7 ++++++-
 system/vl.c                    |  3 ++-
 5 files changed, 39 insertions(+), 9 deletions(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 7e96ae6ffd..23181bbee1 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -466,7 +466,7 @@ void hmp_migrate_incoming(Monitor *mon, const QDict *qdict)
     }
     QAPI_LIST_PREPEND(caps, g_steal_pointer(&channel));
 
-    qmp_migrate_incoming(NULL, true, caps, &err);
+    qmp_migrate_incoming(NULL, true, caps, true, false, &err);
     qapi_free_MigrationChannelList(caps);
 
 end:
diff --git a/migration/migration.c b/migration/migration.c
index a9599838e6..289afa8d85 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -72,6 +72,8 @@
 #define NOTIFIER_ELEM_INIT(array, elem)    \
     [elem] = NOTIFIER_WITH_RETURN_LIST_INITIALIZER((array)[elem])
 
+#define INMIGRATE_DEFAULT_EXIT_ON_ERROR true
+
 static NotifierWithReturnList migration_state_notifiers[] = {
     NOTIFIER_ELEM_INIT(migration_state_notifiers, MIG_MODE_NORMAL),
     NOTIFIER_ELEM_INIT(migration_state_notifiers, MIG_MODE_CPR_REBOOT),
@@ -234,6 +236,8 @@ void migration_object_init(void)
     qemu_cond_init(&current_incoming->page_request_cond);
     current_incoming->page_requested = g_tree_new(page_request_addr_cmp);
 
+    current_incoming->exit_on_error = INMIGRATE_DEFAULT_EXIT_ON_ERROR;
+
     migration_object_check(current_migration, &error_fatal);
 
     blk_mig_init();
@@ -800,12 +804,14 @@ fail:
 
     migration_incoming_state_destroy();
 
-    WITH_QEMU_LOCK_GUARD(&s->error_mutex) {
-        error_report_err(s->error);
-        s->error = NULL;
-    }
+    if (mis->exit_on_error) {
+        WITH_QEMU_LOCK_GUARD(&s->error_mutex) {
+            error_report_err(s->error);
+            s->error = NULL;
+        }
 
-    exit(EXIT_FAILURE);
+        exit(EXIT_FAILURE);
+    }
 }
 
 /**
@@ -1314,6 +1320,15 @@ static void fill_destination_migration_info(MigrationInfo *info)
         break;
     }
     info->status = mis->state;
+
+    if (!info->error_desc) {
+        MigrationState *s = migrate_get_current();
+        QEMU_LOCK_GUARD(&s->error_mutex);
+
+        if (s->error) {
+            info->error_desc = g_strdup(error_get_pretty(s->error));
+        }
+    }
 }
 
 MigrationInfo *qmp_query_migrate(Error **errp)
@@ -1797,10 +1812,13 @@ void migrate_del_blocker(Error **reasonp)
 }
 
 void qmp_migrate_incoming(const char *uri, bool has_channels,
-                          MigrationChannelList *channels, Error **errp)
+                          MigrationChannelList *channels,
+                          bool has_exit_on_error, bool exit_on_error,
+                          Error **errp)
 {
     Error *local_err = NULL;
     static bool once = true;
+    MigrationIncomingState *mis = migration_incoming_get_current();
 
     if (!once) {
         error_setg(errp, "The incoming migration has already been started");
@@ -1815,6 +1833,9 @@ void qmp_migrate_incoming(const char *uri, bool has_channels,
         return;
     }
 
+    mis->exit_on_error =
+        has_exit_on_error ? exit_on_error : INMIGRATE_DEFAULT_EXIT_ON_ERROR;
+
     qemu_start_incoming_migration(uri, has_channels, channels, &local_err);
 
     if (local_err) {
diff --git a/migration/migration.h b/migration/migration.h
index 8045e39c26..95995a818e 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -227,6 +227,9 @@ struct MigrationIncomingState {
      * is needed as this field is updated serially.
      */
     unsigned int switchover_ack_pending_num;
+
+    /* Do exit on incoming migration failure */
+    bool exit_on_error;
 };
 
 MigrationIncomingState *migration_incoming_get_current(void);
diff --git a/qapi/migration.json b/qapi/migration.json
index 8c65b90328..9feed413b5 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1837,6 +1837,10 @@
 # @channels: list of migration stream channels with each stream in the
 #     list connected to a destination interface endpoint.
 #
+# @exit-on-error: Exit on incoming migration failure.  Default true.
+#     When set to false, the failure triggers a MIGRATION event, and
+#     error details could be retrieved with query-migrate.  (since 9.1)
+#
 # Since: 2.3
 #
 # Notes:
@@ -1889,7 +1893,8 @@
 ##
 { 'command': 'migrate-incoming',
              'data': {'*uri': 'str',
-                      '*channels': [ 'MigrationChannel' ] } }
+                      '*channels': [ 'MigrationChannel' ],
+                      '*exit-on-error': 'bool' } }
 
 ##
 # @xen-save-devices-state:
diff --git a/system/vl.c b/system/vl.c
index 7756eac81e..79cd498395 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2723,7 +2723,8 @@ void qmp_x_exit_preconfig(Error **errp)
     if (incoming) {
         Error *local_err = NULL;
         if (strcmp(incoming, "defer") != 0) {
-            qmp_migrate_incoming(incoming, false, NULL, &local_err);
+            qmp_migrate_incoming(incoming, false, NULL, true, true,
+                                 &local_err);
             if (local_err) {
                 error_reportf_err(local_err, "-incoming %s: ", incoming);
                 exit(1);
-- 
2.35.3


