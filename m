Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7365A8A6EB9
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Apr 2024 16:46:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwk4S-0007zR-Cf; Tue, 16 Apr 2024 10:46:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1rwk3z-0006o1-Bt
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 10:45:36 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1rwk3v-0002p9-8r
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 10:45:34 -0400
Received: from MUA by vps-vb.mhejs.net with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <mail@maciej.szmigiero.name>)
 id 1rwk3o-0002kD-Ax; Tue, 16 Apr 2024 16:45:24 +0200
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH RFC 25/26] vfio/migration: Multifd device state transfer
 support - receive side
Date: Tue, 16 Apr 2024 16:43:04 +0200
Message-ID: <6a89d23f1fb5ec7da16a1116c6a36bb23ac15954.1713269378.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1713269378.git.maciej.szmigiero@oracle.com>
References: <cover.1713269378.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=37.28.154.113;
 envelope-from=mail@maciej.szmigiero.name; helo=vps-vb.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

The multifd received data needs to be reassembled since device state
packets sent via different multifd channels can arrive out-of-order.

Therefore, each VFIO device state packet carries a header indicating
its position in the stream.

The last such VFIO device state packet should have
VFIO_DEVICE_STATE_CONFIG_STATE flag set and carry the device config
state.

Since it's important to finish loading device state transferred via
the main migration channel (via save_live_iterate handler) before
starting loading the data asynchronously transferred via multifd
a new VFIO_MIG_FLAG_DEV_DATA_STATE_COMPLETE flag is introduced to
mark the end of the main migration channel data.

The device state loading process waits until that flag is seen before
commencing loading of the multifd-transferred device state.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 hw/vfio/migration.c           | 322 +++++++++++++++++++++++++++++++++-
 hw/vfio/trace-events          |   9 +-
 include/hw/vfio/vfio-common.h |  14 ++
 3 files changed, 342 insertions(+), 3 deletions(-)

diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index bc3aea77455c..3af62dea6899 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -15,6 +15,7 @@
 #include <linux/vfio.h>
 #include <sys/ioctl.h>
 
+#include "io/channel-buffer.h"
 #include "sysemu/runstate.h"
 #include "hw/vfio/vfio-common.h"
 #include "migration/misc.h"
@@ -46,6 +47,7 @@
 #define VFIO_MIG_FLAG_DEV_SETUP_STATE   (0xffffffffef100003ULL)
 #define VFIO_MIG_FLAG_DEV_DATA_STATE    (0xffffffffef100004ULL)
 #define VFIO_MIG_FLAG_DEV_INIT_DATA_SENT (0xffffffffef100005ULL)
+#define VFIO_MIG_FLAG_DEV_DATA_STATE_COMPLETE    (0xffffffffef100006ULL)
 
 /*
  * This is an arbitrary size based on migration of mlx5 devices, where typically
@@ -54,6 +56,15 @@
  */
 #define VFIO_MIG_DEFAULT_DATA_BUFFER_SIZE (1 * MiB)
 
+#define VFIO_DEVICE_STATE_CONFIG_STATE (1)
+
+typedef struct VFIODeviceStatePacket {
+    uint32_t version;
+    uint32_t idx;
+    uint32_t flags;
+    uint8_t data[0];
+} QEMU_PACKED VFIODeviceStatePacket;
+
 static int64_t bytes_transferred;
 
 static const char *mig_state_to_str(enum vfio_device_mig_state state)
@@ -186,6 +197,175 @@ static int vfio_load_buffer(QEMUFile *f, VFIODevice *vbasedev,
     return ret;
 }
 
