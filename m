Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E35E47D9058
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 09:51:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwHZd-0000Bb-DX; Fri, 27 Oct 2023 03:48:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qwHZE-0007Xk-1o; Fri, 27 Oct 2023 03:47:42 -0400
Received: from mail-db5eur02on20701.outbound.protection.outlook.com
 ([2a01:111:f400:fe12::701]
 helo=EUR02-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qwHYx-0003ya-Mf; Fri, 27 Oct 2023 03:47:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e04vBamurhDydwEas17OtqjalkfMkIRVvathH0XOA+2Z/WZqsep+9k/ZCkAgUEdDDjlvNYhu5giuHl8qPPDmsvah+dOkH7X7unRetaggoTkRYBzHU0hVkPf3GXHaw3yjmygVhcvtvo8QwbAijwA6TPIc5vQTtPEhkikcMVhb31G2jtGfkrvYPfPrxyve44gES5tN2X1WJ0hHTDRReJgCthSkyq5g8gPkz/7kqJYDFHA9eXvObYwi+daOS9zeHNvCRl9ISFXHcURPsqB+2b/XgRttQGnpd6Fr8gEtxYASLVY6EW/VxLVqd6Hj1qakq8gWMz4pkf2I7HrgmJ+HrDoMew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gC/UjxZVDVJFYLyiM5idcqbNmNxCyC8qvhUYQzFfNJs=;
 b=Qvtdhh/SNprgoVD7MsfhIF6d3PvjsoMxN14ZNl1WFegIOH8Tepphxfu4XjWiZio62l1M6XO2+YM9mUuBcBB4UxZnSsUQOq5KBWAxGlyIyr7OVtg0tbLvo7NNstcpK2CrQKm/kt2ogAqozZsOEuYAs8wZc4Nk1UVLR0KVrIplGXDvK33yAOMAfYWqJGy7A93wCK35kHeJQ0o8qOWMZFkKnOECtgVxVeWe/4uS0HA7PnGP774R9KunX3tAjLItqXb//8hSpdSo7gdlr6w4iGmr6S5b9w1QWWcqVK0IhMwQDcmZLMzUZNwp0gItjQlfYSfownijVDrPEXb0xepfOjblcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gC/UjxZVDVJFYLyiM5idcqbNmNxCyC8qvhUYQzFfNJs=;
 b=K8xHNIA16U/YZ1c0DaXSrXzIRP8XYIfDDHmsg79jWgUrjjbOzOWRtvtAoLcUvbLa2ZGZ4ldSWM1ehE9FNGinatNEFag5lB7v7fWOSRLNvZ4oY/adNdSa4VYLlV1QdjfVmipbg5DXyLVUWXROLx9ZQyaeCdfcixN+KoV/shu/I0Juw6JnQuM6V10Tqyk/Tfi+Y+Zt8cqFt5GTravIFoFksJeTJTUyeV2hO6UJp6F72jBp3yCF7NU6Y+z9TDFnO/WkZj21kdFxmmjbFRDu7nppkLAyT/NwuvKkulBXL/lZpJcm7j0DePxvNZpVB38ChzhDI0+AwBcKEYYf7Xl18uIxJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by DB4PR08MB8056.eurprd08.prod.outlook.com
 (2603:10a6:10:387::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Fri, 27 Oct
 2023 07:46:52 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::22f7:6498:de53:5371]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::22f7:6498:de53:5371%4]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 07:46:52 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v3 18/21] parallels: Remove unnecessary data_end field
