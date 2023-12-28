Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA3581F65F
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 10:44:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rImuK-0008IA-Rv; Thu, 28 Dec 2023 04:42:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rImuD-0008Da-M2; Thu, 28 Dec 2023 04:42:21 -0500
Received: from mail-am6eur05on20700.outbound.protection.outlook.com
 ([2a01:111:f403:2612::700]
 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rImuC-0008Jv-2v; Thu, 28 Dec 2023 04:42:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VJOW9C5UtFZyLour5pBA9w5EZkmIoFY2xbNji31PqEvJ8BGSkBEIrT0TKsILbCpMHsN4BJdSvYGExrf5B5jr19BaNltCEEnYei+feXKCXqm1DRV5cF7eEFbstkQDRUk51/sAAxcdIgtLTR7Hy/daWvKSE84/yKdOO75f23XXLPJYB86dz+5rBRGjzeqmAZL6baK66A+AIBuQH/o4v3qjoimTapK2UYoDON5MaIHJhQLPZI6rH6yQI38MMMihb7mZx728+L9QRcBRa1u8euICD48nsGBcsdrfYKrxH8pyhUbgE5AlnRZ4gyups7N5+6eQp8v+Xdn70JWpwXbXsoWilA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z84wjcZERYFHoLxhiNvThUkhuyvf/sVU/2uyo8YF85o=;
 b=OaXMCLQ4fLwMzxCU2qeuLVWu+NNiIG75qEhZLzB66HT0TSjJH9WcP7YPF5hhNIrEO0T8gHO8yQKVU/mYOvKB2aZQxfOGOTZ7RhEOfEU4Q4T+m6pEwblBo9kUJW+7bqEs9DdiVUDY/Od9MaSKNgIU+b0HWK4D8lfjEWnu2IryyQK/O8/i6PQA7NnrwGprbPVtvFhYygIt7792Q7EpXepdv2NnZ3DuWr+sTYfrgW87Zg5Fs36XJdqFkDeL2uyEhNoUsgep3cQqf75EsZ4d8TjW3gmWQOTihwYE5bYP4Lce+CIcbkf0sL6OyPD9mDRnlS/AlXLJwh4+GZITEnNH+eh37g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z84wjcZERYFHoLxhiNvThUkhuyvf/sVU/2uyo8YF85o=;
 b=LztZaLfF+N4K3vjZwoIzQbXeqK0TCAlAWrhgE8X0JEwgmoIK1G5B4Igf26+Aqi+D3rAeeMmjIZS+u8vKJ3/J3R6+RdIsVazE42fDh36+qN9ecR3euRfR7Vj+XgMGmBCY391rQXT8UhrtcWTr9nvvT9b604XkXRTTMJIhei0wm12eZALeA0MLwsOR1rEaCkth3rNebXUvtdFLiLTXcdKondDyKcxOyLSCj10aDS/5Xfq82ojDavkqaExk/9g4Mi0rtLnIvFgAW9M3bt+Rq2CIQLFYu0YLepdKmnt0sj9Lhz1kdd9EcIj8J61ZaruJaMPcKwjkVLHoQ8ZnFg5xSnVccw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by PA4PR08MB6064.eurprd08.prod.outlook.com
 (2603:10a6:102:e2::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20; Thu, 28 Dec
 2023 09:42:05 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0%5]) with mapi id 15.20.7135.019; Thu, 28 Dec 2023
 09:42:05 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH 15/21] parallels: Reverse a conditional in
 parallels_check_leak() to reduce indents
Date: Thu, 28 Dec 2023 10:41:47 +0100
Message-Id: <20231228094153.370291-15-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231228094153.370291-1-alexander.ivanov@virtuozzo.com>
References: <20231228094153.370291-1-alexander.ivanov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VE1PR08CA0003.eurprd08.prod.outlook.com
 (2603:10a6:803:104::16) To VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|PA4PR08MB6064:EE_
