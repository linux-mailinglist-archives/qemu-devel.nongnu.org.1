Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA108701AE
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Mar 2024 13:37:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh7UI-0002S0-NA; Mon, 04 Mar 2024 07:32:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=mkh8=KK=redhat.com=clg@ozlabs.org>)
 id 1rh7Su-0000ur-5o
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 07:30:46 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=mkh8=KK=redhat.com=clg@ozlabs.org>)
 id 1rh7ST-0004js-0L
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 07:30:26 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TpJ0x59Rjz4wyx;
 Mon,  4 Mar 2024 23:29:37 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TpJ0r0wzKz4x0m;
 Mon,  4 Mar 2024 23:29:31 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v3 12/26] migration: Add Error** argument to .save_setup()
 handler
Date: Mon,  4 Mar 2024 13:28:30 +0100
Message-ID: <20240304122844.1888308-13-clg@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240304122844.1888308-1-clg@redhat.com>
References: <20240304122844.1888308-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=mkh8=KK=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

The purpose is to record a potential error in the migration stream if
qemu_savevm_state_setup() fails. Most of the current .save_setup()
handlers can be modified to use the Error argument instead of managing
their own and calling locally error_report().

Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>
Cc: Eric Blake <eblake@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: John Snow <jsnow@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---

 Changes in v3: 

 - Made sure an error is always set in case of failure in
   qemu_savevm_state_setup()

 Changes in v2: 

 - dropped qemu_file_set_error_obj(f, ret, local_err);
 
 include/migration/register.h   |  3 ++-
 hw/ppc/spapr.c                 |  2 +-
 hw/s390x/s390-stattrib.c       |  6 ++----
 hw/vfio/migration.c            | 17 ++++++++---------
 migration/block-dirty-bitmap.c |  4 +++-
 migration/block.c              | 13 ++++---------
 migration/ram.c                | 15 ++++++++-------
 migration/savevm.c             |  4 +---
 8 files changed, 29 insertions(+), 35 deletions(-)

diff --git a/include/migration/register.h b/include/migration/register.h
index d7b70a8be68c9df47c7843bda7d430989d7ca384..64fc7c11036c82edd6d69513e56a0216d36c17aa 100644
--- a/include/migration/register.h
+++ b/include/migration/register.h
@@ -60,10 +60,11 @@ typedef struct SaveVMHandlers {
      *
      * @f: QEMUFile where to send the data
      * @opaque: data pointer passed to register_savevm_live()
+     * @errp: pointer to Error*, to store an error if it happens.
      *
      * Returns zero to indicate success and negative for error
      */
-    int (*save_setup)(QEMUFile *f, void *opaque);
+    int (*save_setup)(QEMUFile *f, void *opaque, Error **errp);
 
     /**
      * @save_cleanup
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 55263f0815ed7671b32ea20b394ae71c82e616cb..045c024ffa76eacfc496bd486cb6cafbee2df73e 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2142,7 +2142,7 @@ static const VMStateDescription vmstate_spapr = {
     }
 };
 
-static int htab_save_setup(QEMUFile *f, void *opaque)
+static int htab_save_setup(QEMUFile *f, void *opaque, Error **errp)
 {
     SpaprMachineState *spapr = opaque;
 
diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
index e99de190332a82363b1388bbc450013149295bc0..16dee2e2ea8031d072156bb7930d5ac6dfd5a214 100644
--- a/hw/s390x/s390-stattrib.c
+++ b/hw/s390x/s390-stattrib.c
@@ -167,19 +167,17 @@ static int cmma_load(QEMUFile *f, void *opaque, int version_id)
     return ret;
 }
 
-static int cmma_save_setup(QEMUFile *f, void *opaque)
+static int cmma_save_setup(QEMUFile *f, void *opaque, Error **errp)
 {
     S390StAttribState *sas = S390_STATTRIB(opaque);
     S390StAttribClass *sac = S390_STATTRIB_GET_CLASS(sas);
-    Error *local_err = NULL;
     int res;
     /*
      * Signal that we want to start a migration, thus needing PGSTE dirty
      * tracking.
      */
-    res = sac->set_migrationmode(sas, true, &local_err);
+    res = sac->set_migrationmode(sas, true, errp);
     if (res) {
-        error_report_err(local_err);
         return res;
     }
     qemu_put_be64(f, STATTR_FLAG_EOS);
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 51bea536cc290ba0aa393f78b017b0650e333bff..5152783e01c39edaf4ab37035924f8e495cf48d8 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -378,7 +378,7 @@ static int vfio_save_prepare(void *opaque, Error **errp)
     return 0;
 }
 
