Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 873A08B2811
	for <lists+qemu-devel@lfdr.de>; Thu, 25 Apr 2024 20:18:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s03eP-0001Xh-Qq; Thu, 25 Apr 2024 14:16:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1s03eA-0001Uw-KM
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 14:16:43 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1s03e5-0003zX-Ds
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 14:16:37 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:2a2a:0:640:d546:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 7AB9F60B8A;
 Thu, 25 Apr 2024 21:16:28 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b58e::1:22])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id qFR9v101Pa60-qpvoOCgA; Thu, 25 Apr 2024 21:16:27 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1714068987;
 bh=18w536ufYZlA9siJHU1J/hXZW3Xj6sPZ9OSuuMTxaWo=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=AGUr9GBz99S5D9meI5pkcWeRmGqjkbdSmOVDxylDDkjemjquD/t24puGVMH6rXnGt
 kKgQI0HROCZsF9GYWdAM9hffeJobLMQcqFmhT1I46Fcx0fJsy3ThYjZ/BOBlFiMyJv
 SUoSffjh3cgRo9UgX3prRA7TjGqefToPOMOcPypg=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com,
	farosas@suse.de
Cc: eblake@redhat.com, armbru@redhat.com, pbonzini@redhat.com,
 qemu-devel@nongnu.org, vsementsov@yandex-team.ru, yc-core@yandex-team.ru
Subject: [PATCH v3 4/4] qapi: introduce exit-on-error parameter for
 migrate-incoming
Date: Thu, 25 Apr 2024 21:15:51 +0300
Message-Id: <20240425181551.1465739-5-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425181551.1465739-1-vsementsov@yandex-team.ru>
References: <20240425181551.1465739-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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
---
 migration/migration-hmp-cmds.c |  2 +-
 migration/migration.c          | 36 ++++++++++++++++++++++++++++------
 migration/migration.h          |  3 +++
 qapi/migration.json            |  7 ++++++-
 system/vl.c                    |  3 ++-
 5 files changed, 42 insertions(+), 9 deletions(-)

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
index 0b15f7ccf4..5cfe420a76 100644
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
@@ -797,13 +801,18 @@ fail:
                       MIGRATION_STATUS_FAILED);
     migration_incoming_state_destroy();
 
-    if (migrate_has_error(s)) {
-        WITH_QEMU_LOCK_GUARD(&s->error_mutex) {
-            error_report_err(s->error);
+    if (mis->exit_on_error) {
+        if (migrate_has_error(s)) {
+            WITH_QEMU_LOCK_GUARD(&s->error_mutex) {
+                error_report_err(s->error);
+            }
         }
+        error_report_err(local_err);
+        exit(EXIT_FAILURE);
+    } else {
+        migrate_set_error(s, local_err);
+        error_free(local_err);
     }
-    error_report_err(local_err);
-    exit(EXIT_FAILURE);
 }
 
 /**
@@ -1312,6 +1321,15 @@ static void fill_destination_migration_info(MigrationInfo *info)
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
@@ -1795,10 +1813,13 @@ void migrate_del_blocker(Error **reasonp)
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
@@ -1813,6 +1834,9 @@ void qmp_migrate_incoming(const char *uri, bool has_channels,
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
index 8c65b90328..9de8b98d0b 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1837,6 +1837,10 @@
 # @channels: list of migration stream channels with each stream in the
 #     list connected to a destination interface endpoint.
 #
+# @exit-on-error: Do exit on incoming migration failure.  Default true.
+#     When set to false, the error is reported by MIGRATION event and
+#     error could be retrieved by query-migrate command.  (since 9.1)
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
index c644222982..3bad81b0a4 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2720,7 +2720,8 @@ void qmp_x_exit_preconfig(Error **errp)
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