+typedef struct LoadedBuffer {
+    bool is_present;
+    char *data;
+    size_t len;
+} LoadedBuffer;
+
+static void loaded_buffer_clear(gpointer data)
+{
+    LoadedBuffer *lb = data;
+
+    if (!lb->is_present) {
+        return;
+    }
+
+    g_clear_pointer(&lb->data, g_free);
+    lb->is_present = false;
+}
+
+static int vfio_load_state_buffer(void *opaque, char *data, size_t data_size,
+                                  Error **errp)
+{
+    VFIODevice *vbasedev = opaque;
+    VFIOMigration *migration = vbasedev->migration;
+    VFIODeviceStatePacket *packet = (VFIODeviceStatePacket *)data;
+    g_autoptr(GMutexLocker) locker = g_mutex_locker_new(&migration->load_bufs_mutex);
+    LoadedBuffer *lb;
+
+    if (data_size < sizeof(*packet)) {
+        error_setg(errp, "packet too short at %zu (min is %zu)",
+                   data_size, sizeof(*packet));
+        return -1;
+    }
+
+    if (packet->version != 0) {
+        error_setg(errp, "packet has unknown version %" PRIu32,
+                   packet->version);
+        return -1;
+    }
+
+    if (packet->idx == UINT32_MAX) {
+        error_setg(errp, "packet has too high idx %" PRIu32,
+                   packet->idx);
+        return -1;
+    }
+
+    trace_vfio_load_state_device_buffer_incoming(vbasedev->name, packet->idx);
+
+    /* config state packet should be the last one in the stream */
+    if (packet->flags & VFIO_DEVICE_STATE_CONFIG_STATE) {
+        migration->load_buf_idx_last = packet->idx;
+    }
+
+    assert(migration->load_bufs);
+    if (packet->idx >= migration->load_bufs->len) {
+        g_array_set_size(migration->load_bufs, packet->idx + 1);
+    }
+
+    lb = &g_array_index(migration->load_bufs, typeof(*lb), packet->idx);
+    if (lb->is_present) {
+        error_setg(errp, "state buffer %" PRIu32 " already filled", packet->idx);
+        return -1;
+    }
+
+    assert(packet->idx >= migration->load_buf_idx);
+
+    lb->data = g_memdup2(&packet->data, data_size - sizeof(*packet));
+    lb->len = data_size - sizeof(*packet);
+    lb->is_present = true;
+
+    g_cond_broadcast(&migration->load_bufs_buffer_ready_cond);
+
+    return 0;
+}
+
+static void *vfio_load_bufs_thread(void *opaque)
+{
+    VFIODevice *vbasedev = opaque;
+    VFIOMigration *migration = vbasedev->migration;
+    Error **errp = &migration->load_bufs_thread_errp;
+    g_autoptr(GMutexLocker) locker = g_mutex_locker_new(&migration->load_bufs_mutex);
+    LoadedBuffer *lb;
+
+    while (!migration->load_bufs_device_ready &&
+           !migration->load_bufs_thread_want_exit) {
+        g_cond_wait(&migration->load_bufs_device_ready_cond, &migration->load_bufs_mutex);
+    }
+
+    while (!migration->load_bufs_thread_want_exit) {
+        bool starved;
+        ssize_t ret;
+
+        assert(migration->load_buf_idx <= migration->load_buf_idx_last);
+
+        if (migration->load_buf_idx >= migration->load_bufs->len) {
+            assert(migration->load_buf_idx == migration->load_bufs->len);
+            starved = true;
+        } else {
+            lb = &g_array_index(migration->load_bufs, typeof(*lb), migration->load_buf_idx);
+            starved = !lb->is_present;
+        }
+
+        if (starved) {
+            trace_vfio_load_state_device_buffer_starved(vbasedev->name, migration->load_buf_idx);
+            g_cond_wait(&migration->load_bufs_buffer_ready_cond, &migration->load_bufs_mutex);
+            continue;
+        }
+
+        if (migration->load_buf_idx == migration->load_buf_idx_last) {
+            break;
+        }
+
+        if (migration->load_buf_idx == 0) {
+            trace_vfio_load_state_device_buffer_start(vbasedev->name);
+        }
+
+        if (lb->len) {
+            g_autofree char *buf = NULL;
+            size_t buf_len;
+            int errno_save;
+
+            trace_vfio_load_state_device_buffer_load_start(vbasedev->name,
+                                                           migration->load_buf_idx);
+
+            /* lb might become re-allocated when we drop the lock */
+            buf = g_steal_pointer(&lb->data);
+            buf_len = lb->len;
+
+            /* Loading data to the device takes a while, drop the lock during this process */
+            g_clear_pointer(&locker, g_mutex_locker_free);
+            ret = write(migration->data_fd, buf, buf_len);
+            errno_save = errno;
+            locker = g_mutex_locker_new(&migration->load_bufs_mutex);
+
+            if (ret < 0) {
+                error_setg(errp, "write to state buffer %" PRIu32 " failed with %d",
+                           migration->load_buf_idx, errno_save);
+                break;
+            } else if (ret < buf_len) {
+                error_setg(errp, "write to state buffer %" PRIu32 " incomplete %zd / %zu",
+                           migration->load_buf_idx, ret, buf_len);
+                break;
+            }
+
+            trace_vfio_load_state_device_buffer_load_end(vbasedev->name,
+                                                         migration->load_buf_idx);
+        }
+
+        if (migration->load_buf_idx == migration->load_buf_idx_last - 1) {
+            trace_vfio_load_state_device_buffer_end(vbasedev->name);
+        }
+
+        migration->load_buf_idx++;
+    }
+
+    if (migration->load_bufs_thread_want_exit &&
+        !*errp) {
+        error_setg(errp, "load bufs thread asked to quit");
+    }
+
+    g_clear_pointer(&locker, g_mutex_locker_free);
+
+    qemu_loadvm_load_finish_ready_lock();
+    migration->load_bufs_thread_finished = true;
+    qemu_loadvm_load_finish_ready_broadcast();
+    qemu_loadvm_load_finish_ready_unlock();
+
+    return NULL;
+}
+
 static int vfio_save_device_config_state(QEMUFile *f, void *opaque)
 {
     VFIODevice *vbasedev = opaque;
@@ -208,6 +388,8 @@ static int vfio_load_device_config_state(QEMUFile *f, void *opaque)
     VFIODevice *vbasedev = opaque;
     uint64_t data;
 
+    trace_vfio_load_device_config_state_start(vbasedev->name);
+
     if (vbasedev->ops && vbasedev->ops->vfio_load_config) {
         int ret;
 
@@ -226,7 +408,7 @@ static int vfio_load_device_config_state(QEMUFile *f, void *opaque)
         return -EINVAL;
     }
 
-    trace_vfio_load_device_config_state(vbasedev->name);
+    trace_vfio_load_device_config_state_end(vbasedev->name);
     return qemu_file_get_error(f);
 }
 
