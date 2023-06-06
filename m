Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 473F1724989
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 18:54:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6ZvO-0003UI-Ps; Tue, 06 Jun 2023 12:52:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q6ZvF-0003Ps-Gr
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 12:52:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q6ZvC-0001iC-Ri
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 12:52:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686070356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ia9WSWxL7HYpbhT9gohYFvkr9lgNHzFRWmp7QMw4g8I=;
 b=hNzoDSkjEHkSXYdQonhGcB97+3AmXEfZMgm5ba/AFXN366h5Mi1lw0y7f/gJJ9oY87el+0
 /IL2GrrgpYEXO5bh13K6U8Pu7vKdEhg0Blk2ciSMaS/u7EoOqfCke0+9dEq4XvVmzpjZSi
 TF3fuCWnJIoA0NyzxsgIsUJbO3rvGXY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-BAadTd0OOF-oGF1v5ueNdA-1; Tue, 06 Jun 2023 12:52:35 -0400
X-MC-Unique: BAadTd0OOF-oGF1v5ueNdA-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-62849c5e9f0so7672586d6.1
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 09:52:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686070354; x=1688662354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ia9WSWxL7HYpbhT9gohYFvkr9lgNHzFRWmp7QMw4g8I=;
 b=G6OmarpvTpRp8J3wu/f/HZO3YAnl4a3ZLHd1ztoGgYr1zLYoVJHTDotdRo5kC0I0Rb
 F3mdOR8wY67DxikblHaTIqImUnlRGmrbMdD1PtQ3r4FvUgtq1NHdl64GFXpdDAYA33Sl
 0GEIlRCMZDj97nBYiPot8BG4N7JI49niCNkVg5Q6xGMr63gbFxy2pvGoZvpKy4wQDkdb
 0hjWfhA9peqsVakMeg+xHn9xfbBe6I4kyKQ5qpwM/URVWmaw7vJKqaKcMZVYywqJiDKl
 vpd9CtVLdT/SRtKYL4zf4SQ8+DAk0l7Ph00GD4j/JRj/20sQ+OHK/vuY5L3Rw0mfW02h
 iZvw==
X-Gm-Message-State: AC+VfDysy3jwJ3ZsvvFBY+9Rgh7SFxkAJRY4vfmYDrvbRQpu92Ec5uHQ
 /pHFEbYSUDtzDfv/eoS/eD6n6DCcnuFsQ9yTZqtbnadCqVF8UcfH9QuJCrpcmrcB6H6xb80bRbZ
 qpWHTpcU+0Zvxuv9QsuhOUbc0iMgHlydUDfGsK2JDSo027bQ8JJ7jkbJIQGXUccrQI96mMh4v
X-Received: by 2002:a05:6214:1243:b0:622:265e:3473 with SMTP id
 r3-20020a056214124300b00622265e3473mr3093821qvv.1.1686070354113; 
 Tue, 06 Jun 2023 09:52:34 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7rFGU7eMGa1q9lupBvJY5ZFtQkPg/H8J5S2zQ/7dC34iVXIZ436mmuLmqHKpPmfFU8vpfc4g==
X-Received: by 2002:a05:6214:1243:b0:622:265e:3473 with SMTP id
 r3-20020a056214124300b00622265e3473mr3093785qvv.1.1686070353537; 
 Tue, 06 Jun 2023 09:52:33 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 u26-20020ae9c01a000000b0075d4d5617cdsm3498168qkk.66.2023.06.06.09.52.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 09:52:32 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 peterx@redhat.com, Eric Blake <eblake@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v2 1/2] migration: switchover-hold parameter
Date: Tue,  6 Jun 2023 12:52:27 -0400
Message-Id: <20230606165228.491878-2-peterx@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230606165228.491878-1-peterx@redhat.com>
References: <20230606165228.491878-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
 qapi/migration.json            | 25 +++++++++++++--
 migration/migration.h          | 16 ++++++++++
 migration/migration-hmp-cmds.c |  3 ++
 migration/migration.c          | 56 ++++++++++++++++++++++++++++++++--
 migration/options.c            | 17 +++++++++++
 5 files changed, 111 insertions(+), 6 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 179af0c4d8..fb8751841a 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -779,6 +779,15 @@
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
@@ -800,7 +809,7 @@
            'xbzrle-cache-size', 'max-postcopy-bandwidth',
            'max-cpu-throttle', 'multifd-compression',
            'multifd-zlib-level' ,'multifd-zstd-level',
-           'block-bitmap-mapping' ] }
+           'block-bitmap-mapping', 'switchover-hold' ] }
 
 ##
 # @MigrateSetParameters:
