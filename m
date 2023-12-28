Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0997B81F672
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 10:45:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rImuN-0008KP-CB; Thu, 28 Dec 2023 04:42:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rImuE-0008EV-PF; Thu, 28 Dec 2023 04:42:23 -0500
Received: from mail-am6eur05on20701.outbound.protection.outlook.com
 ([2a01:111:f403:2612::701]
 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rImu5-0008GX-67; Thu, 28 Dec 2023 04:42:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CBME/44BzIV1ocZTy0pUadIbaHEkjPVtFpMfSG/CL4mes70LqcefKJjrXE8vMoRMjtIF1ni2DV0tu4yNAfHYO3WQFBOE/4r6ruxeJ3YhzuujBHXdU/8q+GbsorLe2Mt0xE/e045nyx6wokeoh5dv3PHQWq1jvvB5hdVMtbCPBPnrvaHKdrdZPAxVBfciheshjAvOfCNntRNq0Vp/xEVqAD7M8kBzN9PGI+6uMixa6yG/tQRun5yCm8P2kuiOfSqvUuK4wqcb0p9qWQL0U3qDrzUuNAWylS97T7kVObyrAdBqOPMylhDFdMiOB6DvB/3Lo6booVeCRwwcs48BHFsb9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QZAYmTt6a8iWzR3ObMRJXGIqRa8RVqoX0brRg6ZAt0Q=;
 b=Mw8g6CXgUNmIqNIK6G6D8D1mF+sMiXlquejUJboouRa/SYsiUtZevQzPml1VgbxiQJ0AMz8eGxSZqozKI6NlGjdDvLcqGzmuUuM3sG7jYu6M54eaJ8eNFmnEAJyUcjgfWDT27zq36e9mqDC8rO6gVur7pw6xJjIthwH4r1dw9WmAhTyqvyN2Hn/LXxqb9b9OGzP3wHlUXF/JWJFhdbKWcXmvSlIoWQzeKxHLqDzokf2EcjdZefSL87x/ItocTTeY1nGIsaRRYvpRlO3C2z8ikOqez9AhDLoTpRwZHvqGnPboRmlx1+yw3IaM7d5dgoAx2Gq12CaLnvfMFi99TZZvyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZAYmTt6a8iWzR3ObMRJXGIqRa8RVqoX0brRg6ZAt0Q=;
 b=SGMRwS+NFMwnRZ1n5x0ol7/DFagFIkoEW5nZX5SSPOD4BJropjivt2f6oJWDjbs6GyNcCxFhodNeWg20o6nu6OQA4iqL1l53z73euIg2ta1V5VlTAZdBS1d4+xW5smauCiIPuByHDOestNKmfucwDEOGOFCcodSiyBqc8Mf59p8/mtYaK5hmImb6yG3eh9jeUImzMFpjUYSV4BPyeSkaudphpZH0BLsAGdBqxWOxb9+wE5BtUyDNKW37nSQxEsWlrtnvpe9fAyL+DVRwY/qhoyGNr1IvhVO5cOl141oiweoA07aU3WtkdOTxc8qi3kvnPmLwa4nJKTyFvPDt1HcLKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by AS8PR08MB8969.eurprd08.prod.outlook.com
 (2603:10a6:20b:5b4::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20; Thu, 28 Dec
 2023 09:42:01 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0%5]) with mapi id 15.20.7135.019; Thu, 28 Dec 2023
 09:42:01 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH 03/21] parallels: Make mark_used() a global function
Date: Thu, 28 Dec 2023 10:41:35 +0100
Message-Id: <20231228094153.370291-3-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231228094153.370291-1-alexander.ivanov@virtuozzo.com>
References: <20231228094153.370291-1-alexander.ivanov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VE1PR08CA0003.eurprd08.prod.outlook.com
 (2603:10a6:803:104::16) To VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|AS8PR08MB8969:EE_
