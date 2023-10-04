Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C19317B9716
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 00:04:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo9xM-0004I2-Ah; Wed, 04 Oct 2023 18:03:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qo9xI-0004CG-Da
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 18:02:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qo9xF-0003uc-Hz
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 18:02:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696456972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6qVVdc1vklEI9hY/ZbP4mgABUKv0o2qcSEYQEaeTmoE=;
 b=D+AD7T5okW0E/cBBdGdqlaKsMVvUn9fbWlZOp93FctUI3jAa/e+Kl0Nn4I+Xc8GxKxP86X
 WCgOHvlGRamnWzV43PLSDDxeLRRGr9f+yJ7SawO6QnVUx0QSy3ui7HIzU8XKXqKtePyZ16
 YbXLf3+STxP+kIpucWB5mO622znolI4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-0s-IN6ddMCSQy2x2UPiyOA-1; Wed, 04 Oct 2023 18:02:51 -0400
X-MC-Unique: 0s-IN6ddMCSQy2x2UPiyOA-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-65623d0075aso526606d6.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 15:02:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696456970; x=1697061770;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6qVVdc1vklEI9hY/ZbP4mgABUKv0o2qcSEYQEaeTmoE=;
 b=GsLJ4nvIyotowBPWlrUs5nJS+X8JCD/EAjthrGL7WNshSFdbmCdduppL7gc/9gQwEh
 i6iC8bczuPQ3HsCGcvTTbBOWUdQqYvMmhCkzKA+BhlHAzYkA0A3JEsShPCKy73uxgerJ
 VoCHNLbJ1ne6FiA8bfH7r3Y9J6AzpEa00mP0hc2rjGGLlVwutcU5i+mT2k2xLLd0SbgO
 3EG4S8WN1QFMHh1Rg0b95jQKtNYXCC/gbUPm4ig20Mo//Kyu2ST6QQaydno2VHEOhxtz
 pZnKWkNFbdhA42gxit9NvUc2MuFhDnppHomy7UB5mmM99JdeqJT9Qr7MjFOEccdJr3rK
 PezA==
X-Gm-Message-State: AOJu0Yyezl9fTuKynEUmRvqgEX3jE3o28M7XuNso/YjJK2VqQYs6pdok
 BCc/tW1KksQaFaJ7o5qugOJfDulWWR8LxxtIYWFt8rxjOeJ4qBqmH1Tma/N/S5MkWEiKEgUlDhQ
 krSD6Zgoyb/dOaNUxnaFzZ73LS5VyRL199qZRUP0FnNLgT4h1Ee/lfMs87vYQj6qOpZdebWwS
X-Received: by 2002:ad4:5cce:0:b0:658:305f:d81d with SMTP id
 iu14-20020ad45cce000000b00658305fd81dmr3694551qvb.0.1696456970558; 
 Wed, 04 Oct 2023 15:02:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3y1GndWC1lr/0LBXzpCpwmS9DhgTlTbJk0RimmkKejFd2OrJVQus4AQnzBombFvlGANY6vA==
X-Received: by 2002:ad4:5cce:0:b0:658:305f:d81d with SMTP id
 iu14-20020ad45cce000000b00658305fd81dmr3694518qvb.0.1696456970112; 
 Wed, 04 Oct 2023 15:02:50 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 w17-20020a0cdf91000000b0063d162a8b8bsm10821qvl.19.2023.10.04.15.02.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 15:02:49 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Juan Quintela <quintela@redhat.com>
Subject: [PATCH v3 07/10] migration: Add migration_rp_wait|kick()
Date: Wed,  4 Oct 2023 18:02:37 -0400
Message-ID: <20231004220240.167175-8-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004220240.167175-1-peterx@redhat.com>
References: <20231004220240.167175-1-peterx@redhat.com>
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
 migration/migration.c | 14 ++++++++++++--
 migration/ram.c       | 16 +++++++---------
 3 files changed, 34 insertions(+), 11 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index 33a7831da4..573aa69f19 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -315,6 +315,12 @@ struct MigrationState {
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
@@ -526,4 +532,13 @@ void migration_populate_vfio_info(MigrationInfo *info);
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
index b28b504b4c..1b7ed2d35a 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1749,6 +1749,16 @@ void qmp_migrate_continue(MigrationStatus state, Error **errp)
     qemu_sem_post(&s->pause_sem);
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
@@ -1820,7 +1830,7 @@ static int migrate_handle_rp_resume_ack(MigrationState *s,
                       MIGRATION_STATUS_POSTCOPY_ACTIVE);
 
     /* Notify send thread that time to continue send pages */
-    qemu_sem_post(&s->rp_state.rp_sem);
+    migration_rp_kick(s);
 
     return 0;
 }
@@ -2447,7 +2457,7 @@ static int postcopy_resume_handshake(MigrationState *s)
     qemu_savevm_send_postcopy_resume(s->to_dst_file);
 
     while (s->state == MIGRATION_STATUS_POSTCOPY_RECOVER) {
-        qemu_sem_wait(&s->rp_state.rp_sem);
+        migration_rp_wait(s);
     }
 
     if (s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
diff --git a/migration/ram.c b/migration/ram.c
index ef4af3fbce..43ba62be83 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -4143,7 +4143,7 @@ static int ram_dirty_bitmap_sync_all(MigrationState *s, RAMState *rs)
 
     /* Wait until all the ramblocks' dirty bitmap synced */
     while (qatomic_read(&rs->postcopy_bmap_sync_requested)) {
-        qemu_sem_wait(&s->rp_state.rp_sem);
+        migration_rp_wait(s);
     }
 
     trace_ram_dirty_bitmap_sync_complete();
@@ -4151,11 +4151,6 @@ static int ram_dirty_bitmap_sync_all(MigrationState *s, RAMState *rs)
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
@@ -4238,10 +4233,13 @@ int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block, Error **errp)
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