Date: Fri, 27 Oct 2023 09:46:33 +0200
Message-Id: <20231027074636.430139-19-alexander.ivanov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6726f18e-7d6b-4d56-9c5e-08dbd6c0e0d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7RGrqW6C5otXqcfujMJ2pdBQnufoHyKAdeeEyCX823q6niYEFMsqzqtDvV8YgZVz19I8hUPPV1wKveB6tNGijJ2QL/M67a+WbmIc8hLSyNc8INto8WSNH8f19dHEoizgswAkq3HZScnnxwbempyWEP4KtTsFbFSUTx94/Wqzqubt5YYJYMv54vqXRUtibrG4m3fGfM7fTIaO0qG9966dNxh6tH+EawRhdt5kWvlj+4M4S4tOvLTjW3KaUn8ZYTioOByT5a2Hj26x22gahMv/HIBLTeaonEYk6swlKoonKLunR4UXY2wJSsE4KXoiMKjF8EyRNDaSD764+KWmo2hZBXvey3ftFtoHvYstFdwP9kG1UA5OGSdWU3FMRpnG1xceckJ/gNHB08IwZ0e1IWRFwUAIcu2UiPBKY5UrS6msbVOSlAwCDmLK0ASSmASNM4FGJTm0Sluy7bnkyBPSBtdMFhNoXp+mVwE4CV7ranOQufr1cBiwE0WJDenOLYsml+b4emh5iMn98oW1KGYqz/92wNlOFTn6d5PFNNCvRiq5YTs954li2EYoazBwkVgSodzUSq4alR4Nnz+TP5WTt4HLQjnjW+Tjt0Xz0NmIYjtF8cXMqd71WuOAKY0cN+3KFCMb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(376002)(136003)(346002)(39840400004)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(38350700005)(6512007)(6666004)(52116002)(6486002)(6506007)(478600001)(38100700002)(86362001)(36756003)(2906002)(66556008)(2616005)(26005)(1076003)(4326008)(8936002)(316002)(66946007)(6916009)(44832011)(5660300002)(66476007)(41300700001)(8676002)(83380400001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KNNo+U3yfFqC8RS5qWC3nF2vUJms/dyPxPfyz0OVJhPZPZOrld7oXXUuE6J1?=
 =?us-ascii?Q?JKj17b8EUVKosNymvef0hv1rzTP4rZVYGdzk9nevbL1Y7iDVGt176NHUyef/?=
 =?us-ascii?Q?W/8evgZ13yJlfPwjX8y/dEGXSVQTYfMAYkLZJ8QqRBGJ8QYla+/9UCn2in56?=
 =?us-ascii?Q?Ywd/IP1NflsLa8UjfE4BN54rjFybF9CDKxWyu22Py3nvaQNQbe6R3KErc51P?=
 =?us-ascii?Q?gUmz0OVhffkO+BRIBv9UafDAVZNFiqbAD22sfDryG0zNTu7l0AWlMVBMU9Yw?=
 =?us-ascii?Q?ivKMHpB1i3HUIgtZVZrLrlD0wCtcQ5UFvtmpyyaInDiij2uoxKMBm9rC1u6v?=
 =?us-ascii?Q?Pnq5I3ly/t6U+ShcUIpEsadnAAmpYv74cJ1CYnA5Mecm1dD/5hLvP1mRhVCb?=
 =?us-ascii?Q?WXnJQMv0i52RJcUBzLOGa+KG1y7DDMePKvzZ1OwpXhCbFpRhJ9ozHuLvvIkI?=
 =?us-ascii?Q?P4BMlUJ4S/h2B9iRtooGsfBqZ/ftcI53/9qKKQdCeURjArQYcP+0rabFoi9M?=
 =?us-ascii?Q?n1IiVjyRePgmRJNTOsvWAf1SMt6EvmoJudOvAYhLoZ74qF2TRIr0deND9Rcu?=
 =?us-ascii?Q?mkOGWQJxIbHoURHFwkGCUHaqm5m+3QgfRcIHXJ6bhhd1Zj0WRWmOLVjUg9Kn?=
 =?us-ascii?Q?A8IWJgAWBSnSvNhvdFSxeTavisazu89tYAy3WsXHwDk7+Iom47hv1OzZX2Ro?=
 =?us-ascii?Q?VfpNghhtfuLClyUuWPSYuoIWuaTuxVV9pVNpodqbXl+/OoKgfz17CZUx/Npj?=
 =?us-ascii?Q?JWCBODOuCgof5MVFQdWo8rmPZHWfp8RBFeBYTqbJUjo+xovAx971wcfkV83Y?=
 =?us-ascii?Q?/MzQQQheUKedDo9AfAMW7rIZF0LXn2P2Gfg9qjn6icU0CpxTVjvEfpBJoxv0?=
 =?us-ascii?Q?DhVmrsY85kZ4Nz4bLvN8GTL0ibTeChPS9p4wy0Lb5qdD3/oVm9QHFPFsHg1W?=
 =?us-ascii?Q?7GhqRr67Zk91KLl2XUAvlxD4eSi1gbnTFFa97isaDL9TZS3dfIA5oJBloO3I?=
 =?us-ascii?Q?zHSqaYLj4Nvg+xZJ1eO52syaABB1hw4jphe65qszUFLyGvDX8616BDzw71ei?=
 =?us-ascii?Q?mrxDHWDfzzwF+hx+68nxA0Nu/p2kZB5c0XFpOWy+a0FjwOKI7n3/HKUYMdGF?=
 =?us-ascii?Q?ypOhw7bqmG0zxUhNU8GqAMzO5hl9aqbyHk57YC/IySVPykjG87tIGsOvyglM?=
 =?us-ascii?Q?Q6+sWh1+yS153qNrLMSU9ikncgoTNjkwyQQmTDq1M7cWTLV6hdTSGbhNrtC1?=
 =?us-ascii?Q?OGkz0M6P6sl11uRs8bedsmEJPSm2rj0sw0eWbOM85uwEY5AZ+79xnZJoY9wN?=
 =?us-ascii?Q?DumrzOgVBVPJFfeenGVBlAkf7XfORc7jrk59KCvjMPOfVELzu+b2FAZtFmVh?=
 =?us-ascii?Q?AOA27mDbLgjyDvP0grS4YbbKJ9ApvSlvUEpUlvd+DwBqZPI4f7bqXdLNlQWy?=
 =?us-ascii?Q?djdjD9I//g/kwso9NI8kvAmAXtWdmuY3E+80DazJXER3qsLrb03Pe/7EMdz+?=
 =?us-ascii?Q?XBjvy2awkJZ/6o+6INPRNBSJUu/pIu6gy87MrYIfnxoi91xuJW2nC8r1//zV?=
 =?us-ascii?Q?SUqvs7U4IujDgIiws9BuYhuMVORSZ0ss7bMwTvnCKnNeW1Mv7bxOHRcrlTqG?=
 =?us-ascii?Q?E1BUTcq92Eb+6pQMEyDK2/M=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6726f18e-7d6b-4d56-9c5e-08dbd6c0e0d7
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 07:46:49.8472 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SO4py1eUunO7srLHRF6gjatqczmL+WwCPwRDvTS2ji317SU520UoayP/C0oXcJN8iY5a0YhS9Y5Moh558cPXWmllf3t0z6kaHZ2LjQAYxS4=
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

Since we have used bitmap, field data_end in BDRVParallelsState is
redundant and can be removed.

Add parallels_data_end() helper and remove data_end handling.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 33 +++++++++++++--------------------
 block/parallels.h |  1 -
 2 files changed, 13 insertions(+), 21 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index d497cdbe41..98967dff90 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -266,6 +266,13 @@ static void parallels_free_used_bitmap(BlockDriverState *bs)
     s->used_bmap = NULL;
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
@@ -277,7 +284,7 @@ int64_t parallels_allocate_host_clusters(BlockDriverState *bs,
 
     first_free = find_first_zero_bit(s->used_bmap, s->used_bmap_size);
     if (first_free == s->used_bmap_size) {
-        host_off = s->data_end * BDRV_SECTOR_SIZE;
+        host_off = parallels_data_end(s);
         prealloc_clusters = *clusters + s->prealloc_size / s->tracks;
         bytes = *clusters * s->cluster_size;
         prealloc_bytes = prealloc_clusters * s->cluster_size;
@@ -300,9 +307,6 @@ int64_t parallels_allocate_host_clusters(BlockDriverState *bs,
         s->used_bmap = bitmap_zero_extend(s->used_bmap, s->used_bmap_size,
                                           new_usedsize);
         s->used_bmap_size = new_usedsize;
-        if (host_off + bytes > s->data_end * BDRV_SECTOR_SIZE) {
-            s->data_end = (host_off + bytes) / BDRV_SECTOR_SIZE;
-        }
     } else {
         next_used = find_next_bit(s->used_bmap, s->used_bmap_size, first_free);
 
@@ -318,8 +322,7 @@ int64_t parallels_allocate_host_clusters(BlockDriverState *bs,
          * branch. In the other case we are likely re-using hole. Preallocate
          * the space if required by the prealloc_mode.
          */
-        if (s->prealloc_mode == PRL_PREALLOC_MODE_FALLOCATE &&
-                host_off < s->data_end * BDRV_SECTOR_SIZE) {
+        if (s->prealloc_mode == PRL_PREALLOC_MODE_FALLOCATE) {
             ret = bdrv_pwrite_zeroes(bs->file, host_off, bytes, 0);
             if (ret < 0) {
                 return ret;
@@ -760,13 +763,7 @@ parallels_check_outside_image(BlockDriverState *bs, BdrvCheckResult *res,
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
 
@@ -805,8 +802,6 @@ static int64_t parallels_check_unused_clusters(BlockDriverState *bs,
         return ret;
     }
 
-    s->data_end = end_off / BDRV_SECTOR_SIZE;
-
     parallels_free_used_bitmap(bs);
     ret = parallels_fill_used_bitmap(bs);
     if (ret < 0) {
@@ -1394,8 +1389,7 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
     }
 
     s->data_start = data_start;
-    s->data_end = s->data_start;
-    if (s->data_end < (s->header_size >> BDRV_SECTOR_BITS)) {
+    if (s->data_start < (s->header_size >> BDRV_SECTOR_BITS)) {
         /*
          * There is not enough unused space to fit to block align between BAT
          * and actual data. We can't avoid read-modify-write...
@@ -1438,11 +1432,10 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
 
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


