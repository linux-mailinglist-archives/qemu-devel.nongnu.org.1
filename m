Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD1670700A
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 19:54:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzLDo-0007AO-1y; Wed, 17 May 2023 13:45:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLDe-00072u-5b
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:45:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLDc-00042w-2z
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:45:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684345543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yH+74KQ2tsoEwqM9l5YWtbigZxwIdDyrRmSJ6XlLhtY=;
 b=bOm0t5advQMdNAv5tdkQoF24/1XFm1ojIHebbujynFIBABG55OY6YV1HG4MDJGPI3p7jbh
 VTDG3pbPkeDdDXYCuGI5cG/KUFuack0lLcnkzhwEOREWQelnYZp9+pcV7rmBWVRVpTuBwd
 A8sJqLe6QlppDiRPVu9SxQbIGVOLx7M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-m4owjuMwN_is85t91IkCmw-1; Wed, 17 May 2023 13:45:42 -0400
X-MC-Unique: m4owjuMwN_is85t91IkCmw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f4fb0193c6so4460635e9.1
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 10:45:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684345540; x=1686937540;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yH+74KQ2tsoEwqM9l5YWtbigZxwIdDyrRmSJ6XlLhtY=;
 b=V6QFDzXeI9s7rHxfmNLvGC5ntCCYoRy7FW6AEgiG9DII7RTiiUY1EBJjprX98a6X+e
 EHs2Ccw4tVc6C+jP0TbD1K4jrik5u/74i+zXR/X642V+JGf2HaiBvUycwjMxmTNfVLX5
 STcJe+uXvctgBLLYImYKGTdPd3PX57UHWmN9DkMZ9siCdPu/JzxahW0nmSQWaObfNQj7
 rQx2Q95XixZDt73FB66vv3j6DqPGiAgHi5l+RxAurhHVayf0WwrbITWlmDD8cro7QTlj
 X2Xb5pLuO27JcLqHujpqIlh0Bqrf3mOtlPVriuxz2dFFosWs2HJJv2pvlGnxtG0lrD/4
 jFQA==
X-Gm-Message-State: AC+VfDy7RNnjxJhxeFf3eUvmNpKI/l4uGAjcDdniHfxJH7LUnyCzTwSv
 eEsStysK7KeudYI4QRTTjSzXrYRGx8OUkBy/2ZJx/wWzPVqM1DDbCjoCqptoXPnhVqM2g3VvOqk
 R1B2Oi8rEGDijRaVi1sL88yFmxph73N3t7GumoBV23M98JNM5DdJXlHLrixpBsFE4o8aD+mIor1
 Y=
X-Received: by 2002:a5d:4611:0:b0:309:39a0:beff with SMTP id
 t17-20020a5d4611000000b0030939a0beffmr1350587wrq.5.1684345540308; 
 Wed, 17 May 2023 10:45:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7hwHOmROQjWA1MDza+dftzgrmXtLu0IXbENyOic6ktxjxJ0a64iSdNAAKhQ8DkUdbPXh7I0w==
X-Received: by 2002:a5d:4611:0:b0:309:39a0:beff with SMTP id
 t17-20020a5d4611000000b0030939a0beffmr1350569wrq.5.1684345539949; 
 Wed, 17 May 2023 10:45:39 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 a3-20020a05600c224300b003f17848673fsm2869135wmm.27.2023.05.17.10.45.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 10:45:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gavin Shan <gshan@redhat.com>, Peter Xu <peterx@redhat.com>,
 Zhenyu Zhang <zhenyzha@redhat.com>
Subject: [PULL 10/68] migration: Add last stage indicator to global dirty log
Date: Wed, 17 May 2023 19:44:22 +0200
Message-Id: <20230517174520.887405-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230517174520.887405-1-pbonzini@redhat.com>
References: <20230517174520.887405-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Gavin Shan <gshan@redhat.com>

The global dirty log synchronization is used when KVM and dirty ring
are enabled. There is a particularity for ARM64 where the backup
bitmap is used to track dirty pages in non-running-vcpu situations.
It means the dirty ring works with the combination of ring buffer
and backup bitmap. The dirty bits in the backup bitmap needs to
collected in the last stage of live migration.

In order to identify the last stage of live migration and pass it
down, an extra parameter is added to the relevant functions and
callbacks. This last stage indicator isn't used until the dirty
ring is enabled in the subsequent patches.

No functional change intended.

