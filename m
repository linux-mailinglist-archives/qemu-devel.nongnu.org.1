Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2817A7D903E
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 09:48:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwHZJ-0007ZI-Uo; Fri, 27 Oct 2023 03:47:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qwHYb-0007Am-Ed; Fri, 27 Oct 2023 03:47:08 -0400
Received: from mail-db5eur02on20704.outbound.protection.outlook.com
 ([2a01:111:f400:fe12::704]
 helo=EUR02-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qwHYZ-00040L-0j; Fri, 27 Oct 2023 03:47:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gyQYdCkqTmC6qRGYXVhZ8YrIMYpEsSw+Wd/uGeTepPbWSWNbcCW7er0sobJu1HTdPkNJPgau5W8zEFOivTrKO6JOHi+zGoJhVCZg9FEA2ODVSMzIYSXbIgpKEiqcxlXn6q2e0D61RywbnmREVAGJ/QAdwJtY4aafVu5aGy5svJdXt6vXW/TScJ8pBpY3OnqRiYvQN0oaOM25BQbKjiDraB/mLqGtC3qxbAZTL6jypKBC3bH/+akCP5XBTRB2lIZVvgeafWR6gHSaRjFeMiRh7OLM/J8/cjLuWNN7SLs6XJ14elyIZK+xx1oPjdc5Hh0E7aVMQnBkRg4Xmq42U9i6Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uC4wNRY9AEShD4pxrOKSGs4Rr1nckEx8pvNdLfePCVo=;
 b=EClQZ2dSt7TGhA0fx07s7NkFDx0W9i0n5ywPJG8Cr7aIcWwnHDMnJZeeOhki/vSGaWleQP+oKfClHiskjdl33QzpSB58tsieEU9HdK7ZwJ0ABxXPX5BESMk7ycF3EQDEHxpxbhTir8q3lucDq99cL4lUM6hWKx6e0htx44GBJHRHTJL/und7CrpOiPBxosCllczlIWLrdoQA+c1dJJx+RK2pA8Tk/qioGQ6bLldbRjcEaKLVkwbBFdwjz6fOIZBMhHombfskM5a98mDWkzVIulplI/Bx/J9qGYkhWSs7ypOe+BVyaHrYnu+vyJRLIdfeZEj+uITBu5nxwVzxR5lApA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uC4wNRY9AEShD4pxrOKSGs4Rr1nckEx8pvNdLfePCVo=;
 b=IC7OvAeX4MVAGCHuKJ7l96KtC22PUS3wYhNvFZ6Ju54Vdj1zhSn1EOCQP1Xp+zZ5aEErr7J8mqiwRMxGCxlAjDEFOU6KrbZgZszCLeiCjTa7FV+Xj0ZMgL8LTWHcMT87QNcd0lBMe3GfatHROV6zpkaNexsyG+jo2JXwhQlVe5MOVyJBG+iSkexdnUi/DjO0oHGFImLO8wGPphDki3tE/eRdp34H7xIhMn2tdNRbAqnW5/LdOsKRZwQ1eootgsgS+x3Wy8oplN5xSPWcaybM36GWz3OnVdT19k2kmcC0o4u3ZzO8MsOi8tRFwQlDQdGUzVRlxy9qBDpDUCmVbha8Vg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by DB4PR08MB8056.eurprd08.prod.outlook.com
 (2603:10a6:10:387::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Fri, 27 Oct
 2023 07:46:45 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::22f7:6498:de53:5371]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::22f7:6498:de53:5371%4]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 07:46:45 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v3 03/21] parallels: Make mark_used() a global function
