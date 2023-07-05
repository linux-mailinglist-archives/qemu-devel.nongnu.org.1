Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E14CF748780
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 17:09:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH47f-0004DD-6f; Wed, 05 Jul 2023 11:08:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qH47d-0004Cz-I5
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 11:08:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qH47b-0000GF-En
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 11:08:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688569726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ynPxk9/i0vVuV8WYQufw0KQWJLlpcVsXRA8vR7dmLQs=;
 b=ig95H+aT7P3xoulsKHKQp8+wJGrNO5V5OsmOtd4/KkG9WsioPmKAW9jiKrID75AcPms3Kl
 jUf2gzVcbsoR2S5AEmWutO3ZkKYUBFipgV1BUIvXvZQPq0n/gFttR3tQtTVZ8duyaX6EY/
 Kx8FbFcszlH6R0Pc1bitFyquwhUBABM=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-sruswZpjPHezP6qtYoZJcg-1; Wed, 05 Jul 2023 11:08:45 -0400
X-MC-Unique: sruswZpjPHezP6qtYoZJcg-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-401df9d2dc4so16461261cf.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 08:08:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688569709; x=1691161709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ynPxk9/i0vVuV8WYQufw0KQWJLlpcVsXRA8vR7dmLQs=;
 b=fXpJ9iF50bVfhDP3BR+wremrLo0w3hFdQw8zW0JM/AC3etX0nuWn6Mky4JthiD0P85
 TCGMSIoGu1Rm2I7jjcwNp0MDCj6EmQlUBosxQZ9+9PlwFimRfXfXV/WGUNoTmCDP3H96
 vOku8ylXO26G/SOg7umN/GR1SImMP6b1l2vo+QlISEybb2r1Rca1YgpadhKBaVZI8dvg
 ZTlJFiooXT2P1QLxmdEKo76UmQ3qAYXuFetE+saisBCYGndPLIwjF+uhAF36tmc4eEmS
 zobms9lcD2rI3iOcn4AlvMPM8zcvRQEbbyj9bAez0SChA36H2A1XXfebgAhxX1AQl5nV
 9Wgg==
X-Gm-Message-State: AC+VfDwvmjsJPtAU2TbNWqd5pLzNGDozcR0ivAA13ATHi1mwXhRoQS/+
 dyymArA1WvKRApESnnxPu0JQhQ9ocpUlLsBHuWUsjh2FJt0qkPgORfV0WRviNsFDAGrZ+L0xwvY
 hZX/p9XxclnLXx43ei4W94Hu2avgzLX6KC6rUOCGzcFL2PXYF238Y4Mtbuv68xC4n8bo2Fwoz
X-Received: by 2002:a05:622a:1981:b0:400:84a9:a09c with SMTP id
 u1-20020a05622a198100b0040084a9a09cmr20760705qtc.6.1688569709193; 
 Wed, 05 Jul 2023 08:08:29 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7q21azWl/OBooF7QM3x5yEEsidfCNeqVbSZgi1u7s+cVHaUiApnG4f6cYthj9ABqqSZwq6VQ==
X-Received: by 2002:a05:622a:1981:b0:400:84a9:a09c with SMTP id
 u1-20020a05622a198100b0040084a9a09cmr20760669qtc.6.1688569708588; 
 Wed, 05 Jul 2023 08:08:28 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 bs9-20020ac86f09000000b00400c5f5e713sm11826952qtb.97.2023.07.05.08.08.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jul 2023 08:08:28 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 Eric Blake <eblake@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>
Subject: [PATCH v3 1/2] migration: switchover-hold parameter
Date: Wed,  5 Jul 2023 11:08:23 -0400
Message-ID: <20230705150825.305076-2-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705150825.305076-1-peterx@redhat.com>
References: <20230705150825.305076-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Add a new migration parameter switchover-hold which can block src qemu
migration from switching over to dest from running.

One can set this flag to true so src qemu will keep iterating the VM data,
not switching over to dest even if it can.

