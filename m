Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 024117B4E7B
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 11:02:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnElA-00025j-9O; Mon, 02 Oct 2023 04:58:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qnEl5-0001nI-1H; Mon, 02 Oct 2023 04:58:31 -0400
Received: from mail-vi1eur02on2070d.outbound.protection.outlook.com
 ([2a01:111:f400:fe16::70d]
 helo=EUR02-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qnEkz-0003Q6-DH; Mon, 02 Oct 2023 04:58:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EmRnBQj+9yMaIIUJxQuMWPDkWxY6pAKdDeK9T5y8+BoDQ8QqVaGDuae1fzcguq+BMrrQ68D6zXpTLwt7ptMQXb0bJA142KOAHkMU+qvMpJVttt7F1BjSQuTnrdwign0Rpqor07p5ws1nM9/SFl/0gg48v0WM4SLGSHx8tm4hMMYUrLSN+8wg9FHBSnfc97z5/qzYhFhfz1+Hhk8YNy/bczRVp0eR76BuebzbsSEyv/nDnJVId398sTF02iN2SuLImKLS/05dLxchHPUhNcf3qihPogiLNv4cZJZtz34ctIMeECM8XEHz6uJGhSAfSF2NB5Ygbbvq2VrdL1z7GOZrEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F13z9GiHPMf4tAoe613lR3A620NkyrVO1Op57HmuxwQ=;
 b=DNi1Jz3LsL6wcmgf3KCgGl/pFlJIE6/3cdIGY5KTr0xCJu/gne69aTzl3uWTc52mFQ3ueYQFSP0Vs1hWbgqT4h+PgtgGnXPChxBn5ayOotRyh8U1nT6Vrw4I/iHW5vBwkbLhQzAhpHSNaqBkGWjmXIBXzwBNC8fKv1ll6w7AEVd50o4uq3f5uMRAPtmJMP1FO/SGLXm5e1E90Ntvad9eVcqkQ8PFEJ7yRQs3yi4onbMM+Z6gP8uoHaRe4o9nHIENDpdC4C/Sz2PkJgvYs1FVUugIda3aF0N2w/hhkMxxzgtU0hjKycbLKPSgFJ1ikQmSYgsSwYgKqQzJEXYzuJ4hpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F13z9GiHPMf4tAoe613lR3A620NkyrVO1Op57HmuxwQ=;
 b=jzDJ3Q8mnEW66DV3rPHlkgAARdp3123hIhidkOtpEQpu63fc4Ul7SId6rWWZ4nHGFjqzf/qeA5gbVEIPtMgzj3HdG9QCu6B+M1JdgaPF7+NuleaBkoMuELP6fQzkkwtpQamHFgp+bMaONPCg006lMg/3aaD9cMp2obcqF/sTEvfHcVlWLyolmSHVwJJNEDIbb34uRB2Td3zOpKuaxwT+j3ku+OyKqLc5ETPl+3w+5bm1Csy44RlRyOWo+MWJvrX57B1D6kFHXANiOPddnsIGYXpR/WfVDVaBv/+9VyWUBXoXMYO2tY87KYmMij+3qeLDfmYVqTeHGpG+3D35Y0jiOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com (2603:10a6:3:4b::17)
 by AS8PR08MB8273.eurprd08.prod.outlook.com (2603:10a6:20b:537::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Mon, 2 Oct
 2023 08:58:00 +0000
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::4d4a:2d8c:6f96:4c77]) by HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::4d4a:2d8c:6f96:4c77%5]) with mapi id 15.20.6838.028; Mon, 2 Oct 2023
 08:58:00 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH 16/19] parallels: Check unused clusters in
 parallels_check_leak()
