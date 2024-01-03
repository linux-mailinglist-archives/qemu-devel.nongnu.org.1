Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B9282362E
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 21:09:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rL7YQ-0002rE-Lm; Wed, 03 Jan 2024 15:09:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rL7YN-0002nc-OQ
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 15:09:27 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rL7YL-00030u-Sc
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 15:09:27 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 403JXUsC027022; Wed, 3 Jan 2024 20:05:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=x+u+GMacxwrn64ie5Ex4xyhexUAdtayAFySg/cuy1nU=;
 b=JMn3aIknH1/t0BLXjYeLQDymo3QaEvSIemG2+jMgR7hFhIFr6iWqQYOYsEjy501r6UAm
 0Wr4TcW2pzETpB2oDvGvm30ii8IduWjHniHH6twUWFBN0XsP9+UgKjVWs5jnXZdJ2C9r
 X26oILjd4lledhbpGHYgpo5N2HlhencGTN1iOflIXLseiBsvvXWfTk07iT8tRG6cCscn
 J5l5PBKdltN2fiTZVeLVfdE67z/a7sisxshUDZ4lI5Et72YP5rFEplUWQfbo73RY0cuz
 Qy4ZfFKJmT5lTa4Cjb4bM+PxRVL/dubu0CrlWJOh6fU5Gos7XFvbNZY13pesl5LEIuDK hQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vaatu5qsv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 03 Jan 2024 20:05:47 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 403K2519014127; Wed, 3 Jan 2024 20:05:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3vddsvtbdr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 03 Jan 2024 20:05:45 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 403K2UZf020511;
 Wed, 3 Jan 2024 20:05:45 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3vddsvtba4-3; Wed, 03 Jan 2024 20:05:45 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Anthony PERARD <anthony.perard@citrix.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Paul Durrant <paul@xen.org>, Eric Blake <eblake@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V9 02/12] cpus: stop vm in suspended runstate
Date: Wed,  3 Jan 2024 12:05:31 -0800
Message-Id: <1704312341-66640-3-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1704312341-66640-1-git-send-email-steven.sistare@oracle.com>
References: <1704312341-66640-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-03_08,2024-01-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0
 suspectscore=0 mlxscore=0 adultscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401030162
X-Proofpoint-GUID: _wOUPE0ha4-x2mJ6GpzyFFjod0Ycl5FD
X-Proofpoint-ORIG-GUID: _wOUPE0ha4-x2mJ6GpzyFFjod0Ycl5FD
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
---
 include/sysemu/runstate.h |  9 +++++++++
 qapi/misc.json            | 11 +++++++++--
 qapi/run-state.json       |  6 +++---
 system/cpus.c             | 23 +++++++++++++++--------
 system/runstate.c         |  3 +++
 5 files changed, 39 insertions(+), 13 deletions(-)

diff --git a/include/sysemu/runstate.h b/include/sysemu/runstate.h
index 88a67e2..618eb49 100644
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
diff --git a/qapi/misc.json b/qapi/misc.json
index cda2eff..3622d98 100644
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
index f216ba5..ca05502 100644
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
diff --git a/system/cpus.c b/system/cpus.c
index 9f631ab..f162435 100644
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
index ea9d6c2..e2fa204 100644
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
1.8.3.1


