Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E207DF1AC
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 12:51:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyW8B-0005wk-K3; Thu, 02 Nov 2023 07:44:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qyW86-0005JE-SC
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 07:44:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qyW84-0006Ez-Mv
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 07:44:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698925490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8nC6FZ1Y3kH01iHkAe3CaWVSOv9HnUpMpq4M0pKyH3c=;
 b=YfrJX5wiGiG1qFLWn8Hnft6JyL7e7n/CPqqDqsetBLwbl4MhycAyMndwb6uRF1opDIIkqS
 xvhgJ4QW3mUKOeQ9SuSvr946AK+6M8fKhj7tQr2ziblHlWRPqQNJ1sEWUwRB+YgVRpqJKM
 oWnS2xHlJf7k+BNh7TmkSmqIP/uOnjA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-J5WI3n8YN1Wc-BtWw8-zLg-1; Thu, 02 Nov 2023 07:44:48 -0400
X-MC-Unique: J5WI3n8YN1Wc-BtWw8-zLg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ADB0185A58B;
 Thu,  2 Nov 2023 11:44:46 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 373932026D4C;
 Thu,  2 Nov 2023 11:44:39 +0000 (UTC)
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
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 29/40] migration: Change ram_dirty_bitmap_reload() retval to
 bool
Date: Thu,  2 Nov 2023 12:40:43 +0100
Message-ID: <20231102114054.44360-30-quintela@redhat.com>
In-Reply-To: <20231102114054.44360-1-quintela@redhat.com>
References: <20231102114054.44360-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Now we have a Error** passed into the return path thread stack, which is
even clearer than an int retval.  Change ram_dirty_bitmap_reload() and the
callers to use a bool instead to replace errnos.

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20231017202633.296756-5-peterx@redhat.com>
---
 migration/ram.h       |  2 +-
 migration/migration.c | 18 +++++++++---------
 migration/ram.c       | 24 ++++++++++++------------
 3 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/migration/ram.h b/migration/ram.h
index 6e2c2c1950..9b937a446b 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -71,7 +71,7 @@ void ramblock_recv_bitmap_set(RAMBlock *rb, void *host_addr);
 void ramblock_recv_bitmap_set_range(RAMBlock *rb, void *host_addr, size_t nr);
 int64_t ramblock_recv_bitmap_send(QEMUFile *file,
                                   const char *block_name);
-int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *rb, Error **errp);
+bool ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *rb, Error **errp);
 bool ramblock_page_is_discarded(RAMBlock *rb, ram_addr_t start);
 void postcopy_preempt_shutdown_file(MigrationState *s);
 void *postcopy_preempt_thread(void *opaque);
diff --git a/migration/migration.c b/migration/migration.c
index e875ea0d6b..ce9b7692ad 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1971,29 +1971,29 @@ migrate_handle_rp_req_pages(MigrationState *ms, const char* rbname,
     ram_save_queue_pages(rbname, start, len, errp);
 }
 
-static int migrate_handle_rp_recv_bitmap(MigrationState *s, char *block_name,
-                                         Error **errp)
+static bool migrate_handle_rp_recv_bitmap(MigrationState *s, char *block_name,
+                                          Error **errp)
 {
     RAMBlock *block = qemu_ram_block_by_name(block_name);
 
     if (!block) {
         error_setg(errp, "MIG_RP_MSG_RECV_BITMAP has invalid block name '%s'",
                    block_name);
-        return -EINVAL;
+        return false;
     }
 
     /* Fetch the received bitmap and refresh the dirty bitmap */
     return ram_dirty_bitmap_reload(s, block, errp);
 }
 
