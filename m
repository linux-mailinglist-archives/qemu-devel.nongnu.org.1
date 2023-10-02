Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7CF7B4E77
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 11:01:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnEl7-0001tE-LU; Mon, 02 Oct 2023 04:58:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qnEkx-0001hU-Os; Mon, 02 Oct 2023 04:58:23 -0400
Received: from mail-vi1eur02on2070d.outbound.protection.outlook.com
 ([2a01:111:f400:fe16::70d]
 helo=EUR02-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qnEku-0003Q6-QM; Mon, 02 Oct 2023 04:58:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BXyLzU6Eh6Ye8bkRjxnuNqPBusPlb9sTkotvX83SRaNcpQ0GjnJZY3R9tSP7dynGgVmmoaxMPTK3obxHWoE2bD48mDHulKJg96rXfHmBj7bg7gqIKz55SvcJ3n8Z5lG+p+xi2vYqMcRlTtUrNaZjb0wD4PhY4A7lMeGQfjys1ehQ6eyrHjp7AV8oAGIyYVGqoknekKpXR9hwzt6HbgBXGGRf5MmOb6EMnBimpCbBuIREaqOYXGj5+Jj9MYuZJOihwDTZctKOHv6w1PgX+LjSwndjEqrcSU4khZlLeeONWssyLkW4GWOY2WISfUK5Nf3oB6egA4SqipnafDberyGEkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KntmpZE39WYEeN3cWNez7tMuwUZMtOdTqVd3CJwlC1M=;
 b=LwwjJgUvDPBxlrdcx08fK8M9/z0N1DQMsgQBEUHhEYd1ZqTKKTk/dgRZ8e2Y9bnBG6wmpVlU2+lIngRdx4M9QYS2BxvggWlj+Snu19CxOJodcDjeDGpWJ5btNz2hraPLIK3RkRDst9HMLLnkgY0OxXEpHv4evlcdlAh6LVjyBLLyuaTlomLAt6QJ44CM62WJ3LqTsbcWJqVPfUzXhVfEGcNw5fqi3KsiuBe0IT6Rb6LTe3QtZdiEWHWgMwFOr+LoGWsogRNq5uteFJqyrAq3JRkIgbuHRF/HfatMdwnJrmIyOcXP4vOpubMAWj9scTAZdiI4WZn7XRJiAdB+Us2S4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KntmpZE39WYEeN3cWNez7tMuwUZMtOdTqVd3CJwlC1M=;
 b=oO7H3YqOf93w5BqNGuqxH8S3UZNWObY3m14sMeIYiuXMOX2hwc33DeIvnKn7q9lbstNrtwlozs5xfJn1ujbdsC9s76uqDYZHpWLT06Atn5FsnU3o/t/DEkfvLVtuWlNQv7auy5cNO1S/Fh+1QWdfeI/SGslyNY3C4uWhSH9S+lDf9fEzE0ipIHkfvzGmgCJJh8g+U8vD4P0DH+dJdbxkoNAG1zPt9of7m0s/Lv0Rp8M32OqEJb60zkb3F8+8jPGylEJw2mZD6yiVqzHj0nwnIHkS9uX4LNvchrwQvmdGkAUqqBB+MmSEi88Hxzez4X3encF2TIY2fY73j8V+R0HPOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com (2603:10a6:3:4b::17)
 by AS8PR08MB8273.eurprd08.prod.outlook.com (2603:10a6:20b:537::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Mon, 2 Oct
 2023 08:57:58 +0000
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::4d4a:2d8c:6f96:4c77]) by HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::4d4a:2d8c:6f96:4c77%5]) with mapi id 15.20.6838.028; Mon, 2 Oct 2023
 08:57:58 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH 13/19] parallels: Reverse a conditional in
 parallels_check_leak() to reduce indents