-static int vfio_save_setup(QEMUFile *f, void *opaque)
+static int vfio_save_setup(QEMUFile *f, void *opaque, Error **errp)
 {
     VFIODevice *vbasedev = opaque;
     VFIOMigration *migration = vbasedev->migration;
@@ -392,8 +392,8 @@ static int vfio_save_setup(QEMUFile *f, void *opaque)
                                       stop_copy_size);
     migration->data_buffer = g_try_malloc0(migration->data_buffer_size);
     if (!migration->data_buffer) {
-        error_report("%s: Failed to allocate migration data buffer",
-                     vbasedev->name);
+        error_setg(errp, "%s: Failed to allocate migration data buffer",
+                   vbasedev->name);
         return -ENOMEM;
     }
 
@@ -403,8 +403,8 @@ static int vfio_save_setup(QEMUFile *f, void *opaque)
             ret = vfio_migration_set_state(vbasedev, VFIO_DEVICE_STATE_PRE_COPY,
                                            VFIO_DEVICE_STATE_RUNNING);
             if (ret) {
-                error_report("%s: Failed to set new RUNNING state",
-                             vbasedev->name);
+                error_setg(errp, "%s: Failed to set new RUNNING state",
+                           vbasedev->name);
                 return ret;
             }
 
@@ -415,8 +415,8 @@ static int vfio_save_setup(QEMUFile *f, void *opaque)
             /* vfio_save_complete_precopy() will go to STOP_COPY */
             break;
         default:
-            error_report("%s: Invalid device state %d", vbasedev->name,
-                         migration->device_state);
+            error_setg(errp, "%s: Invalid device state %d", vbasedev->name,
+                       migration->device_state);
             return -EINVAL;
         }
     }
@@ -427,8 +427,7 @@ static int vfio_save_setup(QEMUFile *f, void *opaque)
 
     ret = qemu_file_get_error(f);
     if (ret) {
-        error_report("%s: save setup failed : %s", vbasedev->name,
-                     strerror(ret));
+        error_setg_errno(errp, ret, "%s: save setup failed", vbasedev->name);
     }
 
     return ret;
diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index 2708abf3d762de774ed294d3fdb8e56690d2974c..542a8c297b329abc30d1b3a205d29340fa59a961 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -1213,12 +1213,14 @@ fail:
     return ret;
 }
 
-static int dirty_bitmap_save_setup(QEMUFile *f, void *opaque)
+static int dirty_bitmap_save_setup(QEMUFile *f, void *opaque, Error **errp)
 {
     DBMSaveState *s = &((DBMState *)opaque)->save;
     SaveBitmapState *dbms = NULL;
 
     if (init_dirty_bitmap_migration(s) < 0) {
+        error_setg(errp,
+                   "Failed to initialize dirty tracking bitmap for blocks");
         return -1;
     }
 
diff --git a/migration/block.c b/migration/block.c
index 06f5857cf049df3261d2cf1d7c3607ab92350ac6..02d00095db4cb040d5508a191f469d657b0085bf 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -706,10 +706,9 @@ static void block_migration_cleanup(void *opaque)
     blk_mig_unlock();
 }
 
