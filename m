Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 39AAD7C83AE
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 12:50:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrFjD-0006N4-1H; Fri, 13 Oct 2023 06:49:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qrFj8-00060E-Jb
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 06:49:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qrFj4-0007Ma-5i
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 06:49:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697194141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vT1RydG4IgwSx7egtUvXIbVvTq5aIyG5VMKawu8qdi8=;
 b=V0OKPBekmPDbs+8cWl6TtlNPsBU7aqUmgD3lBtBR9L/ejIvkLFNUDHbNDFhhNN7oIi2W1L
 mM2WIbsLZBIz6lgwfRIPylNPdIHbxiYM/Fn17bkIFhzzTTvqwzKuMi7L3l6BOH2UNjO6OP
 IPLyYUR5lnB6l6m9yQFhfq5/l2Y4E74=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-191-y0aof7RBNcqZ2s4K7LJUBQ-1; Fri, 13 Oct 2023 06:48:13 -0400
X-MC-Unique: y0aof7RBNcqZ2s4K7LJUBQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E6EDF858F1B;
 Fri, 13 Oct 2023 10:48:12 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 07B272156701;
 Fri, 13 Oct 2023 10:48:09 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fam Zheng <fam@euphon.net>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Eric Blake <eblake@redhat.com>, libvir-list@redhat.com,
 Fabiano Rosas <farosas@suse.de>, qemu-block@nongnu.org,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>
Subject: [PATCH v4 10/10] [RFC] migration: Remove block migration support
Date: Fri, 13 Oct 2023 12:47:36 +0200
Message-ID: <20231013104736.31722-11-quintela@redhat.com>
In-Reply-To: <20231013104736.31722-1-quintela@redhat.com>
References: <20231013104736.31722-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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

