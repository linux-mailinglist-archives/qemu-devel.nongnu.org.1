Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 426B0823B6F
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 05:33:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLFPW-0000Eq-IT; Wed, 03 Jan 2024 23:32:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rLFPU-0000Ee-6k
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 23:32:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rLFPS-0006YY-Ah
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 23:32:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704342765;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2y4PqDNz+uiOMvJd4g9dzARaABkeK1CiHVGFkAvIoGE=;
 b=X0nYtkxghiJ5GpeGtTwCcLs020yP0y2+74X10QkRuEjOUckQljy8i3MWZbZeCGfRpvULdw
 40R0Bgy96vC5YbCUO7ARcsVtkntdUVW4AWNwf3o6dxcT34skLusuizuzGIbXOARD27aVLQ
 dFezwLHxfa9HxWFdHX7hWPeM0teiWY4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-lidia0e8PmC8FWgnh0TPYQ-1; Wed,
 03 Jan 2024 23:32:40 -0500
X-MC-Unique: lidia0e8PmC8FWgnh0TPYQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AB97F3816D86;
 Thu,  4 Jan 2024 04:32:39 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B126BC15968;
 Thu,  4 Jan 2024 04:32:35 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, Steve Sistare <steven.sistare@oracle.com>,
 Juan Quintela <quintela@trasno.org>, peterx@redhat.com,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>
Subject: [PULL 04/26] cpus: stop vm in suspended runstate
Date: Thu,  4 Jan 2024 12:31:49 +0800
Message-ID: <20240104043213.431566-5-peterx@redhat.com>
In-Reply-To: <20240104043213.431566-1-peterx@redhat.com>
References: <20240104043213.431566-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.601,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Steve Sistare <steven.sistare@oracle.com>

Currently, a vm in the suspended state is not completely stopped.  The VCPUs
have been paused, but the cpu clock still runs, and runstate notifiers for
the transition to stopped have not been called.  This causes problems for
live migration.  Stale cpu timers_state is saved to the migration stream,
causing time errors in the guest when it wakes from suspend, and state that
would have been modified by runstate notifiers is wrong.

Modify vm_stop to completely stop the vm if the current state is suspended,
transition to RUN_STATE_PAUSED, and remember that the machine was suspended.
Modify vm_start to restore the suspended state.

This affects all callers of vm_stop and vm_start, notably, the qapi stop and
cont commands:

  old behavior:
    RUN_STATE_SUSPENDED --> stop --> RUN_STATE_SUSPENDED

  new behavior:
    RUN_STATE_SUSPENDED --> stop --> RUN_STATE_PAUSED
    RUN_STATE_PAUSED    --> cont --> RUN_STATE_SUSPENDED

For example:

    (qemu) info status
    VM status: paused (suspended)

    (qemu) stop
    (qemu) info status
    VM status: paused

    (qemu) system_wakeup
    Error: Unable to wake up: guest is not in suspended state

    (qemu) cont
    (qemu) info status
    VM status: paused (suspended)

    (qemu) system_wakeup
    (qemu) info status
    VM status: running

Suggested-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/1704312341-66640-3-git-send-email-steven.sistare@oracle.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 qapi/misc.json            | 11 +++++++++--
 qapi/run-state.json       |  6 +++---
 include/sysemu/runstate.h |  9 +++++++++
 system/cpus.c             | 23 +++++++++++++++--------
 system/runstate.c         |  3 +++
 5 files changed, 39 insertions(+), 13 deletions(-)

diff --git a/qapi/misc.json b/qapi/misc.json
index cda2effa81..3622d98d01 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -134,7 +134,7 @@
 ##
 # @stop:
 #
-# Stop all guest VCPU execution.
+# Stop guest VM execution.
 #
 # Since: 0.14
 #
@@ -143,6 +143,9 @@
 #     the guest remains paused once migration finishes, as if the -S
 #     option was passed on the command line.
 #
+#     In the "suspended" state, it will completely stop the VM and
+#     cause a transition to the "paused" state. (Since 9.0)
+#
 # Example:
 #
 # -> { "execute": "stop" }
@@ -153,7 +156,7 @@
 ##
 # @cont:
 #
-# Resume guest VCPU execution.
+# Resume guest VM execution.
 #
 # Since: 0.14
 #
@@ -165,6 +168,10 @@
 #     guest starts once migration finishes, removing the effect of the
 #     -S command line option if it was passed.
 #
+#     If the VM was previously suspended, and not been reset or woken,
+#     this command will transition back to the "suspended" state.
+#     (Since 9.0)
+#
 # Example:
 #
 # -> { "execute": "cont" }
diff --git a/qapi/run-state.json b/qapi/run-state.json
index f216ba54ec..ca05502e0a 100644
--- a/qapi/run-state.json
+++ b/qapi/run-state.json
@@ -102,7 +102,7 @@
 ##
 # @StatusInfo:
 #
-# Information about VCPU run state
+# Information about VM run state
 #
 # @running: true if all VCPUs are runnable, false if not runnable
 #
