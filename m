Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C8780768B
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Dec 2023 18:25:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAvcx-000171-Qb; Wed, 06 Dec 2023 12:24:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rAvcw-00016o-4n
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 12:24:02 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rAvcu-0003ce-JK
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 12:24:01 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B6EYRuM014616; Wed, 6 Dec 2023 17:23:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=TfGqRUQ0q8zDCC+WzTzXTb6O5FNov+jJS/5zduEeT30=;
 b=m7tq/trsvuxDDgfrPe2C9bT9hJrBHX590yh1HkhB/WMS9inpWZOTJMnGYoSWXalBG9rw
 xiLFLlzq5menDSvDVfKLluZhgQpngyQ6Lqo9ls6bTmc5AVKRZ0U+UkEy41th7Ffkuu4L
 8vc9coEWjMQD7kRaCIyxAVLm2bhvH+domMCWjG0fPpO+H+OszY1qpX/ld8ntRSas7lyZ
 nmy/26vnvukV14cOCOoUUIhOG1OqAqNXTiNfd0JJkwLU4WltJa7y3oebhBw5p++uIeME
 lb6kWozIqmokTlIQLrVD+m4mofQ6jPDM8u+fh3eglYwq796e9sHyJjtjXI436yVq+GjA XA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utdc19xq2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 06 Dec 2023 17:23:59 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3B6GfrYU038476; Wed, 6 Dec 2023 17:23:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3utanc79ym-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 06 Dec 2023 17:23:49 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B6HMwkQ002907;
 Wed, 6 Dec 2023 17:23:49 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 3utanc79rv-5; Wed, 06 Dec 2023 17:23:49 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V7 04/12] cpus: vm_resume
Date: Wed,  6 Dec 2023 09:23:29 -0800
Message-Id: <1701883417-356268-5-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1701883417-356268-1-git-send-email-steven.sistare@oracle.com>
References: <1701883417-356268-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_15,2023-12-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 malwarescore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312060140
X-Proofpoint-GUID: H5iHZk-p_soBZsclpjwAey_uq4Dh0nQ_
X-Proofpoint-ORIG-GUID: H5iHZk-p_soBZsclpjwAey_uq4Dh0nQ_
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
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 include/sysemu/runstate.h | 9 +++++++++
 system/cpus.c             | 9 +++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/sysemu/runstate.h b/include/sysemu/runstate.h
index 867e53c..315046b 100644
--- a/include/sysemu/runstate.h
+++ b/include/sysemu/runstate.h
@@ -53,6 +53,15 @@ void vm_start(void);
  * @step_pending: whether any of the CPUs is about to be single-stepped by gdb
  */
 int vm_prepare_start(bool step_pending);
+
+/**
+ * vm_resume: If @state is a live state, start the vm and set the state,
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
index f162435..7d2c28b 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -748,6 +748,15 @@ void vm_start(void)
     }
 }
 
+void vm_resume(RunState state)
+{
+    if (runstate_is_live(state)) {
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


