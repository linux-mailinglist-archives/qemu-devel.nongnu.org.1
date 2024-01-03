Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D52823614
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 21:06:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rL7VF-0004hw-Hp; Wed, 03 Jan 2024 15:06:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rL7V3-0004eF-Rj
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 15:06:02 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rL7V2-0002Bo-9j
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 15:06:01 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 403JYW2m028565; Wed, 3 Jan 2024 20:05:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=Q74Kutq/s1A83wS9uUJES8vX5GoYWvwZa96hIBR5kLA=;
 b=hCCKVXBp+oHH7bV539bRKeE+Xjdu0Q4MsiS8+s8cTOQ6KAAOxAbGR9Cn9ZLCUUc7AmL6
 6Gw+EJcjNRelImFx8R4qmYqV8WLylawKD7Yz4f6qgZ8F68jbwO/AJhYQgiaHEPOWnHQm
 Yn6hpLv7z9XarkTDogsIyBzbATIUueDqMwrP9oBRP8Y9ipkixnmnpvbB1OzYUnQbdAb1
 Ozpuvbbe8FWpY40LMOJJRwR9Y+JM/RGYDzw9qkMl41F0PpCiof3m4QnXqHYOkIw+XliC
 EZL20amxR+S/8/beMdde4aLjtgUPZBxW4yAftAK/czAY4Il505HLhzE6igN9qyX3J0fb cw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vaatu5qsy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 03 Jan 2024 20:05:48 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 403K22Ug013685; Wed, 3 Jan 2024 20:05:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3vddsvtbff-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 03 Jan 2024 20:05:47 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 403K2UZj020511;
 Wed, 3 Jan 2024 20:05:47 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3vddsvtba4-5; Wed, 03 Jan 2024 20:05:47 +0000
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
Subject: [PATCH V9 04/12] cpus: vm_resume
Date: Wed,  3 Jan 2024 12:05:33 -0800
Message-Id: <1704312341-66640-5-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: gqVmwTxsH-W1ylrRJKz5SMaAOnSZZPSV
X-Proofpoint-ORIG-GUID: gqVmwTxsH-W1ylrRJKz5SMaAOnSZZPSV
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

Define the vm_resume helper, for use in subsequent patches.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 include/sysemu/runstate.h | 9 +++++++++
 system/cpus.c             | 9 +++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/sysemu/runstate.h b/include/sysemu/runstate.h
index 618eb49..0117d24 100644
--- a/include/sysemu/runstate.h
+++ b/include/sysemu/runstate.h
@@ -57,6 +57,15 @@ void vm_start(void);
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


