Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0678B6D9B
	for <lists+qemu-devel@lfdr.de>; Tue, 30 Apr 2024 10:57:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1jIW-0003V8-Eh; Tue, 30 Apr 2024 04:57:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1s1jIS-0003S3-K8
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 04:57:08 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1s1jIN-0000wt-Hy
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 04:57:08 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:2a2a:0:640:d546:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 1FFB4608DF;
 Tue, 30 Apr 2024 11:57:02 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:8829::1:3c])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id muME9V11IOs0-G5JClCnL; Tue, 30 Apr 2024 11:57:01 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1714467421;
 bh=hPl5qi27J+/Tg/0IfFFrYhoTft2ShBb4TNFFRz0LIM4=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=wfcHTtt60x/XsOJaMUW7haMIF0/7vS5J9XmlSHILYhoEpp7dSkKZPyRRxHyNTafaD
 5FidVnwy69oKvxJhVz7PdN5cNiFCHo9O77094xETkry7Vfez+BcKVcV21maCIeGr5z
 DWj17IcaR2WrR305iewyg6EOPcFfiQe2tyV1ZWKk=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com,
	farosas@suse.de
Cc: eblake@redhat.com, armbru@redhat.com, pbonzini@redhat.com,
 qemu-devel@nongnu.org, vsementsov@yandex-team.ru, yc-core@yandex-team.ru
Subject: [PATCH v6 5/5] qapi: introduce exit-on-error parameter for
 migrate-incoming
Date: Tue, 30 Apr 2024 11:56:46 +0300
Message-Id: <20240430085646.2359711-6-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430085646.2359711-1-vsementsov@yandex-team.ru>
References: <20240430085646.2359711-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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
2.34.1


