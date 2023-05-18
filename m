Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6D9707A40
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 08:25:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzX3r-0005xh-V1; Thu, 18 May 2023 02:24:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1pzX39-0005wN-Nz
 for qemu-devel@nongnu.org; Thu, 18 May 2023 02:23:44 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1pzX36-0006p0-1p
 for qemu-devel@nongnu.org; Thu, 18 May 2023 02:23:41 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34I4GUFr010641; Wed, 17 May 2023 23:23:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=proofpoint20171006; bh=OqUbbbmEOrIemKbYSILOP47SaDlbS4sifFzFVG2B09E=;
 b=n1VMVTHTPiw4vVA8/qfE6v0/Hr7oq2Nq38hEjRZRHMNPRBMgX7ivG+uJq5WNkTvohM7q
 ngOvRYTW9MjKepBJICZVRyfa9wHHoSZG+ZKqZWicMuTYhrz+9O/CaVWgkYCnq5cB7GeU
 1nrlV5Am4IT0FVuZwD1V8oejq3R5eFPrzYmHyrkh1n2GkLQ/E98XbYixNjUKrv4HBTi7
 //kaJcudX6oZd3hBIV2teLLeffMv8MQzCDPsWXGuKR4V2lbhGtpsJe3KaTvlZcHV5Gwo
 qPhyJRv6ES1R2Zi86rJ1liUstoGCrAJMhix0hmGQgmFS6ujuqtSiJUgyrRWbBZXWwg30 Cw== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3qmw97sxbn-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 May 2023 23:23:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VPmyVSn7/tXv5EUz4+jXDbeo07nn2abzdR5AZOkNMhPuDPxVkz7jBVjbZ2mhYaHAfgx6GM/SrC0MHQYB4tI3ONh1rGT/lYVpU9ZdaW5eEJ58S9+5gCIwbOnrV2Jbu9C1dEsrPrqV7xjRCdY27kKH2hQ/sPezBclKg8m5CwjI7ZHWMIFdsjCNI8OZ+Yv9flXwFMgsiBmIm8GWvhj98cYxtwTDjo6rDjieP767bpAiBULuhquTIVAfqqtRtX+qTDWRJdJjtl3jXWaOmbvNax3bn7G2EsFaYjadpPlbH86/kkhl4b7GOKtANjEwgIxm7utam8KEHh0ev7Kj9SZaafj91w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OqUbbbmEOrIemKbYSILOP47SaDlbS4sifFzFVG2B09E=;
 b=LgEUkjIW3AJDH+xVKx0p/b0jaak0r0q1nmPZDYn4qsL+8hK8xv5ocLdG3s+eYsLLVDKVyFUtQJyOUBI3ziJrIhzXaRrp+T8ZdPdop8uxh3kyfKfvGZHpr6tEAOoiXYTocAJkTsPZZ/Aggx0Saxmxe3fYbMKQCcVEkpdPhnp+wcjUaCQP+Aez9j/UHr3GyVYO/i2UI3Vlb3Eqk8o3ZLJFPCzDL6fBNIC5kgpriOuQFwOCGZ2xBfaBH58P+FxbfhdU7r6E7Fq3fwQrhbexkDQ3GSpBbj6oXSMAeFZP0dlEj5qlskWmjSg9hVFa80DFfmfI49viCYEpKez+cyHVLfQ02Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OqUbbbmEOrIemKbYSILOP47SaDlbS4sifFzFVG2B09E=;
 b=edSPCOk23ZBlJu7bUOyCqMaQWrudBOROamz3wvELtv8AcvlGm0c4YzsIIfN5QUSDDwtzYJkAg3rt9YkXttl78jzIzDRVfBzO3SgzFk8mL77M2AVB/qD31Ws6XnKFoLqmwQ9QSD/wWpkKXIu1je4NJqdDmU76gRnNOSgCnR0MiFjdEsw3lK1q64g0GNwcZ/J+gKeWRiCGwwzBEOuI2Ji1/Xb0F0JUnC6JhC0h8eMjuHq80nNYSKSLVndP5g5X6RbXVG2at3F5fInJp+yUsTaru9lE4Lkmm4dHtRi4rBuZ5esfP+K3jDZd9LLj1GUECejXZK0fBCp3T3iS3vQbem5lvw==