[DON'T MERGE]

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 meson.build                    |    2 -
 qapi/migration.json            |   31 +-
 include/migration/misc.h       |    8 -
 migration/block.h              |   52 --
 migration/options.h            |    1 -
 migration/block.c              | 1030 --------------------------------
 migration/colo.c               |    1 -
 migration/migration-hmp-cmds.c |   34 +-
 migration/migration.c          |   28 +-
 migration/options.c            |   26 -
 migration/ram.c                |   16 -
 migration/savevm.c             |    5 -
 hmp-commands.hx                |   12 +-
 migration/meson.build          |    3 -
 14 files changed, 14 insertions(+), 1235 deletions(-)
 delete mode 100644 migration/block.h
 delete mode 100644 migration/block.c

diff --git a/meson.build b/meson.build
index bd65a111aa..2332fa3dcb 100644
--- a/meson.build
+++ b/meson.build
@@ -2199,7 +2199,6 @@ config_host_data.set('CONFIG_DEBUG_GRAPH_LOCK', get_option('debug_graph_lock'))
 config_host_data.set('CONFIG_DEBUG_MUTEX', get_option('debug_mutex'))
 config_host_data.set('CONFIG_DEBUG_STACK_USAGE', get_option('debug_stack_usage'))
 config_host_data.set('CONFIG_DEBUG_TCG', get_option('debug_tcg'))
-config_host_data.set('CONFIG_LIVE_BLOCK_MIGRATION', get_option('live_block_migration').allowed())
 config_host_data.set('CONFIG_QOM_CAST_DEBUG', get_option('qom_cast_debug'))
 config_host_data.set('CONFIG_REPLICATION', get_option('replication').allowed())
 
@@ -4181,7 +4180,6 @@ if have_block
   summary_info += {'Use block whitelist in tools': get_option('block_drv_whitelist_in_tools')}
   summary_info += {'VirtFS (9P) support':    have_virtfs}
   summary_info += {'VirtFS (9P) Proxy Helper support (deprecated)': have_virtfs_proxy_helper}
-  summary_info += {'Live block migration': config_host_data.get('CONFIG_LIVE_BLOCK_MIGRATION')}
   summary_info += {'replication support': config_host_data.get('CONFIG_REPLICATION')}
   summary_info += {'bochs support':     get_option('bochs').allowed()}
   summary_info += {'cloop support':     get_option('cloop').allowed()}
diff --git a/qapi/migration.json b/qapi/migration.json
index 545da4e257..46c0e0a90e 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -202,9 +202,6 @@
 # @ram: @MigrationStats containing detailed migration status, only
 #     returned if status is 'active' or 'completed'(since 1.2)
 #
-# @disk: @MigrationStats containing detailed disk migration status,
-#     only returned if status is 'active' and it is a block migration
-#
 # @xbzrle-cache: @XBZRLECacheStats containing detailed XBZRLE
 #     migration statistics, only returned if XBZRLE feature is on and
 #     status is 'active' or 'completed' (since 1.2)
@@ -271,17 +268,15 @@
 #
 # Features:
 #
-# @deprecated: Member @disk is deprecated because block migration is.
-#     Member @compression is deprecated because it is unreliable and
-#     untested. It is recommended to use multifd migration, which
-#     offers an alternative compression implementation that is
-#     reliable and tested.
+# @deprecated: Member @compression is deprecated because it is
+#     unreliable and untested. It is recommended to use multifd
+#     migration, which offers an alternative compression
+#     implementation that is reliable and tested.
 #
 # Since: 0.14
 ##
 { 'struct': 'MigrationInfo',
   'data': {'*status': 'MigrationStatus', '*ram': 'MigrationStats',
-           '*disk': { 'type': 'MigrationStats', 'features': [ 'deprecated' ] },
            '*vfio': 'VfioStats',
            '*xbzrle-cache': 'XBZRLECacheStats',
            '*total-time': 'int',
@@ -469,11 +464,6 @@
 # @release-ram: if enabled, qemu will free the migrated ram pages on
 #     the source during postcopy-ram migration.  (since 2.9)
 #
-# @block: If enabled, QEMU will also migrate the contents of all block
-#     devices.  Default is disabled.  A possible alternative uses
-#     mirror jobs to a builtin NBD server on the destination, which
-#     offers more flexibility.  (Since 2.10)
-#
 # @return-path: If enabled, migration will use the return path even
 #     for precopy.  (since 2.10)
 #
@@ -533,8 +523,7 @@
 #
 # Features:
 #
-# @deprecated: Member @block is deprecated.  Use blockdev-mirror with
-#     NBD instead.  Member @compression is deprecated because it is
+# @deprecated: Member @compression is deprecated because it is
 #     unreliable and untested. It is recommended to use multifd
 #     migration, which offers an alternative compression
 #     implementation that is reliable and tested.
@@ -549,7 +538,6 @@
            'events', 'postcopy-ram',
            { 'name': 'x-colo', 'features': [ 'unstable' ] },
            'release-ram',
-           { 'name': 'block', 'features': [ 'deprecated' ] },
            'return-path', 'pause-before-switchover', 'multifd',
            'dirty-bitmaps', 'postcopy-blocktime', 'late-block-activate',
            { 'name': 'x-ignore-shared', 'features': [ 'unstable' ] },
@@ -1496,8 +1484,6 @@
 #
 # @uri: the Uniform Resource Identifier of the destination VM
 #
-# @blk: do block migration (full disk copy)
-#
 # @detach: this argument exists only for compatibility reasons and is
 #     ignored by QEMU
 #
@@ -1505,9 +1491,6 @@
 #
 # Features:
 #
-# @deprecated: Member @blk is deprecated. Set migration capability
-#     'block' to 'true' instead.
-#
 # Returns: nothing on success
 #
 # Since: 0.14
@@ -1529,9 +1512,7 @@
 # <- { "return": {} }
 ##
 { 'command': 'migrate',
-  'data': {'uri': 'str',
-           '*blk': { 'type': 'bool', 'features': [ 'deprecated' ] },
-           '*detach': 'bool', '*resume': 'bool' } }
+  'data': {'uri': 'str', '*detach': 'bool', '*resume': 'bool' } }
 
 ##
 # @migrate-incoming:
diff --git a/include/migration/misc.h b/include/migration/misc.h
index 7dcc0b5c2c..c48242d70b 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -42,14 +42,6 @@ void ram_mig_init(void);
 void qemu_guest_free_page_hint(void *addr, size_t len);
 bool migrate_ram_is_ignored(RAMBlock *block);
 
-/* migration/block.c */
-
-#ifdef CONFIG_LIVE_BLOCK_MIGRATION
-void blk_mig_init(void);
-#else
-static inline void blk_mig_init(void) {}
-#endif
-
 AnnounceParameters *migrate_announce_params(void);
 /* migration/savevm.c */
 
diff --git a/migration/block.h b/migration/block.h
deleted file mode 100644
index 3178609dbd..0000000000
--- a/migration/block.h
+++ /dev/null
@@ -1,52 +0,0 @@
-/*
- * QEMU live block migration
- *
- * Copyright IBM, Corp. 2009
- *
- * Authors:
- *  Liran Schour   <lirans@il.ibm.com>
- *
- * This work is licensed under the terms of the GNU GPL, version 2.  See
- * the COPYING file in the top-level directory.
- *
- */
-
-#ifndef MIGRATION_BLOCK_H
-#define MIGRATION_BLOCK_H
-
-#ifdef CONFIG_LIVE_BLOCK_MIGRATION
-int blk_mig_active(void);
-int blk_mig_bulk_active(void);
-uint64_t blk_mig_bytes_transferred(void);
-uint64_t blk_mig_bytes_remaining(void);
-uint64_t blk_mig_bytes_total(void);
-
-#else
-static inline int blk_mig_active(void)
-{
-    return false;
-}
-
-static inline int blk_mig_bulk_active(void)
-{
-    return false;
-}
-
-static inline uint64_t blk_mig_bytes_transferred(void)
-{
-    return 0;
-}
-
-static inline uint64_t blk_mig_bytes_remaining(void)
-{
-    return 0;
-}
-
-static inline uint64_t blk_mig_bytes_total(void)
-{
-    return 0;
-}
-#endif /* CONFIG_LIVE_BLOCK_MIGRATION */
-
-void migrate_set_block_enabled(bool value, Error **errp);
-#endif /* MIGRATION_BLOCK_H */
diff --git a/migration/options.h b/migration/options.h
index 237e4c75d4..645ca6b44f 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -25,7 +25,6 @@ extern Property migration_properties[];
 
 bool migrate_auto_converge(void);
 bool migrate_background_snapshot(void);
-bool migrate_block(void);
 bool migrate_colo(void);
 bool migrate_compress(void);
 bool migrate_dirty_bitmaps(void);
diff --git a/migration/block.c b/migration/block.c
deleted file mode 100644
index fadf96f668..0000000000
--- a/migration/block.c
+++ /dev/null
@@ -1,1030 +0,0 @@
-/*
- * QEMU live block migration
- *
- * Copyright IBM, Corp. 2009
- *
- * Authors:
- *  Liran Schour   <lirans@il.ibm.com>
- *
- * This work is licensed under the terms of the GNU GPL, version 2.  See
- * the COPYING file in the top-level directory.
- *
- * Contributions after 2012-01-13 are licensed under the terms of the
- * GNU GPL, version 2 or (at your option) any later version.
- */
-
-#include "qemu/osdep.h"
-#include "qapi/error.h"
-#include "qemu/error-report.h"
-#include "qemu/main-loop.h"
-#include "qemu/cutils.h"
-#include "qemu/queue.h"
-#include "block.h"
-#include "block/dirty-bitmap.h"
-#include "migration/misc.h"
-#include "migration.h"
-#include "migration-stats.h"
-#include "migration/register.h"
-#include "qemu-file.h"
-#include "migration/vmstate.h"
-#include "sysemu/block-backend.h"
-#include "trace.h"
-#include "options.h"
-
-#define BLK_MIG_BLOCK_SIZE           (1ULL << 20)
-#define BDRV_SECTORS_PER_DIRTY_CHUNK (BLK_MIG_BLOCK_SIZE >> BDRV_SECTOR_BITS)
-
-#define BLK_MIG_FLAG_DEVICE_BLOCK       0x01
-#define BLK_MIG_FLAG_EOS                0x02
-#define BLK_MIG_FLAG_PROGRESS           0x04
-#define BLK_MIG_FLAG_ZERO_BLOCK         0x08
-
-#define MAX_IS_ALLOCATED_SEARCH (65536 * BDRV_SECTOR_SIZE)
-
-#define MAX_IO_BUFFERS 512
-#define MAX_PARALLEL_IO 16
-
-typedef struct BlkMigDevState {
-    /* Written during setup phase.  Can be read without a lock.  */
-    BlockBackend *blk;
-    char *blk_name;
-    int shared_base;
-    int64_t total_sectors;
-    QSIMPLEQ_ENTRY(BlkMigDevState) entry;
-    Error *blocker;
-
-    /* Only used by migration thread.  Does not need a lock.  */
-    int bulk_completed;
-    int64_t cur_sector;
-    int64_t cur_dirty;
-
-    /* Data in the aio_bitmap is protected by block migration lock.
-     * Allocation and free happen during setup and cleanup respectively.
-     */
-    unsigned long *aio_bitmap;
-
-    /* Protected by block migration lock.  */
-    int64_t completed_sectors;
-
-    /* During migration this is protected by iothread lock / AioContext.
-     * Allocation and free happen during setup and cleanup respectively.
-     */
-    BdrvDirtyBitmap *dirty_bitmap;
-} BlkMigDevState;
-
-typedef struct BlkMigBlock {
-    /* Only used by migration thread.  */
-    uint8_t *buf;
-    BlkMigDevState *bmds;
-    int64_t sector;
-    int nr_sectors;
-    QEMUIOVector qiov;
-    BlockAIOCB *aiocb;
-
-    /* Protected by block migration lock.  */
-    int ret;
-    QSIMPLEQ_ENTRY(BlkMigBlock) entry;
-} BlkMigBlock;
-
-typedef struct BlkMigState {
-    QSIMPLEQ_HEAD(, BlkMigDevState) bmds_list;
-    int64_t total_sector_sum;
-    bool zero_blocks;
-
-    /* Protected by lock.  */
-    QSIMPLEQ_HEAD(, BlkMigBlock) blk_list;
-    int submitted;
-    int read_done;
-
-    /* Only used by migration thread.  Does not need a lock.  */
-    int transferred;
-    int prev_progress;
-    int bulk_completed;
-
-    /* Lock must be taken _inside_ the iothread lock and any AioContexts.  */
-    QemuMutex lock;
-} BlkMigState;
-
-static BlkMigState block_mig_state;
-
-static void blk_mig_lock(void)
-{
-    qemu_mutex_lock(&block_mig_state.lock);
-}
-
-static void blk_mig_unlock(void)
-{
-    qemu_mutex_unlock(&block_mig_state.lock);
-}
-
-/* Must run outside of the iothread lock during the bulk phase,
- * or the VM will stall.
- */
-
-static void blk_send(QEMUFile *f, BlkMigBlock * blk)
-{
-    int len;
-    uint64_t flags = BLK_MIG_FLAG_DEVICE_BLOCK;
-
-    if (block_mig_state.zero_blocks &&
-        buffer_is_zero(blk->buf, BLK_MIG_BLOCK_SIZE)) {
-        flags |= BLK_MIG_FLAG_ZERO_BLOCK;
-    }
-
-    /* sector number and flags */
-    qemu_put_be64(f, (blk->sector << BDRV_SECTOR_BITS)
-                     | flags);
-
-    /* device name */
-    len = strlen(blk->bmds->blk_name);
-    qemu_put_byte(f, len);
-    qemu_put_buffer(f, (uint8_t *) blk->bmds->blk_name, len);
-
-    /* if a block is zero we need to flush here since the network
-     * bandwidth is now a lot higher than the storage device bandwidth.
-     * thus if we queue zero blocks we slow down the migration */
-    if (flags & BLK_MIG_FLAG_ZERO_BLOCK) {
-        qemu_fflush(f);
-        return;
-    }
-
-    qemu_put_buffer(f, blk->buf, BLK_MIG_BLOCK_SIZE);
-}
-
-int blk_mig_active(void)
-{
-    return !QSIMPLEQ_EMPTY(&block_mig_state.bmds_list);
-}
-
-int blk_mig_bulk_active(void)
-{
-    return blk_mig_active() && !block_mig_state.bulk_completed;
-}
-
-uint64_t blk_mig_bytes_transferred(void)
-{
-    BlkMigDevState *bmds;
-    uint64_t sum = 0;
-
-    blk_mig_lock();
-    QSIMPLEQ_FOREACH(bmds, &block_mig_state.bmds_list, entry) {
-        sum += bmds->completed_sectors;
-    }
-    blk_mig_unlock();
-    return sum << BDRV_SECTOR_BITS;
-}
-
-uint64_t blk_mig_bytes_remaining(void)
-{
-    return blk_mig_bytes_total() - blk_mig_bytes_transferred();
-}
-
-uint64_t blk_mig_bytes_total(void)
-{
-    BlkMigDevState *bmds;
-    uint64_t sum = 0;
-
-    QSIMPLEQ_FOREACH(bmds, &block_mig_state.bmds_list, entry) {
-        sum += bmds->total_sectors;
-    }
-    return sum << BDRV_SECTOR_BITS;
-}
-
-
-/* Called with migration lock held.  */
-
-static int bmds_aio_inflight(BlkMigDevState *bmds, int64_t sector)
-{
-    int64_t chunk = sector / (int64_t)BDRV_SECTORS_PER_DIRTY_CHUNK;
-
-    if (sector < bmds->total_sectors) {
-        return !!(bmds->aio_bitmap[chunk / (sizeof(unsigned long) * 8)] &
-            (1UL << (chunk % (sizeof(unsigned long) * 8))));
-    } else {
-        return 0;
-    }
-}
-
-/* Called with migration lock held.  */
-
-static void bmds_set_aio_inflight(BlkMigDevState *bmds, int64_t sector_num,
-                             int nb_sectors, int set)
-{
-    int64_t start, end;
-    unsigned long val, idx, bit;
-
-    start = sector_num / BDRV_SECTORS_PER_DIRTY_CHUNK;
-    end = (sector_num + nb_sectors - 1) / BDRV_SECTORS_PER_DIRTY_CHUNK;
-
-    for (; start <= end; start++) {
-        idx = start / (sizeof(unsigned long) * 8);
-        bit = start % (sizeof(unsigned long) * 8);
-        val = bmds->aio_bitmap[idx];
-        if (set) {
-            val |= 1UL << bit;
-        } else {
-            val &= ~(1UL << bit);
-        }
-        bmds->aio_bitmap[idx] = val;
-    }
-}
-
-static void alloc_aio_bitmap(BlkMigDevState *bmds)
-{
-    int64_t bitmap_size;
-
-    bitmap_size = bmds->total_sectors + BDRV_SECTORS_PER_DIRTY_CHUNK * 8 - 1;
-    bitmap_size /= BDRV_SECTORS_PER_DIRTY_CHUNK * 8;
-
-    bmds->aio_bitmap = g_malloc0(bitmap_size);
-}
-
-/* Never hold migration lock when yielding to the main loop!  */
-
-static void blk_mig_read_cb(void *opaque, int ret)
-{
-    BlkMigBlock *blk = opaque;
-
-    blk_mig_lock();
-    blk->ret = ret;
-
-    QSIMPLEQ_INSERT_TAIL(&block_mig_state.blk_list, blk, entry);
-    bmds_set_aio_inflight(blk->bmds, blk->sector, blk->nr_sectors, 0);
-
-    block_mig_state.submitted--;
-    block_mig_state.read_done++;
-    assert(block_mig_state.submitted >= 0);
-    blk_mig_unlock();
-}
-
-/* Called with no lock taken.  */
-
-static int mig_save_device_bulk(QEMUFile *f, BlkMigDevState *bmds)
-{
-    int64_t total_sectors = bmds->total_sectors;
-    int64_t cur_sector = bmds->cur_sector;
-    BlockBackend *bb = bmds->blk;
-    BlkMigBlock *blk;
-    int nr_sectors;
-    int64_t count;
-
-    if (bmds->shared_base) {
-        qemu_mutex_lock_iothread();
-        aio_context_acquire(blk_get_aio_context(bb));
-        /* Skip unallocated sectors; intentionally treats failure or
-         * partial sector as an allocated sector */
-        while (cur_sector < total_sectors &&
-               !bdrv_is_allocated(blk_bs(bb), cur_sector * BDRV_SECTOR_SIZE,
-                                  MAX_IS_ALLOCATED_SEARCH, &count)) {
-            if (count < BDRV_SECTOR_SIZE) {
-                break;
-            }
-            cur_sector += count >> BDRV_SECTOR_BITS;
-        }
-        aio_context_release(blk_get_aio_context(bb));
-        qemu_mutex_unlock_iothread();
-    }
-
-    if (cur_sector >= total_sectors) {
-        bmds->cur_sector = bmds->completed_sectors = total_sectors;
-        return 1;
-    }
-
-    bmds->completed_sectors = cur_sector;
-
-    cur_sector &= ~((int64_t)BDRV_SECTORS_PER_DIRTY_CHUNK - 1);
-
-    /* we are going to transfer a full block even if it is not allocated */
-    nr_sectors = BDRV_SECTORS_PER_DIRTY_CHUNK;
-
-    if (total_sectors - cur_sector < BDRV_SECTORS_PER_DIRTY_CHUNK) {
-        nr_sectors = total_sectors - cur_sector;
-    }
-
-    blk = g_new(BlkMigBlock, 1);
-    blk->buf = g_malloc(BLK_MIG_BLOCK_SIZE);
-    blk->bmds = bmds;
-    blk->sector = cur_sector;
-    blk->nr_sectors = nr_sectors;
-
-    qemu_iovec_init_buf(&blk->qiov, blk->buf, nr_sectors * BDRV_SECTOR_SIZE);
-
-    blk_mig_lock();
-    block_mig_state.submitted++;
-    blk_mig_unlock();
-
-    /* We do not know if bs is under the main thread (and thus does
-     * not acquire the AioContext when doing AIO) or rather under
-     * dataplane.  Thus acquire both the iothread mutex and the
-     * AioContext.
-     *
-     * This is ugly and will disappear when we make bdrv_* thread-safe,
-     * without the need to acquire the AioContext.
-     */
-    qemu_mutex_lock_iothread();
-    aio_context_acquire(blk_get_aio_context(bmds->blk));
-    bdrv_reset_dirty_bitmap(bmds->dirty_bitmap, cur_sector * BDRV_SECTOR_SIZE,
-                            nr_sectors * BDRV_SECTOR_SIZE);
-    blk->aiocb = blk_aio_preadv(bb, cur_sector * BDRV_SECTOR_SIZE, &blk->qiov,
-                                0, blk_mig_read_cb, blk);
-    aio_context_release(blk_get_aio_context(bmds->blk));
-    qemu_mutex_unlock_iothread();
-
-    bmds->cur_sector = cur_sector + nr_sectors;
-    return (bmds->cur_sector >= total_sectors);
-}
-
-/* Called with iothread lock taken.  */
-
-static int set_dirty_tracking(void)
-{
-    BlkMigDevState *bmds;
-    int ret;
-
-    QSIMPLEQ_FOREACH(bmds, &block_mig_state.bmds_list, entry) {
-        bmds->dirty_bitmap = bdrv_create_dirty_bitmap(blk_bs(bmds->blk),
-                                                      BLK_MIG_BLOCK_SIZE,
-                                                      NULL, NULL);
-        if (!bmds->dirty_bitmap) {
-            ret = -errno;
-            goto fail;
-        }
-    }
-    return 0;
-
-fail:
-    QSIMPLEQ_FOREACH(bmds, &block_mig_state.bmds_list, entry) {
-        if (bmds->dirty_bitmap) {
-            bdrv_release_dirty_bitmap(bmds->dirty_bitmap);
-        }
-    }
-    return ret;
-}
-
-/* Called with iothread lock taken.  */
-
-static void unset_dirty_tracking(void)
-{
-    BlkMigDevState *bmds;
-
-    QSIMPLEQ_FOREACH(bmds, &block_mig_state.bmds_list, entry) {
-        if (bmds->dirty_bitmap) {
-            bdrv_release_dirty_bitmap(bmds->dirty_bitmap);
-        }
-    }
-}
-
-static int init_blk_migration(QEMUFile *f)
-{
-    BlockDriverState *bs;
-    BlkMigDevState *bmds;
-    int64_t sectors;
-    BdrvNextIterator it;
-    int i, num_bs = 0;
-    struct {
-        BlkMigDevState *bmds;
-        BlockDriverState *bs;
-    } *bmds_bs;
-    Error *local_err = NULL;
-    int ret;
-
-    block_mig_state.submitted = 0;
-    block_mig_state.read_done = 0;
-    block_mig_state.transferred = 0;
-    block_mig_state.total_sector_sum = 0;
-    block_mig_state.prev_progress = -1;
-    block_mig_state.bulk_completed = 0;
-    block_mig_state.zero_blocks = migrate_zero_blocks();
-
-    for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
-        num_bs++;
-    }
-    bmds_bs = g_malloc0(num_bs * sizeof(*bmds_bs));
-
-    for (i = 0, bs = bdrv_first(&it); bs; bs = bdrv_next(&it), i++) {
-        if (bdrv_is_read_only(bs)) {
-            continue;
-        }
-
-        sectors = bdrv_nb_sectors(bs);
-        if (sectors <= 0) {
-            ret = sectors;
-            bdrv_next_cleanup(&it);
-            goto out;
-        }
-
-        bmds = g_new0(BlkMigDevState, 1);
-        bmds->blk = blk_new(qemu_get_aio_context(),
-                            BLK_PERM_CONSISTENT_READ, BLK_PERM_ALL);
-        bmds->blk_name = g_strdup(bdrv_get_device_name(bs));
-        bmds->bulk_completed = 0;
-        bmds->total_sectors = sectors;
-        bmds->completed_sectors = 0;
-        bmds->shared_base = false;
-
-        assert(i < num_bs);
-        bmds_bs[i].bmds = bmds;
-        bmds_bs[i].bs = bs;
-
-        block_mig_state.total_sector_sum += sectors;
-
-        if (bmds->shared_base) {
-            trace_migration_block_init_shared(bdrv_get_device_name(bs));
-        } else {
-            trace_migration_block_init_full(bdrv_get_device_name(bs));
-        }
-
-        QSIMPLEQ_INSERT_TAIL(&block_mig_state.bmds_list, bmds, entry);
-    }
-
-    /* Can only insert new BDSes now because doing so while iterating block
-     * devices may end up in a deadlock (iterating the new BDSes, too). */
-    for (i = 0; i < num_bs; i++) {
-        bmds = bmds_bs[i].bmds;
-        bs = bmds_bs[i].bs;
-
-        if (bmds) {
-            ret = blk_insert_bs(bmds->blk, bs, &local_err);
-            if (ret < 0) {
-                error_report_err(local_err);
-                goto out;
-            }
-
-            alloc_aio_bitmap(bmds);
-            error_setg(&bmds->blocker, "block device is in use by migration");
-            bdrv_op_block_all(bs, bmds->blocker);
-        }
-    }
-
-    ret = 0;
-out:
-    g_free(bmds_bs);
-    return ret;
-}
-
-/* Called with no lock taken.  */
-
-static int blk_mig_save_bulked_block(QEMUFile *f)
-{
-    int64_t completed_sector_sum = 0;
-    BlkMigDevState *bmds;
-    int progress;
-    int ret = 0;
-
-    QSIMPLEQ_FOREACH(bmds, &block_mig_state.bmds_list, entry) {
-        if (bmds->bulk_completed == 0) {
-            if (mig_save_device_bulk(f, bmds) == 1) {
-                /* completed bulk section for this device */
-                bmds->bulk_completed = 1;
-            }
-            completed_sector_sum += bmds->completed_sectors;
-            ret = 1;
-            break;
-        } else {
-            completed_sector_sum += bmds->completed_sectors;
-        }
-    }
-
-    if (block_mig_state.total_sector_sum != 0) {
-        progress = completed_sector_sum * 100 /
-                   block_mig_state.total_sector_sum;
-    } else {
-        progress = 100;
-    }
-    if (progress != block_mig_state.prev_progress) {
-        block_mig_state.prev_progress = progress;
-        qemu_put_be64(f, (progress << BDRV_SECTOR_BITS)
-                         | BLK_MIG_FLAG_PROGRESS);
-        trace_migration_block_progression(progress);
-    }
-
-    return ret;
-}
-
-static void blk_mig_reset_dirty_cursor(void)
-{
-    BlkMigDevState *bmds;
-
-    QSIMPLEQ_FOREACH(bmds, &block_mig_state.bmds_list, entry) {
-        bmds->cur_dirty = 0;
-    }
-}
-
-/* Called with iothread lock and AioContext taken.  */
-
-static int mig_save_device_dirty(QEMUFile *f, BlkMigDevState *bmds,
-                                 int is_async)
-{
-    BlkMigBlock *blk;
-    int64_t total_sectors = bmds->total_sectors;
-    int64_t sector;
-    int nr_sectors;
-    int ret = -EIO;
-
-    for (sector = bmds->cur_dirty; sector < bmds->total_sectors;) {
-        blk_mig_lock();
-        if (bmds_aio_inflight(bmds, sector)) {
-            blk_mig_unlock();
-            blk_drain(bmds->blk);
-        } else {
-            blk_mig_unlock();
-        }
-        bdrv_dirty_bitmap_lock(bmds->dirty_bitmap);
-        if (bdrv_dirty_bitmap_get_locked(bmds->dirty_bitmap,
-                                         sector * BDRV_SECTOR_SIZE)) {
-            if (total_sectors - sector < BDRV_SECTORS_PER_DIRTY_CHUNK) {
-                nr_sectors = total_sectors - sector;
-            } else {
-                nr_sectors = BDRV_SECTORS_PER_DIRTY_CHUNK;
-            }
-            bdrv_reset_dirty_bitmap_locked(bmds->dirty_bitmap,
-                                           sector * BDRV_SECTOR_SIZE,
-                                           nr_sectors * BDRV_SECTOR_SIZE);
-            bdrv_dirty_bitmap_unlock(bmds->dirty_bitmap);
-
-            blk = g_new(BlkMigBlock, 1);
-            blk->buf = g_malloc(BLK_MIG_BLOCK_SIZE);
-            blk->bmds = bmds;
-            blk->sector = sector;
-            blk->nr_sectors = nr_sectors;
-
-            if (is_async) {
-                qemu_iovec_init_buf(&blk->qiov, blk->buf,
-                                    nr_sectors * BDRV_SECTOR_SIZE);
-
-                blk->aiocb = blk_aio_preadv(bmds->blk,
-                                            sector * BDRV_SECTOR_SIZE,
-                                            &blk->qiov, 0, blk_mig_read_cb,
-                                            blk);
-
-                blk_mig_lock();
-                block_mig_state.submitted++;
-                bmds_set_aio_inflight(bmds, sector, nr_sectors, 1);
-                blk_mig_unlock();
-            } else {
-                ret = blk_pread(bmds->blk, sector * BDRV_SECTOR_SIZE,
-                                nr_sectors * BDRV_SECTOR_SIZE, blk->buf, 0);
-                if (ret < 0) {
-                    goto error;
-                }
-                blk_send(f, blk);
-
-                g_free(blk->buf);
-                g_free(blk);
-            }
-
-            sector += nr_sectors;
-            bmds->cur_dirty = sector;
-            break;
-        }
-
-        bdrv_dirty_bitmap_unlock(bmds->dirty_bitmap);
-        sector += BDRV_SECTORS_PER_DIRTY_CHUNK;
-        bmds->cur_dirty = sector;
-    }
-
-    return (bmds->cur_dirty >= bmds->total_sectors);
-
-error:
-    trace_migration_block_save_device_dirty(sector);
-    g_free(blk->buf);
-    g_free(blk);
-    return ret;
-}
-
-/* Called with iothread lock taken.
- *
- * return value:
- * 0: too much data for max_downtime
- * 1: few enough data for max_downtime
-*/
-static int blk_mig_save_dirty_block(QEMUFile *f, int is_async)
-{
-    BlkMigDevState *bmds;
-    int ret = 1;
-
-    QSIMPLEQ_FOREACH(bmds, &block_mig_state.bmds_list, entry) {
-        aio_context_acquire(blk_get_aio_context(bmds->blk));
-        ret = mig_save_device_dirty(f, bmds, is_async);
-        aio_context_release(blk_get_aio_context(bmds->blk));
-        if (ret <= 0) {
-            break;
-        }
-    }
-
-    return ret;
-}
-
-/* Called with no locks taken.  */
-
-static int flush_blks(QEMUFile *f)
-{
-    BlkMigBlock *blk;
-    int ret = 0;
-
-    trace_migration_block_flush_blks("Enter", block_mig_state.submitted,
-                                     block_mig_state.read_done,
-                                     block_mig_state.transferred);
-
-    blk_mig_lock();
-    while ((blk = QSIMPLEQ_FIRST(&block_mig_state.blk_list)) != NULL) {
-        if (migration_rate_exceeded(f)) {
-            break;
-        }
-        if (blk->ret < 0) {
-            ret = blk->ret;
-            break;
-        }
-
-        QSIMPLEQ_REMOVE_HEAD(&block_mig_state.blk_list, entry);
-        blk_mig_unlock();
-        blk_send(f, blk);
-        blk_mig_lock();
-
-        g_free(blk->buf);
-        g_free(blk);
-
-        block_mig_state.read_done--;
-        block_mig_state.transferred++;
-        assert(block_mig_state.read_done >= 0);
-    }
-    blk_mig_unlock();
-
-    trace_migration_block_flush_blks("Exit", block_mig_state.submitted,
-                                     block_mig_state.read_done,
-                                     block_mig_state.transferred);
-    return ret;
-}
-
-/* Called with iothread lock taken.  */
-
-static int64_t get_remaining_dirty(void)
-{
-    BlkMigDevState *bmds;
-    int64_t dirty = 0;
-
-    QSIMPLEQ_FOREACH(bmds, &block_mig_state.bmds_list, entry) {
-        aio_context_acquire(blk_get_aio_context(bmds->blk));
-        dirty += bdrv_get_dirty_count(bmds->dirty_bitmap);
-        aio_context_release(blk_get_aio_context(bmds->blk));
-    }
-
-    return dirty;
-}
-
-
-
-/* Called with iothread lock taken.  */
-static void block_migration_cleanup_bmds(void)
-{
-    BlkMigDevState *bmds;
-    BlockDriverState *bs;
-    AioContext *ctx;
-
-    unset_dirty_tracking();
-
-    while ((bmds = QSIMPLEQ_FIRST(&block_mig_state.bmds_list)) != NULL) {
-        QSIMPLEQ_REMOVE_HEAD(&block_mig_state.bmds_list, entry);
-
-        bs = blk_bs(bmds->blk);
-        if (bs) {
-            bdrv_op_unblock_all(bs, bmds->blocker);
-        }
-        error_free(bmds->blocker);
-
-        /* Save ctx, because bmds->blk can disappear during blk_unref.  */
-        ctx = blk_get_aio_context(bmds->blk);
-        aio_context_acquire(ctx);
-        blk_unref(bmds->blk);
-        aio_context_release(ctx);
-
-        g_free(bmds->blk_name);
-        g_free(bmds->aio_bitmap);
-        g_free(bmds);
-    }
-}
-
-/* Called with iothread lock taken.  */
-static void block_migration_cleanup(void *opaque)
-{
-    BlkMigBlock *blk;
-
-    bdrv_drain_all();
-
-    block_migration_cleanup_bmds();
-
-    blk_mig_lock();
-    while ((blk = QSIMPLEQ_FIRST(&block_mig_state.blk_list)) != NULL) {
-        QSIMPLEQ_REMOVE_HEAD(&block_mig_state.blk_list, entry);
-        g_free(blk->buf);
-        g_free(blk);
-    }
-    blk_mig_unlock();
-}
-
-static int block_save_setup(QEMUFile *f, void *opaque)
-{
-    int ret;
-
-    trace_migration_block_save("setup", block_mig_state.submitted,
-                               block_mig_state.transferred);
-
-    warn_report("block migration is deprecated.  Use blockdev-mirror with"
-                "NBD instead.");
-
-    qemu_mutex_lock_iothread();
-    ret = init_blk_migration(f);
-    if (ret < 0) {
-        qemu_mutex_unlock_iothread();
-        return ret;
-    }
-
-    /* start track dirty blocks */
-    ret = set_dirty_tracking();
-
-    qemu_mutex_unlock_iothread();
-
-    if (ret) {
-        return ret;
-    }
-
-    ret = flush_blks(f);
-    blk_mig_reset_dirty_cursor();
-    qemu_put_be64(f, BLK_MIG_FLAG_EOS);
-
-    return ret;
-}
-
-static int block_save_iterate(QEMUFile *f, void *opaque)
-{
-    int ret;
-    uint64_t last_bytes = qemu_file_transferred_noflush(f);
-
-    trace_migration_block_save("iterate", block_mig_state.submitted,
-                               block_mig_state.transferred);
-
-    ret = flush_blks(f);
-    if (ret) {
-        return ret;
-    }
-
-    blk_mig_reset_dirty_cursor();
-
-    /* control the rate of transfer */
-    blk_mig_lock();
-    while (block_mig_state.read_done * BLK_MIG_BLOCK_SIZE <
-           migration_rate_get() &&
-           block_mig_state.submitted < MAX_PARALLEL_IO &&
-           (block_mig_state.submitted + block_mig_state.read_done) <
-           MAX_IO_BUFFERS) {
-        blk_mig_unlock();
-        if (block_mig_state.bulk_completed == 0) {
-            /* first finish the bulk phase */
-            if (blk_mig_save_bulked_block(f) == 0) {
-                /* finished saving bulk on all devices */
-                block_mig_state.bulk_completed = 1;
-            }
-            ret = 0;
-        } else {
-            /* Always called with iothread lock taken for
-             * simplicity, block_save_complete also calls it.
-             */
-            qemu_mutex_lock_iothread();
-            ret = blk_mig_save_dirty_block(f, 1);
-            qemu_mutex_unlock_iothread();
-        }
-        if (ret < 0) {
-            return ret;
-        }
-        blk_mig_lock();
-        if (ret != 0) {
-            /* no more dirty blocks */
-            break;
-        }
-    }
-    blk_mig_unlock();
-
-    ret = flush_blks(f);
-    if (ret) {
-        return ret;
-    }
-
-    qemu_put_be64(f, BLK_MIG_FLAG_EOS);
-    uint64_t delta_bytes = qemu_file_transferred_noflush(f) - last_bytes;
-    return (delta_bytes > 0);
-}
-
-/* Called with iothread lock taken.  */
-
-static int block_save_complete(QEMUFile *f, void *opaque)
-{
-    int ret;
-
-    trace_migration_block_save("complete", block_mig_state.submitted,
-                               block_mig_state.transferred);
-
-    ret = flush_blks(f);
-    if (ret) {
-        return ret;
-    }
-
-    blk_mig_reset_dirty_cursor();
-
-    /* we know for sure that save bulk is completed and
-       all async read completed */
-    blk_mig_lock();
-    assert(block_mig_state.submitted == 0);
-    blk_mig_unlock();
-
-    do {
-        ret = blk_mig_save_dirty_block(f, 0);
-        if (ret < 0) {
-            return ret;
-        }
-    } while (ret == 0);
-
-    /* report completion */
-    qemu_put_be64(f, (100 << BDRV_SECTOR_BITS) | BLK_MIG_FLAG_PROGRESS);
-
-    trace_migration_block_save_complete();
-
-    qemu_put_be64(f, BLK_MIG_FLAG_EOS);
-
-    /* Make sure that our BlockBackends are gone, so that the block driver
-     * nodes can be inactivated. */
-    block_migration_cleanup_bmds();
-
-    return 0;
-}
-
-static void block_state_pending(void *opaque, uint64_t *must_precopy,
-                                uint64_t *can_postcopy)
-{
-    /* Estimate pending number of bytes to send */
-    uint64_t pending;
-
-    qemu_mutex_lock_iothread();
-    pending = get_remaining_dirty();
-    qemu_mutex_unlock_iothread();
-
-    blk_mig_lock();
-    pending += block_mig_state.submitted * BLK_MIG_BLOCK_SIZE +
-               block_mig_state.read_done * BLK_MIG_BLOCK_SIZE;
-    blk_mig_unlock();
-
-    /* Report at least one block pending during bulk phase */
-    if (!pending && !block_mig_state.bulk_completed) {
-        pending = BLK_MIG_BLOCK_SIZE;
-    }
-
-    trace_migration_block_state_pending(pending);
-    /* We don't do postcopy */
-    *must_precopy += pending;
-}
-
-static int block_load(QEMUFile *f, void *opaque, int version_id)
-{
-    static int banner_printed;
-    int len, flags;
-    char device_name[256];
-    int64_t addr;
-    BlockBackend *blk, *blk_prev = NULL;
-    Error *local_err = NULL;
-    uint8_t *buf;
-    int64_t total_sectors = 0;
-    int nr_sectors;
-    int ret;
-    BlockDriverInfo bdi;
-    int cluster_size = BLK_MIG_BLOCK_SIZE;
-
-    do {
-        addr = qemu_get_be64(f);
-
-        flags = addr & (BDRV_SECTOR_SIZE - 1);
-        addr >>= BDRV_SECTOR_BITS;
-
-        if (flags & BLK_MIG_FLAG_DEVICE_BLOCK) {
-            /* get device name */
-            len = qemu_get_byte(f);
-            qemu_get_buffer(f, (uint8_t *)device_name, len);
-            device_name[len] = '\0';
-
-            blk = blk_by_name(device_name);
-            if (!blk) {
-                fprintf(stderr, "Error unknown block device %s\n",
-                        device_name);
-                return -EINVAL;
-            }
-
-            if (blk != blk_prev) {
-                blk_prev = blk;
-                total_sectors = blk_nb_sectors(blk);
-                if (total_sectors <= 0) {
-                    error_report("Error getting length of block device %s",
-                                 device_name);
-                    return -EINVAL;
-                }
-
-                blk_activate(blk, &local_err);
-                if (local_err) {
-                    error_report_err(local_err);
-                    return -EINVAL;
-                }
-
-                ret = bdrv_get_info(blk_bs(blk), &bdi);
-                if (ret == 0 && bdi.cluster_size > 0 &&
-                    bdi.cluster_size <= BLK_MIG_BLOCK_SIZE &&
-                    BLK_MIG_BLOCK_SIZE % bdi.cluster_size == 0) {
-                    cluster_size = bdi.cluster_size;
-                } else {
-                    cluster_size = BLK_MIG_BLOCK_SIZE;
-                }
-            }
-
-            if (total_sectors - addr < BDRV_SECTORS_PER_DIRTY_CHUNK) {
-                nr_sectors = total_sectors - addr;
-            } else {
-                nr_sectors = BDRV_SECTORS_PER_DIRTY_CHUNK;
-            }
-
-            if (flags & BLK_MIG_FLAG_ZERO_BLOCK) {
-                ret = blk_pwrite_zeroes(blk, addr * BDRV_SECTOR_SIZE,
-                                        nr_sectors * BDRV_SECTOR_SIZE,
-                                        BDRV_REQ_MAY_UNMAP);
-            } else {
-                int i;
-                int64_t cur_addr;
-                uint8_t *cur_buf;
-
-                buf = g_malloc(BLK_MIG_BLOCK_SIZE);
-                qemu_get_buffer(f, buf, BLK_MIG_BLOCK_SIZE);
-                for (i = 0; i < BLK_MIG_BLOCK_SIZE / cluster_size; i++) {
-                    cur_addr = addr * BDRV_SECTOR_SIZE + i * cluster_size;
-                    cur_buf = buf + i * cluster_size;
-
-                    if ((!block_mig_state.zero_blocks ||
-                        cluster_size < BLK_MIG_BLOCK_SIZE) &&
-                        buffer_is_zero(cur_buf, cluster_size)) {
-                        ret = blk_pwrite_zeroes(blk, cur_addr,
-                                                cluster_size,
-                                                BDRV_REQ_MAY_UNMAP);
-                    } else {
-                        ret = blk_pwrite(blk, cur_addr, cluster_size, cur_buf,
-                                         0);
-                    }
-                    if (ret < 0) {
-                        break;
-                    }
-                }
-                g_free(buf);
-            }
-
-            if (ret < 0) {
-                return ret;
-            }
-        } else if (flags & BLK_MIG_FLAG_PROGRESS) {
-            if (!banner_printed) {
-                printf("Receiving block device images\n");
-                banner_printed = 1;
-            }
-            printf("Completed %d %%%c", (int)addr,
-                   (addr == 100) ? '\n' : '\r');
-            fflush(stdout);
-        } else if (!(flags & BLK_MIG_FLAG_EOS)) {
-            fprintf(stderr, "Unknown block migration flags: 0x%x\n", flags);
-            return -EINVAL;
-        }
-        ret = qemu_file_get_error(f);
-        if (ret != 0) {
-            return ret;
-        }
-    } while (!(flags & BLK_MIG_FLAG_EOS));
-
-    return 0;
-}
-
-static bool block_is_active(void *opaque)
-{
-    return migrate_block();
-}
-
-static SaveVMHandlers savevm_block_handlers = {
-    .save_setup = block_save_setup,
-    .save_live_iterate = block_save_iterate,
-    .save_live_complete_precopy = block_save_complete,
-    .state_pending_exact = block_state_pending,
-    .state_pending_estimate = block_state_pending,
-    .load_state = block_load,
-    .save_cleanup = block_migration_cleanup,
-    .is_active = block_is_active,
-};
-
-void blk_mig_init(void)
-{
-    QSIMPLEQ_INIT(&block_mig_state.bmds_list);
-    QSIMPLEQ_INIT(&block_mig_state.blk_list);
-    qemu_mutex_init(&block_mig_state.lock);
-
-    register_savevm_live("block", 0, 1, &savevm_block_handlers,
-                         &block_mig_state);
-}
diff --git a/migration/colo.c b/migration/colo.c
index 72f4f7b37e..9f9cd9d587 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -18,7 +18,6 @@
 #include "qemu-file.h"
 #include "savevm.h"
 #include "migration/colo.h"
-#include "block.h"
 #include "io/channel-buffer.h"
 #include "trace.h"
 #include "qemu/error-report.h"
diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index e6f6785ad3..df5dd79169 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -147,15 +147,6 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
         }
     }
 
