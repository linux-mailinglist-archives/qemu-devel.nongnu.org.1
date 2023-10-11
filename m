Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF6C7C4EE2
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 11:28:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqVSH-0005lA-W1; Wed, 11 Oct 2023 05:24:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVSE-0005Wl-3L
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:24:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVSC-0005GQ-E9
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:24:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697016271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k93ppU9takGNXa65Qf4sjjQAREAzL8cPGsOKxV8iTAU=;
 b=Du1I9vnZKNcrMHrwJjb/dH+/IC6y9jCjhuicJXpXPwunVWL3d/6Bq21lDlpUKmyHZ6zS3F
 HJF2bqhXMMjaHe8wjQc+T68JpguYm11cx7ZM1FPliQYvZD57Z08XdBgknmG6QKGLi2UDmY
 bhCwpcg284DQpGNaUjWV4w5F6dvFzFA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-144-jYufwREGOBes5dZ7FBgVcw-1; Wed, 11 Oct 2023 05:24:19 -0400
X-MC-Unique: jYufwREGOBes5dZ7FBgVcw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 41BC93814597;
 Wed, 11 Oct 2023 09:24:18 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 820FE1C060AE;
 Wed, 11 Oct 2023 09:24:16 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Leonardo Bras <leobras@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 65/65] migration: Add migration_rp_wait|kick()
Date: Wed, 11 Oct 2023 11:22:03 +0200
Message-ID: <20231011092203.1266-66-quintela@redhat.com>
In-Reply-To: <20231011092203.1266-1-quintela@redhat.com>
References: <20231011092203.1266-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Peter Xu <peterx@redhat.com>

It's just a simple wrapper for rp_sem on either wait() or kick(), make it
even clearer on how it is used.  Prepared to be used even for other things.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-ID: <20231004220240.167175-8-peterx@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration.h | 15 +++++++++++++++
 migration/migration.c | 14 ++++++++++++--
 migration/ram.c       | 16 +++++++---------
 3 files changed, 34 insertions(+), 11 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index 4106a1dc54..cd5534337c 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -316,6 +316,12 @@ struct MigrationState {
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
@@ -527,4 +533,13 @@ void migration_populate_vfio_info(MigrationInfo *info);
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
index 409eb3e916..1c6c81ad49 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1763,6 +1763,16 @@ static void mark_source_rp_bad(MigrationState *s)
     s->rp_state.error = true;
 }
 
+void migration_rp_wait(MigrationState *s)
+{
+    qemu_sem_wait(&s->rp_state.rp_sem);
+}
+
+void migration_rp_kick(MigrationState *s)
+{
+    qemu_sem_post(&s->rp_state.rp_sem);
+}
+
 static struct rp_cmd_args {
     ssize_t     len; /* -1 = variable */
     const char *name;
@@ -1835,7 +1845,7 @@ static int migrate_handle_rp_resume_ack(MigrationState *s, uint32_t value)
                       MIGRATION_STATUS_POSTCOPY_ACTIVE);
 
     /* Notify send thread that time to continue send pages */
-    qemu_sem_post(&s->rp_state.rp_sem);
+    migration_rp_kick(s);
 
     return 0;
 }
@@ -2464,7 +2474,7 @@ static int postcopy_resume_handshake(MigrationState *s)
     qemu_savevm_send_postcopy_resume(s->to_dst_file);
 
     while (s->state == MIGRATION_STATUS_POSTCOPY_RECOVER) {
-        qemu_sem_wait(&s->rp_state.rp_sem);
+        migration_rp_wait(s);
     }
 
     if (s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
diff --git a/migration/ram.c b/migration/ram.c
index 6c40d9af0c..2f5ce4d60b 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -4141,7 +4141,7 @@ static int ram_dirty_bitmap_sync_all(MigrationState *s, RAMState *rs)
 
     /* Wait until all the ramblocks' dirty bitmap synced */
     while (qatomic_read(&rs->postcopy_bmap_sync_requested)) {
-        qemu_sem_wait(&s->rp_state.rp_sem);
+        migration_rp_wait(s);
     }
 
     trace_ram_dirty_bitmap_sync_complete();
@@ -4149,11 +4149,6 @@ static int ram_dirty_bitmap_sync_all(MigrationState *s, RAMState *rs)
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
@@ -4237,10 +4232,13 @@ int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block)
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


