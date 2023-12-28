Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A50CF81F6C0
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 11:14:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rInNk-0005FS-QU; Thu, 28 Dec 2023 05:12:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rInNj-0005F1-Ei; Thu, 28 Dec 2023 05:12:51 -0500
Received: from mail-vi1eur05on20707.outbound.protection.outlook.com
 ([2a01:111:f400:7d00::707]
 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rInNh-0000Sp-Sl; Thu, 28 Dec 2023 05:12:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N6LH/WsyjdvQhYKiJZPQJJgFmR5ONVRh0vES0HiYJmf2ew+8iurUAQfqd04CmC43aItfF/6oi0EzzPV2R4LWCinleAiWI7LTf5w7YFUDuAoWo8GwNBAxcklRCLeyE2Mv0njoV0ml0yNWqzM0YFGHOuGX32ZDnk3Fe4R0/0dI+lDLT2LpZfNF+axRbdqMH2s6+eXYzvdfTpRr7kCrH8lermmO2yC5XOCdRWzjqnEOO91mrW2kA+DpgXjNsRB9GnMbHw2rIn2akPBQgtDMfuBVpqr3K1gQiB41p8cWgsrnTYMrHA/6Z3VXjyjh/YWD87WrG6G1whn/AK3E36GsBDXNwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QZAYmTt6a8iWzR3ObMRJXGIqRa8RVqoX0brRg6ZAt0Q=;
 b=QLXIwTuvzHaFWidAp/ad/rS59cToM/sgX0IteOUWWeUbaHdRTjiw6RkOvQMLELUnpBggcOmgotXbs+esJnd0ukrlBK0tGUMrsXcjp9Oe5So5SOtkl7fNAQNDghIwiNyddnDLv3jIQeRFiPVKuOJA4Y0tY+bTZrwcRPnhQr60vLkP36Prj2zfD0+ms1/xKZFJpPdzVlWHs1L3XB+vhOTv+SRAjxhmmWPhXQIKBur75N+DWYfi1DVYTMQqDQQjY1jwwhjPeWetlALRkJLaQFuFfGVZLywGOGjcSTez1X0MkAjiXQKR/SYmGwbzbFBAVyxdLNU0rj7UE79r/Ph/xPxP7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZAYmTt6a8iWzR3ObMRJXGIqRa8RVqoX0brRg6ZAt0Q=;
 b=hlZmEzKCFRI7YfPqGbNZS/GzRiOeitgFA2vWNqitjh4WuAZGS901Qeh0X85m2/vSJsGHUAV6pOTXLvJAYlYPqcmBQ1Q5ixphdCsR1QzJdJ14BwiTmVZNaDRfw1h7hyEU22VauQP/uy3SwUQMy4QzmvDJ8WM+TmAo1ExGPxOwWVMtK2N9HI++on9wPILcYUFXf/8ufVy+1EyDsOLBuBuDIVSKhIV6WLZUsvaeVWE5dNAeQ5et9TkgD/yFkL7MzGOwaKp0zq8ZoSfEvLmDL2AM6efpvSx1GXHxryvqKlBvL/OqjX3dDBYmdtpCD7aQGch8eVXms8KklDtQb7bX2hiokw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by PA4PR08MB7459.eurprd08.prod.outlook.com
 (2603:10a6:102:2a6::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.19; Thu, 28 Dec
 2023 10:12:41 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0%5]) with mapi id 15.20.7135.019; Thu, 28 Dec 2023
 10:12:41 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v4 03/21] parallels: Make mark_used() a global function
