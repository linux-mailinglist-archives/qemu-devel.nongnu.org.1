Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AAF7D9046
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 09:49:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwHZb-0008Pl-Ov; Fri, 27 Oct 2023 03:48:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qwHYv-0007Jz-CP; Fri, 27 Oct 2023 03:47:25 -0400
Received: from mail-db5eur02on2072e.outbound.protection.outlook.com
 ([2a01:111:f400:fe12::72e]
 helo=EUR02-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qwHYs-0003oB-Uu; Fri, 27 Oct 2023 03:47:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CJENksIURukkIiqBfhdktB0d6pMu64Cd9yrUoB3g2StnyDg4Cc5OSJHOzSqqSfVNneijdo715M8/2cXJ8F8Rs6JcbHnxanDenbWqZq7AYx1PqRVwSVZm5kW8+9uJMBMiWjDvBZL8HAoO4EenHsZYHtbpQAVej4ekQMTd0JSnfuEArcauLVvgWJeOFpUEeikbDLrI0t1b5+DriXe3eD4CGfYGp2JD1GtUQUqh1k0NyB2Ez9+Id5uj65HAKAPZc9i4C2kROw9/iCacoGVALy77su/5ZS4Y1DQOdEU/l5wTjBikP41Lpzn4sqhX12YzrSExdPTp/3Lg1xluLNUWJmMvmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/k1oANas5MIf55ewby6rPkY5+MPfOFhL+ASOIh1bWOk=;
 b=UEHJpShifFiJ71Yfm/RY1Gujtc1sId7UCn0Rw3xAaColKJx3E9O4AodTHH3GY1yLFmo2E7aK+oOwKHqpI01veOgREMxSLtb4xBlwrR21iJu82EeEp+C8NxbXmZOrUkkcPrp/S9kBuTMzo0tK+Rx9WlU7ZGspb2S/LETFuw84vL+DlFjKEOmxyJgrS4OXcFLVzjXvRnjJq4m6gVDwjCoh6IfHaM7DUYWKRq7MXU3PdL39OklK/Drk6UJ+FBkS8tOjg39avcSHmxuZ+/fTF4WZEn+CfZf5IuGdsiwMzvzbc9fvISTwuMYfcQxjg/EUaLYq9B+JJC6Q8DGvHZUKn2pD/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/k1oANas5MIf55ewby6rPkY5+MPfOFhL+ASOIh1bWOk=;
 b=EAU7/MZVS+KR9SwlHsKIhlm4CSV6OZh5snE3OqlKfh4z5rXav0JwFYgym2FsCYlcZsx32aIo69RQLbLt4s9FT9bvEab9T0y3M+PLiOhClXcanVhQJcGsuWUewnpOZY2e5YUBjHR51qA3XKAItDDiHr+vDaOcmZlBw+xbCOaw/7gR3+M5Zx1J9CJxyfZSzDr+txuMvshdgStPQyeEcgfPbNt1aKtyk8K5tEbh8YmP80m4RIcq/EAeto/HMZhZBBaUQV8cGTpjPcJEk14kl9DKwrgVN80OV+Xlj96erEWRBFta/XeDAIz9I/aL6HfMOgwkmdqh0Tl0zKQsAzUOpHzPyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by DB4PR08MB8056.eurprd08.prod.outlook.com
 (2603:10a6:10:387::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Fri, 27 Oct
 2023 07:46:50 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::22f7:6498:de53:5371]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::22f7:6498:de53:5371%4]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 07:46:49 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v3 13/21] parallels: Handle L1 entries equal to one
