Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F10D2743416
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 07:24:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF6bS-0008GT-E5; Fri, 30 Jun 2023 01:23:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=mf8A=CS=redhat.com=clg@ozlabs.org>)
 id 1qF6b1-0008Ag-QK
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 01:23:04 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=mf8A=CS=redhat.com=clg@ozlabs.org>)
 id 1qF6at-0003NU-FV
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 01:22:59 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QskGy02ZJz4wp2;
 Fri, 30 Jun 2023 15:22:50 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QskGv3HWtz4wZy;
 Fri, 30 Jun 2023 15:22:47 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Peter Xu <peterx@redhat.com>,
 YangHang Liu <yanghliu@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 02/16] migration: Implement switchover ack logic
Date: Fri, 30 Jun 2023 07:22:21 +0200
Message-ID: <20230630052235.1934154-3-clg@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230630052235.1934154-1-clg@redhat.com>
References: <20230630052235.1934154-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=mf8A=CS=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: Avihai Horon <avihaih@nvidia.com>

Implement switchover ack logic. This prevents the source from stopping
the VM and completing the migration until an ACK is received from the
destination that it's OK to do so.

To achieve this, a new SaveVMHandlers handler switchover_ack_needed()
and a new return path message MIG_RP_MSG_SWITCHOVER_ACK are added.

The switchover_ack_needed() handler is called during migration setup in
the destination to check if switchover ack is used by the migrated
device.

When switchover is approved by all migrated devices in the destination
that support this capability, the MIG_RP_MSG_SWITCHOVER_ACK return path
message is sent to the source to notify it that it's OK to do
switchover.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Tested-by: YangHang Liu <yanghliu@redhat.com>
Acked-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/migration/register.h |  2 ++
 migration/migration.h        | 14 ++++++++++
 migration/savevm.h           |  1 +
 migration/migration.c        | 32 +++++++++++++++++++--
 migration/savevm.c           | 54 ++++++++++++++++++++++++++++++++++++
 migration/trace-events       |  3 ++
 6 files changed, 104 insertions(+), 2 deletions(-)

diff --git a/include/migration/register.h b/include/migration/register.h
index a8dfd8fefd0a..90914f32f50c 100644
--- a/include/migration/register.h
+++ b/include/migration/register.h
@@ -71,6 +71,8 @@ typedef struct SaveVMHandlers {
     int (*load_cleanup)(void *opaque);
     /* Called when postcopy migration wants to resume from failure */
     int (*resume_prepare)(MigrationState *s, void *opaque);
+    /* Checks if switchover ack should be used. Called only in dest */
+    bool (*switchover_ack_needed)(void *opaque);
 } SaveVMHandlers;
 
 int register_savevm_live(const char *idstr,
diff --git a/migration/migration.h b/migration/migration.h
index 30c3e97635b1..c859a0d35eb7 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -210,6 +210,13 @@ struct MigrationIncomingState {
      * contains valid information.
      */
     QemuMutex page_request_mutex;
+
+    /*
+     * Number of devices that have yet to approve switchover. When this reaches
+     * zero an ACK that it's OK to do switchover is sent to the source. No lock
+     * is needed as this field is updated serially.
+     */
+    unsigned int switchover_ack_pending_num;
 };
 
 MigrationIncomingState *migration_incoming_get_current(void);
@@ -440,6 +447,12 @@ struct MigrationState {
 
     /* QEMU_VM_VMDESCRIPTION content filled for all non-iterable devices. */
     JSONWriter *vmdesc;
+
+    /*
+     * Indicates whether an ACK from the destination that it's OK to do
+     * switchover has been received.
+     */
+    bool switchover_acked;
 };
 
 void migrate_set_state(int *state, int old_state, int new_state);
@@ -480,6 +493,7 @@ int migrate_send_rp_message_req_pages(MigrationIncomingState *mis,
 void migrate_send_rp_recv_bitmap(MigrationIncomingState *mis,
                                  char *block_name);
 void migrate_send_rp_resume_ack(MigrationIncomingState *mis, uint32_t value);
+int migrate_send_rp_switchover_ack(MigrationIncomingState *mis);
 
 void dirty_bitmap_mig_before_vm_start(void);
 void dirty_bitmap_mig_cancel_outgoing(void);
diff --git a/migration/savevm.h b/migration/savevm.h
index fb636735f0af..e894bbc14331 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -65,6 +65,7 @@ int qemu_loadvm_state(QEMUFile *f);
 void qemu_loadvm_state_cleanup(void);
 int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis);
 int qemu_load_device_state(QEMUFile *f);
+int qemu_loadvm_approve_switchover(void);
 int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
         bool in_postcopy, bool inactivate_disks);
 
