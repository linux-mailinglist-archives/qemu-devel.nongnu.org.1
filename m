Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4FF716CA6
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 20:40:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q44GS-0000Xi-O5; Tue, 30 May 2023 14:40:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q44GO-0000Ws-TQ
 for qemu-devel@nongnu.org; Tue, 30 May 2023 14:40:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q44GM-0004N7-S3
 for qemu-devel@nongnu.org; Tue, 30 May 2023 14:40:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685472006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/MFfSBAQGLXsglEvf7M78QBWXN5LEXG1b5wvsbDTNiw=;
 b=F1C85hXThBC+K0szl920YhQKLJQtFmaOKud3QHPTks82B6Sd0mTca9GhtV14waECB5MmhN
 Od5ErWXdd+rSbezsXjyaGBzrocCS2LygtZExkrdUthET8iC7JaU6hxTkKDwwIBMfqFkWsS
 FiPpMJIH3Dkj93pXg8eOJKtDK8trMF8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-646-mTUG-g3aOrKWfUoQSZPx4A-1; Tue, 30 May 2023 14:40:02 -0400
X-MC-Unique: mTUG-g3aOrKWfUoQSZPx4A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6BE421C068C6;
 Tue, 30 May 2023 18:40:02 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D4255C154D1;
 Tue, 30 May 2023 18:40:00 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Leonardo Bras <leobras@redhat.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Fiona Ebner <f.ebner@proxmox.com>, Peter Xu <peterx@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PATCH v2 09/20] qemu-file: Remove _noflush from
 qemu_file_transferred_noflush()
Date: Tue, 30 May 2023 20:39:30 +0200
Message-Id: <20230530183941.7223-10-quintela@redhat.com>
In-Reply-To: <20230530183941.7223-1-quintela@redhat.com>
References: <20230530183941.7223-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
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

qemu_file_transferred() don't exist anymore, so we can reuse the name.

Signed-off-by: Juan Quintela <quintela@redhat.com>

---

v2: Update the documentation (thanks fabiano)
---
 migration/qemu-file.h | 9 ++++-----
 migration/block.c     | 4 ++--
 migration/qemu-file.c | 2 +-
 migration/savevm.c    | 6 +++---
 migration/vmstate.c   | 4 ++--
 5 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/migration/qemu-file.h b/migration/qemu-file.h
index b4fb872018..507f3bede4 100644
--- a/migration/qemu-file.h
+++ b/migration/qemu-file.h
@@ -34,15 +34,14 @@ QEMUFile *qemu_file_new_output(QIOChannel *ioc);
 int qemu_fclose(QEMUFile *f);
 
 /*
- * qemu_file_transferred_noflush:
+ * qemu_file_transferred:
  *
- * As qemu_file_transferred except for writable files, where no flush
- * is performed and the reported amount will include the size of any
- * queued buffers, on top of the amount actually transferred.
+ * No flush is performed and the reported amount will include the size
+ * of any queued buffers, on top of the amount actually transferred.
  *
  * Returns: the total bytes transferred and queued
  */
-uint64_t qemu_file_transferred_noflush(QEMUFile *f);
+uint64_t qemu_file_transferred(QEMUFile *f);
 
 /*
  * put_buffer without copying the buffer.
diff --git a/migration/block.c b/migration/block.c
index b29e80bdc4..b9580a6c7e 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -748,7 +748,7 @@ static int block_save_setup(QEMUFile *f, void *opaque)
 static int block_save_iterate(QEMUFile *f, void *opaque)
 {
     int ret;
-    uint64_t last_bytes = qemu_file_transferred_noflush(f);
+    uint64_t last_bytes = qemu_file_transferred(f);
 
     trace_migration_block_save("iterate", block_mig_state.submitted,
                                block_mig_state.transferred);
@@ -800,7 +800,7 @@ static int block_save_iterate(QEMUFile *f, void *opaque)
     }
 
     qemu_put_be64(f, BLK_MIG_FLAG_EOS);
-    uint64_t delta_bytes = qemu_file_transferred_noflush(f) - last_bytes;
+    uint64_t delta_bytes = qemu_file_transferred(f) - last_bytes;
     return (delta_bytes > 0);
 }
 
diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 1e6fafc245..94dd6d7fdd 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -623,7 +623,7 @@ int coroutine_mixed_fn qemu_get_byte(QEMUFile *f)
     return result;
 }
 
-uint64_t qemu_file_transferred_noflush(QEMUFile *f)
+uint64_t qemu_file_transferred(QEMUFile *f)
 {
     uint64_t ret = stat64_get(&mig_stats.qemu_file_transferred);
     int i;
diff --git a/migration/savevm.c b/migration/savevm.c
index b2199d1039..751b4a1e31 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -927,9 +927,9 @@ static int vmstate_load(QEMUFile *f, SaveStateEntry *se)
 static void vmstate_save_old_style(QEMUFile *f, SaveStateEntry *se,
                                    JSONWriter *vmdesc)
 {
-    uint64_t old_offset = qemu_file_transferred_noflush(f);
+    uint64_t old_offset = qemu_file_transferred(f);
     se->ops->save_state(f, se->opaque);
-    uint64_t size = qemu_file_transferred_noflush(f) - old_offset;
+    uint64_t size = qemu_file_transferred(f) - old_offset;
 
     if (vmdesc) {
         json_writer_int64(vmdesc, "size", size);
@@ -2952,7 +2952,7 @@ bool save_snapshot(const char *name, bool overwrite, const char *vmstate,
         goto the_end;
     }
     ret = qemu_savevm_state(f, errp);
-    vm_state_size = qemu_file_transferred_noflush(f);
+    vm_state_size = qemu_file_transferred(f);
     ret2 = qemu_fclose(f);
     if (ret < 0) {
         goto the_end;
diff --git a/migration/vmstate.c b/migration/vmstate.c
index 31842c3afb..fd8035ea32 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -361,7 +361,7 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
                 void *curr_elem = first_elem + size * i;
 
                 vmsd_desc_field_start(vmsd, vmdesc_loop, field, i, n_elems);
-                old_offset = qemu_file_transferred_noflush(f);
+                old_offset = qemu_file_transferred(f);
                 if (field->flags & VMS_ARRAY_OF_POINTER) {
                     assert(curr_elem);
                     curr_elem = *(void **)curr_elem;
@@ -391,7 +391,7 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
                     return ret;
                 }
 
-                written_bytes = qemu_file_transferred_noflush(f) - old_offset;
+                written_bytes = qemu_file_transferred(f) - old_offset;
                 vmsd_desc_field_end(vmsd, vmdesc_loop, field, written_bytes, i);
 
                 /* Compressed arrays only care about the first element */
-- 
2.40.1


