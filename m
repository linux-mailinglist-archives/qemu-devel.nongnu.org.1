Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D999E79DBD9
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 00:23:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgBln-0007qe-04; Tue, 12 Sep 2023 18:22:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qgBlf-0007pr-Tj
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 18:21:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qgBld-0003II-Hx
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 18:21:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694557316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xxrT383B6jVKIZe07PgDLcTMsZB82/Mqv4QueM0JWp8=;
 b=EwmI/PAVSBMXgMB+pBYwTtvYU70IxWglWP+J5Xf6qXoxwdi3QdUV0pbEdgFcZedZa63dvO
 9zoa+syZyOY5cFRmT5c64RPyMuzen2wtfj29kE4+zSCT+U2H5a68xBLFJfxcFjKUkl3d+7
 MYbJeqBKUh/7rU8zr58bse0Be4jWLbk=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-vsjlGPAwMUKrA7kosAGhKg-1; Tue, 12 Sep 2023 18:21:55 -0400
X-MC-Unique: vsjlGPAwMUKrA7kosAGhKg-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-655bc5ee855so8773986d6.0
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 15:21:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694557314; x=1695162114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xxrT383B6jVKIZe07PgDLcTMsZB82/Mqv4QueM0JWp8=;
 b=iGjV/LEwVeRfHEq+vZd1OrLEC0A2t0LiXgKQ2DKXdgcbqGYfRs5okHocAuQv7ng7gl
 JD+Szx9Us/b297gaYOzBxLO45tLi1Bjy8JSKWwVOd6qeCCLDf5sbvTlY42OywtivhAD1
 x2ocL9wj0sp0gzWRvCVijFyw/0wDll6rE2t5NCvxV2M6bg4yi2MzS3S5P7XethRaR3CS
 hMoI8oXTWcnoZ/OQNx05QHMEv53Li/ZZgI3e48CJ6iUqPJHpIq+95qSbz4dZZF30WcBQ
 PuEcKfcWaKH51mja2v5hAggog9ia/TvdfWAaZ9h4+sZrMlunUWcS9qmD1UBvi7COzlxW
 DEpw==
X-Gm-Message-State: AOJu0YzBoBPQMar5H877P7IaW4MRvWYNenols29oXB4vluYFT5jZsYow
 2o373zBrpU78wNUC9BZjcLldznbcVcM+jlf794eJLz1AZtrdaflY+M+jsEfeQtES5Dd4JQuiSa/
 889nC40eWGm9dJYG8zFf9V9UD9/EGFBdZCA4ZHbyZaPUlV4+bwi8BqGoBJPpmD6nMZPnOk3Wa
X-Received: by 2002:a05:6214:21ac:b0:655:dd3c:32a1 with SMTP id
 t12-20020a05621421ac00b00655dd3c32a1mr842222qvc.0.1694557314633; 
 Tue, 12 Sep 2023 15:21:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVidte10PuZmJb1BQQBommDPkj/t+74QxVdJIs3DOt1glDJofejFYdzHnBmS4X6U7Gl6La3w==
X-Received: by 2002:a05:6214:21ac:b0:655:dd3c:32a1 with SMTP id
 t12-20020a05621421ac00b00655dd3c32a1mr842210qvc.0.1694557314239; 
 Tue, 12 Sep 2023 15:21:54 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 d5-20020a05620a136500b0076f206cf16fsm3494272qkl.89.2023.09.12.15.21.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 15:21:53 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Juan Quintela <quintela@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2 08/11] migration: Add migration_rp_wait|kick()
Date: Tue, 12 Sep 2023 18:21:42 -0400
Message-ID: <20230912222145.731099-9-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230912222145.731099-1-peterx@redhat.com>
References: <20230912222145.731099-1-peterx@redhat.com>
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

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.h | 15 +++++++++++++++
 migration/migration.c |  4 ++--
 migration/ram.c       | 16 +++++++---------
 3 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index 48322e909e..311334c701 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -304,6 +304,12 @@ struct MigrationState {
          * be cleared in the rp_thread!
          */
         bool          rp_thread_created;
+        /*
+         * Used to synchronize between migration main thread and return
+         * path thread.  The migration thread can wait() on this sem, while
+         * other threads (e.g., return path thread) can kick it using a
+         * post().
+         */
         QemuSemaphore rp_sem;
         /*
          * We post to this when we got one PONG from dest. So far it's an
@@ -516,4 +522,13 @@ void migration_populate_vfio_info(MigrationInfo *info);
 void migration_reset_vfio_bytes_transferred(void);
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
index 216d0e871f..b958ac8743 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1846,7 +1846,7 @@ static int migrate_handle_rp_resume_ack(MigrationState *s,
                       MIGRATION_STATUS_POSTCOPY_ACTIVE);
 
     /* Notify send thread that time to continue send pages */
-    qemu_sem_post(&s->rp_state.rp_sem);
+    migration_rp_kick(s);
 
     return 0;
 }
@@ -2514,7 +2514,7 @@ static int postcopy_resume_handshake(MigrationState *s)
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


