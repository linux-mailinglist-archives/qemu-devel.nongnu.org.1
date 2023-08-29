Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC73678D061
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:23:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7mx-0000kX-PV; Tue, 29 Aug 2023 19:06:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qb3IA-0002b5-KM
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 14:18:18 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qb3I5-0003Vc-Fz
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 14:18:18 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37THikeU025725; Tue, 29 Aug 2023 18:18:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=cYmW8P29zhyl4EK49rtGEAnDbafZtqFSOlAcIELaads=;
 b=OmsEJ3BZg4/iHTkIoXJWLnCVx2jqr1r9oVdO8gXSLrFIk0J95b7hX422HCNKcFOPJjrk
 mjQTmShj/jm+i4aMyiw82Lx+g0lNAeizd9d5ufjMG0lZtmgIrHja6lEHorWVgeORUBz/
 68ekfZSm/dYkNpPdiyx6PiVdowj2ClqAZjJu+WKTT67KPafy0Eiq75/cLrNDyXNlE2x3
 sdpWtaQMTvaCJdhx7nevwLYHbwY3sxKtDU9lEfSjmrioVs4YBWgoHrO5xkXhGI2+vsNB
 yGja0e605odi6+aVQsCSX4VfwXUMdi+d9GZA7JQk0Yu2vowop07Mdd1jT40ryxFHtsnK QQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9xt5qjj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 29 Aug 2023 18:18:10 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 37TH6Sln024740; Tue, 29 Aug 2023 18:18:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3sr6dnfwkc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 29 Aug 2023 18:18:09 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37TII6lw011911;
 Tue, 29 Aug 2023 18:18:09 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3sr6dnfwgx-5; Tue, 29 Aug 2023 18:18:09 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V4 04/11] migration: preserve suspended for snapshot
Date: Tue, 29 Aug 2023 11:17:59 -0700
Message-Id: <1693333086-392798-5-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1693333086-392798-1-git-send-email-steven.sistare@oracle.com>
References: <1693333086-392798-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_13,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308290158
X-Proofpoint-ORIG-GUID: WV0LUJZp-nh_e_x0qjz7-FzAUZsM44t3
X-Proofpoint-GUID: WV0LUJZp-nh_e_x0qjz7-FzAUZsM44t3
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index eba3653..7b9c477 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -3194,6 +3194,7 @@ bool load_snapshot(const char *name, const char *vmstate,
     }
     aio_context_acquire(aio_context);
     ret = qemu_loadvm_state(f);
+    migrate_set_runstate();
     migration_incoming_state_destroy();
     aio_context_release(aio_context);
 
diff --git a/softmmu/runstate.c b/softmmu/runstate.c
index f3bd862..21d7407 100644
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


