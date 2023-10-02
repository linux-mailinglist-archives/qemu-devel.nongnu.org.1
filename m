Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 78ED47B4E6A
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 10:59:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnEl6-0001op-8L; Mon, 02 Oct 2023 04:58:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qnEku-0001cD-2g; Mon, 02 Oct 2023 04:58:20 -0400
Received: from mail-vi1eur02on2070d.outbound.protection.outlook.com
 ([2a01:111:f400:fe16::70d]
 helo=EUR02-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qnEkm-0003Q6-Ds; Mon, 02 Oct 2023 04:58:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nLwbr9oDHCCmMRa9yhd3icVfikwFGHqEaivkHnUFLhDFiQFwADyA+4GIcyh+vFOtD723pOnofGVSrmtkYnYYjk1jUa2yiMzefveQI8/BIJ+vZZI15DLnO97sdDLMYM4fFIEfuKS9QuRJAFE9usCPjOKvGkY4BJ0bjYfhEj4xqFLuZSpkbbpTNlzmbkAeTEtNyray6R1KZS1K8sBKFM1ZSpJ9V1dctJrN8JZumFZlBPZ7hLF3MLZloYqiRji+b0PzIiFes1OkxzYVqT7yYmFTWonhT3ewPSqXq5m1AJkumJNQ9+c+jRltk5As83yA3ow8DTvOmkbjlTfGmYKh6KDK2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LYaSUkEoXMo4QNirSEEcBel8na4gyex5ziLJ4RgbXio=;
 b=bMbgCKv8hzfSdWNb5fIsRGGtMyQHVS/OaXG1Uk9IVWSeQ7/WcZfcuP8M+IjNPhJBqAMAN7mf6fdLV19ZOjB+g4xpIJQSeFMXDCaELEzNSaf1VQxXuRoPXo5+uj1DQwG505IvQB/2cf6C6vJZIYmEPWeZOQl3w4zGrS7D/BSg3gieuMv0rw+WL4Fw0IDMBBMfcN19lBj5Lh0oObme96w+OkO/oLE5yfvLbT6PfwkvvHt7SXFSWGLvlySs2fRvPuqx/KSTDGousazoIWL1rn/4QHNt3V6pbjsgQ4iLlzz4GaYARC0/RXMvYJ3jYnxaUlCwzROufLpIjkc2K3EhOR+0Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LYaSUkEoXMo4QNirSEEcBel8na4gyex5ziLJ4RgbXio=;
 b=vNCwyqtWZurinSHaWJzVXQen2FCdDdVFWUyDS2G4YS6dr6Lv0s2Y1qvZcCntu6yQiGb46bUAYE+wSRLhH5GwNPt7jkEPpkC7uVgejb2MLImHQ6lJP3Hs8olDumvtO1tGoRmzCUbptzPjTY8r9RVlphWN8em3VPsMzAcDEyb/vj4cifMhbfb0WOhSuc3gwujhLXvTUgdoiBL9ZBodP9xNbRAxU2O3SGI0noleAu/XGg7IYr8ZQ+4gwyyYUsg/jngIiy/1kHxBmAbVmiEOn25WQc0ASBSAN6UuuviVl1ZClG6IvTAx6AZTqxruLK0WZOQpuD0Y+LDB4ltd6IIBUwuBcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com (2603:10a6:3:4b::17)
 by AS8PR08MB8273.eurprd08.prod.outlook.com (2603:10a6:20b:537::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Mon, 2 Oct
 2023 08:57:57 +0000
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::4d4a:2d8c:6f96:4c77]) by HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::4d4a:2d8c:6f96:4c77%5]) with mapi id 15.20.6838.028; Mon, 2 Oct 2023
 08:57:57 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH 10/19] parallels: Let image extensions work in RW mode
