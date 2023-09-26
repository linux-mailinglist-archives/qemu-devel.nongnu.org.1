Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 446827AF07F
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 18:19:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlAmJ-0002f3-90; Tue, 26 Sep 2023 12:19:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qlAmD-0002eA-J4
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 12:19:10 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qlAmB-0004tc-S6
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 12:19:09 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38QFOrJc004897; Tue, 26 Sep 2023 16:19:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=Nv04R6yNkgD+tuQEbnhMF3LvSECmo7wziudX5w7LkpI=;
 b=h68S3p0YSo+NsMwJGXMbDM+Nvm557x58bTs3AL0FKSm3mWSzuGacOxKAQ7nDUhYFiQMo
 P9byEXM37blNZPvR3CmsJXiyyUZxaJeE+o+aIMjuhXy+krxRxsLBKvE7cokaRaw4DmHS
 f5qi9FKQMNG6i+lYubYG1Ync7wuGCVPnP44PEFqAZRXmGGbz2DwgPZHgH8dB1pYsDs4Q
 ZQSimwO2kF6GfSeko15BoeGZs/J3Y1LuBnGnhWfdq6ZN9emiwssETs12fyb/Z0o9lbuJ
 H6klHqk6w6rH/EOScCdCWO52c/dnmyWX7EXKQ/ZbGHgw6s9F8MktS2xL9aw7cA3wB0PP JQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9rjuf0n0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Sep 2023 16:19:06 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 38QG5WYE039359; Tue, 26 Sep 2023 16:19:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3t9pfceanf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Sep 2023 16:19:04 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38QGIt9v007977;
 Tue, 26 Sep 2023 16:19:04 GMT
Received: from joaomart-mac.uk.oracle.com (dhcp-10-175-210-190.vpn.oracle.com
 [10.175.210.190])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 3t9pfcea8h-4; Tue, 26 Sep 2023 16:19:04 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH 3/5] migration: Add a tracepoint for the downtime stats
Date: Tue, 26 Sep 2023 17:18:39 +0100
Message-Id: <20230926161841.98464-4-joao.m.martins@oracle.com>
In-Reply-To: <20230926161841.98464-1-joao.m.martins@oracle.com>
References: <20230926161841.98464-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_13,2023-09-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=684
 bulkscore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309260143
X-Proofpoint-ORIG-GUID: X8UoEt43sw3jT_Nc52lLlwsgv6YyqBrk
X-Proofpoint-GUID: X8UoEt43sw3jT_Nc52lLlwsgv6YyqBrk
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

To facilitate understanding of what constitutes downtime, add
a tracepoint that gives the downtime breakdown throughout all
steps of switchover.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 migration/migration.c  | 34 ++++++++++++++++++++++++++++++++++
 migration/trace-events |  1 +
 2 files changed, 35 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index d06840024a1e..4b5bed3eb09b 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -893,6 +893,34 @@ static bool migrate_show_downtime(MigrationState *s)
     return (s->state == MIGRATION_STATUS_COMPLETED) || migration_in_postcopy();
 }
 
+static int64_t migrate_get_downtime_stop(MigrationState *s)
+{
+    return migration_get_timestamp(MIGRATION_DOWNTIME_STOP) -
+        migration_get_timestamp(MIGRATION_DOWNTIME_START);
+}
+
+static int64_t migrate_get_downtime_precopy_iterable(MigrationState *s)
+{
+    return migration_get_timestamp(MIGRATION_DOWNTIME_PRECOPY_ITERABLE) -
+         migration_get_timestamp(MIGRATION_DOWNTIME_STOP);
+}
+
+static int64_t migrate_get_downtime_precopy_noniterable(MigrationState *s)
+{
+    return migration_get_timestamp(MIGRATION_DOWNTIME_PRECOPY_NONITERABLE) -
+           migration_get_timestamp(MIGRATION_DOWNTIME_PRECOPY_ITERABLE);
+}
+
+static int64_t migrate_get_downtime_resume_rp(MigrationState *s)
+{
+    if (migrate_return_path()) {
+        return migration_get_timestamp(MIGRATION_DOWNTIME_RESUME_RETURN_PATH) -
+               migration_get_timestamp(MIGRATION_DOWNTIME_PRECOPY_NONITERABLE);
+    }
+
+    return 0;
+}
+
 static void populate_time_info(MigrationInfo *info, MigrationState *s)
 {
     info->has_status = true;
@@ -2689,6 +2717,12 @@ static void migration_calculate_complete(MigrationState *s)
          * postcopy, downtime is calculated during postcopy_start().
          */
         s->downtime = end_time - migration_get_timestamp(MIGRATION_DOWNTIME_START);
+
+        trace_source_downtime_stats(s->downtime,
+                                    migrate_get_downtime_stop(s),
+                                    migrate_get_downtime_precopy_iterable(s),
+                                    migrate_get_downtime_precopy_noniterable(s),
+                                    migrate_get_downtime_resume_rp(s));
     }
 
     transfer_time = s->total_time - s->setup_time;
diff --git a/migration/trace-events b/migration/trace-events
index 4666f19325e7..163dc74bc49a 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -189,6 +189,7 @@ migrate_transferred(uint64_t transferred, uint64_t time_spent, uint64_t bandwidt
 process_incoming_migration_co_end(int ret, int ps) "ret=%d postcopy-state=%d"
 process_incoming_migration_co_postcopy_end_main(void) ""
 postcopy_preempt_enabled(bool value) "%d"
+source_downtime_stats(int64_t downtime, int64_t stop, int64_t iterable, int64_t non_iterable, int64_t resume_rp) "downtime %"PRIi64": stop %"PRIi64" iterable %"PRIi64" non_iterable %"PRIi64" resume-rp %"PRIi64
 
 # migration-stats
 migration_transferred_bytes(uint64_t qemu_file, uint64_t multifd) "qemu_file %" PRIu64 " multifd %" PRIu64
-- 
2.39.3