@@ -935,6 +944,10 @@
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
@@ -972,7 +985,8 @@
             '*multifd-compression': 'MultiFDCompression',
             '*multifd-zlib-level': 'uint8',
             '*multifd-zstd-level': 'uint8',
-            '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ] } }
+            '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ],
+            '*switchover-hold': 'bool' } }
 
 ##
 # @migrate-set-parameters:
@@ -1127,6 +1141,10 @@
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
@@ -1161,7 +1179,8 @@
             '*multifd-compression': 'MultiFDCompression',
             '*multifd-zlib-level': 'uint8',
             '*multifd-zstd-level': 'uint8',
-            '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ] } }
+            '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ],
+            '*switchover-hold': 'bool' } }
 
 ##
 # @query-migrate-parameters:
diff --git a/migration/migration.h b/migration/migration.h
index 30c3e97635..721b1c9473 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -440,6 +440,22 @@ struct MigrationState {
 
     /* QEMU_VM_VMDESCRIPTION content filled for all non-iterable devices. */
     JSONWriter *vmdesc;
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
index dc05c6f6ea..203d40d4c9 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2693,6 +2693,55 @@ static void migration_update_counters(MigrationState *s,
                               bandwidth, s->threshold_size);
 }
 
+static bool
+migration_should_complete(MigrationState *s, uint64_t pending_size)
+{
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
+    /* We still have lots of thing that must be migrated in precopy */
+    if (must_precopy > s->threshold_size) {
+        return false;
+    }
+    return qatomic_read(&s->start_postcopy);
+}
+
 /* Migration thread iteration status */
 typedef enum {
     MIG_ITERATE_RESUME,         /* Resume current iteration */
@@ -2720,15 +2769,14 @@ static MigIterateState migration_iteration_run(MigrationState *s)
         trace_migrate_pending_exact(pending_size, must_precopy, can_postcopy);
     }
 
-    if (!pending_size || pending_size < s->threshold_size) {
+    if (migration_should_complete(s, pending_size)) {
         trace_migration_thread_low_pending(pending_size);
         migration_completion(s);
         return MIG_ITERATE_BREAK;
     }
 
     /* Still a significant amount to transfer */
-    if (!in_postcopy && must_precopy <= s->threshold_size &&
-        qatomic_read(&s->start_postcopy)) {
+    if (migration_should_start_postcopy(s, must_precopy)) {
         if (postcopy_start(s)) {
             error_report("%s: postcopy failed to start", __func__);
         }
@@ -3285,6 +3333,7 @@ static void migration_instance_finalize(Object *obj)
     qemu_sem_destroy(&ms->rp_state.rp_sem);
     qemu_sem_destroy(&ms->rp_state.rp_pong_acks);
     qemu_sem_destroy(&ms->postcopy_qemufile_src_sem);
+    qemu_sem_destroy(&ms->switchover_hold_sem);
     error_free(ms->error);
 }
 
@@ -3307,6 +3356,7 @@ static void migration_instance_init(Object *obj)
     qemu_sem_init(&ms->rate_limit_sem, 0);
     qemu_sem_init(&ms->wait_unplug_sem, 0);
     qemu_sem_init(&ms->postcopy_qemufile_src_sem, 0);
+    qemu_sem_init(&ms->switchover_hold_sem, 0);
     qemu_mutex_init(&ms->qemu_file_lock);
 }
 
diff --git a/migration/options.c b/migration/options.c
index b62ab30cd5..2d6b138352 100644
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
@@ -883,6 +885,8 @@ MigrationParameters *qmp_query_migrate_parameters(Error **errp)
     params->announce_rounds = s->parameters.announce_rounds;
     params->has_announce_step = true;
     params->announce_step = s->parameters.announce_step;
+    params->has_switchover_hold = true;
+    params->switchover_hold = s->parameters.switchover_hold;
 
     if (s->parameters.has_block_bitmap_mapping) {
         params->has_block_bitmap_mapping = true;
@@ -923,6 +927,7 @@ void migrate_params_init(MigrationParameters *params)
     params->has_announce_max = true;
     params->has_announce_rounds = true;
     params->has_announce_step = true;
+    params->has_switchover_hold = true;
 }
 
 /*
@@ -1177,6 +1182,9 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
     if (params->has_announce_step) {
         dest->announce_step = params->announce_step;
     }
+    if (params->has_switchover_hold) {
+        dest->switchover_hold = params->switchover_hold;
+    }
 
     if (params->has_block_bitmap_mapping) {
         dest->has_block_bitmap_mapping = true;
@@ -1290,6 +1298,15 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
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
2.40.1