Signed-off-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Tested-by: Zhenyu Zhang <zhenyzha@redhat.com>
Message-Id: <20230509022122.20888-2-gshan@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c   |  2 +-
 include/exec/memory.h |  9 +++++++--
 migration/dirtyrate.c |  4 ++--
 migration/ram.c       | 20 ++++++++++----------
 softmmu/memory.c      | 10 +++++-----
 5 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index cf3a88d90e92..870abad82681 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1563,7 +1563,7 @@ static void kvm_log_sync(MemoryListener *listener,
     kvm_slots_unlock();
 }
 
-static void kvm_log_sync_global(MemoryListener *l)
+static void kvm_log_sync_global(MemoryListener *l, bool last_stage)
 {
     KVMMemoryListener *kml = container_of(l, KVMMemoryListener, listener);
     KVMState *s = kvm_state;
diff --git a/include/exec/memory.h b/include/exec/memory.h
index e45ce6061fb5..6f24a3dd4632 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -934,8 +934,11 @@ struct MemoryListener {
      * its @log_sync must be NULL.  Vice versa.
      *
      * @listener: The #MemoryListener.
+     * @last_stage: The last stage to synchronize the log during migration.
+     * The caller should gurantee that the synchronization with true for
+     * @last_stage is triggered for once after all VCPUs have been stopped.
      */
-    void (*log_sync_global)(MemoryListener *listener);
+    void (*log_sync_global)(MemoryListener *listener, bool last_stage);
 
     /**
      * @log_clear:
@@ -2422,8 +2425,10 @@ MemoryRegionSection memory_region_find(MemoryRegion *mr,
  * memory_global_dirty_log_sync: synchronize the dirty log for all memory
  *
  * Synchronizes the dirty page log for all address spaces.
+ *
+ * @last_stage: whether this is the last stage of live migration
  */
-void memory_global_dirty_log_sync(void);
+void memory_global_dirty_log_sync(bool last_stage);
 
 /**
  * memory_global_dirty_log_sync: synchronize the dirty log for all memory
diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
index c06f12c39ded..76257a14918e 100644
--- a/migration/dirtyrate.c
+++ b/migration/dirtyrate.c
@@ -100,7 +100,7 @@ void global_dirty_log_change(unsigned int flag, bool start)
 static void global_dirty_log_sync(unsigned int flag, bool one_shot)
 {
     qemu_mutex_lock_iothread();
-    memory_global_dirty_log_sync();
+    memory_global_dirty_log_sync(false);
     if (one_shot) {
         memory_global_dirty_log_stop(flag);
     }
@@ -580,7 +580,7 @@ static void calculate_dirtyrate_dirty_bitmap(struct DirtyRateConfig config)
      * skip it unconditionally and start dirty tracking
      * from 2'round of log sync
      */
-    memory_global_dirty_log_sync();
+    memory_global_dirty_log_sync(false);
 
     /*
      * reset page protect manually and unconditionally.
diff --git a/migration/ram.c b/migration/ram.c
index f69d8d42b03e..5900cabf2daa 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1039,7 +1039,7 @@ static void migration_trigger_throttle(RAMState *rs)
     }
 }
 
-static void migration_bitmap_sync(RAMState *rs)
+static void migration_bitmap_sync(RAMState *rs, bool last_stage)
 {
     RAMBlock *block;
     int64_t end_time;
@@ -1051,7 +1051,7 @@ static void migration_bitmap_sync(RAMState *rs)
     }
 
     trace_migration_bitmap_sync_start();
-    memory_global_dirty_log_sync();
+    memory_global_dirty_log_sync(last_stage);
 
     qemu_mutex_lock(&rs->bitmap_mutex);
     WITH_RCU_READ_LOCK_GUARD() {
@@ -1086,7 +1086,7 @@ static void migration_bitmap_sync(RAMState *rs)
     }
 }
 
-static void migration_bitmap_sync_precopy(RAMState *rs)
+static void migration_bitmap_sync_precopy(RAMState *rs, bool last_stage)
 {
     Error *local_err = NULL;
 
@@ -1099,7 +1099,7 @@ static void migration_bitmap_sync_precopy(RAMState *rs)
         local_err = NULL;
     }
 
-    migration_bitmap_sync(rs);
+    migration_bitmap_sync(rs, last_stage);
 
     if (precopy_notify(PRECOPY_NOTIFY_AFTER_BITMAP_SYNC, &local_err)) {
         error_report_err(local_err);
@@ -2699,7 +2699,7 @@ void ram_postcopy_send_discard_bitmap(MigrationState *ms)
     RCU_READ_LOCK_GUARD();
 
     /* This should be our last sync, the src is now paused */
-    migration_bitmap_sync(rs);
+    migration_bitmap_sync(rs, false);
 
     /* Easiest way to make sure we don't resume in the middle of a host-page */
     rs->pss[RAM_CHANNEL_PRECOPY].last_sent_block = NULL;
@@ -2890,7 +2890,7 @@ static void ram_init_bitmaps(RAMState *rs)
         /* We don't use dirty log with background snapshots */
         if (!migrate_background_snapshot()) {
             memory_global_dirty_log_start(GLOBAL_DIRTY_MIGRATION);
-            migration_bitmap_sync_precopy(rs);
+            migration_bitmap_sync_precopy(rs, false);
         }
     }
     qemu_mutex_unlock_ramlist();
@@ -3214,7 +3214,7 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
 
     WITH_RCU_READ_LOCK_GUARD() {
         if (!migration_in_postcopy()) {
-            migration_bitmap_sync_precopy(rs);
+            migration_bitmap_sync_precopy(rs, true);
         }
 
         ram_control_before_iterate(f, RAM_CONTROL_FINISH);
@@ -3288,7 +3288,7 @@ static void ram_state_pending_exact(void *opaque, uint64_t *must_precopy,
     if (!migration_in_postcopy() && remaining_size < s->threshold_size) {
         qemu_mutex_lock_iothread();
         WITH_RCU_READ_LOCK_GUARD() {
-            migration_bitmap_sync_precopy(rs);
+            migration_bitmap_sync_precopy(rs, false);
         }
         qemu_mutex_unlock_iothread();
         remaining_size = rs->migration_dirty_pages * TARGET_PAGE_SIZE;
@@ -3523,7 +3523,7 @@ void colo_incoming_start_dirty_log(void)
     qemu_mutex_lock_iothread();
     qemu_mutex_lock_ramlist();
 
-    memory_global_dirty_log_sync();
+    memory_global_dirty_log_sync(false);
     WITH_RCU_READ_LOCK_GUARD() {
         RAMBLOCK_FOREACH_NOT_IGNORED(block) {
             ramblock_sync_dirty_bitmap(ram_state, block);
@@ -3813,7 +3813,7 @@ void colo_flush_ram_cache(void)
     void *src_host;
     unsigned long offset = 0;
 
-    memory_global_dirty_log_sync();
+    memory_global_dirty_log_sync(false);
     qemu_mutex_lock(&ram_state->bitmap_mutex);
     WITH_RCU_READ_LOCK_GUARD() {
         RAMBLOCK_FOREACH_NOT_IGNORED(block) {
diff --git a/softmmu/memory.c b/softmmu/memory.c
index b7b3386e9d48..342c12151450 100644
--- a/softmmu/memory.c
+++ b/softmmu/memory.c
@@ -2253,7 +2253,7 @@ void memory_region_set_dirty(MemoryRegion *mr, hwaddr addr,
  * If memory region `mr' is NULL, do global sync.  Otherwise, sync
  * dirty bitmap for the specified memory region.
  */
-static void memory_region_sync_dirty_bitmap(MemoryRegion *mr)
+static void memory_region_sync_dirty_bitmap(MemoryRegion *mr, bool last_stage)
 {
     MemoryListener *listener;
     AddressSpace *as;
@@ -2283,7 +2283,7 @@ static void memory_region_sync_dirty_bitmap(MemoryRegion *mr)
              * is to do a global sync, because we are not capable to
              * sync in a finer granularity.
              */
-            listener->log_sync_global(listener);
+            listener->log_sync_global(listener, last_stage);
             trace_memory_region_sync_dirty(mr ? mr->name : "(all)", listener->name, 1);
         }
     }
@@ -2347,7 +2347,7 @@ DirtyBitmapSnapshot *memory_region_snapshot_and_clear_dirty(MemoryRegion *mr,
 {
     DirtyBitmapSnapshot *snapshot;
     assert(mr->ram_block);
-    memory_region_sync_dirty_bitmap(mr);
+    memory_region_sync_dirty_bitmap(mr, false);
     snapshot = cpu_physical_memory_snapshot_and_clear_dirty(mr, addr, size, client);
     memory_global_after_dirty_log_sync();
     return snapshot;
@@ -2873,9 +2873,9 @@ bool memory_region_present(MemoryRegion *container, hwaddr addr)
     return mr && mr != container;
 }
 
-void memory_global_dirty_log_sync(void)
+void memory_global_dirty_log_sync(bool last_stage)
 {
-    memory_region_sync_dirty_bitmap(NULL);
+    memory_region_sync_dirty_bitmap(NULL, last_stage);
 }
 
 void memory_global_after_dirty_log_sync(void)
-- 
2.40.1