-    if (info->disk) {
-        monitor_printf(mon, "transferred disk: %" PRIu64 " kbytes\n",
-                       info->disk->transferred >> 10);
-        monitor_printf(mon, "remaining disk: %" PRIu64 " kbytes\n",
-                       info->disk->remaining >> 10);
-        monitor_printf(mon, "total disk: %" PRIu64 " kbytes\n",
-                       info->disk->total >> 10);
-    }
-
     if (info->xbzrle_cache) {
         monitor_printf(mon, "cache size: %" PRIu64 " bytes\n",
                        info->xbzrle_cache->cache_size);
@@ -685,24 +676,9 @@ static void hmp_migrate_status_cb(void *opaque)
     info = qmp_query_migrate(NULL);
     if (!info->has_status || info->status == MIGRATION_STATUS_ACTIVE ||
         info->status == MIGRATION_STATUS_SETUP) {
-        if (info->disk) {
-            int progress;
-
-            if (info->disk->remaining) {
-                progress = info->disk->transferred * 100 / info->disk->total;
-            } else {
-                progress = 100;
-            }
-
-            monitor_printf(status->mon, "Completed %d %%\r", progress);
-            monitor_flush(status->mon);
-        }
 
         timer_mod(status->timer, qemu_clock_get_ms(QEMU_CLOCK_REALTIME) + 1000);
     } else {
-        if (migrate_block()) {
-            monitor_printf(status->mon, "\n");
-        }
         if (info->error_desc) {
             error_report("%s", info->error_desc);
         }
@@ -717,19 +693,11 @@ static void hmp_migrate_status_cb(void *opaque)
 void hmp_migrate(Monitor *mon, const QDict *qdict)
 {
     bool detach = qdict_get_try_bool(qdict, "detach", false);
-    bool blk = qdict_get_try_bool(qdict, "blk", false);
     bool resume = qdict_get_try_bool(qdict, "resume", false);
     const char *uri = qdict_get_str(qdict, "uri");
     Error *err = NULL;
 
-    if (blk) {
-        monitor_printf(mon, "-b migrate option is deprecated, set the "
-                       "'block' capability to 'true' instead.\n");
-        return;
-    }
-
-    qmp_migrate(uri, false, false,
-                false, false, true, resume, &err);
+    qmp_migrate(uri, false, false, true, resume, &err);
     if (hmp_handle_error(mon, err)) {
         return;
     }
diff --git a/migration/migration.c b/migration/migration.c
index d587c8f5b8..a8e9049391 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -46,7 +46,6 @@
 #include "qapi/qmp/qerror.h"
 #include "qapi/qmp/qnull.h"
 #include "qemu/rcu.h"
-#include "block.h"
 #include "postcopy-ram.h"
 #include "qemu/thread.h"
 #include "trace.h"
@@ -160,7 +159,6 @@ void migration_object_init(void)
 
     migration_object_check(current_migration, &error_fatal);
 
-    blk_mig_init();
     ram_mig_init();
     dirty_bitmap_mig_init();
 }
@@ -994,16 +992,6 @@ static void populate_ram_info(MigrationInfo *info, MigrationState *s)
     }
 }
 