Date: Fri, 27 Oct 2023 09:46:18 +0200
Message-Id: <20231027074636.430139-4-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027074636.430139-1-alexander.ivanov@virtuozzo.com>
References: <20231027074636.430139-1-alexander.ivanov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR10CA0101.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::30) To VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|DB4PR08MB8056:EE_
X-MS-Office365-Filtering-Correlation-Id: f44079b2-638d-48c6-d947-08dbd6c0dd7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oNm72LOA8qqBc4CK1m1XXHNPmg8GSZ8aK7vgMEeGuBPsK+VgnL81GVS7jvdOAlHVn7dGyXjisq/TjeILrw9a83p5uhQEUGxCQVMLFYjAnXDrGwpQquc/OoF7pqEUWRweh6jiWeqq5zbfpKhS5LVmGe9oAKld8sFB0WGZ6ggPVMA3VHJWo8w896DzvEeDfuDtH9N4SIRsR67A+z9L0Jjk02WmTlL/01D9PDP9ObCjVwK84dohrhEjQe8waZ+ubavwE+uPj5Lb9OGqTaCe4UyvGTQPE7laI3+ZWSvcNw/0/crsyU6In3gagHKKEriJmyE2+bHPtBx6DJAECw+fe2kIQ4az78OtDC0SnbjvlDkB4jYuXEFtZrz6s5oy5/p0NfHAG+cd+OFjcW9Ir634nh/1WB5A4K2OGO/6EPW2/KDkoSPGYEWUHixnQVgQajDQLaUFAJPHrk+UDuFVO/DbcwhBAqHm+97fa3IRFNKxucUUIhIC772/zfdXgWuA2V7YHtIQZiB/LSPBhU1wSQ7Iy/SmghHYZmdwy5kZp2g5LWZhpl5xl7hwlxwQeObNJvhzCRzM03o82Tj9P5gdUTTsNZbgwVTh2Ytsgr1Q0Pw6ZhoAdOGDjg/JtP4BGDh9PWvrgTMC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(376002)(136003)(346002)(39840400004)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(38350700005)(6512007)(6666004)(52116002)(6486002)(6506007)(478600001)(38100700002)(86362001)(36756003)(2906002)(66556008)(2616005)(26005)(1076003)(4326008)(8936002)(316002)(66946007)(6916009)(44832011)(5660300002)(66476007)(41300700001)(8676002)(83380400001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QJDvMKQaeJwCH61A2bpfNArg9ypDqSX16z6UBlTd2u8aWh5AepGllrEV6mil?=
 =?us-ascii?Q?pIil9U+DzsPkvGS7ixzuRYiuBHw8FcI553axvwdSi2wenF0Ezi1o9ebzsjG9?=
 =?us-ascii?Q?l1KPB+apmDxcY8EnmxszaQRkngy/cG2H+3p1XphUULwn9CMxDQcj74I5OfB+?=
 =?us-ascii?Q?ijcAC7Zg94Xc36mX1gsPL7ay143rnmRprX9myGNr2skgIJ1AUjfSJDPjjAgL?=
 =?us-ascii?Q?qCR3aAAQeOx1gM8v5jkkDBKhr3Zh0fDCzI0CrIxJLwKEZdWmBC+oXgOWA13U?=
 =?us-ascii?Q?7jTmFJ+MQBuyJjXGO1obi/ZZKf21gyIEHnQqm95I4ozSRSH6tuozje559GMf?=
 =?us-ascii?Q?8iU2nUa2PmJmo4riaJrzW4l9qn7cSoq60Kiqp9F/Euc/PqAdbXp776AxgMaF?=
 =?us-ascii?Q?SSNoEQ7O+MzXPt0+kEf4kSe6geSstTflNID+ZuF5WwfPEuBk6/PKj24FKdsv?=
 =?us-ascii?Q?Ki9ZQDevR/VtTpqjzTlVRn0gU6xQI4KIHPhW9K1SNdPnLlctZWqnzFhyIgmk?=
 =?us-ascii?Q?nATcxPWoYjWHIBN9TgP0v1MrRO95LsQdli9YE/a4/jDmeAyiL081gdcBP5+e?=
 =?us-ascii?Q?xYzWVSM/SlojWawHCihqglAlHHav4NDfTcLl6zORmJjxxXNphJ4cyxIb5Uxs?=
 =?us-ascii?Q?F7fo8UWEWWv8RriL2SVUUoLNWNEyVg6jlh4/be7+rtRgO1LcA8D03Z9fvsmR?=
 =?us-ascii?Q?rhDUuum+hgFWIckTmcUzYM8PJpR9xmnBWogzX+AZ0/6jucRkNxeLIPzw3ZV6?=
 =?us-ascii?Q?uXD++l3SEQArPM53EZnNMicwakiy/eBOTvEatUM00iJCxqct5E1TNJPohwna?=
 =?us-ascii?Q?xT6nbl+p0FYEJoCJHORooI+NW8auLNBk332ruuuYk0Mt3FByjuqAR2T2lR6u?=
 =?us-ascii?Q?ZZfdpdwxupgiMXSG0nsS7DcUGRHkZrZY4AIZVCRZrnVS+sCGEDL75shTQqj/?=
 =?us-ascii?Q?EEf4WShVSg5Eauai6hBGCvjxms53p0aYRLt3j/o8COe/ISfGDpzzxwmxu0k3?=
 =?us-ascii?Q?Gqbu9NRZ1KMoSyFl30SOdjdS902N/54lxhZkMs3ataaA3Z5u6JeixhZfvd0Q?=
 =?us-ascii?Q?o9X8e5cJRn2ORUrb2cizAxDWKUZrBoa/TU+UY2SAZisMvKFAdSoJ1vh61+oT?=
 =?us-ascii?Q?LEcjLFtT7t2/NxTHlfnfQPsQ/1gi1rL81GLuITZGKvEQ7qfVPw2CoUioeW3E?=
 =?us-ascii?Q?qHIj9swaXFfRupHtAUSEZp0pjbqMMk+hqMKWBweJjJQtyEUkrIWR5Nr7Y1bf?=
 =?us-ascii?Q?ULk6MbrMxdiLaNb3Zihf5eFds4rHMhkcaVqZv8njP62Jx1kUxj0KfqX1zrI5?=
 =?us-ascii?Q?SJfe5iAVRPi0uHGm5r99hYPuQqj+EjRtcvhlbn8mD4D/9XzoEctEdUFTughS?=
 =?us-ascii?Q?+hJzZ+p6/N+PeiBdYXiviPeSOe6sWcLVet3ajl7QYx0jFORIFlhEqwQiFq5l?=
 =?us-ascii?Q?yu8gcgx7Z9J9kKu1p0uhnbQ15a+1erg2nbM7ED4V4hrqps/PE2btT9m/dgah?=
 =?us-ascii?Q?KkXRE2F3CwnDgHCewMYjRYzMWNyM1OmtCBfrTUeJ9ddepxIUB/ydgt6iZqPQ?=
 =?us-ascii?Q?PESIVmL2VclpBTVBp6tyjJ08+HnMZYmyPRyuWeKx80+YBjU+ceXgx7bpQBvP?=
 =?us-ascii?Q?Ge4L7tK/iI1V5XM4z9P8nBQ=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f44079b2-638d-48c6-d947-08dbd6c0dd7a
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 07:46:44.2401 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xURHLLx9XHM6aczn56NXV4pGKkg0vZXapWmt7hXb9l232RYiEXCrpprStcdjdnM3PSMyca9XQn/snYyuR3TDE6OQzIWiMhjyY07ZB+s0NkM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB8056
Received-SPF: pass client-ip=2a01:111:f400:fe12::704;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR02-DB5-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
 block/parallels.c | 14 ++++++++------
 block/parallels.h |  3 +++
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index 8962bc9fe5..e9a8cbe430 100644
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
@@ -232,7 +232,8 @@ static int parallels_fill_used_bitmap(BlockDriverState *bs)
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
@@ -831,7 +833,7 @@ parallels_check_duplicate(BlockDriverState *bs, BdrvCheckResult *res,
             continue;
         }
 
-        ret = mark_used(bs, bitmap, bitmap_size, host_off, 1);
+        ret = parallels_mark_used(bs, bitmap, bitmap_size, host_off, 1);
         assert(ret != -E2BIG);
         if (ret == 0) {
             continue;
@@ -891,7 +893,7 @@ parallels_check_duplicate(BlockDriverState *bs, BdrvCheckResult *res,
          * considered, and the bitmap size doesn't change. This specifically
          * means that -E2BIG is OK.
          */
-        ret = mark_used(bs, bitmap, bitmap_size, host_off, 1);
+        ret = parallels_mark_used(bs, bitmap, bitmap_size, host_off, 1);
         if (ret == -EBUSY) {
             res->check_errors++;
             goto out_repair_bat;
diff --git a/block/parallels.h b/block/parallels.h
index 6b199443cf..bb18ee0527 100644
--- a/block/parallels.h
+++ b/block/parallels.h
@@ -90,6 +90,9 @@ typedef struct BDRVParallelsState {
     Error *migration_blocker;
 } BDRVParallelsState;
 
+int parallels_mark_used(BlockDriverState *bs, unsigned long *bitmap,
+                        uint32_t bitmap_size, int64_t off, uint32_t count);
+
 int parallels_read_format_extension(BlockDriverState *bs,
                                     int64_t ext_off, Error **errp);
 
-- 
2.34.1