X-MS-Office365-Filtering-Correlation-Id: 239d117b-1df8-43b8-aeb1-08dc07893db0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s90wtEVWZWycSHRKUzYsqyB04VIw5DVbQEYvqDIQb5N9acPqG4bxBWhuP1vle/vh4Q05mdVzL7dfMpftmPN0tLEdhljCOhP0KHtRgSdzHHlAAnzswER3mFEhKlb1fE4m9mw/IkyAJm65b9+wia68eezfRTZA0dLqx4N072Z0jeIGOq0hg5nrOEj5qlWxoqiwpER5qgGksVlozk4tv2YVDsGz73x4PxPp0lgQLHncqyQP37y9taZX3OJigfzDcVfuWkJYpdtTdYNq/LvNXImKEOJVvG+Sqldqa+8Tx/4NVRQKuQ+D26ypzCRlY1ty7Da+N0ddxpIbiLMO8YzYmT9YAwpv+i56kTXSEvItMkbsbQKQUIK4Ue3gz6jMHf/3+BsPf0fUMCLLn95vl49/WK6WNFQwx+v5xuI3HQP/RSovEhg84LQUj0BjBx/NXXawOlaRlnMESDH2YVweGHy5eNlgzxPPZ9wccDL4IWijdBQ14sEz6EX/bb+xmG408g38giDsjqHsig3VYbMZCfk6rMSMW+URAPiEXIcxoItWwEgNJF68XuN3DOynJMpdH6RLNYVNUghdL145gA3xioZOF/xV+4krcjwBAkZTMtklBggiQSXC3pWclZSV5y2zdJc4S9hZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39840400004)(396003)(366004)(376002)(346002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(2616005)(1076003)(26005)(38350700005)(38100700002)(83380400001)(36756003)(44832011)(66476007)(66556008)(6916009)(4326008)(66946007)(86362001)(6486002)(8936002)(8676002)(316002)(6666004)(41300700001)(6506007)(6512007)(2906002)(478600001)(5660300002)(52116002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cCBo1CnNJrajFqZ0lyrk0oT4sDAcojPW0fAfhaRUak1jaEMR82vLU3l7kLii?=
 =?us-ascii?Q?pkcdg0auqPcmleOxS4TQjwgvs0mFz1TWiDZjltgT6dpWFGkBrEFGHmJGPyVs?=
 =?us-ascii?Q?AS0TFRjOwX2TobWlLl0dcNFBhUnmIf39BLr+oR3hS2CILwKTGwKbNLxPuZXB?=
 =?us-ascii?Q?23RmIn81uaQc7Tv/piE8zVej4diQkO/YleIV3FbipRsah3W1tBWSXe2PiDDU?=
 =?us-ascii?Q?/ixmHxNNHL/N4RneOlP5Zjz7GrF66Zizi5nZ3w2VcmMu3MeAWV99PqRfGJPD?=
 =?us-ascii?Q?wzRqlG4M9UaGE+fzWu31gU3KtIbS8LugCGAcq0dZnEKI1tyHVJyGtnvXiosF?=
 =?us-ascii?Q?HQ6fzYl2MlRkcmDYDZnvkV6+ypl+NSeY6krg3oR34utR8aDKwww1oMkzVMbU?=
 =?us-ascii?Q?7MSMO21meodQQP3VVgkSvHjLhLXdgcWEapj+bJuGon1oiljWp3G3eIRFaBUw?=
 =?us-ascii?Q?rCu5/wJkbUB3ZkSaBp23YEuLiXnnEbycTCqSGR+4SDhrrr7OiBbe2n8IYxcs?=
 =?us-ascii?Q?ThzXDW0chLlUBZQcGQpECOunlcC/R20abz6wLDGuggcNHwYnulY6iD9nOuTm?=
 =?us-ascii?Q?ZNDvTIIGJ6yr1ijltty/SE7lBfJ6CuVNMlkVmyUh7YGMYs/SqbiNER5KdfDK?=
 =?us-ascii?Q?1KaouvUYMdbjOH/22a3vcJA+RLn22iqX7J69VHeYjuQf9rOHSATkOb8ApFJA?=
 =?us-ascii?Q?nSk+kLqtziTY8DpM7mOwpa2WvLOAZHs0OuoWQhLcBm9nmi7kdw1SuesZ1rpb?=
 =?us-ascii?Q?udBpbitYOnIA3rdlBUurozAB/36VSV6qOJbsEEjKvgEGco/6CISo2QlCFui/?=
 =?us-ascii?Q?Uoy32mpmL8F0Hj0EJYsJ8goVje9Sl1zUvk4sMllYbV46jFmaX1Q1CTZOZVGR?=
 =?us-ascii?Q?uuCK5aJZ3EPpDYcKtN0szdQ/OS69zs7D43WeVk+noOixjrY+yfaArFWxV2In?=
 =?us-ascii?Q?DRokyidK6Rmdv6Em/BIpcUUk6Y7xU3B7S6+AHrGSiS6Zni0qi4jEct+nSBaa?=
 =?us-ascii?Q?wx7cpOdGGMo1McLanMunRepfJaOs4fI2TtJzxnonJwe2uZOmsLdF9TyzXzN7?=
 =?us-ascii?Q?+8MkcWwW1hLKMFWtQ43HiA6PJzsS+tZtC+FOOTuTTjzBDoKpg1wIFi/b+cAi?=
 =?us-ascii?Q?UainUGhDX708Oq7p4xO1nO1OZYtsh6CFzmn36oNEMst2PHOrNnRko4RGpAb2?=
 =?us-ascii?Q?+k3eBQ8zIfKtvxMjeL/FrXB3Alicv8tYPOYnM+54jtI8W8nRTuqdgFrJqes/?=
 =?us-ascii?Q?PD8Uu3y3MXcdqT9jitQtLM3+778TS+Xd72ROlkzwVcsvRuXQZDkDOQjuUuXt?=
 =?us-ascii?Q?Bl6aIhov6oWtUC09mZODnPiCgj7p8Z7wKC4e9BzrPeX9RKpIutCuQNuQr2BL?=
 =?us-ascii?Q?VTJWSn9cF/Xua7YFBJCVcjOfZBgXyA2XhDiHw8GsWUY1NbiPG7T2DhdM/OU6?=
 =?us-ascii?Q?/0Bav1XU9IXUNdPkf4RDbsGXN3OsI/bMZ45gQLCufSlSqGsyqfQrMq9MZsRE?=
 =?us-ascii?Q?C9so2fzwZodleG6jrVCD4G2iD/vdFWa0pstK9IkZXUXcn+97YHhNOBqphjyX?=
 =?us-ascii?Q?HlhQRZQ4bVI7YWMeEFCmXXpfnfq4/SpnXptAbjqWO5YP6+OCS2y5KXIO2stv?=
 =?us-ascii?Q?mWyITSxgWSyY2DKYFdQNckc=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 239d117b-1df8-43b8-aeb1-08dc07893db0
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 09:42:00.7756 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BuNopFLae84hVHisbMjtej+QckgIKbMyT/I5g2xjN/ervaIMzrzUf76ekKM1b0OZfXb2SbchE+KtY8ZkGJsWCNfrJPYAlN/ArXJ45w7uPWE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8969
Received-SPF: pass client-ip=2a01:111:f403:2612::701;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

We will need this function and a function for marking unused clusters (will
be added in the next patch) in parallels-ext.c too. Let it be a global
function parallels_mark_used().

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Reviewed-by: Denis V. Lunev <den@openvz.org>
---
 block/parallels.c | 14 ++++++++------
 block/parallels.h |  3 +++
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index 992362ce29..ae524f1820 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -178,8 +178,8 @@ static void parallels_set_bat_entry(BDRVParallelsState *s,
     bitmap_set(s->bat_dirty_bmap, bat_entry_off(index) / s->bat_dirty_block, 1);
 }
 
-static int mark_used(BlockDriverState *bs, unsigned long *bitmap,
-                     uint32_t bitmap_size, int64_t off, uint32_t count)
+int parallels_mark_used(BlockDriverState *bs, unsigned long *bitmap,
+                        uint32_t bitmap_size, int64_t off, uint32_t count)
 {
     BDRVParallelsState *s = bs->opaque;
     uint32_t cluster_index = host_cluster_index(s, off);
@@ -232,7 +232,8 @@ static int GRAPH_RDLOCK parallels_fill_used_bitmap(BlockDriverState *bs)
             continue;
         }
 
-        err2 = mark_used(bs, s->used_bmap, s->used_bmap_size, host_off, 1);
+        err2 = parallels_mark_used(bs, s->used_bmap, s->used_bmap_size,
+                                   host_off, 1);
         if (err2 < 0 && err == 0) {
             err = err2;
         }
@@ -366,7 +367,8 @@ allocate_clusters(BlockDriverState *bs, int64_t sector_num,
         }
     }
 
-    ret = mark_used(bs, s->used_bmap, s->used_bmap_size, host_off, to_allocate);
+    ret = parallels_mark_used(bs, s->used_bmap, s->used_bmap_size,
+                              host_off, to_allocate);
     if (ret < 0) {
         /* Image consistency is broken. Alarm! */
         return ret;
@@ -827,7 +829,7 @@ parallels_check_duplicate(BlockDriverState *bs, BdrvCheckResult *res,
             continue;
         }
 
-        ret = mark_used(bs, bitmap, bitmap_size, host_off, 1);
+        ret = parallels_mark_used(bs, bitmap, bitmap_size, host_off, 1);
         assert(ret != -E2BIG);
         if (ret == 0) {
             continue;
@@ -887,7 +889,7 @@ parallels_check_duplicate(BlockDriverState *bs, BdrvCheckResult *res,
          * considered, and the bitmap size doesn't change. This specifically
          * means that -E2BIG is OK.
          */
-        ret = mark_used(bs, bitmap, bitmap_size, host_off, 1);
+        ret = parallels_mark_used(bs, bitmap, bitmap_size, host_off, 1);
         if (ret == -EBUSY) {
             res->check_errors++;
             goto out_repair_bat;
diff --git a/block/parallels.h b/block/parallels.h
index 423b2ad727..68077416b1 100644
--- a/block/parallels.h
+++ b/block/parallels.h
@@ -90,6 +90,9 @@ typedef struct BDRVParallelsState {
     Error *migration_blocker;
 } BDRVParallelsState;
 
+int parallels_mark_used(BlockDriverState *bs, unsigned long *bitmap,
+                        uint32_t bitmap_size, int64_t off, uint32_t count);
+
 int GRAPH_RDLOCK
 parallels_read_format_extension(BlockDriverState *bs, int64_t ext_off,
                                 Error **errp);
-- 
2.40.1