Date: Thu, 28 Dec 2023 11:12:14 +0100
Message-Id: <20231228101232.372142-4-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231228101232.372142-1-alexander.ivanov@virtuozzo.com>
References: <20231228101232.372142-1-alexander.ivanov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0044.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::8) To VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|PA4PR08MB7459:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a3ce7e5-8c7e-4a94-6faf-08dc078d86a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ibe41QkepRzS01THvdA4/dB5XmszX5CxF50H81Ibe1z42M2yBgC5xTVKlt7KYLnb76BgDcbaRa9PwuDG6676SasdscluT+CkUgl662sav9MF2xot//7zyYdLnPVeA8OIHl6V3Dwx83Vd91Qfrm3UgrscyF13VVylLVSVhm9YMcHDf3zpvK6gbrTXx902qknSv4xiKr9ZSxOFZNkR7v0/0LcdELZUBLJunBOwJI3aEtNj3at5uUxqqeHzS92Aq4ocJMa7uePY3bJrigQ/d8Fedy8NiUtlJe4LAzcS5g0e+sEYKnYTYL0jq3WcEoxNWAS+63ibi6XtR6khkZQ+1Cx3R4Iu8SUw54mcZ7/S9S9CdCa+mXNX97ANVnEZXVPUDuzAf7HwxqnXZ5/schrgpxc6iRAsJdzpV8629YSpXOxfPNXQ25aqRJkFDbp1kBQEllJ/yfP4LoCQn2y2KIvWWxB4dXAwqeB035ob3mE/553DJwfwFv0Zzhonl9bDBcJ5NtC64idqMYB2QUltGassnejcHRH9N2G3b2qtHrgnLh8qHn+dgh+kY/ZAZ7VCcU1+BSMyfzL2Uwk3QsQB0cXkO92EAAydF2zyy54GMdt3FP8SIptlVTMOt9hGxCKI4HUNz061
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(396003)(346002)(39850400004)(366004)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(2616005)(26005)(1076003)(6666004)(6512007)(52116002)(6506007)(83380400001)(6916009)(478600001)(4326008)(8936002)(8676002)(5660300002)(44832011)(6486002)(66556008)(66476007)(66946007)(316002)(38100700002)(86362001)(41300700001)(38350700005)(36756003)(2906002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t+yjKdzJ1PiLsv84MR2LtSFshvlQ2j33b2rmBJ6lfakNiAsZGIQwSW59cVyt?=
 =?us-ascii?Q?prOmPyzT2VJY6RbpKuYz3oJ7SqlP2zTPhmesRjB42DPTJc2SSprfwrIvJZsX?=
 =?us-ascii?Q?vUHsAfARy/UUkkT6focfrozKM+DKCSB61jt/I428r0ACM62e/kE57jC2OtFi?=
 =?us-ascii?Q?9P6ZuK5Alfi7oQuNXVDQjpvlu+85vVxEecDJYPyvRTa6EAXCNI4C0yOo6OD9?=
 =?us-ascii?Q?xJNniNlJmempNDURPJL2kWXztXKBd/6LTMmR/ll2TvyPsemC8kryZaDDbCUO?=
 =?us-ascii?Q?AuyUCcH17yaGY5BQ/G7HS10mfzPgWCiKWqxeLO+eIIwMBZJKrTPNRywN2JlH?=
 =?us-ascii?Q?771/p36IQnK23EZOH/WBYI4UJSSVzUdv17xExOx7XYdn/m/6ww01pM1xA1nv?=
 =?us-ascii?Q?7Kcj4TZjSU1z2WebXk+BFyrOWG6imBcJMYFd8e4cBmOjuDN1yTQ8RDFJx3ZY?=
 =?us-ascii?Q?+cQLENVHakoeMYPgEfqZPGBC7QBU0WNv+rmEioyMninl2xd0F/ykuAmR4f2G?=
 =?us-ascii?Q?z90/AwRup58jKOyQj3Gjcg49pRxlw7gXepbXs09ccwlESCp1iYemb4CDpsEg?=
 =?us-ascii?Q?AmXaV6j4GYaYFHLdSO1d2XK31bTHZFj2XqSi3zDeIU52WvqK8dZbSseZqEc9?=
 =?us-ascii?Q?oac/GTJYlwUaPM/Nmh7k5nK7fZvqf8XP1g0g4rWgF5vX+w/Mvh81kEAEZJI5?=
 =?us-ascii?Q?hXj1gYkssrBIx/soUcmPV1lzRudBJFl4MEmf9JVCY8lm54O2acxOE7SYrdCd?=
 =?us-ascii?Q?0OBicfs50/GIWjpOioEKY/xhBbMEpD4UBquAMMSuI7Q8ygjhpM0Mr2F8hB+P?=
 =?us-ascii?Q?+XLcDe/i3YYDjQoNQFZxqi+Z9qGFMMWOCq2Fy8vJq43IjZzmRLpz1CQvmksT?=
 =?us-ascii?Q?vMhixcwVbU8DqV077bIOvPCCIUufY9bO2glGxChwOhwohL1YQ4AHicwEfz+g?=
 =?us-ascii?Q?kXli9ikmW8s/9TiDUcFK6I3FB+18M8jg2tLConFHJJhbZg5oMSzCnoTnxDL4?=
 =?us-ascii?Q?DMvLzC3hfzEcyl799HVZ+a4NUJVOur/0pDnJ093G3MidovxfBrec2NqrXEby?=
 =?us-ascii?Q?PRzMRY3dc7daK8jw4G8zxWpHygCC+i3DS1gawE3RUKXbsY0/MD0zdjwAz02z?=
 =?us-ascii?Q?bhXCXRMeayJiZF8S0Bx7mv0AP1tkTu4VB+9gt0sPD9Gui1gkOztr90j3YfZ3?=
 =?us-ascii?Q?Ot409OTyiIYso+bOMrdhJzqvwVjuLxUac7ieAK36+3D4hjL5t988P9+n5DOo?=
 =?us-ascii?Q?/CRzltTPp6nieKZfmrGZJEFPLVkXIIUBxhof3aSHpJmMdxbETkY37Y+HmDxa?=
 =?us-ascii?Q?6bGiRO5FgtzrcQiLNGGERrSInrJbWKwA5wnxiEnxdpvKk9tvXXhueW5TmaBd?=
 =?us-ascii?Q?WeSsXdlEzwFUwZ8cEzMg2kmYhvkoMG4cFQkX4RekbbyQ71tsNlzQbL5ZnbP3?=
 =?us-ascii?Q?GSQ3UitdbbVQvJsm0S8zviba492bwANfzvnFFLsI1reRSc+VRk9Bry7/PowP?=
 =?us-ascii?Q?FZ8jXzX9PMH/cl0SlN2MNegKePhi5tXGXd3apZBxn3cqtV56/+E9ITK2skKw?=
 =?us-ascii?Q?Sre7VITYKcCn1ZO2cMgzed3Pv2B9p+AZCW3se3NIL2u5o3BCOpJskeb1znBQ?=
 =?us-ascii?Q?jPQAyM4zxLdqKBsXSqkucm4=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a3ce7e5-8c7e-4a94-6faf-08dc078d86a2
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 10:12:41.1466 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mvR3+XGXjXLs+fkbLFnlGqz9pulD+hKDEyBgE/SzqQXE6EXvqeQA9+4WI8AV+mbsvGZ+vxLxjQWoE0smZglwkSB07pqKy9YpCjOSh5GSL6o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB7459
Received-SPF: pass client-ip=2a01:111:f400:7d00::707;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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


