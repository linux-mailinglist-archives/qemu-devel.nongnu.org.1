Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1A37FFDAA
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 22:38:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8ojD-0001pB-To; Thu, 30 Nov 2023 16:37:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1r8oj7-0001mR-OH
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 16:37:41 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1r8oj6-0000mL-1X
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 16:37:41 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AULZ1xI012973; Thu, 30 Nov 2023 21:37:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=1AXK9qY640tp3xWndVb1h1H773czR1vqkCKmAuhlByk=;
 b=flsVJJ+VkHTSuA0WEWhiXQlO35wNjBTA3SyEGiruQGxNnAcRZlitvBPjHCZ7mW9OoyjM
 2JNhb9HEeL3VfQ2lYkRV6zb8ebPGbgddYi1nM0IPReZX6cpVnE2+0lEz2vJtTvqX2G9N
 eZV6DB0s0fXCkid/thhpb8t0/PBYp117xf2PLlPfjBNmMOiyw1vsNA+kFsFoRIY7OxIE
 SmYwKHOUO/rsdZFE+b+94w0fweNYMYtwdtYIMF6SddbujbjwYa7C5XxPTlSwwz8sQTxF
 FQqKYrsY9fC5pyKKML6vFNeqrL6VLu/OyWmytMRc8V3LXz/sC90SGD8bdwTpYkyMav2z 8Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uq21fg357-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Nov 2023 21:37:37 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3AUL0J82012729; Thu, 30 Nov 2023 21:37:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3uk7cgt0qw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Nov 2023 21:37:36 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AULbTg7016589;
 Thu, 30 Nov 2023 21:37:35 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 3uk7cgt0jh-6; Thu, 30 Nov 2023 21:37:35 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V6 05/14] migration: propagate suspended runstate
Date: Thu, 30 Nov 2023 13:37:18 -0800
Message-Id: <1701380247-340457-6-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: OWrbSQzJ7iaFif0QHwALkXOCzMQkHrt-
X-Proofpoint-ORIG-GUID: OWrbSQzJ7iaFif0QHwALkXOCzMQkHrt-
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

If the outgoing machine was previously suspended, propagate that to the
incoming side via global_state, so a subsequent vm_start restores the
suspended state.  To maintain backward and forward compatibility, define
the new field in a zero'd hole in the GlobalState struct.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 migration/global_state.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/migration/global_state.c b/migration/global_state.c
index 4e2a9d8..de2532c 100644
--- a/migration/global_state.c
+++ b/migration/global_state.c
@@ -25,6 +25,7 @@ typedef struct {
     uint8_t runstate[100];
     RunState state;
     bool received;
+    bool vm_was_suspended;
 } GlobalState;
 
 static GlobalState global_state;
@@ -35,6 +36,7 @@ static void global_state_do_store(RunState state)
     assert(strlen(state_str) < sizeof(global_state.runstate));
     strpadcpy((char *)global_state.runstate, sizeof(global_state.runstate),
               state_str, '\0');
+    global_state.vm_was_suspended = vm_get_suspended();
 }
 
 void global_state_store(void)
@@ -68,6 +70,12 @@ static bool global_state_needed(void *opaque)
         return true;
     }
 
+    /* If the suspended state must be remembered, it is needed */
+
+    if (vm_get_suspended()) {
+        return true;
+    }
+
     /* If state is running or paused, it is not needed */
 
     if (strcmp(runstate, "running") == 0 ||
@@ -109,6 +117,7 @@ static int global_state_post_load(void *opaque, int version_id)
         return -EINVAL;
     }
     s->state = r;
+    vm_set_suspended(s->vm_was_suspended || r == RUN_STATE_SUSPENDED);
 
     return 0;
 }
@@ -134,6 +143,7 @@ static const VMStateDescription vmstate_globalstate = {
     .fields = (VMStateField[]) {
         VMSTATE_UINT32(size, GlobalState),
         VMSTATE_BUFFER(runstate, GlobalState),
+        VMSTATE_BOOL(vm_was_suspended, GlobalState),
         VMSTATE_END_OF_LIST()
     },
 };
-- 
1.8.3.1


