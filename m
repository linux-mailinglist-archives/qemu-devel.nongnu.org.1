Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CC97C4F36
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 11:38:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqVSD-0005K2-Fs; Wed, 11 Oct 2023 05:24:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVS2-00057q-Eg
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:24:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVRz-0005E1-SD
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:24:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697016258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3QEULf3jbHJZ303L8i4uGaQWAe3u6wBDVDebIdN2EkE=;
 b=QKuJa6RPb3BgAvPj/9yUQPruIxYxK8nZyobHs/Qx1bvWrSgUTVnIqJVpY/5n9c5976vJKp
 Wi24w6MpDKl9Kkn1xt/aNVRZaqM6TSxOQzSYSpF7J7HoDXvwz5yKVt7QaammRTp+iv8sWv
 nbIYrmOs9sH60+fe33XH1+e/xRD4h2E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-251-2pbpgowaP5WMYnFmErDwkw-1; Wed, 11 Oct 2023 05:24:16 -0400
X-MC-Unique: 2pbpgowaP5WMYnFmErDwkw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3D86F811E7B;
 Wed, 11 Oct 2023 09:24:16 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7F3D11C060AE;
 Wed, 11 Oct 2023 09:24:14 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Leonardo Bras <leobras@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 64/65] migration: Remember num of ramblocks to sync during
 recovery
Date: Wed, 11 Oct 2023 11:22:02 +0200
Message-ID: <20231011092203.1266-65-quintela@redhat.com>
In-Reply-To: <20231011092203.1266-1-quintela@redhat.com>
References: <20231011092203.1266-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
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

From: Peter Xu <peterx@redhat.com>

Instead of only relying on the count of rp_sem, make the counter be part of
RAMState so it can be used in both threads to synchronize on the process.

rp_sem will be further reused in follow up patches, as a way to kick the
main thread, e.g., on recovery failures.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20231004220240.167175-7-peterx@redhat.com>
---
 migration/ram.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index e4bfd39f08..6c40d9af0c 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -394,6 +394,14 @@ struct RAMState {
     /* Queue of outstanding page requests from the destination */
     QemuMutex src_page_req_mutex;
     QSIMPLEQ_HEAD(, RAMSrcPageRequest) src_page_requests;
+
+    /*
+     * This is only used when postcopy is in recovery phase, to communicate
+     * between the migration thread and the return path thread on dirty
+     * bitmap synchronizations.  This field is unused in other stages of
+     * RAM migration.
+     */
+    unsigned int postcopy_bmap_sync_requested;
 };
 typedef struct RAMState RAMState;
 
@@ -4119,20 +4127,20 @@ static int ram_dirty_bitmap_sync_all(MigrationState *s, RAMState *rs)
 {
     RAMBlock *block;
     QEMUFile *file = s->to_dst_file;
-    int ramblock_count = 0;
 
     trace_ram_dirty_bitmap_sync_start();
 
+    qatomic_set(&rs->postcopy_bmap_sync_requested, 0);
     RAMBLOCK_FOREACH_NOT_IGNORED(block) {
         qemu_savevm_send_recv_bitmap(file, block->idstr);
         trace_ram_dirty_bitmap_request(block->idstr);
-        ramblock_count++;
+        qatomic_inc(&rs->postcopy_bmap_sync_requested);
     }
 
     trace_ram_dirty_bitmap_sync_wait();
 
     /* Wait until all the ramblocks' dirty bitmap synced */
-    while (ramblock_count--) {
+    while (qatomic_read(&rs->postcopy_bmap_sync_requested)) {
         qemu_sem_wait(&s->rp_state.rp_sem);
     }
 
@@ -4159,6 +4167,7 @@ int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block)
     unsigned long *le_bitmap, nbits = block->used_length >> TARGET_PAGE_BITS;
     uint64_t local_size = DIV_ROUND_UP(nbits, 8);
     uint64_t size, end_mark;
+    RAMState *rs = ram_state;
 
     trace_ram_dirty_bitmap_reload_begin(block->idstr);
 
@@ -4225,6 +4234,8 @@ int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block)
     /* We'll recalculate migration_dirty_pages in ram_state_resume_prepare(). */
     trace_ram_dirty_bitmap_reload_complete(block->idstr);
 
+    qatomic_dec(&rs->postcopy_bmap_sync_requested);
+
     /*
      * We succeeded to sync bitmap for current ramblock. If this is
      * the last one to sync, we need to notify the main send thread.
-- 
2.41.0


