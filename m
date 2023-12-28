Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1ADB81F6D0
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 11:17:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rInOM-0005bk-5y; Thu, 28 Dec 2023 05:13:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rInO0-0005PU-Q1; Thu, 28 Dec 2023 05:13:11 -0500
Received: from mail-he1eur04on0713.outbound.protection.outlook.com
 ([2a01:111:f400:fe0d::713]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rInNy-0000at-0e; Thu, 28 Dec 2023 05:13:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dSY+su3h1gGxZAL8v0y7yWWGEnBKYrDM/yJB8dWqofumiywU/rB3IyorbuoX2odV/bwcCsoL7BIi8d3VyBy+tG2hdlR2BIVdn0Jj3hamcyye2HuCVUVimD+6TFPTrmLjLwD4jzJZmQcTyaSmoa/F9IWmnIxmkiWTvTzftUras5JGrNWNQdij1+MUXnMlGwdkJTiP5za3tb/WWMuUadaOplTuK8N64ugDI19P8au/7iEyQ0cShnP2ZEbFbuosy4F3PfHn3kVN+xsrD3D874XMobZ120OGoQQcbWUtY6zPrSkrgxi3DeL457C8KXFBeiScKl8TLwhhbri2PSPPZLxO3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RtRIfsa8yMATIzeAlVqe/ZKQZpRciBlgyBwsHIDo9M8=;
 b=aZ589PtSVB0i4Ojut8fG1Ewlb1ITBtNHyzax8BraLM7AVjwhDlExf72HXlj6mVvoie84FzNXMoTYabKSG21xXkdmi6/dFuMfazv+866hg4wF5Bz639fr/v1ol6NzhfACYnM6EBKHZHu2lonek9rXq7fd5LR2a8zweAZEj9bbKNcOzsJmwk6vgJlBVbE6vNrtpi26qNmg0hS2cGpUFJcIfu/juboebsaqdG3di95N8s3xn89rTu7/SOJr+0APmODird5BluAWBYpCbgiDS+AkVj/Vfx42+chZsjf2lXPM7lLatBzgby4J1ytmpQpdcmY1si+0taACnvEomHxIzWSLaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RtRIfsa8yMATIzeAlVqe/ZKQZpRciBlgyBwsHIDo9M8=;
 b=Ne/p3muW/014MtMsFBxe7guUHTIfuI9QWSsLwwwuAMdDwBDSSsQVMsWUOTW6/uCQZlJdsEHWiMACq3R/J5C5uUlCXDMXJxNEC6wrZmZsjsyHeGNc02ZxvP5DklgG5lb/HY0qIIhuNGvS3KlGmr+iR0Uu+2dsAcHBpfI8qGHeRhe5j4/4/vRNYg6xSlwMPygAgIPUzdYuZibaW2Z9RBqE7Tgt/8xKoSfXfpGe5pWPe/w+87ibsqbPVMh9x5rrtl8MgnZV9F2gIDwDykDOpUqy7A30Kx6PUG5ASaT2whvUI/e72gvaxbv2TGnoNA6GbKrN/dK2Zqt/dpL+8z25LEoRdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by PA4PR08MB7459.eurprd08.prod.outlook.com
 (2603:10a6:102:2a6::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.19; Thu, 28 Dec
 2023 10:12:47 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0%5]) with mapi id 15.20.7135.019; Thu, 28 Dec 2023
 10:12:47 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v4 13/21] parallels: Handle L1 entries equal to one
