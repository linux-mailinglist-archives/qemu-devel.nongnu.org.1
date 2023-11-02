Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF4D7DF1BB
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 12:54:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyW7u-0003dq-3j; Thu, 02 Nov 2023 07:44:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qyW7r-0003Q4-5T
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 07:44:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qyW7o-0006Ab-Da
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 07:44:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698925475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=La6LfOYGjRHCBL+sY8jXixPoqwC1VDdMPcNksy9w/Ds=;
 b=TFDdKCf9L+2HPZxu66qJfftCaWLOPFpTUjxwQpZ6O6nHegok1fAJFOnorpmXuam/WdX07y
 y+VwkKYrImyUqxl7rRR9iIltJsTYqN5mLg7c8VHA734aTtSRNW8fVrPbMv4+JMVqpxay0I
 lbHo4MRkRnMqAip/FyWrvHSPJzYjmT0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-29-Dwj9VMHpNGK3zVuE7uJH_g-1; Thu,
 02 Nov 2023 07:44:32 -0400
X-MC-Unique: Dwj9VMHpNGK3zVuE7uJH_g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 30A653806630;
 Thu,  2 Nov 2023 11:44:31 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A39DD2026D4C;
 Thu,  2 Nov 2023 11:44:23 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>, Laurent Vivier <lvivier@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, David Hildenbrand <david@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Leonardo Bras <leobras@redhat.com>, Corey Minyard <cminyard@mvista.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Li Zhijian <lizhijian@fujitsu.com>, Eric Blake <eblake@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>, Hanna Reitz <hreitz@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-arm@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Corey Minyard <minyard@acm.org>,
 John Snow <jsnow@redhat.com>, Jeff Cody <codyprime@gmail.com>,
 Peter Xu <peterx@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Juan Quintela <quintela@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Weil <sw@weilnetz.de>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Fam Zheng <fam@euphon.net>, Xiaohui Li <xiaohli@redhat.com>
Subject: [PULL 27/40] migration: Allow network to fail even during recovery
Date: Thu,  2 Nov 2023 12:40:41 +0100
Message-ID: <20231102114054.44360-28-quintela@redhat.com>
In-Reply-To: <20231102114054.44360-1-quintela@redhat.com>
References: <20231102114054.44360-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
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

From: Peter Xu <peterx@redhat.com>

Normally the postcopy recover phase should only exist for a super short
period, that's the duration when QEMU is trying to recover from an
interrupted postcopy migration, during which handshake will be carried out
for continuing the procedure with state changes from PAUSED -> RECOVER ->
POSTCOPY_ACTIVE again.

Here RECOVER phase should be super small, that happens right after the
admin specified a new but working network link for QEMU to reconnect to
dest QEMU.

However there can still be case where the channel is broken in this small
RECOVER window.

If it happens, with current code there's no way the src QEMU can got kicked
out of RECOVER stage. No way either to retry the recover in another channel
when established.

This patch allows the RECOVER phase to fail itself too - we're mostly
ready, just some small things missing, e.g. properly kick the main
migration thread out when sleeping on rp_sem when we found that we're at
RECOVER stage.  When this happens, it fails the RECOVER itself, and
rollback to PAUSED stage.  Then the user can retry another round of
recovery.

To make it even stronger, teach QMP command migrate-pause to explicitly
kick src/dst QEMU out when needed, so even if for some reason the migration
thread didn't got kicked out already by a failing rethrn-path thread, the
admin can also kick it out.

This will be an super, super corner case, but still try to cover that.

One can try to test this with two proxy channels for migration:

  (a) socat unix-listen:/tmp/src.sock,reuseaddr,fork tcp:localhost:10000
  (b) socat tcp-listen:10000,reuseaddr,fork unix:/tmp/dst.sock

So the migration channel will be:

                      (a)          (b)
  src -> /tmp/src.sock -> tcp:10000 -> /tmp/dst.sock -> dst

Then to make QEMU hang at RECOVER stage, one can do below:

  (1) stop the postcopy using QMP command postcopy-pause
  (2) kill the 2nd proxy (b)
  (3) try to recover the postcopy using /tmp/src.sock on src
  (4) src QEMU will go into RECOVER stage but won't be able to continue
      from there, because the channel is actually broken at (b)

Before this patch, step (4) will make src QEMU stuck in RECOVER stage,
without a way to kick the QEMU out or continue the postcopy again.  After
this patch, (4) will quickly fail qemu and bounce back to PAUSED stage.

Admin can also kick QEMU from (4) into PAUSED when needed using
migrate-pause when needed.

After bouncing back to PAUSED stage, one can recover again.

Reported-by: Xiaohui Li <xiaohli@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=2111332
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20231017202633.296756-3-peterx@redhat.com>
---
 migration/migration.h |  8 ++++--
 migration/migration.c | 63 +++++++++++++++++++++++++++++++++++++++----
 migration/ram.c       |  4 ++-
 3 files changed, 67 insertions(+), 8 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index 615b517594..af8c965b7f 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -494,6 +494,7 @@ int migrate_init(MigrationState *s, Error **errp);
 bool migration_is_blocked(Error **errp);
 /* True if outgoing migration has entered postcopy phase */
 bool migration_in_postcopy(void);
+bool migration_postcopy_is_alive(int state);
 MigrationState *migrate_get_current(void);
 
 uint64_t ram_get_total_transferred_pages(void);