Date: Fri, 27 Oct 2023 09:46:28 +0200
Message-Id: <20231027074636.430139-14-alexander.ivanov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: ccc3fa63-82bc-4e7e-7c1f-08dbd6c0dfb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qxTW1GLUAxcJ4IG1Mj/HIVd0Vc3og6yObrlDcf6lvZWVNpLqjOUe9PWFirR+jw8YP7WdHXIiv+B7sCW4LCtukGekbw2z5xoNB85DzhFME1rTlpd3NymocuricSBJ2MA/FXudYDvhY+pJrJKJICp7xN5BInzmycHr2kms4Qo2LqSJF2rHcUDZhSs0HSYkArFYB9piKVt057yOycAYl1ezNnAlmREd/1q30dihmY46FU3a1Wy1IWgC/KsbFZUqzOIo4oINcqJLc84fX9kwNHxs400BTK9bnAbC8mzaqPI/gCYU/DbOV7AjwiVuGjY2zu4TMYcMl1QG8zYZCpU47foP7FNCtctnyW3b8R3ItuMJMzgFdkCk1mWpXsBTxdVWIJ3wMUn7zRcpjB+dnEwvbH4QlBkIcR5eiH28ftgyQyed0sW4OvkVog184m2UZT7TfuhlNSBZrqcyIxzFbVbfus6/4x1hZg4od2LWH9ZQeebB07qOSIIZwrXwCaXZdZ2OR5zU7n7U2hEwBAH/vwjHhvUmXH2sxi51VTQLOVSmghRthCWBSAa//zfNHyzrgEyyR/5Ssvt8DAjuICJEMCZuS48d7Dd38ClDftGkiAKTcccpcNJCrJizVdfG8JN2XKOmazGU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(376002)(136003)(346002)(39840400004)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(38350700005)(6512007)(6666004)(52116002)(6486002)(6506007)(478600001)(38100700002)(86362001)(36756003)(2906002)(66556008)(2616005)(26005)(1076003)(4326008)(8936002)(316002)(66946007)(6916009)(44832011)(5660300002)(66476007)(41300700001)(8676002)(83380400001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?91E96gfkXKbR42+QrD+HJPVwsTCp4W7AMAivOFNb08C9ex9eGuuYIwggrBQU?=
 =?us-ascii?Q?ZtHW5v+l9qeULMkwEiHhae77ulCztO7mmi6W5n7vBMOCDn4sFZ5BZy26Safm?=
 =?us-ascii?Q?c5ZNVZQMaJRBikbhTTqH80W29wjFK0tOIDE3uqTfJf9URCKmCBwHaXik+Kid?=
 =?us-ascii?Q?fnRBws4Qy1kmXqKqZC/o6nppbP2G2pp9n1WXRVd69n5jbnGU7n7zGwzXld8o?=
 =?us-ascii?Q?idlhsTEJURAAysxYYKShlRI0AGWa92WwQNdc+mU5dQILGx+g/eQc62L03kZe?=
 =?us-ascii?Q?fGklxLuyP2KQaNhn3PHI/0OnFo6ZemEdDLrhNDADbJlXeotrsgwBjzXA1t6B?=
 =?us-ascii?Q?QWTCb9u4E+BvlI/LRbQ6srWMpAJrwh0O7cmlbfMVlnWjlYW8kn/GZzTLfpxH?=
 =?us-ascii?Q?Cn+yDaufMr6in+8JxGLPBOjr18atD8PEQ+Ac9Wr4RYLEbqUHstwenRTxp/+N?=
 =?us-ascii?Q?J+8AxtCgxXUS9/VN/noCmACqnIA4bH2Y7YijICjJXezTj6xpLSE84XdNIU/r?=
 =?us-ascii?Q?hc//x/yLzhYGeSsipNQgEVJYcSa9otPXvR18UM8cWmVp2Xs+Ov6dotL6XIiU?=
 =?us-ascii?Q?tutsrqh4U5K4RB4FKeV1ddv1WU4y5cFpi8KNMdAsJU8RIqrHEtPOOMhZ+VCm?=
 =?us-ascii?Q?sm+yMYlslZZet541S/T32EEuWoTvuySuYFByNP/t1Zc8gWxoyEZ9wUQg2GS0?=
 =?us-ascii?Q?FiYrJwHIZNvZvvBNMDWDaRHL2gk01bTq9hE3at56JtOhf7g2N6GcHmu9AqxP?=
 =?us-ascii?Q?NWgRVEERkzCrEeQ7ZoJIEFTYThYpLEeAWVHLPitI2XV8jPceT9GbHo4Pkxx/?=
 =?us-ascii?Q?FK6lai9w1fUjO2oxKClNXeChiWBHKmd7Ep0Kf1fZZ2De7JDK4nqWYzGnzfyI?=
 =?us-ascii?Q?cUR0Lo8KRZaGXvkOvjQV6+XgCZ3mmDEp2IWOT3vhQnZSZ5WW4SsaVrxXMF5s?=
 =?us-ascii?Q?uLTe0+sYt1vo0oPmj4eyk0OTrQEBCh0QZ9rrMheZiTYaRk0M7BxE/pgQXDwb?=
 =?us-ascii?Q?+clFRuOfHdsXrqE9Ft/ou4EruuVAxawwTPUookm+wyg+6w9Jn7dTu4Jy4DX9?=
 =?us-ascii?Q?F3d3xxgQ6BEW7RfYHdbzdltki3KTwpWWMaBUHImp5QylAyYhHNd4orqUpGme?=
 =?us-ascii?Q?Wm1HtOxk98KvuqC5h6dZKiRG7BunnUZsjomYDhzEFcBmvdGCUwp4QZ/EEOu3?=
 =?us-ascii?Q?aSaaUhp7VoXf0jzdDHmNv5VAK5mCfJeBrk0P7a7It5xlgBVfJcJwO9/prJpT?=
 =?us-ascii?Q?3J4nL5gHt9mWB/+tQNd6bAxtPLISHNSZTqkHjL993/oVRHbl6XK09OmPXsnw?=
 =?us-ascii?Q?djiqIT8Vo6kZMTPYQ4B38F8xtAuqqGYPjZulUqV1P5+uzF4oMhy8hefNAQHF?=
 =?us-ascii?Q?DG6GIZQQ83u4tJVix9opQL/nWu2HThvgLeHTGUolnFaH0Okep6sM2C/gk2GR?=
 =?us-ascii?Q?R1SNipYqLoCQD2anEdYAPqISuXWcn4HSI85O+gt66yGbXCN0okk80DeFua9c?=
 =?us-ascii?Q?JeaVkORjgw5xRmOwzvavNeHDMlohQLgImnrufVol063t5aV5nGRcpJD3PBKf?=
 =?us-ascii?Q?Y2wbwsOaIKgmEob585/GvdG+SmV9HFXWC4d5nEHXDGq7vXXOnU69Yvwkmmk/?=
 =?us-ascii?Q?mmqpBnG6IgQwb74hr/aglmI=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccc3fa63-82bc-4e7e-7c1f-08dbd6c0dfb9
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 07:46:48.0165 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: agRksvvr5xBGm3YeH3WO+aUG9yN9PKA/s5XyTv2UEvuVg5LVSzGd4XFdS9XBvVi7Ipvff12DlQC05BY9OkQuPanK/JSJye5+/Hh6axbnplM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB8056
Received-SPF: pass client-ip=2a01:111:f400:fe12::72e;
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