@@ -130,9 +130,9 @@
 ##
 # @query-status:
 #
-# Query the run status of all VCPUs
+# Query the run status of the VM
 #
-# Returns: @StatusInfo reflecting all VCPUs
+# Returns: @StatusInfo reflecting the VM
 #
 # Since: 0.14
 #
diff --git a/include/sysemu/runstate.h b/include/sysemu/runstate.h
index 88a67e22b0..618eb491af 100644
--- a/include/sysemu/runstate.h
+++ b/include/sysemu/runstate.h
@@ -40,6 +40,15 @@ static inline bool shutdown_caused_by_guest(ShutdownCause cause)
     return cause >= SHUTDOWN_CAUSE_GUEST_SHUTDOWN;
 }
 
+/*
+ * In a "live" state, the vcpu clock is ticking, and the runstate notifiers
+ * think we are running.
+ */
+static inline bool runstate_is_live(RunState state)
+{
+    return state == RUN_STATE_RUNNING || state == RUN_STATE_SUSPENDED;
+}
+
 void vm_start(void);
 
 /**
diff --git a/system/cpus.c b/system/cpus.c
index 9f631ab734..f162435dd4 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -277,11 +277,15 @@ bool vm_get_suspended(void)
 static int do_vm_stop(RunState state, bool send_stop)
 {
     int ret = 0;
+    RunState oldstate = runstate_get();
 
-    if (runstate_is_running()) {
+    if (runstate_is_live(oldstate)) {
+        vm_was_suspended = (oldstate == RUN_STATE_SUSPENDED);
         runstate_set(state);
         cpu_disable_ticks();
-        pause_all_vcpus();
+        if (oldstate == RUN_STATE_RUNNING) {
+            pause_all_vcpus();
+        }
         vm_state_notify(0, state);
         if (send_stop) {
             qapi_event_send_stop();
@@ -694,11 +698,13 @@ int vm_stop(RunState state)
 
 /**
  * Prepare for (re)starting the VM.
- * Returns -1 if the vCPUs are not to be restarted (e.g. if they are already
- * running or in case of an error condition), 0 otherwise.
+ * Returns 0 if the vCPUs should be restarted, -1 on an error condition,
+ * and 1 otherwise.
  */
 int vm_prepare_start(bool step_pending)
 {
+    int ret = vm_was_suspended ? 1 : 0;
+    RunState state = vm_was_suspended ? RUN_STATE_SUSPENDED : RUN_STATE_RUNNING;
     RunState requested;
 
     qemu_vmstop_requested(&requested);
@@ -729,9 +735,10 @@ int vm_prepare_start(bool step_pending)
     qapi_event_send_resume();
 
     cpu_enable_ticks();
-    runstate_set(RUN_STATE_RUNNING);
-    vm_state_notify(1, RUN_STATE_RUNNING);
-    return 0;
+    runstate_set(state);
+    vm_state_notify(1, state);
+    vm_was_suspended = false;
+    return ret;
 }
 
 void vm_start(void)
@@ -745,7 +752,7 @@ void vm_start(void)
    current state is forgotten forever */
 int vm_stop_force_state(RunState state)
 {
-    if (runstate_is_running()) {
+    if (runstate_is_live(runstate_get())) {
         return vm_stop(state);
     } else {
         int ret;
diff --git a/system/runstate.c b/system/runstate.c
index ea9d6c2a32..e2fa2040cb 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -108,6 +108,7 @@ static const RunStateTransition runstate_transitions_def[] = {
     { RUN_STATE_PAUSED, RUN_STATE_POSTMIGRATE },
     { RUN_STATE_PAUSED, RUN_STATE_PRELAUNCH },
     { RUN_STATE_PAUSED, RUN_STATE_COLO},
+    { RUN_STATE_PAUSED, RUN_STATE_SUSPENDED},
 
     { RUN_STATE_POSTMIGRATE, RUN_STATE_RUNNING },
     { RUN_STATE_POSTMIGRATE, RUN_STATE_FINISH_MIGRATE },
@@ -161,6 +162,7 @@ static const RunStateTransition runstate_transitions_def[] = {
     { RUN_STATE_SUSPENDED, RUN_STATE_FINISH_MIGRATE },
     { RUN_STATE_SUSPENDED, RUN_STATE_PRELAUNCH },
     { RUN_STATE_SUSPENDED, RUN_STATE_COLO},
+    { RUN_STATE_SUSPENDED, RUN_STATE_PAUSED},
 
     { RUN_STATE_WATCHDOG, RUN_STATE_RUNNING },
     { RUN_STATE_WATCHDOG, RUN_STATE_FINISH_MIGRATE },
@@ -502,6 +504,7 @@ void qemu_system_reset(ShutdownCause reason)
         qapi_event_send_reset(shutdown_caused_by_guest(reason), reason);
     }
     cpu_synchronize_all_post_reset();
+    vm_set_suspended(false);
 }
 
 /*
-- 
2.41.0