@@ -534,8 +535,11 @@ void migration_populate_vfio_info(MigrationInfo *info);
 void migration_reset_vfio_bytes_transferred(void);
 void postcopy_temp_page_reset(PostcopyTmpPage *tmp_page);
 
-/* Migration thread waiting for return path thread. */
-void migration_rp_wait(MigrationState *s);
+/*
+ * Migration thread waiting for return path thread.  Return non-zero if an
+ * error is detected.
+ */
+int migration_rp_wait(MigrationState *s);
 /*
  * Kick the migration thread waiting for return path messages.  NOTE: the
  * name can be slightly confusing (when read as "kick the rp thread"), just
diff --git a/migration/migration.c b/migration/migration.c
index 455ddc896a..e875ea0d6b 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1393,6 +1393,17 @@ bool migration_in_postcopy(void)
     }
 }
 
+bool migration_postcopy_is_alive(int state)
+{
+    switch (state) {
+    case MIGRATION_STATUS_POSTCOPY_ACTIVE:
+    case MIGRATION_STATUS_POSTCOPY_RECOVER:
+        return true;
+    default:
+        return false;
+    }
+}
+
 bool migration_in_postcopy_after_devices(MigrationState *s)
 {
     return migration_in_postcopy() && s->postcopy_after_devices;
@@ -1673,8 +1684,15 @@ void qmp_migrate_pause(Error **errp)
     MigrationIncomingState *mis = migration_incoming_get_current();
     int ret = 0;
 
-    if (ms->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
+    if (migration_postcopy_is_alive(ms->state)) {
         /* Source side, during postcopy */
+        Error *error = NULL;
+
+        /* Tell the core migration that we're pausing */
+        error_setg(&error, "Postcopy migration is paused by the user");
+        migrate_set_error(ms, error);
+        error_free(error);
+
         qemu_mutex_lock(&ms->qemu_file_lock);
         if (ms->to_dst_file) {
             ret = qemu_file_shutdown(ms->to_dst_file);
@@ -1683,10 +1701,17 @@ void qmp_migrate_pause(Error **errp)
         if (ret) {
             error_setg(errp, "Failed to pause source migration");
         }
+
+        /*
+         * Kick the migration thread out of any waiting windows (on behalf
+         * of the rp thread).
+         */
+        migration_rp_kick(ms);
+
         return;
     }
 
-    if (mis->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
+    if (migration_postcopy_is_alive(mis->state)) {
         ret = qemu_file_shutdown(mis->from_src_file);
         if (ret) {
             error_setg(errp, "Failed to pause destination migration");
@@ -1695,7 +1720,7 @@ void qmp_migrate_pause(Error **errp)
     }
 
     error_setg(errp, "migrate-pause is currently only supported "
-               "during postcopy-active state");
+               "during postcopy-active or postcopy-recover state");
 }
 
 bool migration_is_blocked(Error **errp)
@@ -1882,9 +1907,21 @@ void qmp_migrate_continue(MigrationStatus state, Error **errp)
     qemu_sem_post(&s->pause_sem);
 }
 
-void migration_rp_wait(MigrationState *s)
+int migration_rp_wait(MigrationState *s)
 {
+    /* If migration has failure already, ignore the wait */
+    if (migrate_has_error(s)) {
+        return -1;
+    }
+
     qemu_sem_wait(&s->rp_state.rp_sem);
+
+    /* After wait, double check that there's no failure */
+    if (migrate_has_error(s)) {
+        return -1;
+    }
+
+    return 0;
 }
 
 void migration_rp_kick(MigrationState *s)
@@ -2146,6 +2183,20 @@ out:
         trace_source_return_path_thread_bad_end();
     }
 
+    if (ms->state == MIGRATION_STATUS_POSTCOPY_RECOVER) {
+        /*
+         * this will be extremely unlikely: that we got yet another network
+         * issue during recovering of the 1st network failure.. during this
+         * period the main migration thread can be waiting on rp_sem for
+         * this thread to sync with the other side.
+         *
+         * When this happens, explicitly kick the migration thread out of
+         * RECOVER stage and back to PAUSED, so the admin can try
+         * everything again.
+         */
+        migration_rp_kick(ms);
+    }
+
     trace_source_return_path_thread_end();
     rcu_unregister_thread();
 
@@ -2611,7 +2662,9 @@ static int postcopy_resume_handshake(MigrationState *s)
     qemu_savevm_send_postcopy_resume(s->to_dst_file);
 
     while (s->state == MIGRATION_STATUS_POSTCOPY_RECOVER) {
-        migration_rp_wait(s);
+        if (migration_rp_wait(s)) {
+            return -1;
+        }
     }
 
     if (s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
diff --git a/migration/ram.c b/migration/ram.c
index d05ffddbc8..929cba08f4 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -4099,7 +4099,9 @@ static int ram_dirty_bitmap_sync_all(MigrationState *s, RAMState *rs)
 
     /* Wait until all the ramblocks' dirty bitmap synced */
     while (qatomic_read(&rs->postcopy_bmap_sync_requested)) {
-        migration_rp_wait(s);
+        if (migration_rp_wait(s)) {
+            return -1;
+        }
     }
 
     trace_ram_dirty_bitmap_sync_complete();
-- 
2.41.0


