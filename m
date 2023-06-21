Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD86737D3E
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 10:22:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBt4v-0000M5-Av; Wed, 21 Jun 2023 04:20:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qBt4r-0000J1-Nk; Wed, 21 Jun 2023 04:20:33 -0400
Received: from mail-he1eur04on0711.outbound.protection.outlook.com
 ([2a01:111:f400:fe0d::711]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qBt4q-0007BN-2c; Wed, 21 Jun 2023 04:20:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iE+54W+A39hqKJBu5wh0/kN4U8MjPpRRvNBPVy/OdAWbZ1CiFTcoT1hY9PjipMjTvEsutJd/jkK9lxu5796I5RU0WmuRJXTOJn+/O09w/tv1/ve1dRrjB+IMEsOYtE2fwUWXnMRb2UVPMJNRYE8Wug+DkU9ldmvh4WYsWXEPD6OLxEeriCADRtN39+s9Dw/wC35Vqw2bFq82ccRnrp52KaRp2kSkjh9zJIppmr4atB+KAXmAuOEb+Cn1Ip/vRPwe9YwpOY1Y7Njx6hXOF+qphQIpTJLq1N6u4Jl1lsO649h1GsEMxAfA4ZQcYHksJeXWRWwOsYhw13Ulu5XlkdFDtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gYZKZAV/xlQ1JqMbD4fY+xFVRPy+Rra/0ZkNgpnOXi8=;
 b=mxXWty7H7q+Z9iavJ7q4IGgNNlEfDL+M1bnxclWOqVhl19kRI/9vpaGFkKADHqUVVOqFpt2wXncybz2+Ykt2JlQNbnAMwwqOmPkzWe1pUTOa2rMcFmobnqwivbbiO0qdtl/RpcYGHtWVXLsM35cajSvo1+c2qRLjSHqrBk/LOP+kF8LAYGBnb3x4Uqq2InDlKAX8ZD2dqcpcHS64s6DEqSdZi63xXvRC2h+PjjpE/ccBsKe3lf/zcE78ItwSFY2XaJURr4c8AITMGzs1Nxzu1sAregZrsxWn8EcbvzoOQc3a1K0WPoxsikGnKIQeSxhidQoFRcb8L5OLDH7HLs6/oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gYZKZAV/xlQ1JqMbD4fY+xFVRPy+Rra/0ZkNgpnOXi8=;
 b=lkWnWzpmNEpPwEP1TzgQ4FUD4KcSmi8bTvXMMhg0Av+fUKhbrICpysIBV/ay4VGh7UglU+O70qQYN2/xhVPPcGa5hdbncjscHi1jQgYXI8JUsbHT1ychpPLs1MyobQGN3WGysEsuQZRGVNUafdINhuRCOkSP/g93HXnEzuf8V5wjrAXplJr8juO1jWk2p4tH1kCgwJdo/MDIHRCdpj0azsi3tfwa1g0CjYyBhU9xNsP/VoY1lwZ+xRwmSSMUUQHjba7sAMhKqlXDzhByRd+M4MucrwGv+xMkkqXsTEtPkZgsCnF8pbrKpH3KxsA45LKYeQRY0jM5iiHlRW6BH6QPbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com (2603:10a6:20b:402::11)
 by DU0PR08MB8422.eurprd08.prod.outlook.com (2603:10a6:10:406::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Wed, 21 Jun
 2023 08:20:21 +0000
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::ea9f:354c:ea46:3243]) by AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::ea9f:354c:ea46:3243%7]) with mapi id 15.20.6500.036; Wed, 21 Jun 2023
 08:20:21 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v6 5/5] parallels: Image repairing in parallels_open()