diff --git a/migration/migration.c b/migration/migration.c
index dc05c6f6ea94..7653787f745d 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -78,6 +78,7 @@ enum mig_rp_message_type {
     MIG_RP_MSG_REQ_PAGES,    /* data (start: be64, len: be32) */
     MIG_RP_MSG_RECV_BITMAP,  /* send recved_bitmap back to source */
     MIG_RP_MSG_RESUME_ACK,   /* tell source that we are ready to resume */
+    MIG_RP_MSG_SWITCHOVER_ACK, /* Tell source it's OK to do switchover */
 
     MIG_RP_MSG_MAX
 };
@@ -760,6 +761,11 @@ bool migration_has_all_channels(void)
     return true;
 }
 
+int migrate_send_rp_switchover_ack(MigrationIncomingState *mis)
+{
+    return migrate_send_rp_message(mis, MIG_RP_MSG_SWITCHOVER_ACK, 0, NULL);
+}
+
 /*
  * Send a 'SHUT' message on the return channel with the given value
  * to indicate that we've finished with the RP.  Non-0 value indicates
@@ -1405,6 +1411,7 @@ void migrate_init(MigrationState *s)
     s->vm_old_state = -1;
     s->iteration_initial_bytes = 0;
     s->threshold_size = 0;
+    s->switchover_acked = false;
 }
 
 int migrate_add_blocker_internal(Error *reason, Error **errp)
@@ -1721,6 +1728,7 @@ static struct rp_cmd_args {
     [MIG_RP_MSG_REQ_PAGES_ID]   = { .len = -1, .name = "REQ_PAGES_ID" },
     [MIG_RP_MSG_RECV_BITMAP]    = { .len = -1, .name = "RECV_BITMAP" },
     [MIG_RP_MSG_RESUME_ACK]     = { .len =  4, .name = "RESUME_ACK" },
+    [MIG_RP_MSG_SWITCHOVER_ACK] = { .len =  0, .name = "SWITCHOVER_ACK" },
     [MIG_RP_MSG_MAX]            = { .len = -1, .name = "MAX" },
 };
 
@@ -1959,6 +1967,11 @@ retry:
             }
             break;
 
+        case MIG_RP_MSG_SWITCHOVER_ACK:
+            ms->switchover_acked = true;
+            trace_source_return_path_thread_switchover_acked();
+            break;
+
         default:
             break;
         }
@@ -2693,6 +2706,20 @@ static void migration_update_counters(MigrationState *s,
                               bandwidth, s->threshold_size);
 }
 
+static bool migration_can_switchover(MigrationState *s)
+{
+    if (!migrate_switchover_ack()) {
+        return true;
+    }
+
+    /* No reason to wait for switchover ACK if VM is stopped */
+    if (!runstate_is_running()) {
+        return true;
+    }
+
+    return s->switchover_acked;
+}
+
 /* Migration thread iteration status */
 typedef enum {
     MIG_ITERATE_RESUME,         /* Resume current iteration */
@@ -2708,6 +2735,7 @@ static MigIterateState migration_iteration_run(MigrationState *s)
 {
     uint64_t must_precopy, can_postcopy;
     bool in_postcopy = s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE;
+    bool can_switchover = migration_can_switchover(s);
 
     qemu_savevm_state_pending_estimate(&must_precopy, &can_postcopy);
     uint64_t pending_size = must_precopy + can_postcopy;
@@ -2720,14 +2748,14 @@ static MigIterateState migration_iteration_run(MigrationState *s)
         trace_migrate_pending_exact(pending_size, must_precopy, can_postcopy);
     }
 
-    if (!pending_size || pending_size < s->threshold_size) {
+    if ((!pending_size || pending_size < s->threshold_size) && can_switchover) {
         trace_migration_thread_low_pending(pending_size);
         migration_completion(s);
         return MIG_ITERATE_BREAK;
     }
 
     /* Still a significant amount to transfer */
-    if (!in_postcopy && must_precopy <= s->threshold_size &&
+    if (!in_postcopy && must_precopy <= s->threshold_size && can_switchover &&
         qatomic_read(&s->start_postcopy)) {
         if (postcopy_start(s)) {
             error_report("%s: postcopy failed to start", __func__);
diff --git a/migration/savevm.c b/migration/savevm.c
index bc284087f9b9..cdf47939244d 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2360,6 +2360,21 @@ static int loadvm_process_command(QEMUFile *f)
             error_report("CMD_OPEN_RETURN_PATH failed");
             return -1;
         }
+
+        /*
+         * Switchover ack is enabled but no device uses it, so send an ACK to
+         * source that it's OK to switchover. Do it here, after return path has
+         * been created.
+         */
+        if (migrate_switchover_ack() && !mis->switchover_ack_pending_num) {
+            int ret = migrate_send_rp_switchover_ack(mis);
+            if (ret) {
+                error_report(
+                    "Could not send switchover ack RP MSG, err %d (%s)", ret,
+                    strerror(-ret));
+                return ret;
+            }
+        }
         break;
 
     case MIG_CMD_PING:
@@ -2586,6 +2601,23 @@ static int qemu_loadvm_state_header(QEMUFile *f)
     return 0;
 }
 
+static void qemu_loadvm_state_switchover_ack_needed(MigrationIncomingState *mis)
+{
+    SaveStateEntry *se;
+
+    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+        if (!se->ops || !se->ops->switchover_ack_needed) {
+            continue;
+        }
+
+        if (se->ops->switchover_ack_needed(se->opaque)) {
+            mis->switchover_ack_pending_num++;
+        }
+    }
+
+    trace_loadvm_state_switchover_ack_needed(mis->switchover_ack_pending_num);
+}
+
 static int qemu_loadvm_state_setup(QEMUFile *f)
 {
     SaveStateEntry *se;
@@ -2789,6 +2821,10 @@ int qemu_loadvm_state(QEMUFile *f)
         return -EINVAL;
     }
 
+    if (migrate_switchover_ack()) {
+        qemu_loadvm_state_switchover_ack_needed(mis);
+    }
+
     cpu_synchronize_all_pre_loadvm();
 
     ret = qemu_loadvm_state_main(f, mis);
@@ -2862,6 +2898,24 @@ int qemu_load_device_state(QEMUFile *f)
     return 0;
 }
 
+int qemu_loadvm_approve_switchover(void)
+{
+    MigrationIncomingState *mis = migration_incoming_get_current();
+
+    if (!mis->switchover_ack_pending_num) {
+        return -EINVAL;
+    }
+
+    mis->switchover_ack_pending_num--;
+    trace_loadvm_approve_switchover(mis->switchover_ack_pending_num);
+
+    if (mis->switchover_ack_pending_num) {
+        return 0;
+    }
+
+    return migrate_send_rp_switchover_ack(mis);
+}
+
 bool save_snapshot(const char *name, bool overwrite, const char *vmstate,
                   bool has_devices, strList *devices, Error **errp)
 {
diff --git a/migration/trace-events b/migration/trace-events
index cdaef7a1ea41..5259c1044b08 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -7,6 +7,7 @@ qemu_loadvm_state_section_partend(uint32_t section_id) "%u"
 qemu_loadvm_state_post_main(int ret) "%d"
 qemu_loadvm_state_section_startfull(uint32_t section_id, const char *idstr, uint32_t instance_id, uint32_t version_id) "%u(%s) %u %u"
 qemu_savevm_send_packaged(void) ""
+loadvm_state_switchover_ack_needed(unsigned int switchover_ack_pending_num) "Switchover ack pending num=%u"
 loadvm_state_setup(void) ""
 loadvm_state_cleanup(void) ""
 loadvm_handle_cmd_packaged(unsigned int length) "%u"
@@ -23,6 +24,7 @@ loadvm_postcopy_ram_handle_discard_end(void) ""
 loadvm_postcopy_ram_handle_discard_header(const char *ramid, uint16_t len) "%s: %ud"
 loadvm_process_command(const char *s, uint16_t len) "com=%s len=%d"
 loadvm_process_command_ping(uint32_t val) "0x%x"
+loadvm_approve_switchover(unsigned int switchover_ack_pending_num) "Switchover ack pending num=%u"
 postcopy_ram_listen_thread_exit(void) ""
 postcopy_ram_listen_thread_start(void) ""
 qemu_savevm_send_postcopy_advise(void) ""
@@ -180,6 +182,7 @@ source_return_path_thread_loop_top(void) ""
 source_return_path_thread_pong(uint32_t val) "0x%x"
 source_return_path_thread_shut(uint32_t val) "0x%x"
 source_return_path_thread_resume_ack(uint32_t v) "%"PRIu32
+source_return_path_thread_switchover_acked(void) ""
 migration_thread_low_pending(uint64_t pending) "%" PRIu64
 migrate_transferred(uint64_t tranferred, uint64_t time_spent, uint64_t bandwidth, uint64_t size) "transferred %" PRIu64 " time_spent %" PRIu64 " bandwidth %" PRIu64 " max_size %" PRId64
 process_incoming_migration_co_end(int ret, int ps) "ret=%d postcopy-state=%d"
-- 
2.41.0