Date: Mon,  2 Oct 2023 10:57:29 +0200
Message-Id: <20231002085738.369684-11-alexander.ivanov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: c0624cf4-0f9f-4405-8ebf-08dbc325ab14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XVOI13GMzHoVPNYmm9HGBrOL0RdyI/q6RS2AoY5Z64Xbc5NnokkLTPUmoutCB2G5wJC5kc+TrMdrWvjz15KmfkLEjx62iSUU6zued7pWLotvB3KrW+m/+QMiY1NCR9nsxHlZ5QW6VZE+Jn6KWvSATYFBJ0AxOsqXPgCxkiJAzzoAyhTKxSgH+619xEVnBlaNgp9qxqhe4Si6PZaHNmKBs5Kyo6goTjHw6m09oFBRkavqHh9LAz7YKvhcL8kfx6+dtzWUxkFg3yuEIMvIEwgZdOOoHec/xo6P4DKIrdFPK643yZ80rfywxM/wD7qdXnTZERARg23hzmtrEtRmXkoziyrF5rleBN4pfcfGMqC5DHh2oZlSPnBSKdC3G92dZX8K4rSXVe6Lkjw/YujNyAz3lxMoVH6+wnLNSUPtMzNxzegxJLqHMLu6BKD4+j+jWEJKJfxhW2SxC1+HafU6dB67O/mpMWqoiUPrR6lsO0GIbu1y4luhNJ/4cTHyNGwgBVa3+9Sk85wfZwt/UrY0TU7tl/CI1TGTMXz4AHsx4tbSHHAJ2CiGT18ee/m2ndZiNOQxam0dcRtEGwv/gwlf8cWb3RwktwXXW1fINZ3TtFQaJ8I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB1931.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(346002)(366004)(39840400004)(396003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(478600001)(1076003)(38100700002)(2616005)(26005)(6506007)(52116002)(6486002)(6512007)(38350700002)(86362001)(83380400001)(36756003)(6666004)(316002)(8936002)(4326008)(8676002)(6916009)(41300700001)(66476007)(66556008)(66946007)(44832011)(2906002)(5660300002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X+ZQWFrXel8pkRCjos8K14vL/yS9KQuyJhqa7R0vrCEi2uWlQNy/phsGhNcF?=
 =?us-ascii?Q?u7EGnMPJ2MZjAiqfbxyxzlReVNMN8GEoGZ/3tUXwj4hrc2w7YMdkcylFF4z3?=
 =?us-ascii?Q?2/fLlADCoqXApfrM9FbUjq5ZK7A/i0YNSMeSSllhi2coTKvUeMG+rg38yvDm?=
 =?us-ascii?Q?S9oNG7s6WObXsTEjWwcRyaHG0msNPbHNSkbSZ644QdEf55bjKJWBvf1lVF+D?=
 =?us-ascii?Q?+KMAUV1WbRDFEqZ2UgZKP5ogUfnCljHrVYsFVw2J/pEu49LYvU7ShqV4QTSd?=
 =?us-ascii?Q?6B9KthrnuX7y7cWoNO3I2TcIKayvwmr7BpgtnoJPYc9o04rsKv88JwfeMOWT?=
 =?us-ascii?Q?x8J7XStiOh8U17aVQoiTLJlE7YmqEcUo2aMGaY5HHDeV7SZCvbGcW1eTcj9j?=
 =?us-ascii?Q?uTVZEs8uEv3zZBjCs4b3qaB1drJMS+81vJdGGGUk3rWrx5Sh1m+ZLpuRTAcf?=
 =?us-ascii?Q?KFmOmc26hSHUT3wkogoNgN3qaqgMkCkYOYn5V8elXk1xYuDlYxeWYe8TFU4s?=
 =?us-ascii?Q?wjGGrKZvr10Dk1XQhMY2hDSc5VD+G/OAj1KhnHxsaynIn6YvqnqCzXGMfydr?=
 =?us-ascii?Q?Qs5gT4qyc2Wuqf1fUSlW2W5jTXdNxBI1SFjq/E88Tjw9bDLVgwbqSMG4qMzz?=
 =?us-ascii?Q?Nv9iK60qwMfIDtLy7O7+wsI4fSIa3D4VMeS9WbuV0BPsitSwsve9GUirNAsp?=
 =?us-ascii?Q?HWdimXNrgU62h9JGqKlXhC649yg738PV9p5SJ6eXPU7IX34/oPNbQXdNBqJb?=
 =?us-ascii?Q?OVQvYUIgu5qW87gbQgCtEG506pzxV+Xkonq7ENXFqc6vDoJM9QzNoj/7sLQq?=
 =?us-ascii?Q?DrwA+jHuxpbKlhI9449KFawhiiNMkL3/0VwEEN7THxjFaQ1oMRxzrzkm++ab?=
 =?us-ascii?Q?YcRyCvZ+qGPQZoPqq8K2933w463VseH7yap1Jy0L82Dw5hmXCccZBEtuAhgi?=
 =?us-ascii?Q?fWZUUU+YO4I6yCfoTUyGTPH4RSOh0hG/hpAJ3+CEXwamCO0d1DQBWU/g8zZi?=
 =?us-ascii?Q?JZBkAzafbKtargdA3ccMjvtXwBFY77OtiHLhTFp3RFYu9zJIPUP65O/Pi/jO?=
 =?us-ascii?Q?3/NkGQigbMAOj2Bq3ve/8XVNxPEH+tznTj1Bc+ALyxn7Jp94Es99lQjNHeGp?=
 =?us-ascii?Q?zkvqwFBYNQy+w0zaUV3RNfgMHu4fgPTu8XHeFoZG9ixc8x7WMwGGw1DocL9T?=
 =?us-ascii?Q?aBIIZ10Ndd31Qh6gf/KuWgPDuj0KjwyBwYyUOmSey0wlJwaZrt0868fCykWI?=
 =?us-ascii?Q?3HbNgjdyqSO6knH9EPZW3TZTb5/nkMS8HEaAj7VSETkE7tMDGDjqixEYSCe/?=
 =?us-ascii?Q?yOZHwwWvlzx4fngW4Ve+nt8qeP/fmOEVbaecHs6DeinJu5fbFC8FkdjHUEry?=
 =?us-ascii?Q?lwW6KR7ltB7Bop2HFNno9Ai63qcWKjvUT6UA+QR5UOPJt5flLBVmiw20uveb?=
 =?us-ascii?Q?3qFfuFnmFdrooz6oDN50M5wfGRnD9VKORWXNfHr0zqVSLydMQ68lzuKcg6+H?=
 =?us-ascii?Q?AgkYI3fPpiZdvLPZtl3s3OO4DeIArkVPz/YIujGsO+5eM2cUp0rkqhFqIRc8?=
 =?us-ascii?Q?jfmjP9k7q0jwGH3YCixQ7aOistecmRR0/WsYZsXq+Pn5sV+rOJ/dj6AsOp/0?=
 =?us-ascii?Q?k/ozG/K81QFPBZUmiLuHPi8=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0624cf4-0f9f-4405-8ebf-08dbc325ab14
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB1931.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 08:57:55.6074 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rFiaOkjoeFcypSHUJTbVCkFkYSQro0509yEaIM8ZbAtKjhD0Z/6gN8kzHhy85jRCNz6ulfycCEV6V7luEAo2wAur2l90juvJcxcsN+llgu4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8273
Received-SPF: pass client-ip=2a01:111:f400:fe16::70d;
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

Now we support extensions saving and can let to work with them in
read-write mode.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels-ext.c |  4 ----
 block/parallels.c     | 17 ++++-------------
 2 files changed, 4 insertions(+), 17 deletions(-)

diff --git a/block/parallels-ext.c b/block/parallels-ext.c
index 0a632a2331..a0de4f1b07 100644
--- a/block/parallels-ext.c
+++ b/block/parallels-ext.c
@@ -177,10 +177,6 @@ static BdrvDirtyBitmap *parallels_load_bitmap(BlockDriverState *bs,
         return NULL;
     }
 
-    /* We support format extension only for RO parallels images. */
-    assert(!(bs->open_flags & BDRV_O_RDWR));
-    bdrv_dirty_bitmap_set_readonly(bitmap, true);
-
     return bitmap;
 }
 
diff --git a/block/parallels.c b/block/parallels.c
index d2a45e0c04..772a8ca1eb 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -1371,19 +1371,10 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
     }
 
     if (ph.ext_off) {
-        if (flags & BDRV_O_RDWR) {
-            /*
-             * It's unsafe to open image RW if there is an extension (as we
-             * don't support it). But parallels driver in QEMU historically
-             * ignores the extension, so print warning and don't care.
-             */
-            warn_report("Format Extension ignored in RW mode");
-        } else {
-            ret = parallels_read_format_extension(
-                    bs, le64_to_cpu(ph.ext_off) << BDRV_SECTOR_BITS, errp);
-            if (ret < 0) {
-                goto fail;
-            }
+        ret = parallels_read_format_extension(
+                bs, le64_to_cpu(ph.ext_off) << BDRV_SECTOR_BITS, errp);
+        if (ret < 0) {
+            goto fail;
         }
     }
 
-- 
2.34.1


