Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA62F81F6B9
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 11:14:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rInNt-0005KJ-JY; Thu, 28 Dec 2023 05:13:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rInNr-0005Jd-EZ; Thu, 28 Dec 2023 05:12:59 -0500
Received: from mail-vi1eur04on0727.outbound.protection.outlook.com
 ([2a01:111:f400:fe0e::727]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rInNp-0000fc-GJ; Thu, 28 Dec 2023 05:12:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W0acb+KpnoV9gnUx5uqRak4yDvtPujCzPj3yLtYSojrne7J11jhpLSVzV1ie5TcBGDFMW5qjztzpT39TqUdp0Rze8ylLd36lZAuwZDzFFm0EMy85c76DUSM0f+D3ovh1hhul74vURdIqpvLlsjoDKKTBUAcvt6Hk7skrGN7FjxOUunAArLHD6zcqgTH4FAY4C7TQ8JUdUlhpTGcDapozaINBzh647X7X+Ha7HEdBTQS4Yss+0WfkB0L7hK5NOt8G6IyzaH4ZrJvvhxHjhyrReQwJ1fk8BLPtug+Dq7MWpV7VmUV4XXvhrGjWodYVLVIWSuXOkDG9dpBgvyVDYc5/3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XaAGGTbyMKywUXOYFWi8PjBTqSV5La+m5rxkBDvvPoo=;
 b=M/zvHu/ZXww0JAsuc6si6UHijhjH5+vTlwLPR4LGmqu4qfMIv58yv+ZPR9LNJWwuwIx0PxYyjOsSNsxkw+1oiLXORmt3UaFPnzdk5hgl3bgEVC0EAgWAq99JuZd3SPNfxE1d5xShFJpo5ppzw7JGpA2BpJVjhhx2MQQKbZQvaUx6tv7OrgdUEdpeSHkQb96svxxhtRNpgZyN/86TyL6OAX8YvtsXBu+q62rLnKhpK2Rg4WgLwuC3hAobNvtL0piElbgYixdebrpkkkLuz9B+SwQ04/AnI5X4K6yH626UJs3SzDPJt3thuaQKIuyCkInBtw3xDP8KBnUQsqGXxParUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XaAGGTbyMKywUXOYFWi8PjBTqSV5La+m5rxkBDvvPoo=;
 b=qq9E5MczSNhK1PPeX588Y4WnKgWObmSXLrdnEj9fLcIpli5LcuSrs4o5PM9e3g3E+x4dBtDQEh/5QgcS7hFCMExoImsBqqw1+7xczFhs6CuQyCUAZI/7zYYakFpA3FwvlE6RNDSNIe7dUcjGs+GtMndCcxgZUNFZHPDT6qAfZLPWUqODa7Ioykli8i5RTPmSySr+xGiNPTw9O53lyRL+YaBMPr67ft1uHALHfB6c1PEe0/FKV3eFfd/38BAKIGj49xOt/Kr8Guyz/+OcBQ0vvcE91lViMo/EOXhhwQWVtouD9z8ePkRtL3gOmnkvnhdouxMXK/S7thDXdOfqsriifQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by AS8PR08MB6134.eurprd08.prod.outlook.com
 (2603:10a6:20b:291::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20; Thu, 28 Dec
 2023 10:12:50 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0%5]) with mapi id 15.20.7135.019; Thu, 28 Dec 2023
 10:12:50 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v4 18/21] parallels: Remove unnecessary data_end field
