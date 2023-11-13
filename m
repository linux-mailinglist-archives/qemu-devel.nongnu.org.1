Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF887EA2ED
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 19:34:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2blP-0003Wk-UP; Mon, 13 Nov 2023 13:34:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1r2blB-0003Hu-20
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 13:34:10 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1r2bl9-0003BV-Bp
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 13:34:08 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3ADHiPH7022269; Mon, 13 Nov 2023 18:34:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=JxpJlagSxmfErnErUUXmK55J23K6bwiGGc8na1M8cf0=;
 b=f0KKVHXjkTeoB0LvYUVMYYkpz2QQu9X5+y2x75XrmvtW1hIUCUAKYfzrMw9cqDJzyDPV
 LbxbnbBr4Mc2vbyrQ8EU7L4mDImvWhcj27Hw0EGuxk4UElpgztY//RPz1o0PFv+rUC1I
 4eAoDP46/qeG5FBdg7aQqMwKQOsO6aFfRLpbOFqZncp4fuN2X0ZuCpowwXtkHimHxOuw
 AiuDTOtRybVq6DicUOGvFWLD3C8vwwGfXvt/HAbao3RajL4Q/+7+94/PaAes8f6NSX1M
 YTovo2X1Dm02o7FYbUJPl9RAQfV5XqujpkOzYCRcMhT4kY4eV2XXugfPjX6NGHwPio53 FA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2stkfkk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Nov 2023 18:34:05 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3ADILdkd004490; Mon, 13 Nov 2023 18:34:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3ub5k23k1y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Nov 2023 18:34:03 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ADIY2JU026498;
 Mon, 13 Nov 2023 18:34:03 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 3ub5k23k09-2; Mon, 13 Nov 2023 18:34:03 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V5 01/12] cpus: refactor vm_stop
Date: Mon, 13 Nov 2023 10:33:49 -0800
Message-Id: <1699900440-207345-2-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1699900440-207345-1-git-send-email-steven.sistare@oracle.com>
References: <1699900440-207345-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-13_09,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999
 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311130151
X-Proofpoint-GUID: vRZ_489pel1K9v3u7izlygf5ctxzrp2m
X-Proofpoint-ORIG-GUID: vRZ_489pel1K9v3u7izlygf5ctxzrp2m
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

Refactor the vm_stop functions into one common subroutine do_vm_stop called
with options.  No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 system/cpus.c | 44 +++++++++++++++++---------------------------
 1 file changed, 17 insertions(+), 27 deletions(-)

diff --git a/system/cpus.c b/system/cpus.c
index 0848e0d..f72c4be 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -252,10 +252,21 @@ void cpu_interrupt(CPUState *cpu, int mask)
     }
 }
 
-static int do_vm_stop(RunState state, bool send_stop)
+static int do_vm_stop(RunState state, bool send_stop, bool force)
 {
     int ret = 0;
 
+    if (qemu_in_vcpu_thread()) {
+        qemu_system_vmstop_request_prepare();
+        qemu_system_vmstop_request(state);
+        /*
+         * FIXME: should not return to device code in case
+         * vm_stop() has been requested.
+         */
+        cpu_stop_current();
+        return 0;
+    }
+
     if (runstate_is_running()) {
         runstate_set(state);
         cpu_disable_ticks();
@@ -264,6 +275,8 @@ static int do_vm_stop(RunState state, bool send_stop)
         if (send_stop) {
             qapi_event_send_stop();
         }
+    } else if (force) {
+        runstate_set(state);
     }
 
     bdrv_drain_all();
@@ -278,7 +291,7 @@ static int do_vm_stop(RunState state, bool send_stop)
  */
 int vm_shutdown(void)
 {
-    return do_vm_stop(RUN_STATE_SHUTDOWN, false);
+    return do_vm_stop(RUN_STATE_SHUTDOWN, false, false);
 }
 
 bool cpu_can_run(CPUState *cpu)
@@ -656,18 +669,7 @@ void cpu_stop_current(void)
 
 int vm_stop(RunState state)
 {
-    if (qemu_in_vcpu_thread()) {
-        qemu_system_vmstop_request_prepare();
-        qemu_system_vmstop_request(state);
-        /*
-         * FIXME: should not return to device code in case
-         * vm_stop() has been requested.
-         */
-        cpu_stop_current();
-        return 0;
-    }
-
-    return do_vm_stop(state, true);
+    return do_vm_stop(state, true, false);
 }
 
 /**
@@ -723,19 +725,7 @@ void vm_start(void)
    current state is forgotten forever */
 int vm_stop_force_state(RunState state)
 {
-    if (runstate_is_running()) {
-        return vm_stop(state);
-    } else {
-        int ret;
-        runstate_set(state);
-
-        bdrv_drain_all();
-        /* Make sure to return an error if the flush in a previous vm_stop()
-         * failed. */
-        ret = bdrv_flush_all();
-        trace_vm_stop_flush_all(ret);
-        return ret;
-    }
+    return do_vm_stop(state, true, true);
 }
 
 void qmp_memsave(int64_t addr, int64_t size, const char *filename,
-- 
1.8.3.1


