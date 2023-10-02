Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6E47B4E55
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 10:59:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnElB-0002AH-0i; Mon, 02 Oct 2023 04:58:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qnEl5-0001pM-Uj; Mon, 02 Oct 2023 04:58:32 -0400
Received: from mail-vi1eur02on20713.outbound.protection.outlook.com
 ([2a01:111:f400:fe16::713]
 helo=EUR02-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qnEl3-0003Qj-8C; Mon, 02 Oct 2023 04:58:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fZurBy6PBj9GU8qSPSc6wYJn+d5evPg9s5bOKaF2otiPAJX7Qd2jRlJsX1/xRQafUTHDRMk+8q2V29n/wWEu8HyDmEe0dhLI6N+E8cPo/+cAuCzp3j4UQQDegrpzvrJ7/dxyLpivRLGmcQ/1W3BqtOAr5A4ODX+n9vvRARBHiVlxX06TpzYjfdNh8vic40ZO3Fv+AdTpqbngbnJetP1XN4svXtqWIPxmWl5amg+tVXrylkXmm1Jz9IVbS+BMiTcKLrLoplDm3YQrtQ3Q1PZv605hMmV+QdCLRqJKMAaXKgM9LIFAqlm4rUvQ8rLjzBfPMuJS9acNppafL44ihAeMJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i01mdCxXv0Ljgh5IqttweH0L7afzOn6zNTQCBaD05iU=;
 b=AQilie4V08aD0JtqCVE4y5nYQcYwmTjaLkHSnqoqmcGMBVk/I67SwDxPNKvxXEHPaCvHTj5qCcbSvb5Ot29SP3V41Fe5Ts6T3rORrfx3C4D0zVzCTkMnitGkA7DpVJctkGoWcZ5ewpBZxiStr4AtxU2nAULZZPK6pM32d68E8qVXpslYiQhLbuzNuc0Qj/Z3SIorr9GZlxCc0wg9Djg3rwBMclrGmPywiEf14oebtQXXmUK9ZYshyOCxzvqo61BTm5O5l588rkWaV+jC3Vjl3UdrtNme4ZgY+KBpdI1I+OwN4i8YklspBbVJXANVlrzeDTrlBNNIQHMaQv+HYLaZnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i01mdCxXv0Ljgh5IqttweH0L7afzOn6zNTQCBaD05iU=;
 b=ehQ8TsGWRxpoYDa9e86WeMMvh0k1nAWUoAo1Nh8yxTPJB5ADWZ73z8kn7Z6au7MuE80OaY1x4189ctQ2ujOUHabmk2ZxNlDe7NZ6sHDpRWJVs96IrxfBkrtFcXdFfilSWD66hCY684yKCYOP6EzvfR66VWM1VFtrT6Fa5/gwlkS9n2f6a7KZoCBt2VR5K+fw+bb0hbA5z1Nz3vkbssbfFhmQXkG5w4rXBvrfVIX7fPOMgAa5zJ8Fd0RnQkFb8IGc+vgq+3+Kd6o7ZzU/apNMhbEWgrbSe2uil89g211aR74rMr2DScG0Z55ft4k5WkKJtMWHfE+O9xZfI+YAhehHcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com (2603:10a6:3:4b::17)
 by AS8PR08MB8273.eurprd08.prod.outlook.com (2603:10a6:20b:537::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Mon, 2 Oct
 2023 08:57:59 +0000
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::4d4a:2d8c:6f96:4c77]) by HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::4d4a:2d8c:6f96:4c77%5]) with mapi id 15.20.6838.028; Mon, 2 Oct 2023
 08:57:59 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH 15/19] parallels: Remove unnecessary data_end field
