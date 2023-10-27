Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 571C77D904F
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 09:50:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwHZf-0000JC-9s; Fri, 27 Oct 2023 03:48:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qwHYw-0007KA-O4; Fri, 27 Oct 2023 03:47:25 -0400
Received: from mail-db5eur02on20701.outbound.protection.outlook.com
 ([2a01:111:f400:fe12::701]
 helo=EUR02-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qwHYt-0003ya-Mo; Fri, 27 Oct 2023 03:47:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N7R5g/vxBFm4NOJStShfSoCiVNME2a4J8y9fz0TazlPc//Aj9KVVB/GJpbWfWOWXbUM2fo9DiKT87j9v2av6DZUIFEV+1z+3mXQrNhOuqfvC4BjA3FZqIAyrJHrGJPdIlFAbcryyt0DrqUEVlXTYNoKKTRMHgRTd6KZ13+Ia1lmdsxR3fRo/rw0f1i5XYj+5vdZK2gMpWnFlQIjEm2AawXXOJMc945X1fRxM9NdsyNQ+zhonWj348p4KEINF3LA2OmvOYUXFjAugwp2XG04Vsr5w/HUN3OHkA2VKYUn2PNBLuaBqbCjg1MLqIjImyaNFmpG4eeoVjiroRuXmfRyX3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AwOWlMWKuKlvmeinISKFZiL3UyyI2sCGxN87M5KJLKs=;
 b=h6oh/cXkoDA74F91aLHw7wgDTo4yKNHDYoWFUmkS1v51YS0bbHH3OnAq0QdsmwJWiUfU5BLlBVQ782TDESuG6mZOQwVjfLZ1IEbOVpyicaQDvnzPflmGjyQE8ZDU+kPbJzq3w18P9lDz/tExt/C6zl9x4JKoy7HxFDDq0RbN+3GLmnw4JMhDXDqbfrFmGTqtoq9SaffqcFlFJgib9+qKfjKJs5po9kIA82hVfma1ab0Es2iWfWoLn+9Y357puBHtOvjze3AWdkVN38756eMwFj6L2Fzyy6GV6cwOYglu7sCqoeOW0kHNqSh91XRZIm6Lz1HHS4Mb83p8orppCK6yTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AwOWlMWKuKlvmeinISKFZiL3UyyI2sCGxN87M5KJLKs=;
 b=V5KrVoPkSU4Jz6oK1rVXRaflkD5aFD4lCNdRxE4iztvjmycvcO/gWCTKCdh9Sv9+KJj3H2dxE2+SoyalSUstVGbgF0CH2Mn60e2MQCXIfvsziZygBCVLgJuleqvxdM8xcw6QKwZxctJnonXsDqF5s43j5SISetE6L5xTu6prTHQtLNjMPgOxgkcy0EvNHCI9GEz/I//P3R+6mQBx9qKPFaHdU8x9G40+G8UFG6JUTXosutycDNPqg5De1JBxce3CZNEng3WNm9Fdzu3r+6hadySC1MIQlHXnM3lVk1ikGXEUxtcjPR9d0y2IlKJlhC7H6nKHtPs2fDJU9who+6DGnw==
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
 07:46:50 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v3 15/21] parallels: Reverse a conditional in
 parallels_check_leak() to reduce indents