Date: Mon,  2 Oct 2023 10:57:32 +0200
Message-Id: <20231002085738.369684-14-alexander.ivanov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9b8e2c2b-2085-447e-76e5-08dbc325ac88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TIOeygH1oTtRXb6cfq7GRwHorTayiOWwKYxaEEK/HEqXcfVUev5jPMyOFzSnQk95zjZYbhnrbMY3b1gCzhTl+mR4ZOLLG1GkQqK0TulefXBwXC0dgnDpvlrWTdD15H7KhbmCFtcgnLg1Gop0YVLDkSHTUThPv0i0gIL9fZVu0jFwHVV6j43xa11tTx5LMzrLxlrxLcwBMF+eBGKaZyNCbkMAOuM0hRoyLA6R0msCOqmelOKJVyBn00l/5n/i7Gy1D1uFxEc3RRhlZA9tfyWl9I4uaCKfC2WFM2oBCHd2r3EidYG1d9rR49VpAcdna7R9Kiyk7ccKATSgLjpB7jX7/HAIkoAT1QILTxmWlUTs/JlBnSUZaWEIFJgd819Of2gVV/qdfepmgrHrZMsGVB2XKVZ22xd6haStV9szFCn13UOcV3gN3qebdxfzgH4Y7F3OS6m+KUC/+0wBYX65cBSYPlAyyy5gy4VN2MMDniKADzQ9MK6S0h6g6qxwAFByATpm8xy1fAaotJZGsnRfCsXEcBOR8yqCOcGUlFvT+90z5HtJ3yifhYN8CWO8IFj44A3h/6QoHFj998946A7MlbcUVFIkQE7WnJIIMANhCemnRm8KBwb0MSH3RiQWMqDvd+NS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB1931.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(346002)(366004)(39840400004)(396003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(478600001)(1076003)(38100700002)(2616005)(26005)(6506007)(52116002)(6486002)(6512007)(38350700002)(86362001)(83380400001)(36756003)(6666004)(316002)(8936002)(4326008)(8676002)(6916009)(41300700001)(66476007)(66556008)(66946007)(44832011)(2906002)(5660300002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X5HAQ9BqB1c+Kb7VV9eYxjq2ZjFMtiiz3ClfNGouf2bZhFNfnGJHjHQGupC8?=
 =?us-ascii?Q?h9npnXaZOsD6kWRyY+XrnIZdjd6bq3hiqeuv1i37VCJXQavJhNnKS4JsRCnc?=
 =?us-ascii?Q?6hGHub0h8gQKu+NkJpsL3v4QneBXkDmrMJxV+x1yHQdg/IEF1YpxuvTZhwD4?=
 =?us-ascii?Q?Pdf3XZdURw1TywF6+UY5kF5rjLHK0WmkZg1xOFeVrB2n2LJlAhN+ap9bvzWI?=
 =?us-ascii?Q?5DCrHJHAtmV7OPocuP+Hm1JzYFMAKhNvP1/u1nL4Y/esDvr4LpqGbSIYzZXa?=
 =?us-ascii?Q?A3nx2Zvizes82Oj3lMINT+WVPT4tivgFo9YiWesyZWA5bRzU2ppa8Ova7OtV?=
 =?us-ascii?Q?z9pfcT06T6S5rmzZBV4fUtmlzczTbPP23AChS6otoZRB2Gm3oHY9c+aS4+pG?=
 =?us-ascii?Q?GGhQ8cUNLWt9NDZrRGo04g/gPlNM+OC+GtR/kQuNzuoI56rfzBrZMqH+FTap?=
 =?us-ascii?Q?Z2jJ4FOVo5aNbshzF91+UdA5U2XzIalQGxELgzJWOxtPCE1gqTp5bR5HflkR?=
 =?us-ascii?Q?XnaMeacOZyyK8BRsHTlFME/iI9z9fURUyjly0Bs3z5muXD6bDpVMj/NXChqY?=
 =?us-ascii?Q?Bs7tV4mf8JdMJZVLheNiyErPkLJEg1CgYa3B/1apE457L7m5uIU3dfwn0qzf?=
 =?us-ascii?Q?RzlqJo4j8Zs6lUMe463o+rTDcXtkU4updxV33/5KwLfDH4UnuXjhTGyC6gNK?=
 =?us-ascii?Q?lVIwzLuhTdp9568swV9dU/TVMcFYMtBTo4DZ6CRaGk9Yn7LEugihImxvNJb4?=
 =?us-ascii?Q?15hRgKRdpgpoxK/YXebi+0qRIaZOW1ISKDZjSfCbow4mqbEciQG+Ct0YnHay?=
 =?us-ascii?Q?pTjCsVVGT6kGOBZpyZqyYINx8E/QRcJxGh+7IlCcGIBgcOzhRgajzhZq1hNo?=
 =?us-ascii?Q?BPXqmbi56dPVshxYsW45lz8Q9xI2O2vooBIK175lZ5qmXEkRoQrOGpGfZTQN?=
 =?us-ascii?Q?WX29QhLr3v6ebxmWL7/t0+ByCCUQ/P4wjiJFfUC1rm1PeQvV+MHPyKSzZG6K?=
 =?us-ascii?Q?USLxvI1Izh3sJMn5jdnGqEy3FnfMF3jdlpogriEDzi4+SNp1RtboiLiGdNY9?=
 =?us-ascii?Q?Kc+IuBDVkPSmnJsYe9N53OjUGW/HgPwBjH/5a9n6dQ+mIy0KU0LCUzZUneiR?=
 =?us-ascii?Q?xltKr1BO5XATrbIFB+ceKWzAugJeHfrqd5X9ONNIlK5/KOY7kMM+lfXU9LEZ?=
 =?us-ascii?Q?tfsfVqNx9/s72F0f/Y07e0BY7benRXqOUU4a2mClLXj25TE+axGytXHA4P4/?=
 =?us-ascii?Q?dDcbpGzAAmC9PLoJMQPmIhXEIRFkViFrvmYZiLllvK3HiMtsVAyfaq2TvX9R?=
 =?us-ascii?Q?udrHR5s5wWoRgHEwdqVUKdOPcSDAxlNX1PNt8wlbboKXDJF/qyBMLeitWRkn?=
 =?us-ascii?Q?V+p8VC4vZQejgUWNfNESQX0Z8EP+rOxeZNTN+X7JmTk4ShP8IrRscsZSsf5x?=
 =?us-ascii?Q?BJxi0Y8d1JKiaTS1a7dYnOJG3/cVndVnE5qu1v6KLIUg0HAhCc9eQw8tFxtU?=
 =?us-ascii?Q?iHCMS73L7hUry6lB3Dr85T7FstTCZ9SdwaULy4KdJ3DI6wq/B9zvbt+vB//X?=
 =?us-ascii?Q?5mnhCvJKZu3DxnY61E8wCIU0bslDnKU8dXlRwDPMiGPZeRs9MCCg0KRnS8G/?=
 =?us-ascii?Q?NihyrxsiUMXe3754QpmgBuQ=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b8e2c2b-2085-447e-76e5-08dbc325ac88
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB1931.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 08:57:58.0232 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g0JZN3VKoQ15G/iVDR85ItEV5zNF1OiaBJKjZXLqvkLsyGqm8S3b3BJfCl6Ue0jdDRiNChI8H9GtDSOV6DkJDaAMY8VLE8swUTcziI3JSd8=
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

Let the function return a success code if a file size is not bigger than
image_end_offset. Thus we can decrease indents in the next code block.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 72 +++++++++++++++++++++++------------------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index 772a8ca1eb..7b16ca2ab2 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -772,7 +772,7 @@ parallels_check_leak(BlockDriverState *bs, BdrvCheckResult *res,
                      BdrvCheckMode fix, bool explicit)
 {
     BDRVParallelsState *s = bs->opaque;
-    int64_t size;
+    int64_t size, count;
     int ret;
 
     size = bdrv_co_getlength(bs->file->bs);
@@ -780,43 +780,43 @@ parallels_check_leak(BlockDriverState *bs, BdrvCheckResult *res,
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


