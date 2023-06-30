Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3A3743D0E
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 15:56:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFEZX-0007xk-2T; Fri, 30 Jun 2023 09:54:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qFEVd-0006EG-Fp
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 09:50:02 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qFEVY-000729-Ad
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 09:50:00 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35UBOa6x015241; Fri, 30 Jun 2023 13:49:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=kiwYCzX887hWBxBC+QPxFiWMy14aHhIJmhwl40QCYJk=;
 b=0CKd8HXC2gBk6LEK/0u8Zs5CuVVrC6uPyzCuEfwW5LvjXZcY6qLZMd9A48KxQqVb25D/
 VKM/eXtuNBx8DffrfFopkrVCtkEEV44OFFdZaB0g0uLlfTbvIt+HCMNkApAgsG5eAhvF
 z+XzXRqWbLHCkGXfOOSfLbUIyhlkTvndM0Y/hHSePeA1KJBNTWtON/GMLzw7A75JTiMH
 mQS57hCbbl7BnzSF1tXdYf+7rwaNCLXNUTZJRrjyxBY36Kh6v1bDk3MadLavTQ1uFyQ+
 x794qCWxEGTkBzhxKdYGAxNZoexiSKT4mIPn535Fhk6shHbSesdUl1pJ+jXaH0pt9omJ og== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdrcagh0r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Jun 2023 13:49:50 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35UDm1cB008587; Fri, 30 Jun 2023 13:49:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3rdpx8v0g1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Jun 2023 13:49:49 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35UDnmMh039660;
 Fri, 30 Jun 2023 13:49:49 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3rdpx8v0f9-2; Fri, 30 Jun 2023 13:49:49 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V2 01/10] vl: start on wakeup request
Date: Fri, 30 Jun 2023 06:49:39 -0700
Message-Id: <1688132988-314397-2-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1688132988-314397-1-git-send-email-steven.sistare@oracle.com>
References: <1688132988-314397-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_05,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306300118
X-Proofpoint-ORIG-GUID: GhiC7AWS3HiboIKcHR8GgBDzxVrPn6lo
X-Proofpoint-GUID: GhiC7AWS3HiboIKcHR8GgBDzxVrPn6lo
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

If qemu starts and loads a VM in the suspended state, then a later wakeup
request directly sets the state to running.  This skips vm_start() and its
initialization steps, which is fatal for the guest.  See
qemu_system_wakeup_request(), and qemu_system_wakeup() in
main_loop_should_exit().

Remember if vm_start has been called.  If not, then call vm_start from
qemu_system_wakeup_request.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/sysemu/runstate.h |  1 +
 softmmu/cpus.c            | 12 ++++++++++++
 softmmu/runstate.c        |  2 +-
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/sysemu/runstate.h b/include/sysemu/runstate.h
index 7beb29c..42ddf83 100644
--- a/include/sysemu/runstate.h
+++ b/include/sysemu/runstate.h
@@ -34,6 +34,7 @@ static inline bool shutdown_caused_by_guest(ShutdownCause cause)
 }
 
 void vm_start(void);
+void vm_wakeup(void);
 
 /**
  * vm_prepare_start: Prepare for starting/resuming the VM
diff --git a/softmmu/cpus.c b/softmmu/cpus.c
index fed20ff..fa9e5ba 100644
--- a/softmmu/cpus.c
+++ b/softmmu/cpus.c
@@ -66,6 +66,7 @@
 #endif /* CONFIG_LINUX */
 
 static QemuMutex qemu_global_mutex;
+static bool vm_started;
 
 /*
  * The chosen accelerator is supposed to register this.
@@ -264,6 +265,7 @@ static int do_vm_stop(RunState state, bool send_stop)
         if (send_stop) {
             qapi_event_send_stop();
         }
+        vm_started = false;
     }
 
     bdrv_drain_all();
@@ -722,6 +724,16 @@ void vm_start(void)
 {
     if (!vm_prepare_start(false)) {
         resume_all_vcpus();
+        vm_started = true;
+    }
+}
+
+void vm_wakeup(void)
+{
+    if (!vm_started) {
+        vm_start();
+    } else {
+        runstate_set(RUN_STATE_RUNNING);
     }
 }
 
diff --git a/softmmu/runstate.c b/softmmu/runstate.c
index 1957caf..5bbb22a 100644
--- a/softmmu/runstate.c
+++ b/softmmu/runstate.c
@@ -580,7 +580,7 @@ void qemu_system_wakeup_request(WakeupReason reason, Error **errp)
     if (!(wakeup_reason_mask & (1 << reason))) {
         return;
     }
-    runstate_set(RUN_STATE_RUNNING);
+    vm_wakeup();
     wakeup_reason = reason;
     qemu_notify_event();
 }
-- 
1.8.3.1