-static int block_save_setup(QEMUFile *f, void *opaque)
+static int block_save_setup(QEMUFile *f, void *opaque, Error **errp)
 {
     int ret;
-    Error *local_err = NULL;
 
     trace_migration_block_save("setup", block_mig_state.submitted,
                                block_mig_state.transferred);
@@ -717,25 +716,21 @@ static int block_save_setup(QEMUFile *f, void *opaque)
     warn_report("block migration is deprecated;"
                 " use blockdev-mirror with NBD instead");
 
-    ret = init_blk_migration(f, &local_err);
+    ret = init_blk_migration(f, errp);
     if (ret < 0) {
-        error_report_err(local_err);
         return ret;
     }
 
     /* start track dirty blocks */
     ret = set_dirty_tracking();
     if (ret) {
-        error_setg_errno(&local_err, -ret,
-                         "Failed to start block dirty tracking");
-        error_report_err(local_err);
+        error_setg_errno(errp, -ret, "Failed to start block dirty tracking");
         return ret;
     }
 
     ret = flush_blks(f);
     if (ret) {
-        error_setg_errno(&local_err, -ret, "Flushing block failed");
-        error_report_err(local_err);
+        error_setg_errno(errp, -ret, "Flushing block failed");
         return ret;
     }
     blk_mig_reset_dirty_cursor();
diff --git a/migration/ram.c b/migration/ram.c
index dbd04d8ee2167881007c836a6bbc79c1aced72d0..84e718c562c72310092114c438eb94e0077775f2 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2929,22 +2929,23 @@ void qemu_guest_free_page_hint(void *addr, size_t len)
  *
  * @f: QEMUFile where to send the data
  * @opaque: RAMState pointer
+ * @errp: pointer to Error*, to store an error if it happens.
  */
-static int ram_save_setup(QEMUFile *f, void *opaque)
+static int ram_save_setup(QEMUFile *f, void *opaque, Error **errp)
 {
     RAMState **rsp = opaque;
     RAMBlock *block;
     int ret;
 
     if (compress_threads_save_setup()) {
-        error_report("%s: failed to start compress threads", __func__);
+        error_setg(errp, "%s: failed to start compress threads", __func__);
         return -1;
     }
 
     /* migration has already setup the bitmap, reuse it. */
     if (!migration_in_colo_state()) {
         if (ram_init_all(rsp) != 0) {
-            error_report("%s: failed to setup RAM for migration", __func__);
+            error_setg(errp, "%s: failed to setup RAM for migration", __func__);
             compress_threads_save_cleanup();
             return -1;
         }
@@ -2971,14 +2972,14 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
 
     ret = rdma_registration_start(f, RAM_CONTROL_SETUP);
     if (ret < 0) {
-        error_report("%s: failed to start RDMA registration", __func__);
+        error_setg(errp, "%s: failed to start RDMA registration", __func__);
         qemu_file_set_error(f, ret);
         return ret;
     }
 
     ret = rdma_registration_stop(f, RAM_CONTROL_SETUP);
     if (ret < 0) {
-        error_report("%s: failed to stop RDMA registration", __func__);
+        error_setg(errp, "%s: failed to stop RDMA registration", __func__);
         qemu_file_set_error(f, ret);
         return ret;
     }
@@ -2990,7 +2991,7 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
     ret = multifd_send_sync_main();
     bql_lock();
     if (ret < 0) {
-        error_report("%s: multifd synchronization failed", __func__);
+        error_setg(errp, "%s: multifd synchronization failed", __func__);
         return ret;
     }
 
@@ -3001,7 +3002,7 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
     qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
     ret = qemu_fflush(f);
     if (ret) {
-        error_report("%s failed : %s", __func__, strerror(ret));
+        error_setg_errno(errp, ret, "%s failed", __func__);
     }
     return ret;
 }
diff --git a/migration/savevm.c b/migration/savevm.c
index 3ae4328b95d554cb4855f96989f8685daf4b8407..0ff2c4d97d475b81603bc2387cfaa3c000a25cdc 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1341,11 +1341,9 @@ int qemu_savevm_state_setup(QEMUFile *f, Error **errp)
         }
         save_section_header(f, se, QEMU_VM_SECTION_START);
 
-        ret = se->ops->save_setup(f, se->opaque);
+        ret = se->ops->save_setup(f, se->opaque, errp);
         save_section_footer(f, se);
         if (ret < 0) {
-            error_setg(errp, "failed to setup SaveStateEntry with id(name): "
-                       "%d(%s): %d", se->section_id, se->idstr, ret);
             qemu_file_set_error(f, ret);
             break;
         }
-- 
2.44.0