It means now live migration works somehow like COLO; we keep syncing data
from src to dst without stopping.

When the user is ready for the switchover, one can set the parameter from
true->false.  That'll contain a implicit kick to migration thread to be
alive and re-evaluate the switchover decision.

This can be used in two cases so far in my mind:

  (1) One can use this parameter to start pre-heating migration (but not
      really migrating, so a migrate-cancel will cancel the preheat).  When
      the user wants to really migrate, just clear the flag.  It'll in most
      cases migrate immediately because most pages are already synced.

  (2) Can also be used as a clean way to do qtest, in many of the precopy
      tests we have requirement to run after 1 iteration without completing
      the precopy migration.  Before that we have either set bandwidth to
      ridiculous low value, or tricks on detecting guest memory change over
      some adhoc guest memory position.  Now we can simply set this flag
      then we know precopy won't complete and will just keep going.

Here we leveraged a sem to make sure migration thread won't busy spin on a
physical cpu, meanwhile provide a timedwait() of 10ms so it can still try
its best to sync with dest QEMU from time to time.  Note that the sem is
prone to outdated counts but it's benign, please refer to the comment above
the semaphore definition for more information.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 qapi/migration.json            | 25 +++++++++++--
 migration/migration.h          | 17 +++++++++
 migration/migration-hmp-cmds.c |  3 ++
 migration/migration.c          | 68 ++++++++++++++++++++++++++++++++--
 migration/options.c            | 17 +++++++++
 5 files changed, 124 insertions(+), 6 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 47dfef0278..c050081555 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -789,6 +789,15 @@
 #     Nodes are mapped to their block device name if there is one, and
 #     to their node name otherwise.  (Since 5.2)
 #
+# @switchover-hold: Whether we should hold-off precopy switchover from
+#     src to dest QEMU, even if we can finish migration in the
+#     downtime specified.  By default off, so precopy migration will
+#     complete as soon as possible.  One can set it to explicitly keep
+#     iterating during precopy migration until set the flag to false
+#     again to kick off the final switchover.  Note, this does not
+#     affect postcopy switchover, because the user can control that
+#     using "migrate-start-postcopy" command explicitly.  (Since 8.1)
+#
 # Features:
 #
 # @unstable: Member @x-checkpoint-delay is experimental.
@@ -810,7 +819,7 @@
            'xbzrle-cache-size', 'max-postcopy-bandwidth',
            'max-cpu-throttle', 'multifd-compression',
            'multifd-zlib-level' ,'multifd-zstd-level',
-           'block-bitmap-mapping' ] }
+           'block-bitmap-mapping', 'switchover-hold' ] }
 
 ##
 # @MigrateSetParameters:
@@ -945,6 +954,10 @@
 #     Nodes are mapped to their block device name if there is one, and
 #     to their node name otherwise.  (Since 5.2)
 #
+# @switchover-hold: Whether we should hold-off precopy switchover from
+#     src to dest QEMU.  For more details, please refer to
+#     MigrationParameter entry of the same field.  (Since 8.1)
+#
 # Features:
 #
 # @unstable: Member @x-checkpoint-delay is experimental.
@@ -982,7 +995,8 @@
             '*multifd-compression': 'MultiFDCompression',
             '*multifd-zlib-level': 'uint8',
             '*multifd-zstd-level': 'uint8',
-            '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ] } }
+            '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ],
+            '*switchover-hold': 'bool' } }
 
 ##
 # @migrate-set-parameters:
@@ -1137,6 +1151,10 @@
 #     Nodes are mapped to their block device name if there is one, and
 #     to their node name otherwise.  (Since 5.2)
 #
+# @switchover-hold: Whether we should hold-off precopy switchover from
+#     src to dest QEMU.  For more details, please refer to
+#     MigrationParameter entry of the same field.  (Since 8.1)
+#
 # Features:
 #
 # @unstable: Member @x-checkpoint-delay is experimental.
@@ -1171,7 +1189,8 @@
             '*multifd-compression': 'MultiFDCompression',
             '*multifd-zlib-level': 'uint8',
             '*multifd-zstd-level': 'uint8',
