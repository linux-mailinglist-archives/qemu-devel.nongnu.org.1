Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 664487AF081
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 18:19:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlAmK-0002fk-GL; Tue, 26 Sep 2023 12:19:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qlAmG-0002eW-2J
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 12:19:14 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qlAmE-0004uQ-Cs
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 12:19:11 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38QFOr1S004915; Tue, 26 Sep 2023 16:19:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=gn4dQOb4UWnQxT6KvxYcwBPjvAyQPEHZNwf3F6AsY24=;
 b=dHmBzOEwDavYVszmxS52aXMbJOeAfSqM9syX49vEhGPY3+VjPd5H5phfeZeNKjuD5kqb
 oxziXjW+nwNQN89ScSL44X91TKyYduCMeIYJ+p/gfpfaSuh/2VSC1hSytXw8L75ILr2X
 6+QxZJRb28qm+2sBnm4Gj2E9g8GzKFOlm3nKu3YslNdomHbbvjtevL3UF2gkUdPqab6w
 5JpCNhJBQlNwLZCQtrI5l2C9iUfxCvBRCK7m2yHo8PFXFJnLNBEjN8JTOSQoMg9cOZEw
 SN5VDZxzl5PReXVWRhLJf0nfq+P/RmVKzBXcnMrcun4YuWiOGQVL83dl3g1uE9uSUUmz DA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9rjuf0n1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Sep 2023 16:19:08 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 38QG2Ot7039388; Tue, 26 Sep 2023 16:19:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3t9pfcear2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Sep 2023 16:19:07 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38QGIt9x007977;
 Tue, 26 Sep 2023 16:19:07 GMT
Received: from joaomart-mac.uk.oracle.com (dhcp-10-175-210-190.vpn.oracle.com
 [10.175.210.190])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 3t9pfcea8h-5; Tue, 26 Sep 2023 16:19:07 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH 4/5] migration: Provide QMP access to downtime stats
Date: Tue, 26 Sep 2023 17:18:40 +0100
Message-Id: <20230926161841.98464-5-joao.m.martins@oracle.com>
In-Reply-To: <20230926161841.98464-1-joao.m.martins@oracle.com>
References: <20230926161841.98464-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_13,2023-09-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=693
 bulkscore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309260143
X-Proofpoint-ORIG-GUID: fCW5Nzasz9U4PD6Rq3ejiA1x2WSBShwa
X-Proofpoint-GUID: fCW5Nzasz9U4PD6Rq3ejiA1x2WSBShwa
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

Deliver the downtime breakdown also via `query-migrate`
to allow users to understand what their downtime value
represents.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 qapi/migration.json   | 22 ++++++++++++++++++++++
 migration/migration.c | 14 ++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/qapi/migration.json b/qapi/migration.json
index 2d91fbcb22ff..088e1b2bf440 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -217,6 +217,27 @@
   'data': [ 'start', 'stop', 'precopy-iterable', 'precopy-noniterable',
             'resume-return-path' ] }
 
+##
+# @DowntimeStats:
+#
+# Detailed migration downtime statistics.
+#
+# @stop: Time taken to stop the VM during switchover.
+#
+# @precopy: Time taken to save all precopy state during switchover.
+#
+# @precopy-iterable: Time taken to save all precopy iterable state.
+#
+# @precopy-noniterable: Time taken to save all precopy non iterable state.
+#
+# @resume-return-path: Time taken to resume if return path is enabled,
+#                      otherwise zero.
+#
+# Since: 8.2
+##
+{ 'struct': 'DowntimeStats',
+  'data': {'stop': 'int64', 'precopy': 'int64', 'precopy-iterable': 'int64',
+           'precopy-noniterable': 'int64', 'resume-return-path': 'int64' } }
 
 ##
 # @MigrationInfo:
@@ -308,6 +329,7 @@
            '*total-time': 'int',
            '*expected-downtime': 'int',
            '*downtime': 'int',
+           '*downtime-stats': 'DowntimeStats',
            '*setup-time': 'int',
            '*cpu-throttle-percentage': 'int',
            '*error-desc': 'str',
diff --git a/migration/migration.c b/migration/migration.c
index 4b5bed3eb09b..dec6c88fbff9 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -921,6 +921,19 @@ static int64_t migrate_get_downtime_resume_rp(MigrationState *s)
     return 0;
 }
 
+static void populate_downtime_info(MigrationInfo *info, MigrationState *s)
+{
+    DowntimeStats *stats;
+
+    info->downtime_stats = g_malloc0(sizeof(*info->downtime_stats));
+    stats = info->downtime_stats;
+    stats->stop = migrate_get_downtime_stop(s);
+    stats->precopy_iterable = migrate_get_downtime_precopy_iterable(s);
+    stats->precopy_noniterable = migrate_get_downtime_precopy_noniterable(s);
+    stats->precopy = stats->precopy_iterable + stats->precopy_noniterable;
+    stats->resume_return_path = migrate_get_downtime_resume_rp(s);
+}
+
 static void populate_time_info(MigrationInfo *info, MigrationState *s)
 {
     info->has_status = true;
@@ -939,6 +952,7 @@ static void populate_time_info(MigrationInfo *info, MigrationState *s)
     if (migrate_show_downtime(s)) {
         info->has_downtime = true;
         info->downtime = s->downtime;
+        populate_downtime_info(info, s);
     } else {
         info->has_expected_downtime = true;
         info->expected_downtime = s->expected_downtime;
-- 
2.39.3


