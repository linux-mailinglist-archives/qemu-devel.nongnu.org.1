Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A4CA54D88
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Mar 2025 15:21:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqC10-0007xf-Mh; Thu, 06 Mar 2025 09:15:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tqC0d-0007NF-Ll
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 09:15:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tqC0a-0001on-JQ
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 09:15:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741270531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nx4bd6ERtY3K+2G5g7ASy2iRMEjQ7poAzNL7XntscSA=;
 b=ANt60jDmJJi4dLps7AgkYviRx1lTaDcAuLpeSwXgdHJpM325rE1gYjSDuq9BHLaugXCbjS
 6FHBl4RP2Wt2zQUsX9K+ex0Srlo5JCv4T6z4CFdGrPhPgZX4un9H/gf6hl3SIh1iMpro8V
 ImlpXQchFnjUd3fGBVOSpJMSITaMQNc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-542-3Gt8Rl0cNVirCFxRBrHizg-1; Thu,
 06 Mar 2025 09:15:13 -0500
X-MC-Unique: 3Gt8Rl0cNVirCFxRBrHizg-1
X-Mimecast-MFC-AGG-ID: 3Gt8Rl0cNVirCFxRBrHizg_1741270512
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8EC2F19560BB; Thu,  6 Mar 2025 14:15:12 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.141])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 64CB318009BC; Thu,  6 Mar 2025 14:15:10 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Fabiano Rosas <farosas@suse.de>, Zhang Chen <zhangckid@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 14/42] migration: Add MIG_CMD_SWITCHOVER_START and its load
 handler
Date: Thu,  6 Mar 2025 15:13:50 +0100
Message-ID: <20250306141419.2015340-15-clg@redhat.com>
In-Reply-To: <20250306141419.2015340-1-clg@redhat.com>
References: <20250306141419.2015340-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

This QEMU_VM_COMMAND sub-command and its switchover_start SaveVMHandler is
used to mark the switchover point in main migration stream.

It can be used to inform the destination that all pre-switchover main
migration stream data has been sent/received so it can start to process
post-switchover data that it might have received via other migration
channels like the multifd ones.

Add also the relevant MigrationState bit stream compatibility property and
its hw_compat entry.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Zhang Chen <zhangckid@gmail.com> # for the COLO part
Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Link: https://lore.kernel.org/qemu-devel/311be6da85fc7e49a7598684d80aa631778dcbce.1741124640.git.maciej.szmigiero@oracle.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/migration/client-options.h |  4 +++
 include/migration/register.h       | 12 +++++++++
 migration/migration.h              |  2 ++
 migration/savevm.h                 |  1 +
 hw/core/machine.c                  |  1 +
 migration/colo.c                   |  3 +++
 migration/migration-hmp-cmds.c     |  2 ++
 migration/migration.c              |  2 ++
 migration/options.c                |  9 +++++++
 migration/savevm.c                 | 39 ++++++++++++++++++++++++++++++
 migration/trace-events             |  1 +
 scripts/analyze-migration.py       | 11 +++++++++
 12 files changed, 87 insertions(+)

diff --git a/include/migration/client-options.h b/include/migration/client-options.h
index 59f4b55cf4f744f222c161ab0b5b9828b53198be..289c9d776221ce3cf35d86f91ce3313fd79427d3 100644
--- a/include/migration/client-options.h
+++ b/include/migration/client-options.h
@@ -10,6 +10,10 @@
 #ifndef QEMU_MIGRATION_CLIENT_OPTIONS_H
 #define QEMU_MIGRATION_CLIENT_OPTIONS_H
 
+
+/* properties */
+bool migrate_send_switchover_start(void);
+
 /* capabilities */
 
 bool migrate_background_snapshot(void);
diff --git a/include/migration/register.h b/include/migration/register.h
index 0b02927383208d1457f21da7ad4900ba53e93638..ff0faf5f68c8e9ac0fd1144ad91b3fab731d8a2f 100644
--- a/include/migration/register.h
+++ b/include/migration/register.h
@@ -279,6 +279,18 @@ typedef struct SaveVMHandlers {
      * otherwise
      */
     bool (*switchover_ack_needed)(void *opaque);
+
+    /**
+     * @switchover_start
+     *
+     * Notifies that the switchover has started. Called only on
+     * the destination.
+     *
+     * @opaque: data pointer passed to register_savevm_live()
+     *
+     * Returns zero to indicate success and negative for error
+     */
+    int (*switchover_start)(void *opaque);
 } SaveVMHandlers;
 
 /**
diff --git a/migration/migration.h b/migration/migration.h
index 4639e2a7e42f6b25c1fe45ff1a9c13695306480a..7b4278e2a32b2044fad4cf7f7a5defd4435333ea 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -400,6 +400,8 @@ struct MigrationState {
     bool send_configuration;
     /* Whether we send section footer during migration */
     bool send_section_footer;
+    /* Whether we send switchover start notification during migration */
+    bool send_switchover_start;
 
     /* Needed by postcopy-pause state */
     QemuSemaphore postcopy_pause_sem;
