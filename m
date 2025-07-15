Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB64B06286
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Jul 2025 17:12:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubhI5-00089E-4q; Tue, 15 Jul 2025 11:09:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1ubgoG-0000Xh-17; Tue, 15 Jul 2025 10:39:09 -0400
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1ubgoA-0008ST-8n; Tue, 15 Jul 2025 10:39:06 -0400
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98.2) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1ubgo1-00000000kFj-1GKp; Tue, 15 Jul 2025 16:38:53 +0200
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v2 2/2] vfio/migration: Max in-flight VFIO device state
 buffers size limit
Date: Tue, 15 Jul 2025 16:37:37 +0200
Message-ID: <4f7cad490988288f58e36b162d7a888ed7e7fd17.1752589295.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1752589295.git.maciej.szmigiero@oracle.com>
References: <cover.1752589295.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Allow capping the maximum total size of in-flight VFIO device state buffers
queued at the destination, otherwise a malicious QEMU source could
theoretically cause the target QEMU to allocate unlimited amounts of memory
for buffers-in-flight.

Since this is not expected to be a realistic threat in most of VFIO live
migration use cases and the right value depends on the particular setup
disable this limit by default by setting it to UINT64_MAX.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Avihai Horon <avihaih@nvidia.com>
Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 docs/devel/migration/vfio.rst | 13 +++++++++++++
 hw/vfio/migration-multifd.c   | 21 +++++++++++++++++++--
 hw/vfio/pci.c                 |  9 +++++++++
 include/hw/vfio/vfio-device.h |  1 +
 4 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/docs/devel/migration/vfio.rst b/docs/devel/migration/vfio.rst
index dae3a988307f..0790e5031d8f 100644
--- a/docs/devel/migration/vfio.rst
+++ b/docs/devel/migration/vfio.rst
@@ -248,6 +248,19 @@ The multifd VFIO device state transfer is controlled by
 AUTO, which means that VFIO device state transfer via multifd channels is
 attempted in configurations that otherwise support it.
 
+Since the target QEMU needs to load device state buffers in-order it needs to
+queue incoming buffers until they can be loaded into the device.
+This means that a malicious QEMU source could theoretically cause the target
+QEMU to allocate unlimited amounts of memory for such buffers-in-flight.
+
+The "x-migration-max-queued-buffers-size" property allows capping the total size
+of these VFIO device state buffers queued at the destination.
+
+Because a malicious QEMU source causing OOM on the target is not expected to be
+a realistic threat in most of VFIO live migration use cases and the right value
+depends on the particular setup by default this queued buffers size limit is
+disabled by setting it to UINT64_MAX.
+
 Some host platforms (like ARM64) require that VFIO device config is loaded only
 after all iterables were loaded, during non-iterables loading phase.
 Such interlocking is controlled by "x-migration-load-config-after-iter" VFIO
diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
index e539befaa925..d522671b8d62 100644
--- a/hw/vfio/migration-multifd.c
+++ b/hw/vfio/migration-multifd.c
@@ -72,6 +72,7 @@ typedef struct VFIOMultifd {
     QemuMutex load_bufs_mutex; /* Lock order: this lock -> BQL */
     uint32_t load_buf_idx;
     uint32_t load_buf_idx_last;
+    size_t load_buf_queued_pending_buffers_size;
 } VFIOMultifd;
 
 static void vfio_state_buffer_clear(gpointer data)
@@ -128,6 +129,7 @@ static bool vfio_load_state_buffer_insert(VFIODevice *vbasedev,
     VFIOMigration *migration = vbasedev->migration;
     VFIOMultifd *multifd = migration->multifd;
     VFIOStateBuffer *lb;
+    size_t data_size = packet_total_size - sizeof(*packet);
 
     vfio_state_buffers_assert_init(&multifd->load_bufs);
     if (packet->idx >= vfio_state_buffers_size_get(&multifd->load_bufs)) {
@@ -143,8 +145,19 @@ static bool vfio_load_state_buffer_insert(VFIODevice *vbasedev,
 
     assert(packet->idx >= multifd->load_buf_idx);
 
-    lb->data = g_memdup2(&packet->data, packet_total_size - sizeof(*packet));
-    lb->len = packet_total_size - sizeof(*packet);
+    multifd->load_buf_queued_pending_buffers_size += data_size;
+    if (multifd->load_buf_queued_pending_buffers_size >
+        vbasedev->migration_max_queued_buffers_size) {
+        error_setg(errp,
+                   "%s: queuing state buffer %" PRIu32
+                   " would exceed the size max of %" PRIu64,
+                   vbasedev->name, packet->idx,
+                   vbasedev->migration_max_queued_buffers_size);
+        return false;
+    }
+
+    lb->data = g_memdup2(&packet->data, data_size);
+    lb->len = data_size;
     lb->is_present = true;
 
     return true;
@@ -328,6 +341,9 @@ static bool vfio_load_state_buffer_write(VFIODevice *vbasedev,
         assert(wr_ret <= buf_len);
         buf_len -= wr_ret;
         buf_cur += wr_ret;
+
+        assert(multifd->load_buf_queued_pending_buffers_size >= wr_ret);
+        multifd->load_buf_queued_pending_buffers_size -= wr_ret;
     }
 
     trace_vfio_load_state_device_buffer_load_end(vbasedev->name,
@@ -497,6 +513,7 @@ static VFIOMultifd *vfio_multifd_new(void)
 
     multifd->load_buf_idx = 0;
     multifd->load_buf_idx_last = UINT32_MAX;
+    multifd->load_buf_queued_pending_buffers_size = 0;
     qemu_cond_init(&multifd->load_bufs_buffer_ready_cond);
 
     multifd->load_bufs_iter_done = false;
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 7010f0af35b6..4a360bd17ed6 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3626,6 +3626,8 @@ static const Property vfio_pci_dev_properties[] = {
     DEFINE_PROP_ON_OFF_AUTO("x-migration-load-config-after-iter", VFIOPCIDevice,
                             vbasedev.migration_load_config_after_iter,
                             ON_OFF_AUTO_AUTO),
+    DEFINE_PROP_SIZE("x-migration-max-queued-buffers-size", VFIOPCIDevice,
+                     vbasedev.migration_max_queued_buffers_size, UINT64_MAX),
     DEFINE_PROP_BOOL("migration-events", VFIOPCIDevice,
                      vbasedev.migration_events, false),
     DEFINE_PROP_BOOL("x-no-mmap", VFIOPCIDevice, vbasedev.no_mmap, false),
@@ -3807,6 +3809,13 @@ static void vfio_pci_dev_class_init(ObjectClass *klass, const void *data)
                                           "non-iterables loading phase) when "
                                           "doing live migration of device state "
                                           "via multifd channels");
+    object_class_property_set_description(klass, /* 10.1 */
+                                          "x-migration-max-queued-buffers-size",
+                                          "Maximum size of in-flight VFIO "
+                                          "device state buffers queued at the "
+                                          "destination when doing live "
+                                          "migration of device state via "
+                                          "multifd channels");
 }
 
 static const TypeInfo vfio_pci_dev_info = {
diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
index dac3fdce1539..6e4d5ccdac6e 100644
--- a/include/hw/vfio/vfio-device.h
+++ b/include/hw/vfio/vfio-device.h
@@ -68,6 +68,7 @@ typedef struct VFIODevice {
     OnOffAuto enable_migration;
     OnOffAuto migration_multifd_transfer;
     OnOffAuto migration_load_config_after_iter;
+    uint64_t migration_max_queued_buffers_size;
     bool migration_events;
     bool use_region_fds;
     VFIODeviceOps *ops;