Date: Fri, 27 Oct 2023 09:46:30 +0200
Message-Id: <20231027074636.430139-16-alexander.ivanov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 18f9b32c-5b03-44fc-02a1-08dbd6c0e03f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eb9slyuPpcwr0LGwN1lOr6CeOx8aV1esYTa0a0VgRvy2x9DOwy2FRTGtiYz1SiT7tpG1LXIv5/vmSR84FVNc5gL2sMUn5GDCSxQRu5O+/et0Y0iGLjaA4MoIfNyrAWLdV1H5ZL6tOm4z8A5/M5iRYzSezMgvvhRM9mO8qPWoZJpFIMhng1Po/M7j1EuGO5CdUHevPdCqb+mTh1YmvpNFUsIPYfw0IgwVjZvNE3/x6FwvHv5RGe6p6N69oEyX+sNeVntMYRtlDXg6PNJOn+xbwobO5+Db60ZEgMDl4IITTZjrkEaMfh6iQx1IPOXxohsJd0FBWatGEXGO4HjSdziO/NCGx8SyINwuke9OOf7N/eXMtqc44zwP6ibASMARYISJmRG36wZ1k+YWtbTVhK1KXChZDZfODpaWIMuRx97K/ezcWQShhOMF9vve3xrvxPdKcc3OOwav+RVghPBHGvzHy3pbn0hAxBTfv1YY3O9NjV5nXGvnRIi3x+UdCld86PHuAe/Vc3ueQFZ7ih3El6AQDQEk39W6mh02afwylDTfbI9I6jurml2ZDd5bYsjFI3FRAfrbifawducWgERQgidh5mEmBHELsorxYlB7Oo66WH8oac816jv9Z53p1B+3gyR8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(376002)(136003)(346002)(39840400004)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(38350700005)(6512007)(6666004)(52116002)(6486002)(6506007)(478600001)(38100700002)(86362001)(36756003)(2906002)(66556008)(2616005)(26005)(1076003)(4326008)(8936002)(316002)(66946007)(6916009)(44832011)(5660300002)(66476007)(41300700001)(8676002)(83380400001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6g/h1KOStmk3RL4zqKe3Tefe7a+A4FzYdncBVF2DaOv+i9aaNxSHNSKO9Fq7?=
 =?us-ascii?Q?7paUY3WPRH6x/KYs59qH6O7xZGgqxhIDBM8j33ZeLSEb267+mwK1upDqUj59?=
 =?us-ascii?Q?gqVyZYj0eOr6uWR7uM/9i9cX/dr2bJ+o/ZEA814qIw2/G+c/1Sr5t/buZcjJ?=
 =?us-ascii?Q?UsQfV9ymKqPGhuiATHsGBN+n8AidmvsEptm4UWaf0T1zCtNpWsh+FHhUxWV2?=
 =?us-ascii?Q?dsZY5ZEl0ZOJ1fraDIk0Eko0ult+djG5ESpalcs33LrlUFn6UzVdwJmrVUnm?=
 =?us-ascii?Q?fmr5pF0p0abzO8WTzLy8Tskl2kDBwJvQsZxpfX6itvxIoxD2jrdPNnhO1uNs?=
 =?us-ascii?Q?qZpq6ylvfCjGtDQ/xiWAirIm4bpz4V8sIkGBMlRTiqty5bM5uQaD0PvxEB7x?=
 =?us-ascii?Q?JOI/c8zvi2wdUDeaebek88+jfidO1lDutrkT3mxbeSuESN2hoKpdlnXFtYeh?=
 =?us-ascii?Q?kBsOrSlRYm4EUk2zZt8XLiDXCYj8Xr/vZYVNTJS4PKP3mWed4q7aTFTEGLmZ?=
 =?us-ascii?Q?1i1wsXD2kkMlNtiHuTq+MgkbaUBeP4dI2nSy9PagXCUVjhluRPM4SMZRItNm?=
 =?us-ascii?Q?75my6N7RmbmHb+p1oabjuHQWikF/GbnzWwu5r6UbWJFHzIIVRlBiDz41fXTC?=
 =?us-ascii?Q?2bLWA/5sJL6aM34z51EZo4B5de2spORVSABCzJnGAHN6diRufk8pQcuH4QYU?=
 =?us-ascii?Q?8iSaIWHLMnRkRKHIFRU0HJ2PCyjya/0cXu2O2jeYYDh3ymEOu7fbxP4VWMF1?=
 =?us-ascii?Q?b4vp9UcqKJdckHb+EfWb80iq+snmFew//DqLPsPXWqQAhjcAcWZqBw8h1tWh?=
 =?us-ascii?Q?rRN5wX8VxHOsbzltbY4ncZChXaJyjojxHrox7oCWWwVgxE0QYQcTvy0d9ZaG?=
 =?us-ascii?Q?K/nmI2Ss/wZH2IQoh6LjjnyEtdWXHe0+I1RpvUdGfx8T5HtHur61+L6Ff/a6?=
 =?us-ascii?Q?ulC2KEZnGlekUDvyRJqK4QoBdJCe5LlxiB5U42GtKCxZ83/IZ0XyOM6S2oXV?=
 =?us-ascii?Q?cpBmHBw1JtpRJ53+bpUKz0EmszfBvZZh4IQnfj+lNeKw1HfCGZjnR9zSkeFH?=
 =?us-ascii?Q?1hc3MCYynxaKfILB+i+odTbZpjZqOGC4hdDkZc3jj0RqBAF10Z8BGH4Je5Sf?=
 =?us-ascii?Q?eN4qYDnvI9sIrwHgdjOS4kVEP0F645ktII4uIoiOIYiHGZOJ4P+HWwZIY5Rt?=
 =?us-ascii?Q?zwbVYgyGHScBwJFm9e7nB3VJShsEE5tbYW810lfAjOGlf8X0kDqTmgiLcDzt?=
 =?us-ascii?Q?y3wgeJBYWpw5TJQZIb6lcDgeyWjRHYmGXSixziS/bcTc0GU/tox+fvSBVPN2?=
 =?us-ascii?Q?URG2LKireAfNk9WpJu0pa08jT4+F/Zo5vBqDWQKtKhRoFWfPzIzv1INpM5ZK?=
 =?us-ascii?Q?D+waxcYmbk2Oy+sDPnjEmf+lwMBJuCJF7kylhk5Bm3C53AKEzYoZYZEjAvhN?=
 =?us-ascii?Q?mOwUIJ5/6BCyzHYdw3N0B0RB1Mb4IexH0EUCTIMrZHyF+btIJ0L/kHdC8mfs?=
 =?us-ascii?Q?t36Jd6yr+pcUKKv5u+EADaXf+H0j52Ua7mlr8HvNbxHANhx1e6cPiySC+ZyM?=
 =?us-ascii?Q?2Q4NphP8vHHEGKgDt+UzlhIa2/C94U9GOzyG4OEzPwKbQ+UW06xs/FPCHZlb?=
 =?us-ascii?Q?JT0pWkA74NEVNA9sckqWnXY=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18f9b32c-5b03-44fc-02a1-08dbd6c0e03f
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 07:46:48.8561 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HOI0kNyjdp9aL/qRC7fPQ2PMKBOj8/olqQPNRb+tmlFWzc68bb0BgZZBbrL37JnQ+k/q6DKmGdQI8wirN8drQoU0NtRNYNMCcMfXK/ELp64=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB8056
Received-SPF: pass client-ip=2a01:111:f400:fe12::701;
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

Let the function return a success code if a file size is not bigger than
image_end_offset. Thus we can decrease indents in the next code block.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 72 +++++++++++++++++++++++------------------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index 0a2956b45f..354fa0f2cc 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -775,7 +775,7 @@ parallels_check_leak(BlockDriverState *bs, BdrvCheckResult *res,
                      BdrvCheckMode fix, bool explicit)
 {
     BDRVParallelsState *s = bs->opaque;
-    int64_t size;
+    int64_t size, count;
     int ret;
 
     size = bdrv_co_getlength(bs->file->bs);
@@ -783,43 +783,43 @@ parallels_check_leak(BlockDriverState *bs, BdrvCheckResult *res,
         res->check_errors++;
         return size;
     }
+    if (size <= res->image_end_offset) {
+        return 0;
+    }
+
+    count = DIV_ROUND_UP(size - res->image_end_offset, s->cluster_size);
+    if (explicit) {
+        fprintf(stderr,
+                "%s space leaked at the end of the image %" PRId64 "\n",
+                fix & BDRV_FIX_LEAKS ? "Repairing" : "ERROR",
+                size - res->image_end_offset);
+        res->leaks += count;
+    }
+    if (fix & BDRV_FIX_LEAKS) {
+        Error *local_err = NULL;
+
+        /*
+         * In order to really repair the image, we must shrink it.
+         * That means we have to pass exact=true.
+         */
+        ret = bdrv_co_truncate(bs->file, res->image_end_offset, true,
+                               PREALLOC_MODE_OFF, 0, &local_err);
+        if (ret < 0) {
+            error_report_err(local_err);
+            res->check_errors++;
+            return ret;
+        }
+        s->data_end = res->image_end_offset >> BDRV_SECTOR_BITS;
+
+        parallels_free_used_bitmap(bs);
+        ret = parallels_fill_used_bitmap(bs);
+        if (ret == -ENOMEM) {
+            res->check_errors++;
+            return ret;
+        }
 
-    if (size > res->image_end_offset) {
-        int64_t count;
-        count = DIV_ROUND_UP(size - res->image_end_offset, s->cluster_size);
         if (explicit) {
-            fprintf(stderr,
-                    "%s space leaked at the end of the image %" PRId64 "\n",
-                    fix & BDRV_FIX_LEAKS ? "Repairing" : "ERROR",
-                    size - res->image_end_offset);
-            res->leaks += count;
-        }
-        if (fix & BDRV_FIX_LEAKS) {
-            Error *local_err = NULL;
-
-            /*
-             * In order to really repair the image, we must shrink it.
-             * That means we have to pass exact=true.
-             */
-            ret = bdrv_co_truncate(bs->file, res->image_end_offset, true,
-                                   PREALLOC_MODE_OFF, 0, &local_err);
-            if (ret < 0) {
-                error_report_err(local_err);
-                res->check_errors++;
-                return ret;
-            }
-            s->data_end = res->image_end_offset >> BDRV_SECTOR_BITS;
-
-            parallels_free_used_bitmap(bs);
-            ret = parallels_fill_used_bitmap(bs);
-            if (ret == -ENOMEM) {
-                res->check_errors++;
-                return ret;
-            }
-
-            if (explicit) {
-                res->leaks_fixed += count;
-            }
+            res->leaks_fixed += count;
         }
     }
 
-- 
2.34.1