diff --git a/migration/savevm.h b/migration/savevm.h
index 7957460062cad0de7129e5f03b9f8d51ba5dc1f9..58f871a7ed9ce8498a16f76ab66b08ef665aee73 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -53,6 +53,7 @@ void qemu_savevm_send_postcopy_listen(QEMUFile *f);
 void qemu_savevm_send_postcopy_run(QEMUFile *f);
 void qemu_savevm_send_postcopy_resume(QEMUFile *f);
 void qemu_savevm_send_recv_bitmap(QEMUFile *f, char *block_name);
+void qemu_savevm_maybe_send_switchover_start(QEMUFile *f);
 
 void qemu_savevm_send_postcopy_ram_discard(QEMUFile *f, const char *name,
                                            uint16_t len,
diff --git a/hw/core/machine.c b/hw/core/machine.c
index b68b8b94a3c43865ec89d9a957289e42d1b26da1..d1ddc3a3db595bd746e8f39b006a8bf9cd9a52d6 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -44,6 +44,7 @@ GlobalProperty hw_compat_9_2[] = {
     { "virtio-balloon-pci-non-transitional", "vectors", "0" },
     { "virtio-mem-pci", "vectors", "0" },
     { "migration", "multifd-clean-tls-termination", "false" },
+    { "migration", "send-switchover-start", "off"},
 };
 const size_t hw_compat_9_2_len = G_N_ELEMENTS(hw_compat_9_2);
 
diff --git a/migration/colo.c b/migration/colo.c
index 9a8e5fbe9b94e9fa56b3c59d3ae4271c1368d7f8..c976b3ff344d7ddf8f850c5a601b3fe42a503610 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -452,6 +452,9 @@ static int colo_do_checkpoint_transaction(MigrationState *s,
         bql_unlock();
         goto out;
     }
+
+    qemu_savevm_maybe_send_switchover_start(s->to_dst_file);
+
     /* Note: device state is saved into buffer */
     ret = qemu_save_device_state(fb);
 
diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 3347e34c489136106e29baf077bb93fb2f95ef1d..49c26daed359fbc04474be212cf7b5c8748043d5 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -46,6 +46,8 @@ static void migration_global_dump(Monitor *mon)
                    ms->send_configuration ? "on" : "off");
     monitor_printf(mon, "send-section-footer: %s\n",
                    ms->send_section_footer ? "on" : "off");
+    monitor_printf(mon, "send-switchover-start: %s\n",
+                   ms->send_switchover_start ? "on" : "off");
     monitor_printf(mon, "clear-bitmap-shift: %u\n",
                    ms->clear_bitmap_shift);
 }
diff --git a/migration/migration.c b/migration/migration.c
index c597aa707e5718bfd15ba6f175b4efbd870ee96f..9e9db26667f1adbeaae428be9b97750755c1c144 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2891,6 +2891,8 @@ static bool migration_switchover_start(MigrationState *s, Error **errp)
 
     precopy_notify_complete();
 
+    qemu_savevm_maybe_send_switchover_start(s->to_dst_file);
+
     return true;
 }
 
diff --git a/migration/options.c b/migration/options.c
index bb259d192a932d7af1ada20254a020cf3b2178a2..b0ac2ea4083ffbdf20788e0f508ab9f02a955f99 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -93,6 +93,8 @@ const Property migration_properties[] = {
                      send_configuration, true),
     DEFINE_PROP_BOOL("send-section-footer", MigrationState,
                      send_section_footer, true),
+    DEFINE_PROP_BOOL("send-switchover-start", MigrationState,
+                     send_switchover_start, true),
     DEFINE_PROP_BOOL("multifd-flush-after-each-section", MigrationState,
                       multifd_flush_after_each_section, false),
     DEFINE_PROP_UINT8("x-clear-bitmap-shift", MigrationState,
@@ -209,6 +211,13 @@ bool migrate_auto_converge(void)
     return s->capabilities[MIGRATION_CAPABILITY_AUTO_CONVERGE];
 }
 
+bool migrate_send_switchover_start(void)
+{
+    MigrationState *s = migrate_get_current();
+
+    return s->send_switchover_start;
+}
+
 bool migrate_background_snapshot(void)
 {
     MigrationState *s = migrate_get_current();
diff --git a/migration/savevm.c b/migration/savevm.c
index 4046faf0091e8ec48c47d4265f325236596a8cc5..faebf47ef51f2c5e6c49df831e1efe585c1a38a9 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -90,6 +90,7 @@ enum qemu_vm_cmd {
     MIG_CMD_ENABLE_COLO,       /* Enable COLO */
     MIG_CMD_POSTCOPY_RESUME,   /* resume postcopy on dest */
     MIG_CMD_RECV_BITMAP,       /* Request for recved bitmap on dst */
+    MIG_CMD_SWITCHOVER_START,  /* Switchover start notification */
     MIG_CMD_MAX
 };
 
@@ -109,6 +110,7 @@ static struct mig_cmd_args {
     [MIG_CMD_POSTCOPY_RESUME]  = { .len =  0, .name = "POSTCOPY_RESUME" },
     [MIG_CMD_PACKAGED]         = { .len =  4, .name = "PACKAGED" },
     [MIG_CMD_RECV_BITMAP]      = { .len = -1, .name = "RECV_BITMAP" },
+    [MIG_CMD_SWITCHOVER_START] = { .len =  0, .name = "SWITCHOVER_START" },
     [MIG_CMD_MAX]              = { .len = -1, .name = "MAX" },
 };
 
@@ -1201,6 +1203,19 @@ void qemu_savevm_send_recv_bitmap(QEMUFile *f, char *block_name)
     qemu_savevm_command_send(f, MIG_CMD_RECV_BITMAP, len + 1, (uint8_t *)buf);
 }
 