Date: Thu, 28 Dec 2023 11:12:29 +0100
Message-Id: <20231228101232.372142-19-alexander.ivanov@virtuozzo.com>
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
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|AS8PR08MB6134:EE_
X-MS-Office365-Filtering-Correlation-Id: 79e07fce-bfe4-453c-31fc-08dc078d8c40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vD9zsaFuyiCphJz4bcnMv2Z4m7SEss+A05fNq8Wj7IBTcObYozi7U2uq5YQg1eHoDMXqGCCjy56c1ffsX78WhHycvTP6rz8l6LloS29juKmhgizu+RWIKKa7V/QCO6sp4sTAofDPiRIWuwl9DlYwPFzTHruNF8v8mW9Jv/S6FR4sggkWb9R2bVFq0GXWDHOc6Boyuh775Pj3Ar4VfIIPHj81wtKFxg6ATdPu2RArMZJY5jOaoEhp8AYqDWwaRanGZcYqwPUSx+yal39dToa0HfnjakzZP9Lq8u7XB2HEA0ea2jVVGIdNMGYa1mhjnlZal4c2sM2SCtAl0ag664tFhmIlyJ2VJ6bLdxJaYsRrg3x2pLDLCOrVHNwpYT22sTblsL7N1MIxDxQG7m2azMQ76mLF1EE61PS3gUcX63YpVX5PFs7io6xNHLsi/NrE6mip97GTwzFtoRmpN+sfW8M7MipgSVs5IU4KDsALL119sOuu3/jMUkG8eCVRu/taY4GLPTBchiMFxXW2Qt92NL0a1LLVgn3tznBlVp9hnz+9TELLBjuiTcLHQbY/0kz5MAzyy0j/mCltQHfR2L2Uu08N2iGZ3dJtv+IZ/KxVYzNLeqr08RhbWYDl6kEPK1OyOt6s
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39850400004)(346002)(136003)(366004)(376002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(83380400001)(41300700001)(2616005)(26005)(1076003)(38100700002)(8936002)(8676002)(316002)(4326008)(5660300002)(2906002)(44832011)(478600001)(6666004)(6506007)(6512007)(52116002)(6916009)(66476007)(66946007)(6486002)(66556008)(38350700005)(86362001)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jxfBx3rhiPU2anjK8Wc1rnq4K8bnOu5BISv1voYQn9b9ZOmoXuv839BE0fNS?=
 =?us-ascii?Q?0lYtfU7JBjVlnAipbNyeRDsWKHTOFnW+E1MV/ODNWAiqr86DszBw2esVa97/?=
 =?us-ascii?Q?NfuxweZT/a6SSqZvdSJ1tkx0k1hw4J68Z97nsbWbmwoBtIGOmwoF3AazH88I?=
 =?us-ascii?Q?syoZI4R1xm7iSRPpZTJb5LOR33ap+xuuyezw0WSDLPXmqWlme4USY3eO6oJo?=
 =?us-ascii?Q?RqTbZ1bSnhz7t2mPBC48TTF61Svn1vBG7WSELG9Vir8qQd2GpZZf0UfTIGx1?=
 =?us-ascii?Q?BIyCTSL8bNlmzTXBtA0wYw936Oo5iCno5oluseNlDqfYMofIWXHN8cnoouIN?=
 =?us-ascii?Q?J6L5CSX9wht4PqnnfeIi9XWWVJyEqdhlC2yJoAERiC5mISMbn8jNd5UXqSN+?=
 =?us-ascii?Q?OgoeeCKqcXF160WTfFVm8FcqbGADlVrL7R9XDFKkKog4v+luktTj+tA+nxzH?=
 =?us-ascii?Q?fF0umPqd9rGAlszsLAaH1aISgNJDbxSY40cH6dxkaAhQyntid5iUk8uTHLlA?=
 =?us-ascii?Q?lcfYJJ35B9YsiLLqiT9hSn1X84WcSQz8JUomM4BLduqaNgkBR7k6m6vcn0bm?=
 =?us-ascii?Q?LHK/9eGN4rCJqvUV/RoEUMs0S0ufPqY2INysuW4LwNooaw5/cDawk66TKc9g?=
 =?us-ascii?Q?JlXx+g7gNyPMnLBmtmU8iZbr1cQK8t0oolfX8zJVuJi8yb3tNXZzY/f8cxUY?=
 =?us-ascii?Q?VAyRM6t/bxO5yhfLECVvpE73Q74qza+bQqAvwmOKmw1+n8R6YyGZWFDH3sKj?=
 =?us-ascii?Q?XJlvPyekYBUnazmYRVqUdwnEa6cUEDNK/FmlY5cEDT0EgTH0uUfoPOV5Aw1R?=
 =?us-ascii?Q?q0PKcj8ghOA9U7pMv3zjecfL+ws04C8dJnXMy6HJQnzpDnxdjvoQyyPspRLP?=
 =?us-ascii?Q?3xEGy/6xIwCE9TfqXWxqZS6SxZwHGhNbcnPZQhWC65HE28hk0OgINJuqwFCZ?=
 =?us-ascii?Q?1E6G86Ry0JjPWhu8NTEegiMqnr2ZjFbGmDvzsqi+NLVF/VVu8sb8oWc3+RiC?=
 =?us-ascii?Q?PHFtw7L+pzGkNOgEruaIhAHRq8tNi2RJg/lj+ziP+SyiS9sVUamgjYgeRAxw?=
 =?us-ascii?Q?NheQGXqPRgpjVhSQjvBlsirKBQyqEGGbqRiOtiKz/YtHpTAcfy0u2r//yhLH?=
 =?us-ascii?Q?2HbRKSqJe6TAXtWnueGoiwI35JPHsCMgY/7fW5LIOHvKwG/FO4xjgvp8mrIb?=
 =?us-ascii?Q?JoOltJqukV71/NRwztF2jStUJszf/t9B78YbCUwVED5GS6lk8E4T7WfDB+dt?=
 =?us-ascii?Q?8XP9wnzLy3f/DyXfJtBiY7vM5pE5jbKKImZdpgd13Ay5wUJ62xpZFjaTo1SU?=
 =?us-ascii?Q?2Z43onh/6kYlQyq0ofclm/qyvHlr1KjEGWKiz9pJMFZ/vGQxwJWQfY/B9IXw?=
 =?us-ascii?Q?H+W8ib5fUP3QJzIGcNPO+QzedHn7Z80wx9aM9dkc+oufCOMm33Qz6js6q71R?=
 =?us-ascii?Q?S1T13wi01nbS75NU3ts+B6nh+gBOWrfYOuePj/Zgbeetb78YGh04J3Lh+62S?=
 =?us-ascii?Q?DbvbTnuuSVnJEuBEPxnDGPnUW002t1GT7bRo2LwshHUXPh9Km+39pF4ibonP?=
 =?us-ascii?Q?dO/dxWl4Zhnj9nt+VBUkfK5XWy5nLZERgltJKoV//a1+PkkyXdfQpzHq0bBy?=
 =?us-ascii?Q?tqpQw15ZuuBgXesJmMuVHNo=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79e07fce-bfe4-453c-31fc-08dc078d8c40
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 10:12:50.5702 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pP1Y4ITRLybCpTCTMhg2qUgyj3PPscUFtcbP6C/3QE0H8HN52o6bv1HKEVnHLUpEAedeII6/qRPFFaTJHQTrRXjenGRemn0MOLIhKfMShKE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6134
Received-SPF: pass client-ip=2a01:111:f400:fe0e::727;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
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

Since we have used bitmap, field data_end in BDRVParallelsState is
redundant and can be removed.

Add parallels_data_end() helper and remove data_end handling.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 33 +++++++++++++--------------------
 block/parallels.h |  1 -
 2 files changed, 13 insertions(+), 21 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index 5ed58826bb..2803119699 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -268,6 +268,13 @@ static void parallels_free_used_bitmap(BlockDriverState *bs)
     s->used_bmap = NULL;
 }
 