-static int migrate_handle_rp_resume_ack(MigrationState *s,
-                                        uint32_t value, Error **errp)
+static bool migrate_handle_rp_resume_ack(MigrationState *s,
+                                         uint32_t value, Error **errp)
 {
     trace_source_return_path_thread_resume_ack(value);
 
     if (value != MIGRATION_RESUME_ACK_VALUE) {
         error_setg(errp, "illegal resume_ack value %"PRIu32, value);
-        return -1;
+        return false;
     }
 
     /* Now both sides are active. */
@@ -2003,7 +2003,7 @@ static int migrate_handle_rp_resume_ack(MigrationState *s,
     /* Notify send thread that time to continue send pages */
     migration_rp_kick(s);
 
-    return 0;
+    return true;
 }
 
 /*
@@ -2154,14 +2154,14 @@ static void *source_return_path_thread(void *opaque)
             }
             /* Format: len (1B) + idstr (<255B). This ends the idstr. */
             buf[buf[0] + 1] = '\0';
-            if (migrate_handle_rp_recv_bitmap(ms, (char *)(buf + 1), &err)) {
+            if (!migrate_handle_rp_recv_bitmap(ms, (char *)(buf + 1), &err)) {
                 goto out;
             }
             break;
 
         case MIG_RP_MSG_RESUME_ACK:
             tmp32 = ldl_be_p(buf);
-            if (migrate_handle_rp_resume_ack(ms, tmp32, &err)) {
+            if (!migrate_handle_rp_resume_ack(ms, tmp32, &err)) {
                 goto out;
             }
             break;
diff --git a/migration/ram.c b/migration/ram.c
index 929cba08f4..a0f3b86663 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -4113,10 +4113,11 @@ static int ram_dirty_bitmap_sync_all(MigrationState *s, RAMState *rs)
  * Read the received bitmap, revert it as the initial dirty bitmap.
  * This is only used when the postcopy migration is paused but wants
  * to resume from a middle point.
+ *
+ * Returns true if succeeded, false for errors.
  */
-int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block, Error **errp)
+bool ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block, Error **errp)
 {
-    int ret = -EINVAL;
     /* from_dst_file is always valid because we're within rp_thread */
     QEMUFile *file = s->rp_state.from_dst_file;
     g_autofree unsigned long *le_bitmap = NULL;
@@ -4130,7 +4131,7 @@ int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block, Error **errp)
     if (s->state != MIGRATION_STATUS_POSTCOPY_RECOVER) {
         error_setg(errp, "Reload bitmap in incorrect state %s",
                    MigrationStatus_str(s->state));
-        return -EINVAL;
+        return false;
     }
 
     /*
@@ -4148,24 +4149,23 @@ int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block, Error **errp)
     if (size != local_size) {
         error_setg(errp, "ramblock '%s' bitmap size mismatch (0x%"PRIx64
                    " != 0x%"PRIx64")", block->idstr, size, local_size);
-        return -EINVAL;
+        return false;
     }
 
     size = qemu_get_buffer(file, (uint8_t *)le_bitmap, local_size);
     end_mark = qemu_get_be64(file);
 
-    ret = qemu_file_get_error(file);
-    if (ret || size != local_size) {
-        error_setg(errp, "read bitmap failed for ramblock '%s': %d"
-                   " (size 0x%"PRIx64", got: 0x%"PRIx64")",
-                   block->idstr, ret, local_size, size);
-        return -EIO;
+    if (qemu_file_get_error(file) || size != local_size) {
+        error_setg(errp, "read bitmap failed for ramblock '%s': "
+                   "(size 0x%"PRIx64", got: 0x%"PRIx64")",
+                   block->idstr, local_size, size);
+        return false;
     }
 
     if (end_mark != RAMBLOCK_RECV_BITMAP_ENDING) {
         error_setg(errp, "ramblock '%s' end mark incorrect: 0x%"PRIx64,
                    block->idstr, end_mark);
-        return -EINVAL;
+        return false;
     }
 
     /*
@@ -4197,7 +4197,7 @@ int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block, Error **errp)
      */
     migration_rp_kick(s);
 
-    return 0;
+    return true;
 }
 
 static int ram_resume_prepare(MigrationState *s, void *opaque)
-- 
2.41.0


