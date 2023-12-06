Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6581A807639
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Dec 2023 18:15:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAvSf-00074B-1g; Wed, 06 Dec 2023 12:13:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rAvSd-00073l-B2
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 12:13:23 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rAvSb-0001YQ-S3
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 12:13:23 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B6EXxLN030036; Wed, 6 Dec 2023 17:13:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=VfilU9EXvgzBKnC2WDqJcbYc/hyaw35v8mMAb/HQTmM=;
 b=k5vc2xJZh7vLdbuVw5NurqXzK7untQamzTIm30aFFbaksXbqWv0Cijsith12EqfKhsGE
 D9Hbjd6hglqL8NM2F6ro3Di/6mA32qGn53iqCycj5a/5zzY5Jr8GeuUHE5ntetWJVAS8
 KP6a85CJOnznoy8gXsObaRTuhHRRL7w0N/iDDXqpve3DkapNii6AO3ojZ1jvKTsUxdUa
 gax5FKTZZeofajWlyPAKG+2oRrZsBuyD0QXaAnmrhuu4yn9AU90QsvRnjYCVw7REHfTU
 VRNiv8jxaEzDCBbJlRtivs2DNdyNdhkN2p0FG6CzX2JklsUVLGMAL/tpGVMy+KfU2L+x Lg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utd1ga3ab-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 06 Dec 2023 17:13:19 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3B6Gobwd032258; Wed, 6 Dec 2023 17:13:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3utan9exms-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 06 Dec 2023 17:13:19 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B6HCrVT024168;
 Wed, 6 Dec 2023 17:13:18 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 3utan9ewxa-20; Wed, 06 Dec 2023 17:13:18 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH 10/14] migration: preserve suspended for bg_migration
Date: Wed,  6 Dec 2023 09:12:45 -0800
Message-Id: <1701882772-356078-20-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1701882772-356078-1-git-send-email-steven.sistare@oracle.com>
References: <1701882772-356078-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_15,2023-12-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 suspectscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312060140
X-Proofpoint-ORIG-GUID: vM1FJ2qo_dFhURCki2Wp-eZHeMPxYkoV
X-Proofpoint-GUID: vM1FJ2qo_dFhURCki2Wp-eZHeMPxYkoV
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

Do not wake a suspended guest during bg_migration, and restore the prior
state at finish rather than unconditionally running.  Allow the additional
state transitions that occur.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 7 +------
 system/runstate.c     | 1 +
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 52ba0bc..b30313a 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3389,7 +3389,7 @@ static void bg_migration_vm_start_bh(void *opaque)
     qemu_bh_delete(s->vm_start_bh);
     s->vm_start_bh = NULL;
 
-    vm_start();
+    vm_resume(s->vm_old_state);
     migration_downtime_end(s);
 }
 
@@ -3461,11 +3461,6 @@ static void *bg_migration_thread(void *opaque)
 
     qemu_mutex_lock_iothread();
 
-    /*
-     * If VM is currently in suspended state, then, to make a valid runstate
-     * transition in vm_stop_force_state() we need to wakeup it up.
-     */
-    qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, NULL);
     s->vm_old_state = runstate_get();
 
     global_state_store();
diff --git a/system/runstate.c b/system/runstate.c
index ca9eb54..621a023 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -168,6 +168,7 @@ static const RunStateTransition runstate_transitions_def[] = {
     { RUN_STATE_SUSPENDED, RUN_STATE_PAUSED},
     { RUN_STATE_SUSPENDED, RUN_STATE_SAVE_VM },
     { RUN_STATE_SUSPENDED, RUN_STATE_RESTORE_VM },
+    { RUN_STATE_SUSPENDED, RUN_STATE_SHUTDOWN },
 
     { RUN_STATE_WATCHDOG, RUN_STATE_RUNNING },
     { RUN_STATE_WATCHDOG, RUN_STATE_FINISH_MIGRATE },
-- 
1.8.3.1