Received: from DM6PR02MB4810.namprd02.prod.outlook.com (2603:10b6:5:fb::15) by
 CY5PR02MB8920.namprd02.prod.outlook.com (2603:10b6:930:38::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.17; Thu, 18 May 2023 06:23:35 +0000
Received: from DM6PR02MB4810.namprd02.prod.outlook.com
 ([fe80::7b0b:cd05:f137:7f12]) by DM6PR02MB4810.namprd02.prod.outlook.com
 ([fe80::7b0b:cd05:f137:7f12%7]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 06:23:35 +0000
From: Tejus GK <tejus.gk@nutanix.com>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, leobras@redhat.com,
 berrange@redhat.com, shivam.kumar1@nutanix.com,
 Tejus GK <tejus.gk@nutanix.com>
Subject: [RFC v3 1/2] migration: Update error description whenever migration
 fails
Date: Thu, 18 May 2023 06:23:07 +0000
Message-Id: <20230518062308.90631-2-tejus.gk@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20230518062308.90631-1-tejus.gk@nutanix.com>
References: <20230518062308.90631-1-tejus.gk@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::15) To DM6PR02MB4810.namprd02.prod.outlook.com
 (2603:10b6:5:fb::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR02MB4810:EE_|CY5PR02MB8920:EE_
X-MS-Office365-Filtering-Correlation-Id: ea9ec8ce-48d4-454b-438f-08db576868d4
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uw+5uc7wq+PrUq12blXvxPS3f7Cgwe7PLcAededlHmHc9QI15LpHq/RekHmDnC6936pzZB8hL8U9RhbCTnmmiqgvuyNSKEiS9/hMtpVIa68wzqUdxxNJ8dIGs+tTL3zR1n1IQUDhswgqFv6kgd0iUa9yqravQpPE9CCs3QVvuccSz4MTPl6BdeTgUZEZdx5evVu6hDJPGMyC+20UVg5UgtAxeKSYXn97Ypbh0A5JsCFvrM7n/X7SLTpw9q90rpyWCGy6JqZzIGsxDxGaZERY0/Q0gkY0oVgZXBOdeGI3QZm0IDXu7OO6lv5FkNsoBPEgGc1WKRH67/QZMoVja3BExUdB0ovt1bWR2mCbVslgw13IkwhsSD5uTC4569NSMB2IcF28R+wBXQQLNAD/41G8KHhOZdmlsaXnxQ1fOlXUz3xto3OiXd0i8B1xiDDGhMYq3487C/wWD8RyQw5L13o05BfoMj1Rr+LVeelcmSEoR4+I24sz56jZfznz/5Tg5Xsw4c36S3feoU1H3zeeBaBZfQiSBQ3VggUUx1nWMTTfB2er/95YlW03wmQRGtTqC2mwYMjBcBUSDPH//nS736hZS/m+IpN6b+l4Zn3mBpdbZvsq3+/zsPEf7qZP5m3yM59P
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR02MB4810.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(396003)(136003)(39860400002)(366004)(376002)(451199021)(66556008)(316002)(6916009)(66476007)(52116002)(478600001)(4326008)(6486002)(86362001)(36756003)(83380400001)(1076003)(6512007)(6506007)(107886003)(186003)(26005)(66946007)(2616005)(8936002)(2906002)(5660300002)(8676002)(15650500001)(6666004)(38350700002)(41300700001)(38100700002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uPC7N7ssMD8p8ZKIR3PfznSSGOES2u8DlUroqlAieTviZJqcByQDgzySGaZF?=
 =?us-ascii?Q?YVh6d0803whFWRlQRBxp3v4VK9tHdXR3ZrUhmLYWuGxXXZjn/sNv8/rm3xnd?=
 =?us-ascii?Q?h74LHZAVVV71SP3xzdds62mjKZ7JjLtHeiNeulmt0EQ85VnVlVyNJYJthrYw?=
 =?us-ascii?Q?38jz4RZTcvk9U4ZrwCYreV3q7bF+yVkq+31x7UtD8uBByoDZ50JYcczPmjIi?=
 =?us-ascii?Q?+ImVyKatjcNvw+I0PctF89pDnVoseMXX66M6wqZyMnVo51Ocea+9JU08gH14?=
 =?us-ascii?Q?7IVMD2EPujtaZZWMEryAhspZIhN9qhWMfxTEvRGECV9+y7G1yHqt4AZLShjb?=
 =?us-ascii?Q?wqHrImkI1eMqfnNM10X9uZsFPn83pO9vFWNyulqLoupSZD+nV6ZeTLoIkgGE?=
 =?us-ascii?Q?RDIN9zRKK3xYTZp1CFnogOEQxoR6ILfERXpg1+83v5GM0onBzvv7p9FxHH2N?=
 =?us-ascii?Q?NHpDsM7zDs4pN5hFVkq/2qOilf0tUaxbWZr37p7kNycWTsi0BNr6GR5s54ot?=
 =?us-ascii?Q?wsmTSdTUKFgVEyITzvBB5k5O23ASFf5O8mytlAu6G3Q9gLi/jJRWMEfffLm0?=
 =?us-ascii?Q?pxPQyg8uJJ1ObqIo0lnJ+BaE//SIusQx3BsfiNT3Z9RQ2PKoK2sbD+QecOov?=
 =?us-ascii?Q?CF2iUCNrDVGvh2eqZu5BvH6aJz7vZdPuPyR3FeVvteN1cv4u6M20mNLNzeuR?=
 =?us-ascii?Q?H/d7HoyfUMDqmSqo9vDjiw6hchB/1tZxwM90HtCLZ7lmsYbRkdOzWRaFhd7w?=
 =?us-ascii?Q?FtttnwnHIwWvIyis079RS1kEdnNavi8eeu+ZWcZmPlDJmw7d19mNiZ3d+vPV?=
 =?us-ascii?Q?9y/i8Ohzgh5meS0WIOZqukGz85rYTKudyI+8a7RWF5Ykv8Cu7kqsNjACNP44?=
 =?us-ascii?Q?Ld8naqkmeRhEb077ZAReyP3LTS7mCeRsO/ut5yzRLyLNb1rRRO1Xdcs6T8qr?=
 =?us-ascii?Q?6AS27qMWMh4jlEnEtwrqF21G+gEXYKmuwPx7iu+FKnNhmfyViKx7YBXv/08V?=
 =?us-ascii?Q?gtrTWATImgfgtANGBtmfTUFiAW8Tn/wYzaNVaM8rMkCbcEwehQMDW8trMWNS?=
 =?us-ascii?Q?zCMIiFLug307SwKIjpbUpgd0OkDj2t+SQqQAyG/8/sux+yMa8iCsuzdMWl+V?=
 =?us-ascii?Q?Lhg9BBOMhoHMRPaN7FIZSdcoUm/kXrGb6IOkm5j6byCCIBMqknpPudxYZAI5?=
 =?us-ascii?Q?EzNdMOm8PAwZ3woMzIkNBYc3fGyigOvTWse/ucjXgcfrITHNNpWokMMUolyN?=
 =?us-ascii?Q?TvNaMl6KuuSM0J34zsuHVKqlZFCbsX0bWFkmKJGGmb6jeJYEccwBFpVfkbxc?=
 =?us-ascii?Q?nRByrFgK8scg3jmxXKj8xoUDvQ4LmvB2uHt9f8dMx+jwFZfWj+1cOd/EFAN2?=
 =?us-ascii?Q?A6DQYK0nCyN4zg5r67vxY+16TLOFg5Dg45oGcMC3WPFhtjVR1gpF+cteOcVh?=
 =?us-ascii?Q?4J5eK/JkcTvXfZ/aYNMzOajlriQi7B8gpnu6JyyiY3onKkpL4W4DgUCb3GFO?=
 =?us-ascii?Q?QnnzhnZL1U6vHdUtng/ikAAu6ovGKnd68+pttC+Et02Ufgn9dr+IZA7Fz8jg?=
 =?us-ascii?Q?ucQASRF4SUVq5VUSGO5f7kJaMgud6T827Lq0U5t8+2BDpUV0EIvVpnhwMCSB?=
 =?us-ascii?Q?sA=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea9ec8ce-48d4-454b-438f-08db576868d4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB4810.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 06:23:35.1855 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2gSDWEExFR9FY11TAJagQrhUNuICJ0qIcBYQ5NL4zZks2uJr978bFRZg0yfniGYJQJVT1PNasQVs6hxeJpuHqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR02MB8920
X-Proofpoint-GUID: zHvbA8-avjADhSzxJ9y6tqyIPXwELlag
X-Proofpoint-ORIG-GUID: zHvbA8-avjADhSzxJ9y6tqyIPXwELlag
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_04,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=tejus.gk@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

There are places in migration.c where the migration is marked failed with
MIGRATION_STATUS_FAILED, but the failure reason is never updated. Hence
libvirt doesn't know why the migration failed when it queries for it.

Signed-off-by: Tejus GK <tejus.gk@nutanix.com>
---
 migration/migration.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 00d8ba8da0..864150d01d 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1683,15 +1683,11 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
     } else if (strstart(uri, "fd:", &p)) {
         fd_start_outgoing_migration(s, p, &local_err);
     } else {
-        if (!(has_resume && resume)) {
-            yank_unregister_instance(MIGRATION_YANK_INSTANCE);
-        }
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "uri",
+        error_setg(&local_err, QERR_INVALID_PARAMETER_VALUE, "uri",
                    "a valid migration protocol");
         migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
                           MIGRATION_STATUS_FAILED);
         block_cleanup_parameters();
-        return;
     }
 
     if (local_err) {
@@ -2073,7 +2069,7 @@ migration_wait_main_channel(MigrationState *ms)
  * Switch from normal iteration to postcopy
  * Returns non-0 on error
  */
-static int postcopy_start(MigrationState *ms)
+static int postcopy_start(MigrationState *ms, Error **errp)
 {
     int ret;
     QIOChannelBuffer *bioc;
@@ -2183,7 +2179,7 @@ static int postcopy_start(MigrationState *ms)
      */
     ret = qemu_file_get_error(ms->to_dst_file);
     if (ret) {
-        error_report("postcopy_start: Migration stream errored (pre package)");
+        error_setg(errp, "postcopy_start: Migration stream errored (pre package)");
         goto fail_closefb;
     }
 
@@ -2220,7 +2216,7 @@ static int postcopy_start(MigrationState *ms)
 
     ret = qemu_file_get_error(ms->to_dst_file);
     if (ret) {
-        error_report("postcopy_start: Migration stream errored");
+        error_setg(errp, "postcopy_start: Migration stream errored");
         migrate_set_state(&ms->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
                               MIGRATION_STATUS_FAILED);
     }
@@ -2741,6 +2737,7 @@ typedef enum {
 static MigIterateState migration_iteration_run(MigrationState *s)
 {
     uint64_t must_precopy, can_postcopy;
+    Error *local_err = NULL;
     bool in_postcopy = s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE;
 
     qemu_savevm_state_pending_estimate(&must_precopy, &can_postcopy);
@@ -2763,8 +2760,9 @@ static MigIterateState migration_iteration_run(MigrationState *s)
     /* Still a significant amount to transfer */
     if (!in_postcopy && must_precopy <= s->threshold_size &&
         qatomic_read(&s->start_postcopy)) {
-        if (postcopy_start(s)) {
-            error_report("%s: postcopy failed to start", __func__);
+        if (postcopy_start(s, &local_err)) {
+            migrate_set_error(s, local_err);
+            error_report_err(local_err);
         }
         return MIG_ITERATE_SKIP;
     }
@@ -3250,8 +3248,10 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
      */
     if (migrate_postcopy_ram() || migrate_return_path()) {
         if (open_return_path_on_source(s, !resume)) {
-            error_report("Unable to open return-path for postcopy");
+            error_setg(&local_err, "Unable to open return-path for postcopy");
             migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
+            migrate_set_error(s, local_err);
+            error_report_err(local_err);
             migrate_fd_cleanup(s);
             return;
         }
@@ -3275,6 +3275,7 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
     }
 
     if (multifd_save_setup(&local_err) != 0) {
+        migrate_set_error(s, local_err);
         error_report_err(local_err);
         migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
                           MIGRATION_STATUS_FAILED);
-- 
2.22.3


