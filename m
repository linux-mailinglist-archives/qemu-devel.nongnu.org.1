Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E58D08116FE
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 16:32:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDRC1-0004E4-M2; Wed, 13 Dec 2023 10:30:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rDRBw-0004DS-Ik
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 10:30:32 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rDRBs-00070K-Pe
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 10:30:30 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3BDER4QH021056; Wed, 13 Dec 2023 15:30:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=54WE3zIc9WakuDR0Wl+eRiPQLJuKyyI4IJzRdInpsHI=;
 b=aJozJeo91OMQVZ9KMmWPW64orelrQL1iYZmnM3nw2DCaD83aLucEkK0IGfqxRuTDVMZo
 hF4qWOevcF9w1TmKdr9GrbrpwjlPjNmsEcA00G83Ii8y/pPkAXPNnt+PNdj59yzueZ/o
 SQZISMhpVJibAzcUWBDO9CXTX1duBfyGa3TE1QXF85wePI/QezlRxvokx97ydlAS3hA+
 XeCtQ00MYDexf0lANU2O2CNCwAOjquzp6WLZZ3ERtkPvaq+Rqgn5FasXWMwbvzmY3Wzi
 nvvnoaAqkjvmveEuaCQeXsSwq1ljj4CmjTb8COGP/Uc9zUmQkgdTFntiBr4iwCKIUSiR Tg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uvfuu8g80-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Dec 2023 15:30:24 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3BDEpmE1008246; Wed, 13 Dec 2023 15:30:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3uvep8e0rc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Dec 2023 15:30:23 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BDFQXop001263;
 Wed, 13 Dec 2023 15:30:23 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3uvep8e0nt-2; Wed, 13 Dec 2023 15:30:23 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V8 01/12] cpus: vm_was_suspended
Date: Wed, 13 Dec 2023 07:30:10 -0800
Message-Id: <1702481421-375368-2-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1702481421-375368-1-git-send-email-steven.sistare@oracle.com>
References: <1702481421-375368-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-13_08,2023-12-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312130110
X-Proofpoint-GUID: smpv99_q4PdEo68o1HaZjSsI-Akh--Zn
X-Proofpoint-ORIG-GUID: smpv99_q4PdEo68o1HaZjSsI-Akh--Zn
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

Add a state variable to remember if a vm previously transitioned into a
suspended state.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 include/sysemu/runstate.h |  2 ++
 system/cpus.c             | 15 +++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/sysemu/runstate.h b/include/sysemu/runstate.h
index c8c2bd8..88a67e2 100644
--- a/include/sysemu/runstate.h
+++ b/include/sysemu/runstate.h
@@ -51,6 +51,8 @@ int vm_prepare_start(bool step_pending);
 int vm_stop(RunState state);
 int vm_stop_force_state(RunState state);
 int vm_shutdown(void);
+void vm_set_suspended(bool suspended);
+bool vm_get_suspended(void);
 
 typedef enum WakeupReason {
     /* Always keep QEMU_WAKEUP_REASON_NONE = 0 */
diff --git a/system/cpus.c b/system/cpus.c
index a444a74..9f631ab 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -259,6 +259,21 @@ void cpu_interrupt(CPUState *cpu, int mask)
     }
 }
 
+/*
+ * True if the vm was previously suspended, and has not been woken or reset.
+ */
+static int vm_was_suspended;
+
+void vm_set_suspended(bool suspended)
+{
+    vm_was_suspended = suspended;
+}
+
+bool vm_get_suspended(void)
+{
+    return vm_was_suspended;
+}
+
 static int do_vm_stop(RunState state, bool send_stop)
 {
     int ret = 0;
-- 
1.8.3.1