+static int64_t parallels_data_end(BDRVParallelsState *s)
+{
+    int64_t data_end = s->data_start * BDRV_SECTOR_SIZE;
+    data_end += s->used_bmap_size * s->cluster_size;
+    return data_end;
+}
+
 int64_t GRAPH_RDLOCK parallels_allocate_host_clusters(BlockDriverState *bs,
                                                       int64_t *clusters)
 {
@@ -279,7 +286,7 @@ int64_t GRAPH_RDLOCK parallels_allocate_host_clusters(BlockDriverState *bs,
 
     first_free = find_first_zero_bit(s->used_bmap, s->used_bmap_size);
     if (first_free == s->used_bmap_size) {
-        host_off = s->data_end * BDRV_SECTOR_SIZE;
+        host_off = parallels_data_end(s);
         prealloc_clusters = *clusters + s->prealloc_size / s->tracks;
         bytes = *clusters * s->cluster_size;
         prealloc_bytes = prealloc_clusters * s->cluster_size;
@@ -302,9 +309,6 @@ int64_t GRAPH_RDLOCK parallels_allocate_host_clusters(BlockDriverState *bs,
         s->used_bmap = bitmap_zero_extend(s->used_bmap, s->used_bmap_size,
                                           new_usedsize);
         s->used_bmap_size = new_usedsize;
-        if (host_off + bytes > s->data_end * BDRV_SECTOR_SIZE) {
-            s->data_end = (host_off + bytes) / BDRV_SECTOR_SIZE;
-        }
     } else {
         next_used = find_next_bit(s->used_bmap, s->used_bmap_size, first_free);
 
@@ -320,8 +324,7 @@ int64_t GRAPH_RDLOCK parallels_allocate_host_clusters(BlockDriverState *bs,
          * branch. In the other case we are likely re-using hole. Preallocate
          * the space if required by the prealloc_mode.
          */
-        if (s->prealloc_mode == PRL_PREALLOC_MODE_FALLOCATE &&
-                host_off < s->data_end * BDRV_SECTOR_SIZE) {
+        if (s->prealloc_mode == PRL_PREALLOC_MODE_FALLOCATE) {
             ret = bdrv_pwrite_zeroes(bs->file, host_off, bytes, 0);
             if (ret < 0) {
                 return ret;
@@ -758,13 +761,7 @@ parallels_check_outside_image(BlockDriverState *bs, BdrvCheckResult *res,
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
 
@@ -803,8 +800,6 @@ parallels_check_unused_clusters(BlockDriverState *bs, bool truncate)
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
@@ -1436,11 +1430,10 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
 
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
index 9db4f5c908..b494d93139 100644
--- a/block/parallels.h
+++ b/block/parallels.h
@@ -79,7 +79,6 @@ typedef struct BDRVParallelsState {
     unsigned int bat_size;
 
     int64_t  data_start;
-    int64_t  data_end;
     uint64_t prealloc_size;
     ParallelsPreallocMode prealloc_mode;
 
-- 
2.40.1


