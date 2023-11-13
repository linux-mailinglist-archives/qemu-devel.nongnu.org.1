Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CA37EA2EC
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 19:34:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2blN-0003Ne-OH; Mon, 13 Nov 2023 13:34:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1r2blA-0003HP-L2
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 13:34:08 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1r2bl8-0003Bh-U1
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 13:34:08 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3ADHi6Xt017368; Mon, 13 Nov 2023 18:34:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=trLkVX2MuDhZfouukG0T49HfQPzvXxSvNnI2I+xo8CE=;
 b=f82qkgfbuU8DXDUClL4UFjQm7pwY9kSWi9VP5Zcp3ZasdoxyQpeXQBM6cVYKBTMmZJQ9
 LpTD7BDeSSsk9Da+sVPpdJOt2vbPTlYiGO+dOl0DfTKw8+mperZ2crC/odlno0/6qbMT
 mry+Wjpq7X3E1vrfgJBUoQbFLpOXiPFVQi1vohYlOFdZb9kKsYaW+f+dypB6kqfW0SRA
 0KfU9blyCWpi+JfByhr0jj1ehlBnm2F5bRDreONZANMtvDenyWy1Y9oK0LVN3tSbS55X
 2xc5OtRr+tlV4wcPR9RxezFdoS2PVZUmVQsAbrwbz+zOSrF/lbntSKDO9T/KPj/sGH+z 2A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2mdkj9t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Nov 2023 18:34:05 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3ADII4Zn004746; Mon, 13 Nov 2023 18:34:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3ub5k23k2s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Nov 2023 18:34:05 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ADIY2JW026498;
 Mon, 13 Nov 2023 18:34:04 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 3ub5k23k09-3; Mon, 13 Nov 2023 18:34:04 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V5 02/12] cpus: stop vm in suspended state
Date: Mon, 13 Nov 2023 10:33:50 -0800
Message-Id: <1699900440-207345-3-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: _0o81syBDORKOdkznScNeH8RrrLhoyol
X-Proofpoint-ORIG-GUID: _0o81syBDORKOdkznScNeH8RrrLhoyol
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

A vm in the suspended state is not completely stopped.  The VCPUs have been
paused, but the cpu clock still runs, and runstate notifiers for the
transition to stopped have not been called.  Modify vm_stop_force_state to
completely stop the vm if the current state is suspended, to be called for
live migration and snapshots.

Suggested-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 system/cpus.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/system/cpus.c b/system/cpus.c
index f72c4be..c772708 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -255,6 +255,8 @@ void cpu_interrupt(CPUState *cpu, int mask)
 static int do_vm_stop(RunState state, bool send_stop, bool force)
 {
     int ret = 0;
+    bool running = runstate_is_running();
+    bool suspended = runstate_check(RUN_STATE_SUSPENDED);
 
     if (qemu_in_vcpu_thread()) {
         qemu_system_vmstop_request_prepare();
@@ -267,10 +269,12 @@ static int do_vm_stop(RunState state, bool send_stop, bool force)
         return 0;
     }
 
-    if (runstate_is_running()) {
+    if (running || (suspended && force)) {
         runstate_set(state);
         cpu_disable_ticks();
-        pause_all_vcpus();
+        if (running) {
+            pause_all_vcpus();
+        }
         vm_state_notify(0, state);
         if (send_stop) {
             qapi_event_send_stop();
-- 
1.8.3.1


