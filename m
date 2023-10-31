Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A15D87DC912
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 10:08:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxkev-0002uX-M5; Tue, 31 Oct 2023 05:03:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxkei-0002F5-6z
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 05:03:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxkef-0007Ae-Dn
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 05:03:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698743000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QjSL1hcG9VuYm/7FTdP+GJGNi8SYhcnfOVzKe90L+6k=;
 b=QW5ULXMsoxiIcSvxRY/iN8NJYDMuJ0kTkQVRVWR+cbBiTXPPQ1aR1NauntJueTzbTJZKfn
 BHf6gx5lKA4QsN9Omk49GVNSO/qZNljj2WC0lcX96VToBdWmrFlYXmutrtV7wMx1iwe4OV
 XnRmL67zE2EQ2943Mp+/DS01s698glA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-79-FG3gJ5aLNo6mh1oG1xtdyA-1; Tue,
 31 Oct 2023 05:03:16 -0400
X-MC-Unique: FG3gJ5aLNo6mh1oG1xtdyA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CE3F93C10422;
 Tue, 31 Oct 2023 09:03:15 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 718791C060AE;
 Tue, 31 Oct 2023 09:03:13 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, libvir-list@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 Hanna Reitz <hreitz@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>, qemu-block@nongnu.org,
 Fabiano Rosas <farosas@suse.de>
Subject: [PULL 32/38] qemu-file: Remove _noflush from
 qemu_file_transferred_noflush()
Date: Tue, 31 Oct 2023 10:01:36 +0100
Message-ID: <20231031090142.13122-33-quintela@redhat.com>
In-Reply-To: <20231031090142.13122-1-quintela@redhat.com>
References: <20231031090142.13122-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Juan Quintela <quintela@redhat.com>

Message-ID: <20231025091117.6342-7-quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/qemu-file.h | 9 ++++-----
 migration/block.c     | 4 ++--
 migration/qemu-file.c | 2 +-
 migration/savevm.c    | 6 +++---
 migration/vmstate.c   | 4 ++--
 5 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/migration/qemu-file.h b/migration/qemu-file.h
index 8b71152754..1b2f6b8d8f 100644
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
index acffe88f84..a15f9bddcb 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -755,7 +755,7 @@ static int block_save_setup(QEMUFile *f, void *opaque)
 static int block_save_iterate(QEMUFile *f, void *opaque)
 {
     int ret;
-    uint64_t last_bytes = qemu_file_transferred_noflush(f);
+    uint64_t last_bytes = qemu_file_transferred(f);
 
     trace_migration_block_save("iterate", block_mig_state.submitted,
                                block_mig_state.transferred);
@@ -807,7 +807,7 @@ static int block_save_iterate(QEMUFile *f, void *opaque)
     }
 
     qemu_put_be64(f, BLK_MIG_FLAG_EOS);
-    uint64_t delta_bytes = qemu_file_transferred_noflush(f) - last_bytes;
+    uint64_t delta_bytes = qemu_file_transferred(f) - last_bytes;
     return (delta_bytes > 0);
 }
 
diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index efa5f11033..0158db2a54 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -618,7 +618,7 @@ int coroutine_mixed_fn qemu_get_byte(QEMUFile *f)
     return result;
 }
 
-uint64_t qemu_file_transferred_noflush(QEMUFile *f)
+uint64_t qemu_file_transferred(QEMUFile *f)
 {
     uint64_t ret = stat64_get(&mig_stats.qemu_file_transferred);
     int i;
diff --git a/migration/savevm.c b/migration/savevm.c
index ca5c7cebe0..9ec78abd53 100644
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
@@ -3053,7 +3053,7 @@ bool save_snapshot(const char *name, bool overwrite, const char *vmstate,
         goto the_end;
     }
     ret = qemu_savevm_state(f, errp);
-    vm_state_size = qemu_file_transferred_noflush(f);
+    vm_state_size = qemu_file_transferred(f);
     ret2 = qemu_fclose(f);
     if (ret < 0) {
         goto the_end;
diff --git a/migration/vmstate.c b/migration/vmstate.c
index 9c36803c8a..b7723a4187 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -387,7 +387,7 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
                 void *curr_elem = first_elem + size * i;
 
                 vmsd_desc_field_start(vmsd, vmdesc_loop, field, i, n_elems);
-                old_offset = qemu_file_transferred_noflush(f);
+                old_offset = qemu_file_transferred(f);
                 if (field->flags & VMS_ARRAY_OF_POINTER) {
                     assert(curr_elem);
                     curr_elem = *(void **)curr_elem;
@@ -417,7 +417,7 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
                     return ret;
                 }
 
-                written_bytes = qemu_file_transferred_noflush(f) - old_offset;
+                written_bytes = qemu_file_transferred(f) - old_offset;
                 vmsd_desc_field_end(vmsd, vmdesc_loop, field, written_bytes, i);
 
                 /* Compressed arrays only care about the first element */
-- 
2.41.0


