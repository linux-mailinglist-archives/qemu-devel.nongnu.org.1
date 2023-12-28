Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0125C81F667
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 10:44:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rImuL-0008JD-O8; Thu, 28 Dec 2023 04:42:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rImuF-0008EW-AH; Thu, 28 Dec 2023 04:42:23 -0500
Received: from mail-am6eur05on20701.outbound.protection.outlook.com
 ([2a01:111:f403:2612::701]
 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rImuD-0008Gn-I6; Thu, 28 Dec 2023 04:42:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jixAGze8YCecFw2cprCCwAzsoL0Qo3ffmqFuSx4ozbgp8RKydpqnp2DP/bCxFHiWhKFZwkFB5UmzO/YPu/BQH2uXcaP3l0LJWNY0orypumLyjG4KBefeWEYQX7FHi6V+N1E7MgiM1uDVeVlX9CwNZMquK8hMIdiEpXDLNxd8xnqiegc/8311xT0TDQh7RQzwe1me+Qu9O8pww4T5jfCm8Lbt3zxAz9ebgKnd/gCdZyJ3SGlAHvrZua3k4xOs0GJYT4xkejVGi8az4S+P4/0j44eJmkr6gOvlPL8z2+W4CNBkWIFxNDn9cvM6kRYx5YQMJfblrRqjVI1sJslo2OTmWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U7P+uRNFOiA3jbxt02/V9W2Df0T3Qf9rsJ8x0mN78yo=;
 b=AdiW3d5XR6CCeahOABNBraze+R4xmW3F9MquWNWkgSNy70H4whpbks3i+7+2Yoo8i9Yo5tnvHyCKUJYM9q8U720gWd3d34isZE3ymKK4y8oK2lPx0qvhhhviPwPuDMKoJDMsrau7bTkqna69j1Wldbtozl7YLRS/iWNOK27ZR9dml8qfFSqp5SHWbxYQRztfAnQVUKVebJQP1bQS7fs0qaWrJJcRBnb1vCdnlaMbakfCvljZBec2cusTX9QH4q28yWvnAGvZB59y1Vl5TnW2Xl604t+s4qzLFspTCN5Rgz4dZv7CPtNjNo3xclKzMRXY1mUGgY6k3LhmfmQrOfCWRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7P+uRNFOiA3jbxt02/V9W2Df0T3Qf9rsJ8x0mN78yo=;
 b=S9xu0G/OQKtKX665Lw2suQ+4bazNw5V2UrRtMr5UGZgMBXx4ODFlxuj97t1vXMxO3UgSq1mM/0AEED6mevYHxf/IWhxPAlkl2tbVjEhJdrmSAzAYMmYub91qQppGB27eEWpMhkgfkcIuexoHyVWXx+/HVrcVxSOKL0xrp1JfqIkoJWrQDOzwA90KwgFiDxoyT4ka5/nr/OXWIzUikCXNBI86cHYb9kHG41BcHnmvJEQgYuXxEI6tW1CeZCG/EDeGLYUjYY6iEocfrGVp1pD5yoxRgxXVwWnusH5txwb67dINwDHnV0nrqLE5L4bV9hMggBksXsxJHJFJ4TqmtiwpcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by PA4PR08MB6064.eurprd08.prod.outlook.com
 (2603:10a6:102:e2::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20; Thu, 28 Dec
 2023 09:42:06 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0%5]) with mapi id 15.20.7135.019; Thu, 28 Dec 2023
 09:42:06 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH 17/21] parallels: Check unused clusters in
 parallels_check_leak()
