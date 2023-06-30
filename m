Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB321743D13
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 15:57:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFEbF-0000WH-Fb; Fri, 30 Jun 2023 09:55:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qFEVb-0006Dc-HN
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 09:49:59 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qFEVY-00072N-70
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 09:49:59 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35UBOa8x024643; Fri, 30 Jun 2023 13:49:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=ACkvWIoOt+7r16FbvyVhFx8LJGLlODeZid2HQvwRsQ8=;
 b=y4xQBspVBTrsQ4XwguJXpUk4EIsNaAdBi3JWdeeolqBAdsx+1+KL2PCrd5mMyixZ7UAm
 m8PYhHJl7WJddMSp58dbKvHnPiB4Lp8pgPSbcZXOQ8OKDU9E4405hEx/OsQZPSyS/tsm
 TuKxtYjk1UUVMGBvZ3jr3FMJZKk2aL6vUqNQMbfJJ09pvCALRDLVx0AXGCowb4AkTScL
 8A0csfWyBt5l5cMeqSVaSD9277DdUJkIeru5o+Olg6fXe9AwuyVfQ6BmOL6KTUgc0LvR
 Q9NMPbdNWohUZiLKp406MBHr4nico1YVXiKu4DYinLAzvynzKc2QQttWO5vIoazG9kIF xQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdq93gsue-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Jun 2023 13:49:52 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35UD1x0e008657; Fri, 30 Jun 2023 13:49:51 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3rdpx8v0h7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Jun 2023 13:49:51 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35UDnmMn039660;
 Fri, 30 Jun 2023 13:49:51 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3rdpx8v0f9-5; Fri, 30 Jun 2023 13:49:50 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V2 04/10] migration: preserve suspended for snapshot
Date: Fri, 30 Jun 2023 06:49:42 -0700
Message-Id: <1688132988-314397-5-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-ORIG-GUID: SnfExXoqAbQQjkQKFr9FbR8ltlkM39DU
X-Proofpoint-GUID: SnfExXoqAbQQjkQKFr9FbR8ltlkM39DU
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

Restoring a snapshot can break a suspended guest.

If a guest is suspended and saved to a snapshot using savevm, and qemu
is terminated and restarted with the -S option, then loadvm does not
restore the guest.  The runstate is running, but the guest is not, because
vm_start was not called.  The root cause is that loadvm does not restore
the runstate (eg suspended) from global_state loaded from the state file.

Restore the runstate, and allow the new state transitions that are possible.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 migration/savevm.c | 1 +
 softmmu/runstate.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/migration/savevm.c b/migration/savevm.c
index e0f4972..972d183 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -3139,6 +3139,7 @@ bool load_snapshot(const char *name, const char *vmstate,
     }
     aio_context_acquire(aio_context);
     ret = qemu_loadvm_state(f);
+    migrate_set_runstate();
     migration_incoming_state_destroy();
     aio_context_release(aio_context);
 
diff --git a/softmmu/runstate.c b/softmmu/runstate.c
index 5bbb22a..18efe31 100644
--- a/softmmu/runstate.c
+++ b/softmmu/runstate.c
@@ -77,6 +77,8 @@ typedef struct {
 
 static const RunStateTransition runstate_transitions_def[] = {
     { RUN_STATE_PRELAUNCH, RUN_STATE_INMIGRATE },
+    { RUN_STATE_PRELAUNCH, RUN_STATE_PAUSED },
+    { RUN_STATE_PRELAUNCH, RUN_STATE_SUSPENDED },
 
     { RUN_STATE_DEBUG, RUN_STATE_RUNNING },
     { RUN_STATE_DEBUG, RUN_STATE_FINISH_MIGRATE },
-- 
1.8.3.1


