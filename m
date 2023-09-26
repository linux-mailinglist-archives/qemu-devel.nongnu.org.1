Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A237AF082
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 18:20:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlAmN-0002gM-7a; Tue, 26 Sep 2023 12:19:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qlAmK-0002fj-1f
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 12:19:16 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qlAmI-0004v5-Gb
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 12:19:15 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38QFOkfu007544; Tue, 26 Sep 2023 16:19:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=EoifFSgy6KyJSPmQ5XrH+l71SCAXSUA4VrQyatL5zWM=;
 b=zRq9T7SwxXvUbbDxbS3qan2EfLtLB2G7gefaLBNMVTE0NI8zcJ3X73lgSQVm7dH5rILg
 zAxn8jOMhC2VeaEAwd6fDyOTUDsOy0Rv9EoUsisg3VACKCEas1olV1JhVWUdYhU4HljA
 wxBYGhFXT/L/1WU8VpeYer6l+iRTRPbEYnF7ftmtLJjPxgLvQcRZgW00NyuVN0ot92N+
 afQkMqRuwGKwkp8S2TqmrZHJkOM3o/r7mCXCxnxj2uoJK0fpu0B9dEjbCk/hHOvn7Mug
 pquj1y4L1lIk+fclwkO7DWK1KBmw3Xk8hJ65skcP4VeOtufxf7r63F/OYoECzFupQ1Vc MA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9pm2745t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Sep 2023 16:19:11 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 38QFAD1O039362; Tue, 26 Sep 2023 16:19:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3t9pfceatb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Sep 2023 16:19:10 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38QGItA1007977;
 Tue, 26 Sep 2023 16:19:09 GMT
Received: from joaomart-mac.uk.oracle.com (dhcp-10-175-210-190.vpn.oracle.com
 [10.175.210.190])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 3t9pfcea8h-6; Tue, 26 Sep 2023 16:19:09 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH 5/5] migration: Print expected-downtime on completion
Date: Tue, 26 Sep 2023 17:18:41 +0100
Message-Id: <20230926161841.98464-6-joao.m.martins@oracle.com>
In-Reply-To: <20230926161841.98464-1-joao.m.martins@oracle.com>
References: <20230926161841.98464-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_13,2023-09-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 bulkscore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309260143
X-Proofpoint-ORIG-GUID: 8sMUgqTUet7VPmvTOrDWDF0QXRs_8_Xl
X-Proofpoint-GUID: 8sMUgqTUet7VPmvTOrDWDF0QXRs_8_Xl
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

Right now, migration statistics either print downtime or expected
downtime depending on migration completing of in progress. Also in the
beginning of migration by printing the downtime limit as expected
downtime, when estimation is not available.

The pending_size is private in migration iteration and not necessarily
accessible outside. Given the non-determinism of the switchover cost, it
can be useful to understand if the downtime was far off from the one
detected by the migration algoritm, thus print the resultant downtime
alongside its estimation.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 migration/migration.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index dec6c88fbff9..f08f65b4b1c3 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -943,6 +943,10 @@ static void populate_time_info(MigrationInfo *info, MigrationState *s)
     if (s->state == MIGRATION_STATUS_COMPLETED) {
         info->has_total_time = true;
         info->total_time = s->total_time;
+        if (s->expected_downtime) {
+            info->has_expected_downtime = true;
+            info->expected_downtime = s->expected_downtime;
+        }
     } else {
         info->has_total_time = true;
         info->total_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME) -
@@ -2844,6 +2848,10 @@ static MigIterateState migration_iteration_run(MigrationState *s)
 
     if ((!pending_size || pending_size < s->threshold_size) && can_switchover) {
         trace_migration_thread_low_pending(pending_size);
+        if (s->threshold_size) {
+            s->expected_downtime = (pending_size * s->parameters.downtime_limit) /
+                                   s->threshold_size;
+        }
         migration_completion(s);
         return MIG_ITERATE_BREAK;
     }
-- 
2.39.3


