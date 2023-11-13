Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CF4A7EA2F8
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 19:36:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2blW-0004J3-4R; Mon, 13 Nov 2023 13:34:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1r2blD-0003Nd-R7
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 13:34:12 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1r2blC-0003CI-99
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 13:34:11 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3ADHi6aL009373; Mon, 13 Nov 2023 18:34:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=DX2olWKBBfJnffVKjIa6OPm7Ce1k7PrfA7mU0ZmfExM=;
 b=1MNgC1X8t0BCd2QjAzod1DiNdkhKQ1G9fuXWcwCtUwq3Uo9gGj7vumui7pOYT7ruQxTE
 1rLrl1ilQ5qO9lfwnJJPrztLYmwKyzUlvk3+gbZOyAFfZ7wngTrfA4/mRGWhJg2xxdLD
 neyymNLta7NhfgyWMyOaikyR9xjRX+cO1hmiLYG3r5IpoTrD0Yq5jXpZsUf4QiphgETq
 uMhAunqrRJTJCFIuAIUI5Ze+0JNVjZvKeveCuALbBIprVaE5EDOXqi0zjN1SSHt3shPr
 EvWqQUxiULB/YW/RlEv/2lmJGLY/PzVZkHlUbhjzKZNUDGX0z35nuu0P6hYG6jX4BgNJ bA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2qd3fxh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Nov 2023 18:34:08 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3ADIXqFm004521; Mon, 13 Nov 2023 18:34:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3ub5k23k46-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Nov 2023 18:34:07 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ADIY2Ja026498;
 Mon, 13 Nov 2023 18:34:07 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 3ub5k23k09-5; Mon, 13 Nov 2023 18:34:07 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V5 04/12] cpus: start vm in suspended state
Date: Mon, 13 Nov 2023 10:33:52 -0800
Message-Id: <1699900440-207345-5-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-ORIG-GUID: tJyye2gBEq5KeRVstInNmnf31ZXUDUqy
X-Proofpoint-GUID: tJyye2gBEq5KeRVstInNmnf31ZXUDUqy
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

Provide the vm_resume helper which resumes the vm in the requested state,
correctly restoring the suspended state.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/sysemu/runstate.h |  8 ++++++++
 system/cpus.c             | 11 +++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/sysemu/runstate.h b/include/sysemu/runstate.h
index 9e78c7f..3fa28a4 100644
--- a/include/sysemu/runstate.h
+++ b/include/sysemu/runstate.h
@@ -50,6 +50,14 @@ void vm_start(void);
  */
 int vm_prepare_start(bool step_pending, RunState state);
 
+/**
+ * vm_resume: If @state is a running state, start the vm and set the state,
+ * else just set the state.
+ *
+ * @state: the state to restore
+ */
+void vm_resume(RunState state);
+
 int vm_stop(RunState state);
 int vm_stop_force_state(RunState state);
 int vm_shutdown(void);
diff --git a/system/cpus.c b/system/cpus.c
index 4d05d83..1d867bb 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -725,6 +725,17 @@ void vm_start(void)
     }
 }
 
+void vm_resume(RunState state)
+{
+    if (state == RUN_STATE_RUNNING) {
+        vm_start();
+    } else if (state == RUN_STATE_SUSPENDED) {
+        vm_prepare_start(false, state);
+    } else {
+        runstate_set(state);
+    }
+}
+
 /* does a state transition even if the VM is already stopped,
    current state is forgotten forever */
 int vm_stop_force_state(RunState state)
-- 
1.8.3.1