Date: Thu, 28 Dec 2023 10:41:49 +0100
Message-Id: <20231228094153.370291-17-alexander.ivanov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0f04ed68-809b-4601-1d00-08dc078940c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X38UxhNbuY8RJiqkdPmq68mMh70LwMcH8kwXDevS+vex8El4cmaDP5fNvhmT6R84Hy9bF53vANZmSf4rJXPj2oAi0ihzxju43sVC/QnEhqgl6ceZla1tpz55UEjbY6BDvAJrUrsktTXNxqk3TGgCyCliBD6K3Zs2LPN+J+smdpOR99V1Y72I1DzIVRZkAw9OuU4FUuvahFRpdbE64QRI2AHezC2QIUzducDGJIqkt/nEubryhd7Z/5ZXZJTb14VCGC5gr10tyk9u6j3BcKPlh1d9pWlgJXX+JPAPJjHYnuR7xuxJPo/Vu5awsHKXtq+WenKJiYRFU1XnfaDrfFR1c1HQMUJA2CZfPUpP3FrDAlKfeLYPS+iJlul9OkLG1b2DeHmsOkw7y01LDK+zhZFAEX9BBitLQx8quxI/kApKPTvkNmSY1kMKjm9qq5/V1dOQmtv6Z4XA/Rm7kosxXggKjEDMj1FkLDBSIATb8oEGDGwkuPv+NyhMrUb0vB5JxfmijchWFyg9PcM+bof7sfAb6eT1D1yNUvDs87ZCtvWz/Cy4LnSO5R15fmZkk0f1T2dl0gLD/btFSfCjJ1jWF/nj3YvOMQeQW+KVRLCFHFPn+q0SvaqhGCdT3UzvXTUrZwon
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39840400004)(396003)(346002)(136003)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(66556008)(66476007)(66946007)(6916009)(6486002)(4326008)(44832011)(316002)(36756003)(8936002)(2616005)(26005)(1076003)(83380400001)(478600001)(6512007)(6506007)(6666004)(52116002)(8676002)(5660300002)(2906002)(41300700001)(38350700005)(38100700002)(86362001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1KYpXrGTXPLxBlZwAxJNV6eHRPLduY6gB6mQuQFYiWBsFPHKj3O1orj5Xw8e?=
 =?us-ascii?Q?Q5jzIlnCIgqt77pQxXdojVkF2oaYBQbQ6OKJqGBx827oCP6gFRa90OoJ3lTz?=
 =?us-ascii?Q?xCGsIgKpiACoyLDW9HolmfiSwSQridJu6ub435kdJbQaxxh+NBCOPp47pGFl?=
 =?us-ascii?Q?r8xRvy7PpW/p3ngZSQZYHn7MhkFDrcanHdD1blANFCfGzkZCQTIbHy6Y9IKZ?=
 =?us-ascii?Q?woZeJOfcXAOroZfgb0tsEto+rPeZDbneU1yQh3aYs6q2pDBc8H42S4Jk815y?=
 =?us-ascii?Q?wL6XcyqbiNbbkcLa2B5tRxnFZNBb3NGCv2HwxBGb2Z3Q3iuvi/IMyLyG6MWR?=
 =?us-ascii?Q?3E3ih4ziVnSsWFfCRxiJiBTcMPFkn8QdiW73irWhW2b4b+z+Cfi+le6CNPww?=
 =?us-ascii?Q?939TnAWCsMrFYRbt8mTd4zHoza8vfaqdJjrp6HKNXVl2SYYM+Az3viLJa5RE?=
 =?us-ascii?Q?fVW96yiS+nkL3pfHEHFvLhAGhF2keZtdIfX67hkE0ZGOVVPsAKjRPKuhBZkU?=
 =?us-ascii?Q?f+D62crmLUA5C6x83U4mmt4cysCC4UMB1Zx4AKLZ7ErxXp5lB5DT8IZwFH2M?=
 =?us-ascii?Q?ZO2UApm3kOcW2csPb4/w2IS1B63STj74n6AN9eSCOXs65wArXMbQhaTBg50l?=
 =?us-ascii?Q?rYhA7GKju308gy93i2CAiWDI6s7eb4vs+bAzwMh7zcTmK9OyhtzHp5IMBocV?=
 =?us-ascii?Q?lS2NTnnNRijq+v65O6xTnkj2F1i/AW9Yb7MSxVcqjHt2SGQnqay6zQ5w6LQU?=
 =?us-ascii?Q?befyu+7YChKX0SIhrsYU1kEX90TUKtvwmdDl8pallT2M4hUMih/8gxHkvLX6?=
 =?us-ascii?Q?MvHcoIbD2ogA6lco9iqA4jcBnjKuZ76VIbPPMJ8PP/yRYgTq8JehpnaZWjm6?=
 =?us-ascii?Q?GzxT+5CNG8GfFkfjHljwF37cQhewezgvYw6/hZ/WApAhfXhW/k1m/wXDJEA4?=
 =?us-ascii?Q?bItF+tZ0xVr22vweIiBLL3hch4ZvIdZLXwxkjCmtquDfHu0nPpVXU7HP+Y0Q?=
 =?us-ascii?Q?5UFtJiRssP3KazYMqOzpMUv1h7SH1ixXXDpaaWyRLCGhL+i9a+4xBtp+2PtY?=
 =?us-ascii?Q?WNQHh2Xvyg1PM+U7cjozf3n7Gfo5csCdzkyvlo1AQ89I2Dj1hzEpjwgUOvGy?=
 =?us-ascii?Q?rmJyR0eET3rab44mDLjp7sCqDoKsjvfMq681GmmZTKATX/cssjTiaF7FvJON?=
 =?us-ascii?Q?gfzuRc+Pn+flbCr4XeNccHPeGWdme4mwpchp5oV2F0WFU542+1InG4KPsnVQ?=
 =?us-ascii?Q?kRIV9Y8ByL4h45KrpQNK84d+ZdSbJPUF1q63+8FtYCYt49jv1tcoBAaU/Hn3?=
 =?us-ascii?Q?aIPFGmYN7ItPHTwwjRijclXAkUmX13Y+ieP1mUcxvpK2CXUY/tgQqLDrukkh?=
 =?us-ascii?Q?8Czy20afbI0si56rOQB1F0XXljdwj1TjcKXxsJ6movRekMsbrnTA6EHDUM1L?=
 =?us-ascii?Q?4UnxXVsAvtPS8lUZKsCPKsOM0rV2KGJqkz3qQcqtJKrqwO8jKfHhqMIrwNTp?=
 =?us-ascii?Q?ZkEiXP9lum7+uX7s3/n/NjFRpnIZ/czTBCQU7JJQfLtmV0oqMv+FlbtSoMaF?=
 =?us-ascii?Q?3oQRpPxxlDA0KeBopxfYcBSSBC05mMFZzOiRiywx6fQvJgJrdm6dps7QNTEn?=
 =?us-ascii?Q?EGpddHMQv3tNK5EBElpFs7I=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f04ed68-809b-4601-1d00-08dc078940c1
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 09:42:05.9449 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LwOCb7UK1eoFqJ24HlPdDf9k7T41YLSF7dJY9+oX/U5Ufta0RWoeknYupl3p0+U8IN+0XHudp1BqQqwNyTAQSOu42GaWZJdQtMqheI7DFeU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6064
Received-SPF: pass client-ip=2a01:111:f403:2612::701;
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

Since we have used bitmap, leak check is useless. Transform
parallels_truncate_unused_clusters() to parallels_check_unused_clusters()
helper and use it in leak check.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 121 +++++++++++++++++++++++++---------------------
 1 file changed, 67 insertions(+), 54 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index 136865d53e..5ed58826bb 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -768,57 +768,87 @@ parallels_check_outside_image(BlockDriverState *bs, BdrvCheckResult *res,
     return 0;
 }
 
+static int64_t GRAPH_RDLOCK
+parallels_check_unused_clusters(BlockDriverState *bs, bool truncate)
+{
+    BDRVParallelsState *s = bs->opaque;
+    int64_t leak, file_size, end_off = 0;
+    int ret;
+
+    file_size = bdrv_getlength(bs->file->bs);
+    if (file_size < 0) {
+        return file_size;
+    }
+
+    if (s->used_bmap_size > 0) {
+        end_off = find_last_bit(s->used_bmap, s->used_bmap_size);
+        if (end_off == s->used_bmap_size) {
+            end_off = 0;
+        } else {
+            end_off = (end_off + 1) * s->cluster_size;
+        }
+    }
+
+    end_off += s->data_start * BDRV_SECTOR_SIZE;
+    leak = file_size - end_off;
+    if (leak < 0) {
+        return -EINVAL;
+    }
+    if (!truncate || leak == 0) {
+        return leak;
+    }
+
+    ret = bdrv_truncate(bs->file, end_off, true, PREALLOC_MODE_OFF, 0, NULL);
+    if (ret) {
+        return ret;
+    }
+
+    s->data_end = end_off / BDRV_SECTOR_SIZE;
+
+    parallels_free_used_bitmap(bs);
+    ret = parallels_fill_used_bitmap(bs);
+    if (ret < 0) {
+        return ret;
+    }
+
+    return leak;
+}
+
 static int coroutine_fn GRAPH_RDLOCK
 parallels_check_leak(BlockDriverState *bs, BdrvCheckResult *res,
                      BdrvCheckMode fix, bool explicit)
 {
     BDRVParallelsState *s = bs->opaque;
-    int64_t size, count;
-    int ret;
+    int64_t leak, count, size;
+
+    leak = parallels_check_unused_clusters(bs, fix & BDRV_FIX_LEAKS);
+    if (leak < 0) {
+        res->check_errors++;
+        return leak;
+    }
+    if (leak == 0) {
+        return 0;
+    }
 
     size = bdrv_co_getlength(bs->file->bs);
     if (size < 0) {
         res->check_errors++;
         return size;
     }
-    if (size <= res->image_end_offset) {
+    res->image_end_offset = size;
+
+    if (!explicit) {
         return 0;
     }
 
-    count = DIV_ROUND_UP(size - res->image_end_offset, s->cluster_size);
-    if (explicit) {
-        fprintf(stderr,
-                "%s space leaked at the end of the image %" PRId64 "\n",
-                fix & BDRV_FIX_LEAKS ? "Repairing" : "ERROR",
-                size - res->image_end_offset);
-        res->leaks += count;
-    }
+    count = DIV_ROUND_UP(leak, s->cluster_size);
+    fprintf(stderr,
+            "%s space leaked at the end of the image %" PRId64 "\n",
+            fix & BDRV_FIX_LEAKS ? "Repairing" : "ERROR", leak);
+    res->leaks += count;
+
     if (fix & BDRV_FIX_LEAKS) {
-        Error *local_err = NULL;
-
-        /*
-         * In order to really repair the image, we must shrink it.
-         * That means we have to pass exact=true.
-         */
-        ret = bdrv_co_truncate(bs->file, res->image_end_offset, true,
-                               PREALLOC_MODE_OFF, 0, &local_err);
-        if (ret < 0) {
-            error_report_err(local_err);
-            res->check_errors++;
-            return ret;
-        }
-        s->data_end = res->image_end_offset >> BDRV_SECTOR_BITS;
-
-        parallels_free_used_bitmap(bs);
-        ret = parallels_fill_used_bitmap(bs);
-        if (ret == -ENOMEM) {
-            res->check_errors++;
-            return ret;
-        }
-
-        if (explicit) {
-            res->leaks_fixed += count;
-        }
+        res->leaks_fixed += count;
     }
 
     return 0;
@@ -1454,23 +1484,6 @@ fail:
     return ret;
 }
 
-static int GRAPH_RDLOCK parallels_truncate_unused_clusters(BlockDriverState *bs)
-{
-    BDRVParallelsState *s = bs->opaque;
-    uint64_t end_off = 0;
-    if (s->used_bmap_size > 0) {
-        end_off = find_last_bit(s->used_bmap, s->used_bmap_size);
-        if (end_off == s->used_bmap_size) {
-            end_off = 0;
-        } else {
-            end_off = (end_off + 1) * s->cluster_size;
-        }
-    }
-    end_off += s->data_start * BDRV_SECTOR_SIZE;
-    s->data_end = end_off / BDRV_SECTOR_SIZE;
-    return bdrv_truncate(bs->file, end_off, true, PREALLOC_MODE_OFF, 0, NULL);
-}
-
 static int GRAPH_RDLOCK parallels_inactivate(BlockDriverState *bs)
 {
     BDRVParallelsState *s = bs->opaque;
@@ -1488,7 +1501,7 @@ static int GRAPH_RDLOCK parallels_inactivate(BlockDriverState *bs)
     parallels_update_header(bs);
 
     /* errors are ignored, so we might as well pass exact=true */
-    ret = parallels_truncate_unused_clusters(bs);
+    ret = parallels_check_unused_clusters(bs, true);
     if (ret < 0) {
         error_report("Failed to truncate image: %s", strerror(-ret));
     }
-- 
2.40.1


