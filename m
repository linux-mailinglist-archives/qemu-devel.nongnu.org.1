Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DABB27CCE04
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 22:28:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsqeR-0000Qt-Sk; Tue, 17 Oct 2023 16:26:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qsqeM-0000IQ-6o
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 16:26:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qsqeK-0000lT-E4
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 16:26:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697574403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8cSQeC5Z7TwUIWEbdrWTkKxGeuItSqPw3IOExmlUlQY=;
 b=LprZ/RUIChjmEEUVNeeBJ1eVJarGWFWu+w8ffwQ6cDCQS5CGZnmGLRprsEH5ElG6Y3ioPH
 J+0dKueQkGj20FH/jivinJq2D70KlpC7RZKkqO9zlApcDEc5VmqFnfyF6nByQ9tsDT2K6h
 8K2wZxYCxAT7OLIGoEb7KfP+ckdytPY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-gqGalfuVM0uatG9-ZjeNWw-1; Tue, 17 Oct 2023 16:26:40 -0400
X-MC-Unique: gqGalfuVM0uatG9-ZjeNWw-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-66d3f71f49cso8528386d6.1
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 13:26:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697574400; x=1698179200;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8cSQeC5Z7TwUIWEbdrWTkKxGeuItSqPw3IOExmlUlQY=;
 b=YdKrE/3Q4nvk6fyeA9N/hNkKwYOOWW8Xcc3r3/fhQatLuYFXOa+tnmyrRNJrfmruY6
 P9AFQtyth2POI8Hdp6mxeuETHBJsRfGHBM2znyE6Bh2e43V4zQJG7/YCubC9yixm8iUP
 EBIEQLpvKvvm7QWd+dXgwTrF7uAPKGimTZUpV+cuPFgjJ5J5JnvvZlZIblTToNEhuj0h
 K0RZuFYnmGW6DGl9C1wYnLr5HKw8p2SjRLZwGU7ysLRQ3WoWkUPhAux8ntGkkM78BeST
 3gy5bmj6RM3yeJNC4RoYftyls+2VxtQW+/OiUtwz9scfBfQzp7am4BFjbaKWiZI3X9Ju
 f8ow==
X-Gm-Message-State: AOJu0Yw3MWa6sIFodwjqTA1JSxWUoI4FX/pNMfpOWUXuR6JAElWGI6Yg
 JE+mSs9NZwqdtN2BeZDRcG1esj0A9RDGNbNRV33ckDwmQl52OFjn4zPbuu1Z8Lvz87MBP+23iiF
 wnHw2UldWmKuje1IL1/jLQZXdlnB4Wa/Jm3lj+PTiJdd4BiXEhzA1nI98Qui2LOskrhG9PBwN
X-Received: by 2002:a05:620a:3994:b0:775:8fab:8c6d with SMTP id
 ro20-20020a05620a399400b007758fab8c6dmr3222214qkn.1.1697574400009; 
 Tue, 17 Oct 2023 13:26:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPzF6uUkr5KWCJFK1zw1tC2LVCedSasJjT7+NJ5d8JsHqvYGMc+3Td3autrmg0ZrKkO+VACg==
X-Received: by 2002:a05:620a:3994:b0:775:8fab:8c6d with SMTP id
 ro20-20020a05620a399400b007758fab8c6dmr3222194qkn.1.1697574399565; 
 Tue, 17 Oct 2023 13:26:39 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 s17-20020ae9f711000000b0076f16e98851sm931879qkg.102.2023.10.17.13.26.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 13:26:38 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Juan Quintela <quintela@redhat.com>
Subject: [PATCH v4 4/5] migration: Change ram_dirty_bitmap_reload() retval to
 bool
Date: Tue, 17 Oct 2023 16:26:32 -0400
Message-ID: <20231017202633.296756-5-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231017202633.296756-1-peterx@redhat.com>
References: <20231017202633.296756-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Now we have a Error** passed into the return path thread stack, which is
even clearer than an int retval.  Change ram_dirty_bitmap_reload() and the
callers to use a bool instead to replace errnos.

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/ram.h       |  2 +-
 migration/migration.c | 18 +++++++++---------
 migration/ram.c       | 24 ++++++++++++------------
 3 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/migration/ram.h b/migration/ram.h
index 14ed666d58..af0290f8ab 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -72,7 +72,7 @@ void ramblock_recv_bitmap_set(RAMBlock *rb, void *host_addr);
 void ramblock_recv_bitmap_set_range(RAMBlock *rb, void *host_addr, size_t nr);
 int64_t ramblock_recv_bitmap_send(QEMUFile *file,
                                   const char *block_name);
-int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *rb, Error **errp);
+bool ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *rb, Error **errp);
 bool ramblock_page_is_discarded(RAMBlock *rb, ram_addr_t start);
 void postcopy_preempt_shutdown_file(MigrationState *s);
 void *postcopy_preempt_thread(void *opaque);
diff --git a/migration/migration.c b/migration/migration.c
index 0661dad953..dfb8b48dcb 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1843,29 +1843,29 @@ migrate_handle_rp_req_pages(MigrationState *ms, const char* rbname,
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
@@ -1875,7 +1875,7 @@ static int migrate_handle_rp_resume_ack(MigrationState *s,
     /* Notify send thread that time to continue send pages */
     migration_rp_kick(s);
 
-    return 0;
+    return true;
 }
 
 /*
@@ -2026,14 +2026,14 @@ static void *source_return_path_thread(void *opaque)
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
index 973e872284..ca77444e18 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -4189,10 +4189,11 @@ static int ram_dirty_bitmap_sync_all(MigrationState *s, RAMState *rs)
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
@@ -4206,7 +4207,7 @@ int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block, Error **errp)
     if (s->state != MIGRATION_STATUS_POSTCOPY_RECOVER) {
         error_setg(errp, "Reload bitmap in incorrect state %s",
                    MigrationStatus_str(s->state));
-        return -EINVAL;
+        return false;
     }
 
     /*
@@ -4224,24 +4225,23 @@ int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block, Error **errp)
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
@@ -4273,7 +4273,7 @@ int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block, Error **errp)
      */
     migration_rp_kick(s);
 
-    return 0;
+    return true;
 }
 
 static int ram_resume_prepare(MigrationState *s, void *opaque)
-- 
2.41.0