Date: Mon,  2 Oct 2023 10:57:35 +0200
Message-Id: <20231002085738.369684-17-alexander.ivanov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: dbe92b1b-6552-41c5-3817-08dbc325adf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QRZYl5azY0GYN3aghcPPDY/c3Oz5/eqkeIpNcgIElNKCFw+Yvh/JZFVuBf3FkaDe5OD0emqdoCxNmEanhIJ+0lR/KcmSqlxDMz4JVxiOvBEAW+pRT8ignqXLN+RSe8mdW5WLjCcWwSnTckYGK4pTW9b0ce2pog6/H+6JKxMdran4/7BTV78nFwEJCvEH/ESdFqK5xwEB8RxToZNezMv/FdhmTDeF73WO5eNuodaDWWw75CQzKZfUm3SPWMpTVPAv7eSh6Pws/hv9g0hLIYD/pL8IcHFs0iAr4wuSuEnsborZwc1+t8iV3BgeGsLWdtiESJrxHoNrDbqMgZlQC8W5YDw0prgRU0I2n33/CP15+a2jPU5LYVowaceCYMGFB2q7i5pdwGB3olOpntgplB+RpmDrwkkSFb8QH/Au4Gpc18WjL3D5/lTKq6Y6j+w1PsFtOJej6WJOc0gEJSjmgkzrMqUHXqC1qemMClQz5iROYEN1wxfCe9Oe8xXAuXmKkT7Z3J4vgDWBRU3uynwc+CeCKhGcQBk9a1msrC0Rtya4+mxCckJjcrUQ7m9vWAAGgRnJPAYkFcnSZig2dkKLzYwihI+d7H+xCvOJoII0wtSZsRRgIqWhihzQuLfK8v1/bCiu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB1931.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(346002)(366004)(39840400004)(396003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(478600001)(1076003)(38100700002)(2616005)(26005)(6506007)(52116002)(6486002)(6512007)(38350700002)(86362001)(83380400001)(36756003)(6666004)(316002)(8936002)(4326008)(8676002)(6916009)(41300700001)(66476007)(66556008)(66946007)(44832011)(2906002)(5660300002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SB21NBxqtbK22Z00KPuXVhfw4VWHsXhiGKEoZIPPpgvlRizdZ2RlQUPmI2Wq?=
 =?us-ascii?Q?J2mjtV+Rqt6wgt5OnhotgMrrx21ApcxYPBGgvn57N2YiorQWRkjqb8SO7sCk?=
 =?us-ascii?Q?X9KiOKLO3GSVxPO46hLhTXPguQMGyNgZaJemQ1alfhBM29BZc4wroA5IwdKm?=
 =?us-ascii?Q?68dqYCOf0a5CnDT3NQyos89fXXiaD39uXkz12p4oz3RGt2hF2s6yMMzGc28Y?=
 =?us-ascii?Q?rYxefnL7oAAfBu5YvBeN2fwqx85l2kxLwObm0KaOjk/4T8gHzTp5DuKWP1MZ?=
 =?us-ascii?Q?pe9/Yy3fr11g3+igAMNXNYoneOqtwkKeF5L0W9se48A9AwE73EFYXNgBu+B6?=
 =?us-ascii?Q?JtqVl/We2+RBCG8vhuyjRrbIMDduEwY7D2orvptBbYCVjDzJqmhITlakMXvJ?=
 =?us-ascii?Q?IsTX0PRz1Bd6rhbjeIRWZ7UjRHZedPRPPa3Xtz5sn6Lv9+pl+CQ8S2aW34P0?=
 =?us-ascii?Q?5SVXd0U/f+va56elH9eDzsk/Nq78GKZ7igMsBxOxuUs6jvqiIWHvVI+ipupf?=
 =?us-ascii?Q?mFtbzbuZiH4dR6O9bOIfDb0MFgupFtVq6eDVD9aCjNou6e/XvB8qhKdtAJBA?=
 =?us-ascii?Q?f+RrQar8YywSbUVl2dkEHsywCUs2Fzmqbl1zmfhQPa3n3ovITxDRe/YQAWx1?=
 =?us-ascii?Q?lWd10aSRFbm2mdcOtjsQyKs2oRzAtWrg4sQrIqZhwj+YKUDqOndDFysjvbaQ?=
 =?us-ascii?Q?wSAIDaz+QVW7mNDkzlDc6ctiasx0URXXMyCH7eOUOwsSFZyFGmNx2olskjdt?=
 =?us-ascii?Q?vRQfEjO+yP4D/GeI7u52fnKeBBRUvM5XRycs1mnaoObWPRGhsFUBFqJ9Xodd?=
 =?us-ascii?Q?YkUuvbEeUQamPxcK0+WeoAcXUnjYoMbvP5o7UiLiRk7Rj5DqFDHVhqKTakSM?=
 =?us-ascii?Q?LbuNsNNb/mm4TmdYzTE5x3vDaiJNTpyMw6APxWyLNtJI/vLwOZMB+oZy7ceg?=
 =?us-ascii?Q?RBjcCrTXItRGaqjrE2cG1hWRnxawPP8c0SZorgq5OzdwgIOKevaedI9Ft2gb?=
 =?us-ascii?Q?n5m/peipFBTzzjydI3Ls5gO0HBNa2JOSsfQ11OISBPEbSaWOtV1j8NDMHDbs?=
 =?us-ascii?Q?1MOseLNq+hFW0tCPK4lgCWEvjxX2Kur7hrmg49FFljplhRB6FQ57ysp90Xo/?=
 =?us-ascii?Q?mdz/DK9tFNVzrHsWK6JHabPjNyWNrBy0SMmG+sh6ILwoq5lJTyHIbTAChOTK?=
 =?us-ascii?Q?aKgdEcJASlmOGSxikPkT5o4Pl0cS8Z5bib8W1N+6EQWF3s/VTXd+21dGWSsW?=
 =?us-ascii?Q?U8NgL0207ivBj03g4ij1ljucnz4l+Jvxe6QvkUA01nX8l6zaWRdYzifCfvAb?=
 =?us-ascii?Q?ENQiF2meFCU1Ha154GZoXzAg5Qbb/M/E/62y4bRxmfEP+hieFqAnV0TrHADp?=
 =?us-ascii?Q?T9EesAfqEsFwFK4UmaqZQdoL+OCx/7KMgdpzZCDAjcL049gC1fJVIwvQs+rR?=
 =?us-ascii?Q?TPicBHKCoagwDsJsbImJY8cY9EGf7U7N0i22Awi8OPYNQWchoXnkh/a5XnhH?=
 =?us-ascii?Q?35YegIgc5O4rUfrxKlIWOdRI7H6sAQ2gW+LyBPLIPMna+ri8cGGMTDIHfqkN?=
 =?us-ascii?Q?lhzyP1aJu57crQEvR6PhNspKhpf1xAfNgUpOqIG5RAac3z3+l3GUXtURG9UJ?=
 =?us-ascii?Q?QiMb4y3daLw+4h2eQ2u+8xM=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbe92b1b-6552-41c5-3817-08dbc325adf5
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB1931.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 08:58:00.4297 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oGOs5t+f0LiOUmZcZS8VSE40Zsd9uZUYipZnDAUW5dwtHFf5OBJ5FHu7oi9xzruG8WymyGWqmtPDwIuSYqKjEjARlfznJDkotqgoe2wLysQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8273
Received-SPF: pass client-ip=2a01:111:f400:fe16::70d;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR02-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=0.799,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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
 block/parallels.c | 112 ++++++++++++++++++++++++++--------------------
 1 file changed, 63 insertions(+), 49 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index 80a7171b84..053ec0f8a1 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -764,56 +764,82 @@ parallels_check_outside_image(BlockDriverState *bs, BdrvCheckResult *res,
     return 0;
 }
 
+static int64_t parallels_check_unused_clusters(BlockDriverState *bs,
+                                               bool truncate)
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
+            return 0;
+        }
+        end_off = (end_off + 1) * s->cluster_size;
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
-        res->check_errors++;
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
@@ -1446,18 +1472,6 @@ fail:
     return ret;
 }
 
-static int parallels_truncate_unused_clusters(BlockDriverState *bs)
-{
-    BDRVParallelsState *s = bs->opaque;
-    uint64_t end_off = 0;
-    if (s->used_bmap_size > 0) {
-        end_off = find_last_bit(s->used_bmap, s->used_bmap_size);
-        end_off = (end_off + 1) * s->cluster_size;
-    }
-    end_off += s->data_start * BDRV_SECTOR_SIZE;
-    return bdrv_truncate(bs->file, end_off, true, PREALLOC_MODE_OFF, 0, NULL);
-}
-
 static int parallels_inactivate(BlockDriverState *bs)
 {
     BDRVParallelsState *s = bs->opaque;
@@ -1475,7 +1489,7 @@ static int parallels_inactivate(BlockDriverState *bs)
     parallels_update_header(bs);
 
     /* errors are ignored, so we might as well pass exact=true */
-    ret = parallels_truncate_unused_clusters(bs);
+    ret = parallels_check_unused_clusters(bs, true);
     if (ret < 0) {
         error_report("Failed to truncate image: %s", strerror(-ret));
     }
-- 
2.34.1