Date: Wed, 21 Jun 2023 10:20:10 +0200
Message-Id: <20230621082010.139195-6-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230621082010.139195-1-alexander.ivanov@virtuozzo.com>
References: <20230621082010.139195-1-alexander.ivanov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR08CA0165.eurprd08.prod.outlook.com
 (2603:10a6:800:d1::19) To AS8PR08MB7095.eurprd08.prod.outlook.com
 (2603:10a6:20b:402::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR08MB7095:EE_|DU0PR08MB8422:EE_
X-MS-Office365-Filtering-Correlation-Id: 75bba585-d4fe-4fe7-5f7a-08db72305ae1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EWcCri6GGuAq0ZzX0OcuqJaUxVSvwE2UfznLdqlMsZSeErKhgOOCRkOwreW1i47F274bYMWB3VCHm6V48TW6FQg+9YXAIw5Ud52wwlm5hcv5NveUUsFY5vAmHt4TUvdGsl8qCtnk6q0r2rQ7858UUhFBjDrg56vCKMLzKST3l9FTej/NharKISp3SFa9Oq7hhmDgvO5An1cdHDscldhpgjY960TxQ5ytZmKaJY+rjHy9r6F1Bnrguds3i4bQkDbw5n5tLWdlUtvXSSKd5O++Y06jj5JO5EU5QI0eYiYjTFvpQmkpn0NT7riJPKMY9+teosp5TUDTeTYYbrGWdGPhJ0BuEHlHz6JPQ+O9ZR1QNampM6+I6UC6/rBFnjsEH/MKrPeZMh5FscKRb7rI0M//ucXpKboBp9WjZ7cdOmwfCS4mAnz3R72xlH6RHoia0NhT2A6SgN+Q8VzNvNXptO80BMr7ZLfWLnABl4vHXvRV/jSTWlgtfas8hyVl9iVuPFFHQeNTjrOC2GUk1TcqD9LWsSV6W/wAH1qc5u6DHKwovBztGrICUqeG/AK6VMZSB2SVolyaL+tlJjpM7626pl2QYhlLpugpeDdMMzVwuORHdvie2DSu/wrnJzXHRwwrMsW9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB7095.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(39850400004)(396003)(366004)(136003)(451199021)(66946007)(44832011)(5660300002)(86362001)(2616005)(8936002)(8676002)(1076003)(26005)(6666004)(186003)(6486002)(36756003)(6512007)(6506007)(52116002)(2906002)(478600001)(83380400001)(38350700002)(4326008)(66556008)(316002)(6916009)(66476007)(38100700002)(41300700001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?99teRLaGv1gQw+kJBRALgcvyvY+SPxM40hrcnqyFahSAYlEV1ngR5BcKmWpq?=
 =?us-ascii?Q?YI+FZ5XhrHoaHLnrkKA1Ql/0x+bqm44L4zdu30tvMWsdt+XIJG8EvkZDOkB2?=
 =?us-ascii?Q?VKXy96feE/J+vWtjZWf3Z7nqFnHi6LBhgitQRu1Bd04eI/hUTr2SKqp8pSTf?=
 =?us-ascii?Q?Z3YTd0XMM787S9OUvc00KjtqTZQlYIgi3v1eHzRiGMZ1cTdsaKz6MhzpO1+B?=
 =?us-ascii?Q?QdLhC98bQUieryC6BV5Kkf+eHjKJdkz1EggAGD1Bgr6VLwloxkeew79+qTGg?=
 =?us-ascii?Q?gCEo9vI1yFQvKC7LFk6+NDgpGZf9qAlTntFjplOJJWmTzLMlARF41zTO46uw?=
 =?us-ascii?Q?PEjk3gDTtJ8mpb6xsa9GMheKIjVp5x5tIQEQa69cpr8mryz4IuwmNKofsazl?=
 =?us-ascii?Q?ifW9OD428EKCMPjvfDVcFfzeYEnTY775iLYKoOihF7iOXEZEqZq5TbZI1mfA?=
 =?us-ascii?Q?BFJ8TpeDFEwy8zBOQjv1+JNw6tPoc7hS9NN8WKsp3yUzQ8eqYx/aZveTHxFz?=
 =?us-ascii?Q?+2d63xkeb079sV26T16FtsyuwxrlIYFNKelvvjTbntr20BvrdogMn3YA5YWN?=
 =?us-ascii?Q?m2gJGesrIgutZFRGxIAulvKLFRN9GPW2hG0S7nPl5GfhU4+q5ZA9b0nE1OT7?=
 =?us-ascii?Q?IyOQ6PgmZoMNM8EeSE7PXnk9xb4GwDuGJZNCjAxpT2/2QuzW/C8GnjbnOiFA?=
 =?us-ascii?Q?Sn1pXi7/051bgAdsILIx4WYMD0CRRegRJHZNVlZEgYSpI+fAhfhYTkvN7PxY?=
 =?us-ascii?Q?JNrSUbE0IB0JEts892UGSWZ8coTZgfcXtFKVZnG9IHmHKd2XjjFnZ49MzqI2?=
 =?us-ascii?Q?BiAIR4EIPAsxoUv/H2AbIjYvSo3/KNGdGS/37CSolGSK7SHR4a0vGT+R3NvA?=
 =?us-ascii?Q?Pw+PSDFTvwr5I/mWB2jMBcSm651trLcQ+HckqII3dSKMo78ktQ2FqgA+khmz?=
 =?us-ascii?Q?gJn+hLhOHhtRC22EFt+ohK0c97XCDQFFh89SzAvCVDHWOXzMk2nXyiA8paNy?=
 =?us-ascii?Q?G/xMiH0Gx+hl87/x5jyIOZitRR7SEhSr4BvwAJczOA0b+E+8GNq3hTVXu2U8?=
 =?us-ascii?Q?EH6LsPa8W9YBAXCW6YYXsl2LG98OALq4h9Wy2i50mSxD6BAzQikCqNQZwVyU?=
 =?us-ascii?Q?3pgj26HigV4pC88yHUU6uH4L496uQ/rRscD5kDluHnwjqwQ/IbopVZY/PLbD?=
 =?us-ascii?Q?Ln/RA5c1QVTOJ1UMW3HO2AOXWp8dB5cdoHXPyh0YnoCmsK0/0Rao9EQACBGh?=
 =?us-ascii?Q?wNrYmW9yKVCnZyUSIpzV32vmfrhcwB1sPAYFbuOuaQtO6x06xQwi8rFKjmAC?=
 =?us-ascii?Q?yJIYeSzUXdLETV+l8SoM8P35Mk6h+2LteydwD0TjzYt3QqJZt6DbkTalIvkm?=
 =?us-ascii?Q?1NQENeqpxuQTraHQ1xzxc0CLJ93l6L3Lf7xtm6afTET7M5huH515Z6bEqMd1?=
 =?us-ascii?Q?yPPMefxuNhzlkohvlDj6VbEuLgJmdYFWH34F8ly8bRZj4ZmC3/ctdduWuZeh?=
 =?us-ascii?Q?uW+ZNftEs55+6igWMYFvxeQVXYdElU878M8EuY+HUKbmjUaKbocDATItefxO?=
 =?us-ascii?Q?9l3Yl/RQRqQBG2Byuexp0HLjIiraYThqvd8GMAoNvBsLJz0H1i3tGcPW+Mt7?=
 =?us-ascii?Q?6xuM9hncMxz3dYmB/3TrdxM=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75bba585-d4fe-4fe7-5f7a-08db72305ae1
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB7095.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 08:20:21.2762 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V+QLxQNFajkyXL9BPLCsyocx36qd6BoUW3DBDeJ5q5xdBywnowl5YhJhaql+wsEwCt5AEMkQ3mmjpsYQ8FTcisd6FZ1ux028LbG0lRXW0iw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8422
Received-SPF: pass client-ip=2a01:111:f400:fe0d::711;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
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

Repair an image at opening if the image is unclean or out-of-image
corruption was detected.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 65 +++++++++++++++++++++++++++--------------------
 1 file changed, 38 insertions(+), 27 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index d507fe7d90..dc7eb6375e 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -944,7 +944,7 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
     BDRVParallelsState *s = bs->opaque;
     ParallelsHeader ph;
     int ret, size, i;
-    int64_t file_nb_sectors;
+    int64_t file_nb_sectors, sector;
     QemuOpts *opts = NULL;
     Error *local_err = NULL;
     char *buf;
@@ -1026,33 +1026,8 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
     }
     s->bat_bitmap = (uint32_t *)(s->header + 1);
 
