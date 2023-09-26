Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BC37AF080
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 18:19:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlAmI-0002eD-U7; Tue, 26 Sep 2023 12:19:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qlAmB-0002dH-QS
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 12:19:07 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qlAm9-0004sc-QA
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 12:19:07 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38QFOqDc016260; Tue, 26 Sep 2023 16:19:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=ASmsvenoKJLPjaK3+00293q6yYqQ6YqFbMy57xo70lM=;
 b=n3KYTulSBcsR4AZCKf9Q2ijQwuanXEUy306PEuhmcVZ0BrDLhvHuUZV9SNwIRxIqLi8n
 gZBwGU7dIqKaur0A8u3G1+tPueY4zhTS0s1wQ43FKLi481xxqKFTbsyqLpoSnV+gye1d
 aJqUfFtZQAhytQB6S2m8rgN8nCDHUeO6J89+RbUfo853zzbSoYgoDyv2A8VTLh7OVmkf
 k5tofqI2lEBguUVJAxpEaP7A9kgUkCXj6jEgmUo6wspia+zZtfCjc1+aHXOj7zwqDQzt
 lATAtUumx1J89FeyxM7sb7sMJQQ1bGAxyn3CO/c7M84U2kXDb3vKUHAlXx4LI0yH470G nw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9qwbeysm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Sep 2023 16:19:03 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 38QFSbA5039378; Tue, 26 Sep 2023 16:19:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3t9pfceahf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Sep 2023 16:19:01 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38QGIt9t007977;
 Tue, 26 Sep 2023 16:19:01 GMT
Received: from joaomart-mac.uk.oracle.com (dhcp-10-175-210-190.vpn.oracle.com
 [10.175.210.190])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 3t9pfcea8h-3; Tue, 26 Sep 2023 16:19:01 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH 2/5] migration: Collect more timestamps during switchover
Date: Tue, 26 Sep 2023 17:18:38 +0100
Message-Id: <20230926161841.98464-3-joao.m.martins@oracle.com>
In-Reply-To: <20230926161841.98464-1-joao.m.martins@oracle.com>
References: <20230926161841.98464-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_13,2023-09-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=821
 bulkscore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309260143
X-Proofpoint-GUID: W1HvVASqUqA9uDeFo9XhKvlIUan4VRqx
X-Proofpoint-ORIG-GUID: W1HvVASqUqA9uDeFo9XhKvlIUan4VRqx
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
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

In addition to the start of switchover (previously @downtime_start),
add other timestamps during saving of state and return path.

For precopy migration, it should be able to capture the principal
steps of switchover. Resume-side downtime is sadly only possible when
return path is enabled.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 qapi/migration.json   | 16 +++++++++++++++-
 migration/migration.c |  5 +++++
 migration/savevm.c    |  2 ++
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index b836cc881d33..2d91fbcb22ff 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -199,10 +199,24 @@
 # @start:Timestamp taken at the start of the switchover right before
 #        we stop the VM.
 #
+# @stop: Timestamp taken after stopping the VM.
+#
+# @precopy-iterable: Timestamp taken after copying all iterable state
+#                    in stop copy phase.
+#
+# @precopy-noniterable: Timestamp taken after copying all non iterable
+#                       state in stop copy phase.
+#
+# @resume-return-path: Timestamp taken after return path has finished
+#                      migration on destination. It is zero if
+#                      'return-path' is not enabled.
+#
 # Since: 8.2
 ##
 { 'enum': 'MigrationDowntime',
-  'data': [ 'start' ] }
+  'data': [ 'start', 'stop', 'precopy-iterable', 'precopy-noniterable',
+            'resume-return-path' ] }
+
 
 ##
 # @MigrationInfo:
diff --git a/migration/migration.c b/migration/migration.c
index dd955c61acc7..d06840024a1e 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2348,6 +2348,8 @@ static void migration_completion(MigrationState *s)
 
         ret = vm_stop_force_state(RUN_STATE_FINISH_MIGRATE);
         trace_migration_completion_vm_stop(ret);
+        migration_set_timestamp(MIGRATION_DOWNTIME_STOP);
+
         if (ret >= 0) {
             ret = migration_maybe_pause(s, &current_active_state,
                                         MIGRATION_STATUS_DEVICE);
@@ -2401,6 +2403,7 @@ static void migration_completion(MigrationState *s)
         trace_migration_return_path_end_before();
         rp_error = await_return_path_close_on_source(s);
         trace_migration_return_path_end_after(rp_error);
+        migration_set_timestamp(MIGRATION_DOWNTIME_RESUME_RETURN_PATH);
         if (rp_error) {
             goto fail;
         }
@@ -3166,6 +3169,8 @@ static void *bg_migration_thread(void *opaque)
     if (vm_stop_force_state(RUN_STATE_PAUSED)) {
         goto fail;
     }
+    migration_set_timestamp(MIGRATION_DOWNTIME_STOP);
+
     /*
      * Put vCPUs in sync with shadow context structures, then
      * save their state to channel-buffer along with devices.
diff --git a/migration/savevm.c b/migration/savevm.c
index bb3e99194c60..e93701ff2393 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1468,6 +1468,7 @@ int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy)
         }
     }
 
+    migration_set_timestamp(MIGRATION_DOWNTIME_PRECOPY_ITERABLE);
     return 0;
 }
 
@@ -1524,6 +1525,7 @@ int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
     json_writer_free(vmdesc);
     ms->vmdesc = NULL;
 
+    migration_set_timestamp(MIGRATION_DOWNTIME_PRECOPY_NONITERABLE);
     return 0;
 }
 
-- 
2.39.3