X-MS-Office365-Filtering-Correlation-Id: af728d1b-42ea-4aa1-6f87-08dc07894053
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VAomBNgdB+hEoA4YUOT9A8+pmCfKMBoXBqIennNO3syUNZQQdVlwfDXh1pVolZKjFaDmqyI403fA0X6ZSqxIiQjN/37HDnJjYy6Kv43AitPlfiEOcitcw/cbinPLecDGZfp3CGjvEFLzxmCSLd5Y+04WxtlN6qi8D5oJol31troAUuDiuFgJbd9BPkmCzOls0nnttqf8NkmiZZsfgZ1yH+DpuVhLyvkXjmr35xqo+Ju9HVnZOmKtj5gGV+GibcuG4LrKUP+7LPyogpCD+Qry/eyiw4ameJc0jEYN0hcq2PTAWd07O4YH+JnRUo8YW+gnacr/bvt9g9gspwRtkD9omCXwihhnTQ4w8gVDhfLVCyaYYCIMVbgGAiPP+4C+gRI6SeWkvoX+XEIar7L9smZRSOXTDBMQwzKTYbWocxxEv267pqvFR6JahSF09k0a/OCSe6iXPrm0ZgDGsjWIcenHkdr28pNLqd/XYDxOiOr9svfSG/QDYANKHvQfk4I5fVma5fq5ghnQzNVW68FjfxNaydT4y2hbtNAnTyZoqPczRrmd/tgCIewWUAUdvAfcsUUjB+zRKAIJdenCykk1AdrEr+nleDLKO9dxxcWIjq70NGRpV4fa4RgVbEvaCB7zetS4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39840400004)(396003)(346002)(136003)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(66556008)(66476007)(66946007)(6916009)(6486002)(4326008)(44832011)(316002)(36756003)(8936002)(2616005)(26005)(1076003)(83380400001)(478600001)(6512007)(6506007)(6666004)(52116002)(8676002)(5660300002)(2906002)(41300700001)(38350700005)(38100700002)(86362001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QDHVw5/7CTUWa1ewzaurFy2zOn3hF+kRmPIKPRhdgbzJD/NixufGRLN1DYMC?=
 =?us-ascii?Q?3CCfmBEeVGyl+vmZ7p5AUHj6TIBA37OUUS5wP7HZ5cywLKYM6sL/m1FCFQnF?=
 =?us-ascii?Q?uEvXKA6rZwc2PfEQVukajTYWecGuqVzuE97HtJFH5aXrcxDXHOp0MRp3COdg?=
 =?us-ascii?Q?dLzuTOPMG8vqHu4Lxvksge/yaxQzOa96tTDagFTl91q2UdoW5hoji0HEJpPM?=
 =?us-ascii?Q?XpscMcgFjrR2DIZ1HYlQnHsNw9uW+hea7V92G4H7eKI53hxvelLbNs0IOkf8?=
 =?us-ascii?Q?+OiklehkwhV/DZoxPAGVMBYcLONO+lRgcm8IVrx1vHtK7KWTeX1vvq32jNEs?=
 =?us-ascii?Q?2VzWwZ67GkB5oZzvznxyEk0ebmSPN3+iCWz34o5ppQLu+EW0RljUJWfdzKtv?=
 =?us-ascii?Q?lbFT2xSru+atxkR5mM4pO0ZYl/WHQI9TgENQ+OmKMwIAGUyUuXIdqWEeO6Cf?=
 =?us-ascii?Q?id4lwFR/BhDTv8LFtr9suEGWDsUvitIB5L6deOT6gI187ecu0Q6onOGlfXjc?=
 =?us-ascii?Q?aT3nl3pfVSMxfj9VTWBuN0juO0LACZBk65pkzwKoHecqL5tdDIHbraah+cux?=
 =?us-ascii?Q?TaPvUXJKq20d4dRiLZTprr9FlcuVmgDJK9KizBnvce6WoK8HYEXKrK+6jd0W?=
 =?us-ascii?Q?QCiGQyvmDiYO722BRErhfVeMxQeUNvrwkx8ZfcgbWQ31FKpNgPZ+izt6b+gk?=
 =?us-ascii?Q?l4KHzO8atZoRQGjCmR/s4h1KSivHkq7wXhaCEwFbPbx6U6c0byIAVnZWdOUg?=
 =?us-ascii?Q?93zwe9G1e4apVwjnHzfRJGxlXYu9jFyfuDAM83rblDQr1Ln0Uz2h5qiBEpYI?=
 =?us-ascii?Q?gpJ9pVuL2iFzaLtf1a/ZRS0MOqDGoXBQc/EKoFVH5F5GtkalIs4m1wtM1lBA?=
 =?us-ascii?Q?I+GH4UkGMg+wcGiYpskQicFctnR98vE60gRKV7durT50tTLO0MxfeKWj+Gkf?=
 =?us-ascii?Q?nXUniPngM7yM6oXh+Fqq+f4cl6da3Hh5MaGg4GTEmLoHorJ/ktrJibWufEWW?=
 =?us-ascii?Q?o7AKfxWazWD+Qw9fabXMxGvKiem4yOOXOyibOv2zRbCOS5Y/VwZKS+wGH9oJ?=
 =?us-ascii?Q?UWSwJHDM2nzY02GEJUvA3nno+7j0zsxGKDZzUYaoeGAixCjLC6xqG39z8fiw?=
 =?us-ascii?Q?4O73kPSni/DOceRMoH2F5523wf/vccZY+xT+U9DiTw64FhCshCvjmGzWZv0H?=
 =?us-ascii?Q?KrRr4qnGIq0YhD6lKQZyL87HVi/abT3OBY32aupis8mJI4e6oXyEdb6VpXB5?=
 =?us-ascii?Q?McycG3C+e9cr3XL0afxJZrBNeBdqc8Eggz95EVM27wrk8deu8TSlmLWrMm2Q?=
 =?us-ascii?Q?BBL2P2Qf8XjNHGlvDlxGI8/dYTgWDah71uhluLEJFVKMiPxl7nFuMrUdMbJh?=
 =?us-ascii?Q?/nqEpEKglp07rku+Qs0jryTF5SmduM9nL7qt3dJlYyjKA6Tx3agq7CqDwMAZ?=
 =?us-ascii?Q?Ok9i/Yu/UCCFjWi5Rv7rJfPvtiAvm7SR25mmXN5QCDzbL8Yqo7t49Xpo207g?=
 =?us-ascii?Q?R1e+ra/1yQd0UWbkaM6KGl41jPh977uYYNuVFRnstT/c74Xn/RfSDQW1jWsl?=
 =?us-ascii?Q?apzwvYHDyoub2ChIDxAvjNAYvR91WxyKnBAMgO4+9ZwXGk/BXqa8Qz0orMau?=
 =?us-ascii?Q?tyG/vBtMTWVUvSW3mO37tbo=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af728d1b-42ea-4aa1-6f87-08dc07894053
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 09:42:05.1831 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yReXaI2UADzQJf1UM1MYUT5Wtny1pMWOSDXtD9hVtyW79w/fxCPMXBzNgBMjWnbG5YQr/jSBI9BhEDhh2FYjyMl5uDPh+V8g/Facln3/gPc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6064
Received-SPF: pass client-ip=2a01:111:f403:2612::700;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
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

Let the function return a success code if a file size is not bigger than
image_end_offset. Thus we can decrease indents in the next code block.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 72 +++++++++++++++++++++++------------------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index d5d87984cf..fb7bc5e555 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -773,7 +773,7 @@ parallels_check_leak(BlockDriverState *bs, BdrvCheckResult *res,
                      BdrvCheckMode fix, bool explicit)
 {
     BDRVParallelsState *s = bs->opaque;
-    int64_t size;
+    int64_t size, count;
     int ret;
 
     size = bdrv_co_getlength(bs->file->bs);
@@ -781,43 +781,43 @@ parallels_check_leak(BlockDriverState *bs, BdrvCheckResult *res,
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
2.40.1


