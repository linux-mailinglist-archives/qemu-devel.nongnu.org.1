Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 043319E7C3C
	for <lists+qemu-devel@lfdr.de>; Sat,  7 Dec 2024 00:09:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJhRU-000352-5P; Fri, 06 Dec 2024 18:09:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJhRS-00034r-5G
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 18:08:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJhRP-0005qs-L7
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 18:08:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733526534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wzJbEwR/amI3Osl7VJKBOkOySNjtCXDra3pLIrdt9sU=;
 b=BCWRREOu4F+ARkg+gxL0VjdguBN2yfkApy1x7PVyt4dOA0VC6lRtzMTfjEjmbT90JBXWih
 HjN/V2orvCpP6/Aw7y7xsHeLRHTxS4MUSEApqQdPPKtO4ujo7rb4qrEeoPWskIZXE5y2sv
 FMgoodVcyQRkatv3NN6rYGKsvyBZNrM=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-ZnX9JAggPfmADL0_SWeAFw-1; Fri, 06 Dec 2024 18:08:53 -0500
X-MC-Unique: ZnX9JAggPfmADL0_SWeAFw-1
X-Mimecast-MFC-AGG-ID: ZnX9JAggPfmADL0_SWeAFw
Received: by mail-io1-f72.google.com with SMTP id
 ca18e2360f4ac-843dde4b616so243691439f.0
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 15:08:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733526532; x=1734131332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wzJbEwR/amI3Osl7VJKBOkOySNjtCXDra3pLIrdt9sU=;
 b=CSAC0jKGeSObMJBl7dWhqBOBuspe9EI+53L1Z8A8u/eEu0WWL0mzRm7aYy6xLeVi0S
 iHIBV96q4av41jOvGSot0GljMFgTGqpZMvjVSG3wlwGlFbnSSXHs6bumkUrBrVv9HhMq
 rLpKkwQElhy05EK1AZrAgUKp2iTadnE2I/c2USa+uBvKbFc6mxUdtY8FJFo7LinLrydJ
 UM5jWxkn9GxJK8grzLfKuj41QcziA3uGEmN9hGdEdOpTaC0Y9+Sy3nYqX6HjJDLhfRg7
 ttfJ4y2fF8OgB/I9nHGbnLY1xRv3/I5F+XLIB0aR37t40UYHmpaBLOOKm0iysMWnZaT2
 VlPg==
X-Gm-Message-State: AOJu0YzXZ0yqN3t1hmhKD5VBzCSTP6uKCrfuVmtikhYDFOfj3hAHWmeh
 BQxwpoxwR1oHCaDxxCyDTvt5XhfZKj0n6qEvsnAEl+5c1cxEgSWZXAIXv/nEL4OKTqBDKZkf+s6
 mPIdbAOejyyvBO/NewAdqaTRq+m/Z8Qdo+XU93uxFf76OZYu705kqXFNRLfhj9IIKRR/TUNT8d+
 CUPksVORDG//MMBId9362Sn2q1mkL+c92I1A==
X-Gm-Gg: ASbGnctp8ky5tp/GiuUYoXeLJDxNgRo4cKihYfws5ioaSbkZPsPdACsxNep6J2a5KoQ
 Wm8k03JLNU0ddX+yB+QYr3glVNTDXnf5Gr/d/2xipzMyj82bITFY0Jh8j+G7ACPA/RAO2CW+72N
 BqwDOxYw7rMPvwwHb37UOSk84OeWlF8yRjoDpQ6W+mSJjo8AfS1PUi1UlQLlnj7nMlxclxMPtpG
 mQy99b7xk92oGNyNituTXPbtrFAVRojzKc8DH8ot9ngo7/N9rL6pHt24MlujyAVmslAfv8RPLo9
 hQvZvE8D2PH4ZH2InPnPjAqJtg==