-            '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ] } }
+            '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ],
+            '*switchover-hold': 'bool' } }
 
 ##
 # @query-migrate-parameters:
diff --git a/migration/migration.h b/migration/migration.h
index a80b22b703..6b31a4b371 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -453,6 +453,23 @@ struct MigrationState {
      * switchover has been received.
      */
     bool switchover_acked;
+
+    /*
+     * Only migration thread will wait on it when switchover_hold==true.
+     *
+     * Only qmp set param will kick it when switching switchover_hold from
+     * true->false.
+     *
+     * NOTE: outdated sem count here is benign.  E.g., when this is posted,
+     * the 1st migration got cancelled, then start the 2nd migration, or
+     * when someone sets the flag from true->false->true->false.. because
+     * any outdated sem count will only let the migration thread to run one
+     * more loop (timedwait() will eat the outdated count) when reaching
+     * the completion phase, then in the next loop it'll sleep again.  The
+     * important thing here OTOH is when the migration thread is sleeping
+     * we can always kick it out of the sleep, which we will always do.
+     */
+    QemuSemaphore switchover_hold_sem;
 };
 
 void migrate_set_state(int *state, int old_state, int new_state);
diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 9885d7c9f7..63a2c8a4a3 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -338,6 +338,9 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
         monitor_printf(mon, "%s: '%s'\n",
             MigrationParameter_str(MIGRATION_PARAMETER_TLS_AUTHZ),
             params->tls_authz);
+        monitor_printf(mon, "%s: %s\n",
+            MigrationParameter_str(MIGRATION_PARAMETER_SWITCHOVER_HOLD),
+            params->switchover_hold ? "on" : "off");
 
         if (params->has_block_bitmap_mapping) {
             const BitmapMigrationNodeAliasList *bmnal;
diff --git a/migration/migration.c b/migration/migration.c
index 096e8191d1..5492eb8bcd 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2721,6 +2721,67 @@ static bool migration_can_switchover(MigrationState *s)
     return s->switchover_acked;
 }
 
+static bool
+migration_should_complete(MigrationState *s, uint64_t pending_size)
+{
+    /* Need an explicit ACK from dst? */
+    if (!migration_can_switchover(s)) {
+        return false;
+    }
+
+    /* We still have large pending data to send? */
+    if (pending_size && (pending_size >= s->threshold_size)) {
+        return false;
+    }
+
+    /* The user doesn't want us to switchover yet for precopy */
+    if (!migration_in_postcopy() && s->parameters.switchover_hold) {
+        /*
+         * Note: when reaching here it probably means we've migrated almost
+         * everything and ready to switchover.  If user asked not to switch
+         * wait for a short period and respond to kicks immediately.
+         *
+         * If we wait too long, there can be a lot of dirty data generated,
+         * while we could have done something to sync data between src/dst.
+         *
+         * If we wait too short, migration thread can eat most/all cpu
+         * resource looping over switchover_hold.
+         *
+         * Make it 10ms which seems to be a good intermediate value.
+         */
+        qemu_sem_timedwait(&s->switchover_hold_sem, 10);
+
+        /*
+         * Return false here always even if user changed it, because we'd
+         * like to re-evaluate everything (e.g. pending_size).
+         */
+        return false;
+    }
+
+    return true;
+}
+
+static bool
+migration_should_start_postcopy(MigrationState *s, uint64_t must_precopy)
+{
+    /* If we're already in postcopy phase, don't bother */
+    if (migration_in_postcopy()) {
+        return false;
+    }
+
+    /* Need an explicit ACK from dst? */
+    if (!migration_can_switchover(s)) {
+        return false;
+    }
+
+    /* We still have lots of thing that must be migrated in precopy */
+    if (must_precopy > s->threshold_size) {
+        return false;
+    }
+
+    return qatomic_read(&s->start_postcopy);
+}
+
 /* Migration thread iteration status */
 typedef enum {
     MIG_ITERATE_RESUME,         /* Resume current iteration */
@@ -2749,15 +2810,14 @@ static MigIterateState migration_iteration_run(MigrationState *s)
         trace_migrate_pending_exact(pending_size, must_precopy, can_postcopy);
     }
 
