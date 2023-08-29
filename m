Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5AB78D0A3
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:30:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7nv-0001qw-Fg; Tue, 29 Aug 2023 19:07:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qb6U9-0006ME-Fo
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 17:42:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qb6U7-0000iE-1m
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 17:42:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693345370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hrlS5gw7406y1NAmCuKbevjOhQ68l6+fK/m+TPY+7RE=;
 b=Bh1XEhhScdHSqrWsmhOZ8MLyjRvYCLbR3cWWLR58OGVPTpE26aYU4aRRfcPekldu70GF2Q
 AnJB2MQl9qLG912BFxbkQM0dHAzFoAiRA2zbuFQz0Rv3fKHGgtmUUlJf2cmy1ewuqc+JGF
 zugk5eBHzNmnknjYtJN44Hpa9zQTx/Q=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-kZaT113-MACX8C7-H3bqSA-1; Tue, 29 Aug 2023 17:42:48 -0400
X-MC-Unique: kZaT113-MACX8C7-H3bqSA-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-411f4a7ddbdso14275511cf.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 14:42:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693345368; x=1693950168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hrlS5gw7406y1NAmCuKbevjOhQ68l6+fK/m+TPY+7RE=;
 b=fFGb9KPGxLkQkmhT2L1Le/1N12shx1Hr1n5Qd3mcD2W0qtaHSm+YanaYAhGc+nGEoO
 MYesVD/jSqTW3aQIPZXoxkOZhCWn5Df6FaO6Hsy3LiOAFFdGtFvmCbRYsulhfQ6rrPM5
 dKXJW8L6kX031qTTqgLKsBAnUjSOf4ASNDGCE6TPBtTR+pOVAqHHBrnr5Vl6hQYtyK4d
 5UsUupPzEJrT+eXrXKTbGwl09cWFYKAnZHZKHes5Ngxdu2VoG2rwpSnyxKMfmCCcyrWU
 d0VqSOIcvhP1lwew2teZlVn3w3TfVxRytrSS/l+eaOWuSYA/VTBj9OrOEgbIWZO0YkKk
 iqLQ==
X-Gm-Message-State: AOJu0YzJX+7vdDKAGZMclz9Dxa0QCksBE8Zy86dOjRdq0ju6OyZ1HJVR
 NnHK8bD/QHymuYVy7FE/LpdHBcSqj7O8e/ewbgz/II0CdvXxbjVA/elvDvOZSoih3j7YhXS3vyG
 wavija4hmiBeSZXY8fUlo4RpAzDstv9MlpBs0mgYKFHghKVSuarTtiheOVSnPUIeTr7rH0qr6
X-Received: by 2002:a05:622a:1801:b0:40c:8ba5:33e0 with SMTP id
 t1-20020a05622a180100b0040c8ba533e0mr276299qtc.3.1693345367954; 
 Tue, 29 Aug 2023 14:42:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkuJ1ibV1nRksySKJp03jFYiDIosU7y7kVYn2+Lu503JIrQehtd+2uC/asbIizfknt9vTpPw==
X-Received: by 2002:a05:622a:1801:b0:40c:8ba5:33e0 with SMTP id
 t1-20020a05622a180100b0040c8ba533e0mr276285qtc.3.1693345367592; 
 Tue, 29 Aug 2023 14:42:47 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 b18-20020ac86bd2000000b0040f8ac751a5sm3260343qtt.96.2023.08.29.14.42.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 14:42:47 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 Juan Quintela <quintela@redhat.com>
Subject: [PATCH 8/9] migration: Add migration_rp_wait|kick()
Date: Tue, 29 Aug 2023 17:42:34 -0400
Message-ID: <20230829214235.69309-9-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230829214235.69309-1-peterx@redhat.com>
References: <20230829214235.69309-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

It's just a simple wrapper for rp_sem on either wait() or kick(), make it
even clearer on how it is used.  Prepared to be used even for other things.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.h | 15 +++++++++++++++
 migration/migration.c |  4 ++--
 migration/ram.c       | 16 +++++++---------
 3 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index a5c95e4d43..b6de78dbdd 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -304,6 +304,12 @@ struct MigrationState {
          * be cleared in the rp_thread!
          */
         bool          rp_thread_created;
+        /*
+         * Used to synchonize between migration main thread and return path
+         * thread.  The migration thread can wait() on this sem, while
+         * other threads (e.g., return path thread) can kick it using a
+         * post().
+         */
         QemuSemaphore rp_sem;
         /*
          * We post to this when we got one PONG from dest. So far it's an
@@ -516,4 +522,13 @@ void populate_vfio_info(MigrationInfo *info);
 void reset_vfio_bytes_transferred(void);
 void postcopy_temp_page_reset(PostcopyTmpPage *tmp_page);
 
+/* Migration thread waiting for return path thread. */
+void migration_rp_wait(MigrationState *s);
+/*
+ * Kick the migration thread waiting for return path messages.  NOTE: the
+ * name can be slightly confusing (when read as "kick the rp thread"), just
+ * to remember the target is always the migration thread.
+ */
+void migration_rp_kick(MigrationState *s);
+
 #endif
diff --git a/migration/migration.c b/migration/migration.c
index 576e102319..3a5f324781 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1835,7 +1835,7 @@ static int migrate_handle_rp_resume_ack(MigrationState *s,
                       MIGRATION_STATUS_POSTCOPY_ACTIVE);
 
     /* Notify send thread that time to continue send pages */
-    qemu_sem_post(&s->rp_state.rp_sem);
+    migration_rp_kick(s);
 
     return 0;
 }
@@ -2503,7 +2503,7 @@ static int postcopy_resume_handshake(MigrationState *s)
     qemu_savevm_send_postcopy_resume(s->to_dst_file);
 
     while (s->state == MIGRATION_STATUS_POSTCOPY_RECOVER) {
-        qemu_sem_wait(&s->rp_state.rp_sem);
+        migration_rp_wait(s);
     }
 
     if (s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
diff --git a/migration/ram.c b/migration/ram.c
index a9541c60b4..b5f6d65d84 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -4157,7 +4157,7 @@ static int ram_dirty_bitmap_sync_all(MigrationState *s, RAMState *rs)
 
     /* Wait until all the ramblocks' dirty bitmap synced */
     while (qatomic_read(&rs->postcopy_bmap_sync_requested)) {
-        qemu_sem_wait(&s->rp_state.rp_sem);
+        migration_rp_wait(s);
     }
 
     trace_ram_dirty_bitmap_sync_complete();
@@ -4165,11 +4165,6 @@ static int ram_dirty_bitmap_sync_all(MigrationState *s, RAMState *rs)
     return 0;
 }
 
-static void ram_dirty_bitmap_reload_notify(MigrationState *s)
-{
-    qemu_sem_post(&s->rp_state.rp_sem);
-}
-
 /*
  * Read the received bitmap, revert it as the initial dirty bitmap.
  * This is only used when the postcopy migration is paused but wants
@@ -4252,10 +4247,13 @@ int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block, Error **errp)
     qatomic_dec(&rs->postcopy_bmap_sync_requested);
 
     /*
-     * We succeeded to sync bitmap for current ramblock. If this is
-     * the last one to sync, we need to notify the main send thread.
+     * We succeeded to sync bitmap for current ramblock. Always kick the
+     * migration thread to check whether all requested bitmaps are
+     * reloaded.  NOTE: it's racy to only kick when requested==0, because
+     * we don't know whether the migration thread may still be increasing
+     * it.
      */
-    ram_dirty_bitmap_reload_notify(s);
+    migration_rp_kick(s);
 
     ret = 0;
 out:
-- 
2.41.0