-    for (i = 0; i < s->bat_size; i++) {
-        int64_t off = bat2sect(s, i);
-        if (off >= file_nb_sectors) {
-            if (flags & BDRV_O_CHECK) {
-                continue;
-            }
-            error_setg(errp, "parallels: Offset %" PRIi64 " in BAT[%d] entry "
-                       "is larger than file size (%" PRIi64 ")",
-                       off << BDRV_SECTOR_BITS, i,
-                       file_nb_sectors << BDRV_SECTOR_BITS);
-            ret = -EINVAL;
-            goto fail;
-        }
-        if (off >= s->data_end) {
-            s->data_end = off + s->tracks;
-        }
-    }
-
     if (le32_to_cpu(ph.inuse) == HEADER_INUSE_MAGIC) {
-        /* Image was not closed correctly. The check is mandatory */
         s->header_unclean = true;
-        if ((flags & BDRV_O_RDWR) && !(flags & BDRV_O_CHECK)) {
-            error_setg(errp, "parallels: Image was not closed correctly; "
-                       "cannot be opened read/write");
-            ret = -EACCES;
-            goto fail;
-        }
     }
 
     opts = qemu_opts_create(&parallels_runtime_opts, NULL, 0, errp);
@@ -1113,10 +1088,40 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
                bdrv_get_device_or_node_name(bs));
     ret = migrate_add_blocker(s->migration_blocker, errp);
     if (ret < 0) {
-        error_free(s->migration_blocker);
+        error_setg(errp, "Migration blocker error");
         goto fail;
     }
     qemu_co_mutex_init(&s->lock);
+
+    for (i = 0; i < s->bat_size; i++) {
+        sector = bat2sect(s, i);
+        if (sector + s->tracks > s->data_end) {
+            s->data_end = sector + s->tracks;
+        }
+    }
+
+    /*
+     * We don't repair the image here if it's opened for checks. Also we don't
+     * want to change inactive images and can't change readonly images.
+     */
+    if ((flags & (BDRV_O_CHECK | BDRV_O_INACTIVE)) || !(flags & BDRV_O_RDWR)) {
+        return 0;
+    }
+
+    /*
+     * Repair the image if it's dirty or
+     * out-of-image corruption was detected.
+     */
+    if (s->data_end > file_nb_sectors || s->header_unclean) {
+        BdrvCheckResult res;
+        ret = bdrv_check(bs, &res, BDRV_FIX_ERRORS | BDRV_FIX_LEAKS);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret, "Could not repair corrupted image");
+            migrate_del_blocker(s->migration_blocker);
+            goto fail;
+        }
+    }
+
     return 0;
 
 fail_format:
@@ -1124,6 +1129,12 @@ fail_format:
 fail_options:
     ret = -EINVAL;
 fail:
+    /*
+     * "s" object was allocated by g_malloc0 so we can safely
+     * try to free its fields even they were not allocated.
+     */
+    error_free(s->migration_blocker);
+    g_free(s->bat_dirty_bmap);
     qemu_vfree(s->header);
     return ret;
 }
-- 
2.34.1


