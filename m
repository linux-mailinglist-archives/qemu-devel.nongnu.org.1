Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 316637FFDA7
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 22:38:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8ojF-0001pU-Ss; Thu, 30 Nov 2023 16:37:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1r8oj7-0001mS-O2
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 16:37:41 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1r8oj6-0000mD-1V
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 16:37:41 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AULbadi004994; Thu, 30 Nov 2023 21:37:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=+PgQmi+GvWDqrpP2J8L93xNcystEa+GSrFvhUOEQWHA=;
 b=l9fVVdRX53esYVVfbQ5UaVf/SK/QbZbv4S3Vov3VU2h+V3qqNTFBSF+agUQPqRGjtexu
 jC98btQSBFC3XyU9lIcKwxbLu6sLWo2b9UEusn9GwdjPpPgfSAjLRuK3U35xaaZqgRTe
 fm7A22rbuTxH+kbiOvu6uwXGQNDJQV+Z9qOihS8jyOyoq5DKQyQ7GbAOYAqIGBaKovhW
 zg7HYrJGZRwj4JXOadD8VsVfIQEifpD+2VCiNnXEsCmMhLcTx+RU4nlFlaAtn6lEPAKi
 Ba3coDKZ+Ji1mvbjLEcXo5DojjpieFP3Rx5uKXOBdPKuT9XkhLs66Xk9DYoJxmGiw6vf Yw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uq2ffr00f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Nov 2023 21:37:36 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3AUKH2ev012657; Thu, 30 Nov 2023 21:37:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3uk7cgt0pk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Nov 2023 21:37:34 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AULbTg5016589;
 Thu, 30 Nov 2023 21:37:34 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 3uk7cgt0jh-5; Thu, 30 Nov 2023 21:37:34 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V6 04/14] cpus: vm_resume
Date: Thu, 30 Nov 2023 13:37:17 -0800
Message-Id: <1701380247-340457-5-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: zeS9bqa0_AIsDDDBivRMkz4yHykZyCa8
X-Proofpoint-ORIG-GUID: zeS9bqa0_AIsDDDBivRMkz4yHykZyCa8
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

Define the vm_resume helper, for use in subsequent patches.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/sysemu/runstate.h | 8 ++++++++
 system/cpus.c             | 9 +++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/sysemu/runstate.h b/include/sysemu/runstate.h
index 1d6828f..a900cec 100644
--- a/include/sysemu/runstate.h
+++ b/include/sysemu/runstate.h
@@ -55,6 +55,14 @@ void vm_start(void);
  */
 int vm_prepare_start(bool step_pending, RunState state);
 
+/**
+ * vm_resume: If @state is a startable state, start the vm and set the state,
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
index cbc6d6d..63cf356 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -750,6 +750,15 @@ void vm_start(void)
     }
 }
 
+void vm_resume(RunState state)
+{
+    if (runstate_is_started(state)) {
+        vm_start();
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