-static void populate_disk_info(MigrationInfo *info)
-{
-    if (blk_mig_active()) {
-        info->disk = g_malloc0(sizeof(*info->disk));
-        info->disk->transferred = blk_mig_bytes_transferred();
-        info->disk->remaining = blk_mig_bytes_remaining();
-        info->disk->total = blk_mig_bytes_total();
-    }
-}
-
 static void fill_source_migration_info(MigrationInfo *info)
 {
     MigrationState *s = migrate_get_current();
@@ -1046,7 +1034,6 @@ static void fill_source_migration_info(MigrationInfo *info)
         /* TODO add some postcopy stats */
         populate_time_info(info, s);
         populate_ram_info(info, s);
-        populate_disk_info(info);
         migration_populate_vfio_info(info);
         break;
     case MIGRATION_STATUS_COLO:
@@ -1595,15 +1582,8 @@ bool migration_is_blocked(Error **errp)
 }
 
 /* Returns true if continue to migrate, or false if error detected */
-static bool migrate_prepare(MigrationState *s, bool blk,
-                            bool resume, Error **errp)
+static bool migrate_prepare(MigrationState *s, bool resume, Error **errp)
 {
-    if (blk) {
-        error_setg(errp, "@blk/-i migrate option is deprecated, set the "
-                   "'block' capability to 'true' instead.");
-        return false;
-    }
-
     if (resume) {
         if (s->state != MIGRATION_STATUS_POSTCOPY_PAUSED) {
             error_setg(errp, "Cannot resume if there is no "
@@ -1660,8 +1640,7 @@ static bool migrate_prepare(MigrationState *s, bool blk,
     return true;
 }
 
-void qmp_migrate(const char *uri, bool has_blk, bool blk,
-                 bool has_detach, bool detach,
+void qmp_migrate(const char *uri, bool has_detach, bool detach,
                  bool has_resume, bool resume, Error **errp)
 {
     bool resume_requested;
@@ -1675,8 +1654,7 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
     }
 
     resume_requested = has_resume && resume;
-    if (!migrate_prepare(s, has_blk && blk,
-                         resume_requested, errp)) {
+    if (!migrate_prepare(s, resume_requested, errp)) {
         /* Error detected, put into errp */
         return;
     }
diff --git a/migration/options.c b/migration/options.c
index a4defb4e63..31f180679c 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -187,7 +187,6 @@ Property migration_properties[] = {
                         MIGRATION_CAPABILITY_POSTCOPY_PREEMPT),
     DEFINE_PROP_MIG_CAP("x-colo", MIGRATION_CAPABILITY_X_COLO),
     DEFINE_PROP_MIG_CAP("x-release-ram", MIGRATION_CAPABILITY_RELEASE_RAM),
-    DEFINE_PROP_MIG_CAP("x-block", MIGRATION_CAPABILITY_BLOCK),
     DEFINE_PROP_MIG_CAP("x-return-path", MIGRATION_CAPABILITY_RETURN_PATH),
     DEFINE_PROP_MIG_CAP("x-multifd", MIGRATION_CAPABILITY_MULTIFD),
     DEFINE_PROP_MIG_CAP("x-background-snapshot",
@@ -216,13 +215,6 @@ bool migrate_background_snapshot(void)
     return s->capabilities[MIGRATION_CAPABILITY_BACKGROUND_SNAPSHOT];
 }
 
-bool migrate_block(void)
-{
-    MigrationState *s = migrate_get_current();
-
-    return s->capabilities[MIGRATION_CAPABILITY_BLOCK];
-}
-
 bool migrate_colo(void)
 {
     MigrationState *s = migrate_get_current();
@@ -461,19 +453,6 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
     MigrationIncomingState *mis = migration_incoming_get_current();
 
     ERRP_GUARD();
-#ifndef CONFIG_LIVE_BLOCK_MIGRATION
-    if (new_caps[MIGRATION_CAPABILITY_BLOCK]) {
-        error_setg(errp, "QEMU compiled without old-style (blk/-b, inc/-i) "
-                   "block migration");
-        error_append_hint(errp, "Use blockdev-mirror with NBD instead.\n");
-        return false;
-    }
-#endif
-    if (new_caps[MIGRATION_CAPABILITY_BLOCK]) {
-        warn_report("Block migration is deprecated. "
-                    "Use blockdev-mirror with NBD instead.");
-    }
-
     if (new_caps[MIGRATION_CAPABILITY_COMPRESS]) {
         warn_report("Old compression method is deprecated. "
                     "Use multifd compression methods instead.");
@@ -630,11 +609,6 @@ MigrationCapabilityStatusList *qmp_query_migrate_capabilities(Error **errp)
     int i;
 
     for (i = 0; i < MIGRATION_CAPABILITY__MAX; i++) {
-#ifndef CONFIG_LIVE_BLOCK_MIGRATION
-        if (i == MIGRATION_CAPABILITY_BLOCK) {
-            continue;
-        }
-#endif
         caps = g_malloc0(sizeof(*caps));
         caps->capability = i;
         caps->state = s->capabilities[i];
diff --git a/migration/ram.c b/migration/ram.c
index 2f5ce4d60b..d797243a68 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -53,7 +53,6 @@
 #include "exec/target_page.h"
 #include "qemu/rcu_queue.h"
 #include "migration/colo.h"
-#include "block.h"
 #include "sysemu/cpu-throttle.h"
 #include "savevm.h"
 #include "qemu/iov.h"
@@ -1034,13 +1033,6 @@ static void migration_trigger_throttle(RAMState *rs)
     uint64_t bytes_dirty_period = rs->num_dirty_pages_period * TARGET_PAGE_SIZE;
     uint64_t bytes_dirty_threshold = bytes_xfer_period * threshold / 100;
 
-    /* During block migration the auto-converge logic incorrectly detects
-     * that ram migration makes no progress. Avoid this by disabling the
-     * throttling logic during the bulk phase of block migration. */
-    if (blk_mig_bulk_active()) {
-        return;
-    }
-
     /*
      * The following detection logic can be refined later. For now:
      * Check to see if the ratio between dirtied bytes and the approx.
@@ -3099,13 +3091,6 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
     int64_t t0;
     int done = 0;
 
-    if (blk_mig_bulk_active()) {
-        /* Avoid transferring ram during bulk phase of block migration as
-         * the bulk phase will usually take a long time and transferring
-         * ram updates during that time is pointless. */
-        goto out;
-    }
-
     /*
      * We'll take this lock a little bit long, but it's okay for two reasons.
      * Firstly, the only possible other thread to take it is who calls
@@ -3181,7 +3166,6 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
      */
     ram_control_after_iterate(f, RAM_CONTROL_ROUND);
 
-out:
     if (ret >= 0
         && migration_is_setup_or_active(migrate_get_current()->state)) {
         if (migrate_multifd_flush_after_each_section()) {
diff --git a/migration/savevm.c b/migration/savevm.c
index 497ce02bd7..11d69afee2 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1649,11 +1649,6 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
         return -EINVAL;
     }
 
-    if (migrate_block()) {
-        error_setg(errp, "Block migration and snapshots are incompatible");
-        return -EINVAL;
-    }
-
     ret = migrate_init(ms, errp);
     if (ret) {
         return ret;
diff --git a/hmp-commands.hx b/hmp-commands.hx
index ce26057e85..c56086266e 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -920,21 +920,17 @@ ERST
 
     {
         .name       = "migrate",
-        .args_type  = "detach:-d,blk:-b,resume:-r,uri:s",
-        .params     = "[-d] [-b] [-r] uri",
+        .args_type  = "detach:-d,resume:-r,uri:s",
+        .params     = "[-d] [-r] uri",
         .help       = "migrate to URI (using -d to not wait for completion)"
-		      "\n\t\t\t -b for migration without shared storage with"
-		      " full copy of disk\n\t\t\t -r to resume a paused migration",
+		      "\n\t\t\t -r to resume a paused migration",
         .cmd        = hmp_migrate,
     },
 
 
 SRST
-``migrate [-d] [-b]`` *uri*
+``migrate [-d]`` *uri*
   Migrate to *uri* (using -d to not wait for completion).
-
-  ``-b``
-    for migration with full copy of disk
 ERST
 
     {
diff --git a/migration/meson.build b/migration/meson.build
index 92b1cc4297..af7350a21b 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -36,9 +36,6 @@ if get_option('replication').allowed()
 endif
 
 system_ss.add(when: rdma, if_true: files('rdma.c'))
-if get_option('live_block_migration').allowed()
-  system_ss.add(files('block.c'))
-endif
 system_ss.add(when: zstd, if_true: files('multifd-zstd.c'))
 
 specific_ss.add(when: 'CONFIG_SYSTEM_ONLY',
-- 
2.41.0