X-Received: by 2002:a5d:9947:0:b0:835:3dfc:5ba5 with SMTP id
 ca18e2360f4ac-844710e5ddfmr924740339f.5.1733526532191; 
 Fri, 06 Dec 2024 15:08:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+yu12rwxiwAYUSjQpwzZP+Gilm2wV63K/v1whAUIP4XSbyi3kvua8mw41zGSCbRfZQxWuIg==
X-Received: by 2002:a5d:9947:0:b0:835:3dfc:5ba5 with SMTP id
 ca18e2360f4ac-844710e5ddfmr924737339f.5.1733526531487; 
 Fri, 06 Dec 2024 15:08:51 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2861d9a8dsm1038895173.86.2024.12.06.15.08.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 15:08:50 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, qemu-block@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Eric Blake <eblake@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 6/6] migration/block: Rewrite disk activation
Date: Fri,  6 Dec 2024 18:08:38 -0500
Message-ID: <20241206230838.1111496-7-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241206230838.1111496-1-peterx@redhat.com>
References: <20241206230838.1111496-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

This patch proposes a flag to maintain disk activation status globally.  It
mostly rewrites disk activation mgmt for QEMU, including COLO and QMP
command xen_save_devices_state.

Backgrounds
===========

We have two problems on disk activations, one resolved, one not.

Problem 1: disk activation recover (for switchover interruptions)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

When migration is either cancelled or failed during switchover, especially
when after the disks are inactivated, QEMU needs to remember re-activate
the disks again before vm starts.

It used to be done separately in two paths: one in qmp_migrate_cancel(),
the other one in the failure path of migration_completion().