If all the bits in a dirty bitmap cluster are ones, the cluster shouldn't
be written. Instead the corresponding L1 entry should be set to 1.

Check if all bits in a memory region are ones and set 1 to L1 entries
corresponding clusters filled with ones.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels-ext.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/block/parallels-ext.c b/block/parallels-ext.c
index a0de4f1b07..ebda6b0a01 100644
--- a/block/parallels-ext.c
+++ b/block/parallels-ext.c
@@ -354,7 +354,7 @@ static void parallels_save_bitmap(BlockDriverState *bs, BdrvDirtyBitmap *bitmap,
     offset = 0;
     while ((offset = bdrv_dirty_bitmap_next_dirty(bitmap, offset, bm_size)) >= 0) {
         uint64_t idx = offset / limit;
-        int64_t cluster_off, end, write_size;
+        int64_t cluster_off, end, write_size, first_zero;
 
         offset = QEMU_ALIGN_DOWN(offset, limit);
         end = MIN(bm_size, offset + limit);
@@ -367,6 +367,16 @@ static void parallels_save_bitmap(BlockDriverState *bs, BdrvDirtyBitmap *bitmap,
             memset(bm_buf + write_size, 0, s->cluster_size - write_size);
         }
 
+        first_zero = bdrv_dirty_bitmap_next_zero(bitmap, offset, bm_size);
+        if (first_zero < 0) {
+            goto end;
+        }
+        if (first_zero - offset >= s->cluster_size) {
+            l1_table[idx] = 1;
+            offset = end;
+            continue;
+        }
+
         cluster_off = parallels_allocate_host_clusters(bs, &alloc_size);
         if (cluster_off <= 0) {
             goto end;
-- 
2.34.1


