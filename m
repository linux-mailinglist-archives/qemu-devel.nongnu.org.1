Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2B97FFDAC
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 22:38:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8oj9-0001mx-8Y; Thu, 30 Nov 2023 16:37:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1r8oj6-0001k4-89
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 16:37:40 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1r8oj1-0000lh-Km
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 16:37:39 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AULU3ga026237; Thu, 30 Nov 2023 21:37:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=Gd+w+A+YJpN/zJNVARt6Cl7goOfGTwX8Vf570VwZKqI=;
 b=jTPZ4nABYy5mlkTmG85lpFs24bCuodKRqPZ+i6W51gZkh5sERuX14LeW8s0twLX/x/RN
 W+3S0mSe73ZD9O2RpWLX5Q7z88JgeVm0njq9e+x86M1ekX+r4KMiI9eCPL0M4AJv/QVG
 WCw004Sb5H42kWxoi/nWGZndMoKp6fELICiL5mpMoi+JuPfV47Mfld5DJ6B7t5NIoNvA
 XX2vDAEmbIJt7gF92DSONEQvM/DS88kbcwPVMRdu2H3CbQpFLUl3rT7qJ0agHGK5mUwn
 0v/YyMJV6EI3Jj/87AKeJVqzMj6a2rTzbxYd6e9SKaMoX6Q04THgcfiDPWtt4qR/ndHD EQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uq21n82yy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Nov 2023 21:37:32 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3AULKUne012746; Thu, 30 Nov 2023 21:37:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3uk7cgt0me-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Nov 2023 21:37:31 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AULbTfx016589;
 Thu, 30 Nov 2023 21:37:30 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 3uk7cgt0jh-2; Thu, 30 Nov 2023 21:37:30 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V6 01/14] cpus: pass runstate to vm_prepare_start
Date: Thu, 30 Nov 2023 13:37:14 -0800
Message-Id: <1701380247-340457-2-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1701380247-340457-1-git-send-email-steven.sistare@oracle.com>
References: <1701380247-340457-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-30_21,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 mlxscore=0
 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311300158
X-Proofpoint-GUID: ReDecOnomHBfJiZMIL4fWKK6ps2UBZMF
X-Proofpoint-ORIG-GUID: ReDecOnomHBfJiZMIL4fWKK6ps2UBZMF
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

When a vm in the suspended state is migrated, we must call vm_prepare_start
on the destination, so a later system_wakeup properly resumes the guest,
when main_loop_should_exit calls resume_all_vcpus.  However, the runstate
should remain suspended until system_wakeup is called, so allow the caller
to pass the new state to vm_prepare_start, rather than assume the new state
is RUN_STATE_RUNNING.  Modify vm state change handlers that check
RUN_STATE_RUNNING to instead use the running parameter.

No functional change.

Suggested-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 backends/tpm/tpm_emulator.c | 2 +-
 gdbstub/system.c            | 2 +-
 hw/usb/hcd-ehci.c           | 2 +-
 hw/usb/redirect.c           | 2 +-
 hw/xen/xen-hvm-common.c     | 2 +-
 include/sysemu/runstate.h   | 4 +++-
 system/cpus.c               | 8 ++++----
 7 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
index f7f1b4a..254fce7 100644
--- a/backends/tpm/tpm_emulator.c
+++ b/backends/tpm/tpm_emulator.c
@@ -904,7 +904,7 @@ static void tpm_emulator_vm_state_change(void *opaque, bool running,
 
     trace_tpm_emulator_vm_state_change(running, state);
 
-    if (!running || state != RUN_STATE_RUNNING || !tpm_emu->relock_storage) {
+    if (!running || !tpm_emu->relock_storage) {
         return;
     }
 
diff --git a/gdbstub/system.c b/gdbstub/system.c
index 783ac14..7ab9f82 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -570,7 +570,7 @@ int gdb_continue_partial(char *newstates)
             }
         }
 
-        if (vm_prepare_start(step_requested)) {
+        if (vm_prepare_start(step_requested, RUN_STATE_RUNNING)) {
             return 0;
         }
 
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
index 19b4534..10c82ce 100644
--- a/hw/usb/hcd-ehci.c
+++ b/hw/usb/hcd-ehci.c
@@ -2451,7 +2451,7 @@ static void usb_ehci_vm_state_change(void *opaque, bool running, RunState state)
      * USB-devices which have async handled packages have a packet in the
      * ep queue to match the completion with.
      */
-    if (state == RUN_STATE_RUNNING) {
+    if (running) {
         ehci_advance_async_state(ehci);
     }
 
diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index c9893df..3785bb0 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -1403,7 +1403,7 @@ static void usbredir_vm_state_change(void *priv, bool running, RunState state)
 {
     USBRedirDevice *dev = priv;
 
-    if (state == RUN_STATE_RUNNING && dev->parser != NULL) {
+    if (running && dev->parser != NULL) {
         usbredirparser_do_write(dev->parser); /* Flush any pending writes */
     }
 }
diff --git a/hw/xen/xen-hvm-common.c b/hw/xen/xen-hvm-common.c
index 565dc39..47e6cb1 100644
--- a/hw/xen/xen-hvm-common.c
+++ b/hw/xen/xen-hvm-common.c
@@ -623,7 +623,7 @@ void xen_hvm_change_state_handler(void *opaque, bool running,
 
     xen_set_ioreq_server_state(xen_domid,
                                state->ioservid,
-                               (rstate == RUN_STATE_RUNNING));
+                               running);
 }
 
 void xen_exit_notifier(Notifier *n, void *data)
diff --git a/include/sysemu/runstate.h b/include/sysemu/runstate.h
index c8c2bd8..9e78c7f 100644
--- a/include/sysemu/runstate.h
+++ b/include/sysemu/runstate.h
@@ -46,8 +46,10 @@ void vm_start(void);
  * vm_prepare_start: Prepare for starting/resuming the VM
  *
  * @step_pending: whether any of the CPUs is about to be single-stepped by gdb
+ * @state: the vm state to setup
  */
-int vm_prepare_start(bool step_pending);
+int vm_prepare_start(bool step_pending, RunState state);
+
 int vm_stop(RunState state);
 int vm_stop_force_state(RunState state);
 int vm_shutdown(void);
diff --git a/system/cpus.c b/system/cpus.c
index a444a74..0c60d7a 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -682,7 +682,7 @@ int vm_stop(RunState state)
  * Returns -1 if the vCPUs are not to be restarted (e.g. if they are already
  * running or in case of an error condition), 0 otherwise.
  */
-int vm_prepare_start(bool step_pending)
+int vm_prepare_start(bool step_pending, RunState state)
 {
     RunState requested;
 
@@ -714,14 +714,14 @@ int vm_prepare_start(bool step_pending)
     qapi_event_send_resume();
 
     cpu_enable_ticks();
-    runstate_set(RUN_STATE_RUNNING);
-    vm_state_notify(1, RUN_STATE_RUNNING);
+    runstate_set(state);
+    vm_state_notify(1, state);
     return 0;
 }
 
 void vm_start(void)
 {
-    if (!vm_prepare_start(false)) {
+    if (!vm_prepare_start(false, RUN_STATE_RUNNING)) {
         resume_all_vcpus();
     }
 }
-- 
1.8.3.1