Date: Mon,  2 Oct 2023 10:57:34 +0200
Message-Id: <20231002085738.369684-16-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231002085738.369684-1-alexander.ivanov@virtuozzo.com>
References: <20231002085738.369684-1-alexander.ivanov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0068.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::45) To HE1PR0801MB1931.eurprd08.prod.outlook.com
 (2603:10a6:3:4b::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1931:EE_|AS8PR08MB8273:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d4c757f-4391-49b6-b6c7-08dbc325ad6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bwmgex3UjTjdcnsn+5qtI8fYEjV7OtN1NH6lujn+HKF3pgZVI+DlVRocvnP8WIkcF91oeRVBD/dF4L56Ymwo9bM4Jx9OCAkVplY6tGjevIuegme7tJFBfy8f6Wxv3qidGkAfbS/yLhCrTJmYTOSttbkjhkDEI2nUAZl2UC5AFEuU+T+U3VkYPrR9BlAI2PTGWVh5hqKwdW5Kn7prUlAUWphGMa57Hxkn0XT5JnJ5DDWozzprcDC1RdgmhG7c/ESiKN1wof3tG036Yb7E0LP2gc4uZ1VP7Dl1evUehkeSrB6DQz85qikO9fFLnr2BMG3bZtmmlcSzQ3HkF1TJkge7gGKNYVD24av0sKtw0jVo8zYkVyadV/293e2RyQ7sUCW+iFRhZfphF/s3vfAi5Bj+Mrq2kqKgT2C3/HzhPRtztJV0/yTok4yckjGwZC9OdSzAPmPV/zxF050lw9f0xzLbQ0xiDvgbPK6Bx5yCRz6JW/J+sq/p7YcmxDLfbQVpuao/873at1nbZ+8EYrDE0Kt7+8XTMUOoT1iDJJ7o1TepVquTCf4rYxeIgpb1xX8a2CvS/ipZs66DNY5jSqUB2MHtZeRoRSRfgVlZ6Qn+KnWX8rikN4NDOMeIrsl8lWEvqX1X
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB1931.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(346002)(366004)(39840400004)(396003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(478600001)(1076003)(38100700002)(2616005)(26005)(6506007)(52116002)(6486002)(6512007)(38350700002)(86362001)(83380400001)(36756003)(6666004)(316002)(8936002)(4326008)(8676002)(6916009)(41300700001)(66476007)(66556008)(66946007)(44832011)(2906002)(5660300002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FoWigg3O/VKUrBzHE7A1KBnH/NCUDwJCKdBBMsY2OT87oLIG3L4OdydXIjMM?=
 =?us-ascii?Q?f+5aEm3cSxltovHcVGkv5/+oB5ehiPF2qzAg3cqClnm+mjtBanNXaWwuZ5/h?=
 =?us-ascii?Q?fhpEBNT/iyT2nqgn3PTXmCWZ0kFMt6pT7oLSn48IqpjUhqt6OXb40M9GsMTc?=
 =?us-ascii?Q?Em0Cc7LiuLbtAwQT0Ct9Ys5sC9ymBvnSF5Y+Q8T0io7RAUQuXFaVjdHLcJeY?=
 =?us-ascii?Q?hV6L19vkNMS5G+rKYEm1iTUGCq8Bsy4hqt1Oa5GDTblgUK3TJYPlOpRaL8Va?=
 =?us-ascii?Q?/iI6txkpMsXDllGKKSm7X5ZClO08xVLx0ztTZhiiZ3EHflUbCO8fKO9qwuH9?=
 =?us-ascii?Q?sWBa499JD004AZTM7SdAJJiaOM60G51OnLTX+M6h6Cxfg3cCa49NGuzlvEoF?=
 =?us-ascii?Q?0F4yG3IHWk0B9rJFbXDS5M5wbOl3kVcXs38XCsaXJ+kvnjstMTFpzeq6Hmhc?=
 =?us-ascii?Q?hHt8ayz0BDNwTWj8rKGCA3/YoZLvJjqI62pZD6uNpRRal5KbV5xxot1pCqyO?=
 =?us-ascii?Q?X6Hh6ASxpOogfwBW6IM2YezJrLAhq50Gumut5b7qoRZJsaJgGEsQffaIVuSl?=
 =?us-ascii?Q?w76kISYluj6Pmuvgrc0kZh8xAfStWBOJD43ax3bbpw4prEpQNVvFeNgdJt7w?=
 =?us-ascii?Q?GI/tY7Vuzg19eq2BaCTJyx0anal2YbL37CwlEZ3DaaE1FAfqPeHH9+BtTuWs?=
 =?us-ascii?Q?Vb4aZg1HmVKiGH1PA4VOw7P5wjbcQHW6U8MxNAirubCCXPqnJI74ziBMQ5Z9?=
 =?us-ascii?Q?cpQMp+hf0rwu5RHntFQgCTbn7jl9Q/0M98PxOkfBk4LyhWZ2eA4HlU783wnF?=
 =?us-ascii?Q?QIfu+KUYWotOh3sXtG/BaKqJ+4htkECO25wfhllMA84FTdQW/9aTdlxnhih5?=
 =?us-ascii?Q?NBKWZ5waPTr2LqL1PHNprIUGj2AZDBXQWuFRnSolD6eMWmtpK1pkDpJH73ZY?=
 =?us-ascii?Q?KdGZcAbMt+8vuSM+8Sudl9MaJQgnrAOxyfSxvEnjB+6BFFgoox5xjPbhiT+k?=
 =?us-ascii?Q?0KOKXtaY5JJvF6X2DR9WZHZwrctWtz+QGHgOQ60Hr+VhmNxTlfVhZTIvEGNy?=
 =?us-ascii?Q?usr3bVOqRDOttkz4cpQED4PCpqCIazET+DUWC/A7uV/QBq9BgP+B8gH6G3wv?=
 =?us-ascii?Q?uhs2gachtTBM4IWpvExK8HOi3wisWFpxRIvefVOB5Ythucy4P98e9aH9TiOp?=
 =?us-ascii?Q?BSdUkladGQqrqsPdPc/ppl5estF1CgdMlF36sRQBQw4vb5DDLNAd0RWCeOyq?=
 =?us-ascii?Q?Vx16dhxBaT5imkbucABRFVEOxvIbRIcbudPT1xj6hKtt7fALs0QY5y7SznGE?=
 =?us-ascii?Q?89wspPZqJ0t/YNNkDKBBinsYii4znlZWYaHdkxV4HHSVo01KrNrM0Sbm0dUz?=
 =?us-ascii?Q?/TVBfYPxPrb/XLqRHs2ZsOsW/nPFNgTGfG7WMHzyQDfp0oKEiullTm5n2FHZ?=
 =?us-ascii?Q?y6YdzOIjugSv3cV/jveIKVyXdO6r2L9ZQ3dptjXGat2Kvy3ebWkLfXhDlgKG?=
 =?us-ascii?Q?arlBQ16+lGqPu7dfsw6EtSg28bsPeJH7zs4JzxbldkkcFV9WdEQ7NpRyPtR+?=
 =?us-ascii?Q?FfX6ZwvMMjJNYP/E/3mXAyC5fwBJI7+s8y6RfnDqtMSIfTNhf36RQiwBesmg?=
 =?us-ascii?Q?RwCvCJ8ItdsTA2Tk5y5xZzA=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d4c757f-4391-49b6-b6c7-08dbc325ad6f
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB1931.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 08:57:59.5508 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AQERfl6zZZNwYfJV7Kxdj33I1CtPDh8WQ9cQI5d25tFSIIHQJlOlSF79KwxgTUSLi9wxUt1LSpHDldGi9KZtCZgIxjUihVC/l0r6arqIrMk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8273
Received-SPF: pass client-ip=2a01:111:f400:fe16::713;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR02-VI1-obe.outbound.protection.outlook.com
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

Since we have used bitmap, field data_end in BDRVParallelsState is
redundant and can be removed.

Add parallels_data_end() helper and remove data_end handling.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 33 +++++++++++++--------------------
 block/parallels.h |  1 -
 2 files changed, 13 insertions(+), 21 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index 48ea5b3f03..80a7171b84 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -265,6 +265,13 @@ static void parallels_free_used_bitmap(BlockDriverState *bs)
     g_free(s->used_bmap);
 }
 
+static int64_t parallels_data_end(BDRVParallelsState *s)
+{
+    int64_t data_end = s->data_start * BDRV_SECTOR_SIZE;
+    data_end += s->used_bmap_size * s->cluster_size;
+    return data_end;
+}
+
 int64_t parallels_allocate_host_clusters(BlockDriverState *bs,
                                          int64_t *clusters)
 {
@@ -275,7 +282,7 @@ int64_t parallels_allocate_host_clusters(BlockDriverState *bs,
 
     first_free = find_first_zero_bit(s->used_bmap, s->used_bmap_size);
     if (first_free == s->used_bmap_size) {
-        host_off = s->data_end * BDRV_SECTOR_SIZE;
+        host_off = parallels_data_end(s);
         prealloc_clusters = *clusters + s->prealloc_size / s->tracks;
         bytes = prealloc_clusters * s->cluster_size;
 
@@ -297,9 +304,6 @@ int64_t parallels_allocate_host_clusters(BlockDriverState *bs,
         s->used_bmap = bitmap_zero_extend(s->used_bmap, s->used_bmap_size,
                                           new_usedsize);
         s->used_bmap_size = new_usedsize;
-        if (host_off + bytes > s->data_end * BDRV_SECTOR_SIZE) {
-            s->data_end = (host_off + bytes) / BDRV_SECTOR_SIZE;
-        }
     } else {
         next_used = find_next_bit(s->used_bmap, s->used_bmap_size, first_free);
 
@@ -315,8 +319,7 @@ int64_t parallels_allocate_host_clusters(BlockDriverState *bs,
          * branch. In the other case we are likely re-using hole. Preallocate
          * the space if required by the prealloc_mode.
          */
-        if (s->prealloc_mode == PRL_PREALLOC_MODE_FALLOCATE &&
-                host_off < s->data_end * BDRV_SECTOR_SIZE) {
+        if (s->prealloc_mode == PRL_PREALLOC_MODE_FALLOCATE) {
             ret = bdrv_pwrite_zeroes(bs->file, host_off, bytes, 0);
             if (ret < 0) {
                 return ret;
@@ -757,13 +760,7 @@ parallels_check_outside_image(BlockDriverState *bs, BdrvCheckResult *res,
         }
     }
 
-    if (high_off == 0) {
-        res->image_end_offset = s->data_end << BDRV_SECTOR_BITS;
-    } else {
-        res->image_end_offset = high_off + s->cluster_size;
-        s->data_end = res->image_end_offset >> BDRV_SECTOR_BITS;
-    }
-
+    res->image_end_offset = parallels_data_end(s);
     return 0;
 }
 
@@ -806,7 +803,6 @@ parallels_check_leak(BlockDriverState *bs, BdrvCheckResult *res,
             res->check_errors++;
             return ret;
         }
-        s->data_end = res->image_end_offset >> BDRV_SECTOR_BITS;
 
         parallels_free_used_bitmap(bs);
         ret = parallels_fill_used_bitmap(bs);
@@ -1361,8 +1357,7 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
     }
 
     s->data_start = data_start;
-    s->data_end = s->data_start;
-    if (s->data_end < (s->header_size >> BDRV_SECTOR_BITS)) {
+    if (s->data_start < (s->header_size >> BDRV_SECTOR_BITS)) {
         /*
          * There is not enough unused space to fit to block align between BAT
          * and actual data. We can't avoid read-modify-write...
@@ -1403,11 +1398,10 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
 
     for (i = 0; i < s->bat_size; i++) {
         sector = bat2sect(s, i);
-        if (sector + s->tracks > s->data_end) {
-            s->data_end = sector + s->tracks;
+        if (sector + s->tracks > file_nb_sectors) {
+            need_check = true;
         }
     }
-    need_check = need_check || s->data_end > file_nb_sectors;
 
     ret = parallels_fill_used_bitmap(bs);
     if (ret == -ENOMEM) {
@@ -1461,7 +1455,6 @@ static int parallels_truncate_unused_clusters(BlockDriverState *bs)
         end_off = (end_off + 1) * s->cluster_size;
     }
     end_off += s->data_start * BDRV_SECTOR_SIZE;
-    s->data_end = end_off / BDRV_SECTOR_SIZE;
     return bdrv_truncate(bs->file, end_off, true, PREALLOC_MODE_OFF, 0, NULL);
 }
 
diff --git a/block/parallels.h b/block/parallels.h
index 18b4f8068e..a6a048d890 100644
--- a/block/parallels.h
+++ b/block/parallels.h
@@ -79,7 +79,6 @@ typedef struct BDRVParallelsState {
     unsigned int bat_size;
 
     int64_t  data_start;
-    int64_t  data_end;
     uint64_t prealloc_size;
     ParallelsPreallocMode prealloc_mode;
 
-- 
2.34.1


