Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4507320EC
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 22:28:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9tYQ-00027z-Sm; Thu, 15 Jun 2023 16:26:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1q9tYO-000276-2N
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 16:26:48 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1q9tYM-0002FX-3g
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 16:26:47 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35FGJfdh020988; Thu, 15 Jun 2023 20:26:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=k9E5SkWUyLMpg/oNeAVlDfuTHwYVmes7KQkYR+YKRQc=;
 b=tDjm5sNDSaIH6Td0GAyHCfqtDUXTUxh0TtgVvwNux/4be/0mVYwvPT5NS1zFW1PPPkXJ
 ibww+4VW8QlNHcbzlz5ikS5JN4w/LeTMt3UZelbM5S95IVhGKwqjCJ5iuo3cjuyupAox
 xA9M8I4fsn7rApxNO2RCWUv+MzCGIgfg/IZ6l9tDSW2Sq8q6w2I2O97eDhxgxfkqBKOV
 VfToTUXyr8uREj46bkUdWqKnMnFj9sNaOe0EmjHcSbSSUQRAS1G9bUQEgLZZZ4Gvrqmm
 nECJkh5APuGiJqnWlB3iqUgbyGIFOb2Mrn4KfqBVJoJTcnzneAw/1YdZVSAWRTGnEciO Lg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4hqutye8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 Jun 2023 20:26:42 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35FK5g27038872; Thu, 15 Jun 2023 20:26:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3r4fm75mne-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 Jun 2023 20:26:41 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35FKQeq6003391;
 Thu, 15 Jun 2023 20:26:41 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3r4fm75mmg-2; Thu, 15 Jun 2023 20:26:41 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V1 1/3] vl: start on wakeup request
Date: Thu, 15 Jun 2023 13:26:38 -0700
Message-Id: <1686860800-34667-2-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1686860800-34667-1-git-send-email-steven.sistare@oracle.com>
References: <1686860800-34667-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-15_16,2023-06-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306150176
X-Proofpoint-ORIG-GUID: jOSy7BMwJ6xVWTTlNQIJLROvNzP5cedF
X-Proofpoint-GUID: jOSy7BMwJ6xVWTTlNQIJLROvNzP5cedF
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
request sets the state to running and tries to start execution, but it
bypasses vm_start() and its initialization steps, which is fatal for the
guest.  See qemu_system_wakeup_request(), and qemu_system_wakeup() in
main_loop_should_exit().

Define the start_on_wakeup_requested() hook to cause vm_start() to be called
when processing the wakeup request.  This will be called in a subsequent
migration patch.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/sysemu/runstate.h |  1 +
 softmmu/runstate.c        | 15 ++++++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/sysemu/runstate.h b/include/sysemu/runstate.h
index 7beb29c..c12ad7d 100644
--- a/include/sysemu/runstate.h
+++ b/include/sysemu/runstate.h
@@ -57,6 +57,7 @@ void qemu_system_reset_request(ShutdownCause reason);
 void qemu_system_suspend_request(void);
 void qemu_register_suspend_notifier(Notifier *notifier);
 bool qemu_wakeup_suspend_enabled(void);
+void qemu_system_start_on_wakeup_request(void);
 void qemu_system_wakeup_request(WakeupReason reason, Error **errp);
 void qemu_system_wakeup_enable(WakeupReason reason, bool enabled);
 void qemu_register_wakeup_notifier(Notifier *notifier);
diff --git a/softmmu/runstate.c b/softmmu/runstate.c
index 1957caf..e127b21 100644
--- a/softmmu/runstate.c
+++ b/softmmu/runstate.c
@@ -343,6 +343,7 @@ void vm_state_notify(bool running, RunState state)
     }
 }
 
+static bool start_on_wakeup_requested;
 static ShutdownCause reset_requested;
 static ShutdownCause shutdown_requested;
 static int shutdown_signal;
@@ -568,6 +569,11 @@ void qemu_register_suspend_notifier(Notifier *notifier)
     notifier_list_add(&suspend_notifiers, notifier);
 }
 
+void qemu_system_start_on_wakeup_request(void)
+{
+    start_on_wakeup_requested = true;
+}
+
 void qemu_system_wakeup_request(WakeupReason reason, Error **errp)
 {
     trace_system_wakeup_request(reason);
@@ -580,7 +586,14 @@ void qemu_system_wakeup_request(WakeupReason reason, Error **errp)
     if (!(wakeup_reason_mask & (1 << reason))) {
         return;
     }
-    runstate_set(RUN_STATE_RUNNING);
+
+    if (start_on_wakeup_requested) {
+        start_on_wakeup_requested = false;
+        vm_start();
+    } else {
+        runstate_set(RUN_STATE_RUNNING);
+    }
+
     wakeup_reason = reason;
     qemu_notify_event();
 }
-- 
1.8.3.1