@@ -596,16 +778,69 @@ static void vfio_save_state(QEMUFile *f, void *opaque)
 static int vfio_load_setup(QEMUFile *f, void *opaque)
 {
     VFIODevice *vbasedev = opaque;
+    VFIOMigration *migration = vbasedev->migration;
+    int ret;
 
-    return vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_RESUMING,
+    ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_RESUMING,
                                    vbasedev->migration->device_state);
+    if (ret) {
+        return ret;
+    }
+
+    assert(!migration->load_bufs);
+    migration->load_bufs = g_array_new(FALSE, TRUE, sizeof(LoadedBuffer));
+    g_array_set_clear_func(migration->load_bufs, loaded_buffer_clear);
+
+    g_mutex_init(&migration->load_bufs_mutex);
+
+    migration->load_bufs_device_ready = false;
+    g_cond_init(&migration->load_bufs_device_ready_cond);
+
+    migration->load_buf_idx = 0;
+    migration->load_buf_idx_last = UINT32_MAX;
+    g_cond_init(&migration->load_bufs_buffer_ready_cond);
+
+    migration->config_state_loaded_to_dev = false;
+
+    assert(!migration->load_bufs_thread_started);
+
+    migration->load_bufs_thread_finished = false;
+    migration->load_bufs_thread_want_exit = false;
+    qemu_thread_create(&migration->load_bufs_thread, "vfio-load-bufs",
+                       vfio_load_bufs_thread, opaque, QEMU_THREAD_JOINABLE);
+
+    migration->load_bufs_thread_started = true;
+
+    return 0;
 }
 
 static int vfio_load_cleanup(void *opaque)
 {
     VFIODevice *vbasedev = opaque;
+    VFIOMigration *migration = vbasedev->migration;
+
+    if (migration->load_bufs_thread_started) {
+        g_mutex_lock(&migration->load_bufs_mutex);
+        migration->load_bufs_thread_want_exit = true;
+        g_mutex_unlock(&migration->load_bufs_mutex);
+
+        g_cond_broadcast(&migration->load_bufs_device_ready_cond);
+        g_cond_broadcast(&migration->load_bufs_buffer_ready_cond);
+
+        qemu_thread_join(&migration->load_bufs_thread);
+
+        assert(migration->load_bufs_thread_finished);
+
+        migration->load_bufs_thread_started = false;
+    }
 
     vfio_migration_cleanup(vbasedev);
+
+    g_clear_pointer(&migration->load_bufs, g_array_unref);
+    g_cond_clear(&migration->load_bufs_buffer_ready_cond);
+    g_cond_clear(&migration->load_bufs_device_ready_cond);
+    g_mutex_clear(&migration->load_bufs_mutex);
+
     trace_vfio_load_cleanup(vbasedev->name);
 
     return 0;
@@ -614,6 +849,7 @@ static int vfio_load_cleanup(void *opaque)
 static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
 {
     VFIODevice *vbasedev = opaque;
+    VFIOMigration *migration = vbasedev->migration;
     int ret = 0;
     uint64_t data;
 
@@ -625,6 +861,7 @@ static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
         switch (data) {
         case VFIO_MIG_FLAG_DEV_CONFIG_STATE:
         {
+            migration->config_state_loaded_to_dev = true;
             return vfio_load_device_config_state(f, opaque);
         }
         case VFIO_MIG_FLAG_DEV_SETUP_STATE:
@@ -651,6 +888,15 @@ static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
             }
             break;
         }
+        case VFIO_MIG_FLAG_DEV_DATA_STATE_COMPLETE:
+        {
+            g_autoptr(GMutexLocker) locker = g_mutex_locker_new(&migration->load_bufs_mutex);
+
+            migration->load_bufs_device_ready = true;
+            g_cond_broadcast(&migration->load_bufs_device_ready_cond);
+
+            break;
+        }
         case VFIO_MIG_FLAG_DEV_INIT_DATA_SENT:
         {
             if (!vfio_precopy_supported(vbasedev) ||
@@ -683,6 +929,76 @@ static int vfio_load_state(QEMUFile *f, void *opaque, int version_id)
     return ret;
 }
 
+static int vfio_load_finish(void *opaque, bool *is_finished, Error **errp)
+{
+    VFIODevice *vbasedev = opaque;
+    VFIOMigration *migration = vbasedev->migration;
+    g_autoptr(GMutexLocker) locker = NULL;
+    LoadedBuffer *lb;
+    g_autoptr(QIOChannelBuffer) bioc = NULL;
+    QEMUFile *f_out = NULL, *f_in = NULL;
+    uint64_t mig_header;
+    int ret;
+
+    if (migration->config_state_loaded_to_dev) {
+        *is_finished = true;
+        return 0;
+    }
+
+    if (!migration->load_bufs_thread_finished) {
+        assert(migration->load_bufs_thread_started);
+        *is_finished = false;
+        return 0;
+    }
+
+    if (migration->load_bufs_thread_errp) {
+        error_propagate(errp, g_steal_pointer(&migration->load_bufs_thread_errp));
+        return -1;
+    }
+
+    locker = g_mutex_locker_new(&migration->load_bufs_mutex);
+
+    assert(migration->load_buf_idx == migration->load_buf_idx_last);
+    lb = &g_array_index(migration->load_bufs, typeof(*lb), migration->load_buf_idx);
+    assert(lb->is_present);
+
+    bioc = qio_channel_buffer_new(lb->len);
+    qio_channel_set_name(QIO_CHANNEL(bioc), "vfio-device-config-load");
+
+    f_out = qemu_file_new_output(QIO_CHANNEL(bioc));
+    qemu_put_buffer(f_out, (uint8_t *)lb->data, lb->len);
+
+    ret = qemu_fflush(f_out);
+    if (ret) {
+        error_setg(errp, "load device config state file flush failed with %d", ret);
+        g_clear_pointer(&f_out, qemu_fclose);
+        return -1;
+    }
+
+    qio_channel_io_seek(QIO_CHANNEL(bioc), 0, 0, NULL);
+    f_in = qemu_file_new_input(QIO_CHANNEL(bioc));
+
+    mig_header = qemu_get_be64(f_in);
+    if (mig_header != VFIO_MIG_FLAG_DEV_CONFIG_STATE) {
+        error_setg(errp, "load device config state invalid header %"PRIu64, mig_header);
+        g_clear_pointer(&f_out, qemu_fclose);
+        g_clear_pointer(&f_in, qemu_fclose);
+        return -1;
+    }
+
+    ret = vfio_load_device_config_state(f_in, opaque);
+    g_clear_pointer(&f_out, qemu_fclose);
+    g_clear_pointer(&f_in, qemu_fclose);
+    if (ret < 0) {
+        error_setg(errp, "load device config state failed with %d", ret);
+        return -1;
+    }
+
+    migration->config_state_loaded_to_dev = true;
+    *is_finished = true;
+    return 0;
+}
+
 static bool vfio_switchover_ack_needed(void *opaque)
 {
     VFIODevice *vbasedev = opaque;
@@ -703,6 +1019,8 @@ static const SaveVMHandlers savevm_vfio_handlers = {
     .load_setup = vfio_load_setup,
     .load_cleanup = vfio_load_cleanup,
     .load_state = vfio_load_state,
+    .load_state_buffer = vfio_load_state_buffer,
+    .load_finish = vfio_load_finish,
     .switchover_ack_needed = vfio_switchover_ack_needed,
 };
 
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index a72697678256..569bb6897b66 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -148,9 +148,16 @@ vfio_display_edid_write_error(void) ""
 
 # migration.c
 vfio_load_cleanup(const char *name) " (%s)"
-vfio_load_device_config_state(const char *name) " (%s)"
+vfio_load_device_config_state_start(const char *name) " (%s)"
+vfio_load_device_config_state_end(const char *name) " (%s)"
 vfio_load_state(const char *name, uint64_t data) " (%s) data 0x%"PRIx64
 vfio_load_state_device_data(const char *name, uint64_t data_size, int ret) " (%s) size 0x%"PRIx64" ret %d"
+vfio_load_state_device_buffer_incoming(const char *name, uint32_t idx) " (%s) idx %"PRIu32
+vfio_load_state_device_buffer_start(const char *name) " (%s)"
+vfio_load_state_device_buffer_starved(const char *name, uint32_t idx) " (%s) idx %"PRIu32
+vfio_load_state_device_buffer_load_start(const char *name, uint32_t idx) " (%s) idx %"PRIu32
+vfio_load_state_device_buffer_load_end(const char *name, uint32_t idx) " (%s) idx %"PRIu32
+vfio_load_state_device_buffer_end(const char *name) " (%s)"
 vfio_migration_realize(const char *name) " (%s)"
 vfio_migration_set_state(const char *name, const char *state) " (%s) state %s"
 vfio_migration_state_notifier(const char *name, int state) " (%s) state %d"
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 9bb523249e73..f861cbd13384 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -74,6 +74,20 @@ typedef struct VFIOMigration {
 
     bool save_iterate_run;
     bool save_iterate_empty_hit;
+    QemuThread load_bufs_thread;
+    Error *load_bufs_thread_errp;
+    bool load_bufs_thread_started;
+    bool load_bufs_thread_finished;
+    bool load_bufs_thread_want_exit;
+
+    GArray *load_bufs;
+    bool load_bufs_device_ready;
+    GCond load_bufs_device_ready_cond;
+    GCond load_bufs_buffer_ready_cond;
+    GMutex load_bufs_mutex;
+    uint32_t load_buf_idx;
+    uint32_t load_buf_idx_last;
+    bool config_state_loaded_to_dev;
 } VFIOMigration;
 
 struct VFIOGroup;