Date: Thu, 28 Dec 2023 11:12:24 +0100
Message-Id: <20231228101232.372142-14-alexander.ivanov@virtuozzo.com>
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
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|PA4PR08MB7459:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d13bb3a-568f-41ff-6776-08dc078d8a57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kJLlbQ5iV96JvScIl27YtAT3o3oNTwAWTV2MqWBKeDKs1PQ2FfHjybZKnT3JVKkAOPPLWs5VT4o8l/TCbTDlI3VqRkBarPXGibdtRN67tN7WAYG83yygQCi6CYY10pPaCNGygdMB3g894HPNFMCDCrZdKsdPzeMXA7I45acknwRqPjKW92WWSfcXkz6uTnopPv8mRbNZFhrRUecFpVNB/GYOMl0MloKYhxqBtDOXMKsU2y3LIRJF4zHAY6jNJWbKf30/wX5947a8YMNzfStIDRJyDFeOVRJ+Sco+Ux8hmoZlI22UupLZXBFFyvdQ7MxkDOw6gCs4Tls2idlfnOnCS57lNj1grLIySY4hDqH8XqqC05mdlP8fYTQtxFAoCRQvIg5YPEkhdVpbuhCdKHX1YNYnAiaVUsCmVDM543hq/DLLR1MtppDz9Kfj5VfQ3EGxzGr5Ie444fHB4+NaLDYmUCxJwtLpz57FIRcnBMKNBcfsrCq4VS5xdGMF/7B+/GTjNq4WkGzcrACMJWEoisNJ6WnzBbb0RZLJvt1+CkQuhV+smKkme4V51dB/wx2QO72bI7Fr25m3C5Xxuh6rYLxFYWZq8oZachwtJJLd3uWhpfcgc96Z61W9uVhfirKqP5fC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(396003)(346002)(39850400004)(366004)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(2616005)(26005)(1076003)(6666004)(6512007)(52116002)(6506007)(83380400001)(6916009)(478600001)(4326008)(8936002)(8676002)(5660300002)(44832011)(6486002)(66556008)(66476007)(66946007)(316002)(38100700002)(86362001)(41300700001)(38350700005)(36756003)(2906002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ba4usCD01bYoOYkzFvPVt1YDP5YRTinkcXipb/VYqgk826uGxOfhSMgHC3iO?=
 =?us-ascii?Q?Bhc85X46QXQuvh1Chy7JsPYeb+E1E/zrRl1rwNPmnmlF+YiGaRBOsm5HENTI?=
 =?us-ascii?Q?B2rtPjBx8dbKc8FD7xJIXSm4IBoRYeDWaNsdgQAKfJXcqFMLQwX0Udjnh/jC?=
 =?us-ascii?Q?EGU035CgZo2iGI0EFh3P+Vo0DmhIiGkS5LiOFRS7VbCeD0z0GKJXD2dsnycW?=
 =?us-ascii?Q?XCr6izYuVRk6KTyzbzbo/MNdVVD89Vl1uZDqvDLTMzJhOmaf5w+N86sKnOXe?=
 =?us-ascii?Q?UISUhfqE0YiD4qz8TuOD0dw3vZKuw0NlNN1Hih5C9UjnWarxBnbHeFCow5E1?=
 =?us-ascii?Q?m0HyK8txmfqPOfaL+znvkG9LExMjnTekOceGt19+OpYcxAehwdIq00L0PPhA?=
 =?us-ascii?Q?L2T2kMxEFKHd17yrfTBuS72Tu9kv48GFystN4guvYd72+7xhYEu/y7gYRuJh?=
 =?us-ascii?Q?JjMQwW68CTl1LvVoyGak6phnD1GDBjkZpzLfrEt+V6HEh6AI+n10BHwVs4Hq?=
 =?us-ascii?Q?viabbwqIJEuLx1OiwDNu6ZZeF66jDWeqKa+gLv2WC+D5Mv1F7oCt/ejPGlO6?=
 =?us-ascii?Q?mKqYdJEAWF8sO2xKSPlA/ZtbYYaHUTiQIDnpXmuKtD1Q6qDw2SO+djoF5zKe?=
 =?us-ascii?Q?WZk6YBdAB3zS6mQDH/7i1qBne8JFnKNSDM8V5ndeNBsozc3Jchcuqk8tErO7?=
 =?us-ascii?Q?0J1i1XNiemQRz7pqRNHI5VXZvCKKBz73Hr/CYdCuV9siPnXc0wQRE0z6t7sL?=
 =?us-ascii?Q?DnPOtBRyuw7B1CblpnEYE99OuGB54Nnfb+7p/oiN/mxejkTFrGaqtlxlhUuB?=
 =?us-ascii?Q?4o3LSXp9HafAc3KbfyIjxgk+ycfdvTCCajH/F5sW0IVwgUI8vhtXxBPnxAFq?=
 =?us-ascii?Q?4t1KoKU1cN7hD5Xw4lx4WsSWiPZKBE6CLjXI5we/Vqouym+nQVF+MNOiGaOL?=
 =?us-ascii?Q?hG5de/cseKmMWqwmX4DdCUqX/ug23KMXHZgiW2zbfFNG6cWFF01a1x1s2Ar7?=
 =?us-ascii?Q?Dr6MNWp8TDCad6fz8V4i6hgreGltmHgb8YbX5pdyhMPlnD6hz6QpnukQDHj2?=
 =?us-ascii?Q?8qUpZaHhSDKIwJ0Nl+qjxqwQGvcTqM6KmIiQVx2aX8a4geiFN9GSXrYYtVZC?=
 =?us-ascii?Q?rtvRp+d9VKsqqiEYuylvEgr8hJfg/+Ub+EI5F3Y6o2fjOdLLOvd4GliLnhZ+?=
 =?us-ascii?Q?Zeqa5sWJ+ESi5BWSsnFayKc/rKdIDNFutrr/PrhBAMFqKJXuIDGUn1RpLSJM?=
 =?us-ascii?Q?ZbeUu8rhD8F+PJc8P0hxTsPhgiE4THxogwhNrERrqXAgDentxDeKAFYcdEdp?=
 =?us-ascii?Q?0S7ipXTtYIQrswsgYJKvgwEpU2G7J4HN3wwzTVPGDPm12I7y4QdcS5A11Lnv?=
 =?us-ascii?Q?F2uqLZyoAPR0kS8Lq3w70j6gxsDFtX1cIwoDIhtVoNwfCxOiuFlqXadupvm8?=
 =?us-ascii?Q?aUf8rcR3SnEfRBr0fLArYYoc1028A9n+7dcg2d8AoQ3ODOHNd/2KrowTavsy?=
 =?us-ascii?Q?uJ6edZmEqwnwz7yj3euHQ6vAPYOGOS8KR2Xe2OMRnosPI3o8jO2mpHvls0yL?=
 =?us-ascii?Q?dNxacAcyeYg8Ceb+ZXtDlD5XYwjCmromZlYy9+Cq2M0IVsWLSJD6e4f3MwwI?=
 =?us-ascii?Q?vduxE6BKrlDzII/La8JJXgo=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d13bb3a-568f-41ff-6776-08dc078d8a57
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 10:12:47.3692 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LxFUbIGsQAfWMWw91Tkgpq7DVt2dazhahPXb9N8TFQwB4yqDIrck/4IUeDkS5GwazC46XVE4q1r4kpOJhVWg6piGiTnT96gbOU/yYYVg8OI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB7459
Received-SPF: pass client-ip=2a01:111:f400:fe0d::713;
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

If all the bits in a dirty bitmap cluster are ones, the cluster shouldn't
be written. Instead the corresponding L1 entry should be set to 1.

Check if all bits in a memory region are ones and set 1 to L1 entries
corresponding clusters filled with ones.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels-ext.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/block/parallels-ext.c b/block/parallels-ext.c
index 195b01b109..033ca3ec3a 100644
--- a/block/parallels-ext.c
+++ b/block/parallels-ext.c
@@ -354,7 +354,7 @@ static void GRAPH_RDLOCK parallels_save_bitmap(BlockDriverState *bs,
     offset = 0;
     while ((offset = bdrv_dirty_bitmap_next_dirty(bitmap, offset, bm_size)) >= 0) {
         uint64_t idx = offset / limit;
-        int64_t cluster_off, end, write_size;
+        int64_t cluster_off, end, write_size, first_zero;
 
         offset = QEMU_ALIGN_DOWN(offset, limit);
         end = MIN(bm_size, offset + limit);
@@ -367,6 +367,16 @@ static void GRAPH_RDLOCK parallels_save_bitmap(BlockDriverState *bs,
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
2.40.1