-    if ((!pending_size || pending_size < s->threshold_size) && can_switchover) {
+    if (migration_should_complete(s, pending_size)) {
         trace_migration_thread_low_pending(pending_size);
         migration_completion(s);
         return MIG_ITERATE_BREAK;
     }
 
     /* Still a significant amount to transfer */
-    if (!in_postcopy && must_precopy <= s->threshold_size && can_switchover &&
-        qatomic_read(&s->start_postcopy)) {
+    if (migration_should_start_postcopy(s, must_precopy)) {
         if (postcopy_start(s)) {
             error_report("%s: postcopy failed to start", __func__);
         }
@@ -3314,6 +3374,7 @@ static void migration_instance_finalize(Object *obj)
     qemu_sem_destroy(&ms->rp_state.rp_sem);
     qemu_sem_destroy(&ms->rp_state.rp_pong_acks);
     qemu_sem_destroy(&ms->postcopy_qemufile_src_sem);
+    qemu_sem_destroy(&ms->switchover_hold_sem);
     error_free(ms->error);
 }
 
@@ -3336,6 +3397,7 @@ static void migration_instance_init(Object *obj)
     qemu_sem_init(&ms->rate_limit_sem, 0);
     qemu_sem_init(&ms->wait_unplug_sem, 0);
     qemu_sem_init(&ms->postcopy_qemufile_src_sem, 0);
+    qemu_sem_init(&ms->switchover_hold_sem, 0);
     qemu_mutex_init(&ms->qemu_file_lock);
 }
 
diff --git a/migration/options.c b/migration/options.c
index 5a9505adf7..aac658fb2d 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -163,6 +163,8 @@ Property migration_properties[] = {
     DEFINE_PROP_STRING("tls-creds", MigrationState, parameters.tls_creds),
     DEFINE_PROP_STRING("tls-hostname", MigrationState, parameters.tls_hostname),
     DEFINE_PROP_STRING("tls-authz", MigrationState, parameters.tls_authz),
+    DEFINE_PROP_BOOL("switchover-hold", MigrationState,
+                     parameters.switchover_hold, false),
 
     /* Migration capabilities */
     DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
@@ -900,6 +902,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->announce_rounds = s->parameters.announce_rounds;
     params->has_announce_step = true;
     params->announce_step = s->parameters.announce_step;
+    params->has_switchover_hold = true;
+    params->switchover_hold = s->parameters.switchover_hold;
 
     if (s->parameters.has_block_bitmap_mapping) {
         params->has_block_bitmap_mapping = true;
@@ -940,6 +944,7 @@ void migrate_params_init(MigrationParameters *params)
     params->has_announce_max = true;
     params->has_announce_rounds = true;
     params->has_announce_step = true;
+    params->has_switchover_hold = true;
 }
 
 /*
@@ -1194,6 +1199,9 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
     if (params->has_announce_step) {
         dest->announce_step = params->announce_step;
     }
+    if (params->has_switchover_hold) {
+        dest->switchover_hold = params->switchover_hold;
+    }
 
     if (params->has_block_bitmap_mapping) {
         dest->has_block_bitmap_mapping = true;
@@ -1307,6 +1315,15 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
     if (params->has_announce_step) {
         s->parameters.announce_step = params->announce_step;
     }
+    if (params->has_switchover_hold) {
+        bool old = s->parameters.switchover_hold;
+        bool new = params->switchover_hold;
+
+        s->parameters.switchover_hold = params->switchover_hold;
+        if (old && !new) {
+            qemu_sem_post(&s->switchover_hold_sem);
+        }
+    }
 
     if (params->has_block_bitmap_mapping) {
         qapi_free_BitmapMigrationNodeAliasList(
-- 
2.41.0