+static void qemu_savevm_send_switchover_start(QEMUFile *f)
+{
+    trace_savevm_send_switchover_start();
+    qemu_savevm_command_send(f, MIG_CMD_SWITCHOVER_START, 0, NULL);
+}
+
+void qemu_savevm_maybe_send_switchover_start(QEMUFile *f)
+{
+    if (migrate_send_switchover_start()) {
+        qemu_savevm_send_switchover_start(f);
+    }
+}
+
 bool qemu_savevm_state_blocked(Error **errp)
 {
     SaveStateEntry *se;
@@ -1687,6 +1702,7 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
 
     ret = qemu_file_get_error(f);
     if (ret == 0) {
+        qemu_savevm_maybe_send_switchover_start(f);
         qemu_savevm_state_complete_precopy(f, false);
         ret = qemu_file_get_error(f);
     }
@@ -2383,6 +2399,26 @@ static int loadvm_process_enable_colo(MigrationIncomingState *mis)
     return ret;
 }
 
+static int loadvm_postcopy_handle_switchover_start(void)
+{
+    SaveStateEntry *se;
+
+    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+        int ret;
+
+        if (!se->ops || !se->ops->switchover_start) {
+            continue;
+        }
+
+        ret = se->ops->switchover_start(se->opaque);
+        if (ret < 0) {
+            return ret;
+        }
+    }
+
+    return 0;
+}
+
 /*
  * Process an incoming 'QEMU_VM_COMMAND'
  * 0           just a normal return
@@ -2481,6 +2517,9 @@ static int loadvm_process_command(QEMUFile *f)
 
     case MIG_CMD_ENABLE_COLO:
         return loadvm_process_enable_colo(mis);
+
+    case MIG_CMD_SWITCHOVER_START:
+        return loadvm_postcopy_handle_switchover_start();
     }
 
     return 0;
diff --git a/migration/trace-events b/migration/trace-events
index 58c0f07f5b2dc3c7550239eab0c410561a21d645..c506e11a2e1d37a4aa22035248bcce47ac5956b1 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -39,6 +39,7 @@ savevm_send_postcopy_run(void) ""
 savevm_send_postcopy_resume(void) ""
 savevm_send_colo_enable(void) ""
 savevm_send_recv_bitmap(char *name) "%s"
+savevm_send_switchover_start(void) ""
 savevm_state_setup(void) ""
 savevm_state_resume_prepare(void) ""
 savevm_state_header(void) ""
diff --git a/scripts/analyze-migration.py b/scripts/analyze-migration.py
index 8e1fbf4c9d9f13151535f95bfbee4f32ce8d7500..67631ac43e9f4807b16d3ae62b4eff2d0e340943 100755
--- a/scripts/analyze-migration.py
+++ b/scripts/analyze-migration.py
@@ -620,7 +620,9 @@ class MigrationDump(object):
     QEMU_VM_SUBSECTION    = 0x05
     QEMU_VM_VMDESCRIPTION = 0x06
     QEMU_VM_CONFIGURATION = 0x07
+    QEMU_VM_COMMAND       = 0x08
     QEMU_VM_SECTION_FOOTER= 0x7e
+    QEMU_MIG_CMD_SWITCHOVER_START = 0x0b
 
     def __init__(self, filename):
         self.section_classes = {
@@ -685,6 +687,15 @@ def read(self, desc_only = False, dump_memory = False,
             elif section_type == self.QEMU_VM_SECTION_PART or section_type == self.QEMU_VM_SECTION_END:
                 section_id = file.read32()
                 self.sections[section_id].read()
+            elif section_type == self.QEMU_VM_COMMAND:
+                command_type = file.read16()
+                command_data_len = file.read16()
+                if command_type != self.QEMU_MIG_CMD_SWITCHOVER_START:
+                    raise Exception("Unknown QEMU_VM_COMMAND: %x" %
+                                    (command_type))
+                if command_data_len != 0:
+                    raise Exception("Invalid SWITCHOVER_START length: %x" %
+                                    (command_data_len))
             elif section_type == self.QEMU_VM_SECTION_FOOTER:
                 read_section_id = file.read32()
                 if read_section_id != section_id:
-- 
2.48.1