It used to be fixed in different commits, all over the places in QEMU.  So
these are the relevant changes I saw, I'm not sure if it's complete list:

 - In 2016, commit fe904ea824 ("migration: regain control of images when
   migration fails to complete")

 - In 2017, commit 1d2acc3162 ("migration: re-active images while migration
   been canceled after inactive them")

 - In 2023, commit 6dab4c93ec ("migration: Attempt disk reactivation in
   more failure scenarios")

Now since we have a slightly better picture maybe we can unify the
reactivation in a single path.

One side benefit of doing so is, we can move the disk operation outside QMP
command "migrate_cancel".  It's possible that in the future we may want to
make "migrate_cancel" be OOB-compatible, while that requires the command
doesn't need BQL in the first place.  This will already do that and make
migrate_cancel command lightweight.

Problem 2: disk invalidation on top of invalidated disks
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This is an unresolved bug for current QEMU.  Link in "Resolves:" at the
end.  It turns out besides the src switchover phase (problem 1 above), QEMU
also needs to remember block activation on destination.

Consider two continuous migration in a row, where the VM was always paused.
In that scenario, the disks are not activated even until migration
completed in the 1st round.  When the 2nd round starts, if QEMU doesn't
know the status of the disks, it needs to try inactivate the disk again.

Here the issue is the block layer API bdrv_inactivate_all() will crash a
QEMU if invoked on already inactive disks for the 2nd migration.  For
detail, see the bug link at the end.

Implementation
==============

This patch proposes to maintain disk activation with a global flag, so we
know:

  - If we used to inactivate disks for migration, but migration got
  cancelled, or failed, QEMU will know it should reactivate the disks.

  - On incoming side, if the disks are never activated but then another
  migration is triggered, QEMU should be able to tell that inactivate is
  not needed for the 2nd migration.

We used to have disk_inactive, but it only solves the 1st issue, not the
2nd.  Also, it's done in completely separate paths so it's extremely hard
to follow either how the flag changes, or the duration that the flag is
valid, and when we will reactivate the disks.

Convert the existing disk_inactive flag into that global flag (also invert
its naming), and maintain the disk activation status for the whole
lifecycle of qemu.  That includes the incoming QEMU.

Put both of the error cases of source migration (failure, cancelled)
together into migration_iteration_finish(), which will be invoked for
either of the scenario.  So from that part QEMU should behave the same as
before.  However with such global maintenance on disk activation status, we
not only cleanup quite a few temporary paths that we try to maintain the
disk activation status (e.g. in postcopy code), meanwhile it fixes the
crash for problem 2 in one shot.

For freshly started QEMU, the flag is initialized to TRUE showing that the
QEMU owns the disks by default.

For incoming migrated QEMU, the flag will be initialized to FALSE once and
for all showing that the dest QEMU doesn't own the disks until switchover.
That is guaranteed by the "once" variable.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2395
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/migration/misc.h |  4 ++
 migration/migration.h    |  6 +--
 migration/block-active.c | 94 ++++++++++++++++++++++++++++++++++++++++
 migration/colo.c         |  2 +-
 migration/migration.c    | 80 ++++++++--------------------------
 migration/savevm.c       | 33 ++++++--------
 monitor/qmp-cmds.c       |  8 +---
 migration/meson.build    |  1 +
 migration/trace-events   |  3 ++
 9 files changed, 140 insertions(+), 91 deletions(-)
 create mode 100644 migration/block-active.c

diff --git a/include/migration/misc.h b/include/migration/misc.h
index 804eb23c06..e68a473feb 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -106,4 +106,8 @@ bool migration_incoming_postcopy_advised(void);
 /* True if background snapshot is active */
 bool migration_in_bg_snapshot(void);
 
+/* Wrapper for block active/inactive operations */
+bool migration_block_activate(Error **errp);
+bool migration_block_inactivate(void);
+
 #endif
diff --git a/migration/migration.h b/migration/migration.h
index 3857905c0e..fab3cad2b9 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -370,9 +370,6 @@ struct MigrationState {
     /* Flag set once the migration thread is running (and needs joining) */
     bool migration_thread_running;
 
-    /* Flag set once the migration thread called bdrv_inactivate_all */
-    bool block_inactive;
-
     /* Migration is waiting for guest to unplug device */
     QemuSemaphore wait_unplug_sem;
 
@@ -556,4 +553,7 @@ void migration_bitmap_sync_precopy(bool last_stage);
 /* migration/block-dirty-bitmap.c */
 void dirty_bitmap_mig_init(void);
 
+/* migration/block-active.c */
+void migration_block_active_setup(bool active);
+
 #endif
diff --git a/migration/block-active.c b/migration/block-active.c
new file mode 100644
index 0000000000..d477cf8182
--- /dev/null
+++ b/migration/block-active.c
@@ -0,0 +1,94 @@
+/*
+ * Block activation tracking for migration purpose
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Copyright (C) 2024 Red Hat, Inc.
+ */
+#include "qemu/osdep.h"
+#include "block/block.h"
+#include "qapi/error.h"
+#include "migration/migration.h"
+#include "qemu/error-report.h"
+#include "trace.h"
+
+/*
+ * Migration-only cache to remember the block layer activation status.
+ * Protected by BQL.
+ *
+ * We need this because..
+ *
+ * - Migration can fail after block devices are invalidated (during
+ *   switchover phase).  When that happens, we need to be able to recover
+ *   the block drive status by re-activating them.
+ *
+ * - Currently bdrv_inactivate_all() is not safe to be invoked on top of
+ *   invalidated drives (even if bdrv_activate_all() is actually safe to be
+ *   called any time!).  It means remembering this could help migration to
+ *   make sure it won't invalidate twice in a row, crashing QEMU.  It can
+ *   happen when we migrate a PAUSED VM from host1 to host2, then migrate
+ *   again to host3 without starting it.  TODO: a cleaner solution is to
+ *   allow safe invoke of bdrv_inactivate_all() at anytime, like
+ *   bdrv_activate_all().
+ *
+ * For freshly started QEMU, the flag is initialized to TRUE reflecting the
+ * scenario where QEMU owns block device ownerships.
+ *
+ * For incoming QEMU taking a migration stream, the flag is initialized to
+ * FALSE reflecting that the incoming side doesn't own the block devices,
+ * not until switchover happens.
+ */
+static bool migration_block_active;
+
+/* Setup the disk activation status */
+void migration_block_active_setup(bool active)
+{
+    migration_block_active = active;
+}
+
+bool migration_block_activate(Error **errp)
+{
+    ERRP_GUARD();
+
+    assert(bql_locked());
+
+    if (migration_block_active) {
+        trace_migration_block_activation("active-skipped");
+        return true;
+    }
+
+    trace_migration_block_activation("active");
+
+    bdrv_activate_all(errp);
+    if (*errp) {
+        error_report_err(error_copy(*errp));
+        return false;
+    }
+
+    migration_block_active = true;
+    return true;
+}
+
+bool migration_block_inactivate(void)
+{
+    int ret;
+
+    assert(bql_locked());
+
+    if (!migration_block_active) {
+        trace_migration_block_activation("inactive-skipped");
+        return true;
+    }
+
+    trace_migration_block_activation("inactive");
+
+    ret = bdrv_inactivate_all();
+    if (ret) {
+        error_report("%s: bdrv_inactivate_all() failed: %d",
+                     __func__, ret);
+        return false;
+    }
+
+    migration_block_active = false;
+    return true;
+}
diff --git a/migration/colo.c b/migration/colo.c
index 9590f281d0..ae3387a7a4 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -836,7 +836,7 @@ static void *colo_process_incoming_thread(void *opaque)
 
     /* Make sure all file formats throw away their mutable metadata */
     bql_lock();
-    bdrv_activate_all(&local_err);
+    migration_block_activate(&local_err);
     bql_unlock();
     if (local_err) {
         error_report_err(local_err);
diff --git a/migration/migration.c b/migration/migration.c
index ba5deec5bc..d755ccb03d 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -738,7 +738,6 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
 
 static void process_incoming_migration_bh(void *opaque)
 {
-    Error *local_err = NULL;
     MigrationIncomingState *mis = opaque;
 
     trace_vmstate_downtime_checkpoint("dst-precopy-bh-enter");
@@ -769,11 +768,7 @@ static void process_incoming_migration_bh(void *opaque)
              * Make sure all file formats throw away their mutable
              * metadata.  If error, don't restart the VM yet.
              */
-            bdrv_activate_all(&local_err);
-            if (local_err) {
-                error_report_err(local_err);
-                local_err = NULL;
-            } else {
+            if (migration_block_activate(NULL)) {
                 vm_start();
             }
         } else {
@@ -1552,16 +1547,6 @@ static void migrate_fd_cancel(MigrationState *s)
             }
         }
     }
-    if (s->state == MIGRATION_STATUS_CANCELLING && s->block_inactive) {
-        Error *local_err = NULL;
-
-        bdrv_activate_all(&local_err);
-        if (local_err) {
-            error_report_err(local_err);
-        } else {
-            s->block_inactive = false;
-        }
-    }
 }
 
 void migration_add_notifier_mode(NotifierWithReturn *notify,
@@ -1860,6 +1845,12 @@ void qmp_migrate_incoming(const char *uri, bool has_channels,
         return;
     }
 
+    /*
+     * Newly setup incoming QEMU.  Mark the block active state to reflect
+     * that the src currently owns the disks.
+     */
+    migration_block_active_setup(false);
+
     once = false;
 }
 
@@ -2512,7 +2503,6 @@ static int postcopy_start(MigrationState *ms, Error **errp)
     QIOChannelBuffer *bioc;
     QEMUFile *fb;
     uint64_t bandwidth = migrate_max_postcopy_bandwidth();
-    bool restart_block = false;
     int cur_state = MIGRATION_STATUS_ACTIVE;
 
     if (migrate_postcopy_preempt()) {
@@ -2548,13 +2538,10 @@ static int postcopy_start(MigrationState *ms, Error **errp)
         goto fail;
     }
 
-    ret = bdrv_inactivate_all();
-    if (ret < 0) {
-        error_setg_errno(errp, -ret, "%s: Failed in bdrv_inactivate_all()",
-                         __func__);
+    if (!migration_block_inactivate()) {
+        error_setg(errp, "%s: Failed in bdrv_inactivate_all()", __func__);
         goto fail;
     }
-    restart_block = true;
 
     /*
      * Cause any non-postcopiable, but iterative devices to
@@ -2624,8 +2611,6 @@ static int postcopy_start(MigrationState *ms, Error **errp)
         goto fail_closefb;
     }
 
-    restart_block = false;
-
     /* Now send that blob */
     if (qemu_savevm_send_packaged(ms->to_dst_file, bioc->data, bioc->usage)) {
         error_setg(errp, "%s: Failed to send packaged data", __func__);
@@ -2670,17 +2655,7 @@ fail_closefb:
 fail:
     migrate_set_state(&ms->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
                           MIGRATION_STATUS_FAILED);
-    if (restart_block) {
-        /* A failure happened early enough that we know the destination hasn't
-         * accessed block devices, so we're safe to recover.
-         */
-        Error *local_err = NULL;
-
-        bdrv_activate_all(&local_err);
-        if (local_err) {
-            error_report_err(local_err);
-        }
-    }
+    migration_block_activate(NULL);
     migration_call_notifiers(ms, MIG_EVENT_PRECOPY_FAILED, NULL);
     bql_unlock();
     return -1;
@@ -2778,31 +2753,6 @@ static void migration_completion_postcopy(MigrationState *s)
     trace_migration_completion_postcopy_end_after_complete();
 }
 
-static void migration_completion_failed(MigrationState *s,
-                                        int current_active_state)
-{
-    if (s->block_inactive && (s->state == MIGRATION_STATUS_ACTIVE ||
-                              s->state == MIGRATION_STATUS_DEVICE)) {
-        /*
-         * If not doing postcopy, vm_start() will be called: let's
-         * regain control on images.
-         */
-        Error *local_err = NULL;
-
-        bql_lock();
-        bdrv_activate_all(&local_err);
-        if (local_err) {
-            error_report_err(local_err);
-        } else {
-            s->block_inactive = false;
-        }
-        bql_unlock();
-    }
-
-    migrate_set_state(&s->state, current_active_state,
-                      MIGRATION_STATUS_FAILED);
-}
-
 /**
  * migration_completion: Used by migration_thread when there's not much left.
  *   The caller 'breaks' the loop when this returns.
@@ -2856,7 +2806,8 @@ fail:
         error_free(local_err);
     }
 
-    migration_completion_failed(s, current_active_state);
+    migrate_set_state(&s->state, current_active_state,
+                      MIGRATION_STATUS_FAILED);
 }
 
 /**
@@ -3286,6 +3237,11 @@ static void migration_iteration_finish(MigrationState *s)
     case MIGRATION_STATUS_FAILED:
     case MIGRATION_STATUS_CANCELLED:
     case MIGRATION_STATUS_CANCELLING:
+        /*
+         * Re-activate the block drives if they're inactivated.  Note, COLO
+         * shouldn't use block_active at all, so it should be no-op there.
+         */
+        migration_block_activate(NULL);
         if (runstate_is_live(s->vm_old_state)) {
             if (!runstate_check(RUN_STATE_SHUTDOWN)) {
                 vm_start();
@@ -3858,6 +3814,8 @@ static void migration_instance_init(Object *obj)
     ms->state = MIGRATION_STATUS_NONE;
     ms->mbps = -1;
     ms->pages_per_second = -1;
+    /* Freshly started QEMU owns all the block devices */
+    migration_block_active_setup(true);
     qemu_sem_init(&ms->pause_sem, 0);
     qemu_mutex_init(&ms->error_mutex);
 
diff --git a/migration/savevm.c b/migration/savevm.c
index 706b77ffab..969a994a85 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1547,19 +1547,18 @@ int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
     }
 
     if (inactivate_disks) {
-        /* Inactivate before sending QEMU_VM_EOF so that the
-         * bdrv_activate_all() on the other end won't fail. */
-        ret = bdrv_inactivate_all();
-        if (ret) {
-            error_setg(&local_err, "%s: bdrv_inactivate_all() failed (%d)",
-                       __func__, ret);
+        /*
+         * Inactivate before sending QEMU_VM_EOF so that the
+         * bdrv_activate_all() on the other end won't fail.
+         */
+        if (!migration_block_inactivate()) {
+            error_setg(&local_err, "%s: bdrv_inactivate_all() failed",
+                       __func__);
             migrate_set_error(ms, local_err);
             error_report_err(local_err);
-            qemu_file_set_error(f, ret);
+            qemu_file_set_error(f, -EFAULT);
             return ret;
         }
-        /* Remember that we did this */
-        s->block_inactive = true;
     }
     if (!in_postcopy) {
         /* Postcopy stream will still be going */
@@ -2123,7 +2122,6 @@ static int loadvm_postcopy_handle_listen(MigrationIncomingState *mis)
 
 static void loadvm_postcopy_handle_run_bh(void *opaque)
 {
-    Error *local_err = NULL;
     MigrationIncomingState *mis = opaque;
 
     trace_vmstate_downtime_checkpoint("dst-postcopy-bh-enter");
@@ -2146,12 +2144,11 @@ static void loadvm_postcopy_handle_run_bh(void *opaque)
          * Make sure all file formats throw away their mutable metadata.
          * If we get an error here, just don't restart the VM yet.
          */
-        bdrv_activate_all(&local_err);
+        bool success = migration_block_activate(NULL);
+
         trace_vmstate_downtime_checkpoint("dst-postcopy-bh-cache-invalidated");
-        if (local_err) {
-            error_report_err(local_err);
-            local_err = NULL;
-        } else {
+
+        if (success) {
             vm_start();
         }
     } else {
@@ -3193,11 +3190,7 @@ void qmp_xen_save_devices_state(const char *filename, bool has_live, bool live,
          * side of the migration take control of the images.
          */
         if (live && !saved_vm_running) {
-            ret = bdrv_inactivate_all();
-            if (ret) {
-                error_setg(errp, "%s: bdrv_inactivate_all() failed (%d)",
-                           __func__, ret);
-            }
+            migration_block_inactivate();
         }
     }
 
diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
index 76f21e8af3..6f76d9beaf 100644
--- a/monitor/qmp-cmds.c
+++ b/monitor/qmp-cmds.c
@@ -31,6 +31,7 @@
 #include "qapi/type-helpers.h"
 #include "hw/mem/memory-device.h"
 #include "hw/intc/intc.h"
+#include "migration/misc.h"
 
 NameInfo *qmp_query_name(Error **errp)
 {
@@ -103,13 +104,8 @@ void qmp_cont(Error **errp)
          * Continuing after completed migration. Images have been
          * inactivated to allow the destination to take control. Need to
          * get control back now.
-         *
-         * If there are no inactive block nodes (e.g. because the VM was
-         * just paused rather than completing a migration),
-         * bdrv_inactivate_all() simply doesn't do anything.
          */
-        bdrv_activate_all(&local_err);
-        if (local_err) {
+        if (!migration_block_activate(&local_err)) {
             error_propagate(errp, local_err);
             return;
         }
diff --git a/migration/meson.build b/migration/meson.build
index d53cf3417a..dac687ee3a 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -11,6 +11,7 @@ migration_files = files(
 
 system_ss.add(files(
   'block-dirty-bitmap.c',
+  'block-active.c',
   'channel.c',
   'channel-block.c',
   'cpu-throttle.c',
diff --git a/migration/trace-events b/migration/trace-events
index bb0e0cc6dc..b82a1c5e40 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -383,3 +383,6 @@ migration_pagecache_insert(void) "Error allocating page"
 # cpu-throttle.c
 cpu_throttle_set(int new_throttle_pct)  "set guest CPU throttled by %d%%"
 cpu_throttle_dirty_sync(void) ""
+
+# block-active.c
+migration_block_activation(const char *name) "%s"
-- 
2.47.0


