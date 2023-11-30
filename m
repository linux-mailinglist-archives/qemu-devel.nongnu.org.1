Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 519F97FFDAB
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 22:38:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8ojK-0001ws-TQ; Thu, 30 Nov 2023 16:37:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1r8ojA-0001oa-JE
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 16:37:45 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1r8oj8-0000n8-Tv
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 16:37:44 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AULU35b026222; Thu, 30 Nov 2023 21:37:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=Q5IWAv6edqUFzqckOU2T0rI49681VfDqZp5LpC2LNxA=;
 b=OiWM4gYYMMrann9gysX/NtJwlhurnHq9osdssajQ/tTL/Xl5V3QQKp9RkreMht3zogHC
 gWNqCKPYp3bdcMR2tmdQHPoDrTCHQkk5mApqmsqLa6/Fb3Vracrx3U9XD9PKtY3HCTaH
 0e/hLbRY5H3sp7tZYKdEN9C3PEgfrHDsbbke9UrTVM1A+VThm93IFImYplMJ688G5kBD
 atALVmbrOsaLmY9JLMqiQZpba4dhe8M51y5B/2VJQ6DtWjVdeBlGYdrfUSVdZJRxZT9H
 rzuRDCT+zKaBP4Ogl35B75+trtrgO2O8MS44IHqFFp49qIpjXrQz8puPNs+d7oYHg/Pt tQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uq21n8307-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Nov 2023 21:37:41 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3AUL7YQk013344; Thu, 30 Nov 2023 21:37:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3uk7cgt0t9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Nov 2023 21:37:40 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AULbTgD016589;
 Thu, 30 Nov 2023 21:37:39 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 3uk7cgt0jh-9; Thu, 30 Nov 2023 21:37:39 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V6 08/14] migration: preserve suspended for bg_migration
Date: Thu, 30 Nov 2023 13:37:21 -0800
Message-Id: <1701380247-340457-9-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: rBKrIVpqNpIMngGavg40rFjAl6Ch1v96
X-Proofpoint-ORIG-GUID: rBKrIVpqNpIMngGavg40rFjAl6Ch1v96
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

Do not wake a suspended guest during bg_migration, and restore the prior
state at finish rather than unconditionally running.  Allow the additional
state transitions that occur.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 7 +------
 system/runstate.c     | 1 +
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index d1d94c4..63c616f 100644
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


