Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D00D07B4E73
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 11:00:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnEl5-0001li-87; Mon, 02 Oct 2023 04:58:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qnEkl-0001Uz-RI; Mon, 02 Oct 2023 04:58:12 -0400
Received: from mail-db8eur05on2071c.outbound.protection.outlook.com
 ([2a01:111:f400:7e1a::71c]
 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qnEkk-0003RK-3T; Mon, 02 Oct 2023 04:58:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nMALzO+Xxf6TPD/wNjeKUt+3vzINN4dgbRCIhB3wfVLzDPx+QXwv8VmdJBCfEMRQdUVR1srMHpzZygCumCdaOzJOhSqIvmkWEiD1sUqFDvpLgRlv22aF45Y4rfDuecomBIn099Y+MJniWDX5z4WA9YCiy/8dlEwxnQhjHMATJubuz7oQgs9f9JvpVTAu45OUS7qrIicfBzuoTVVo1lLH8yS4Ane8seiF76NjljgTP+vqlywTafIAgd1mOIfVe0d0hip1WYg7x9qRHA5dTrf6Tnfpd7a+bgWMtlzMGvQpkSDNyIW59XfuEYczoesg1RU+4RBlb3ouQg8QnP4GEjursA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zj9+hB8ZBRU3lZSb5pn2qqRCz7DQGcUjmLtk4z/tFNs=;
 b=OiwzRIQbNM37tB10KgFKbJEqrWsltCw9tGnXDXmkckOPqrHpG2eh4lGOFDP0yR+cNAhSw2mCf2v5G11WGrafmc4c8hWI34lMsYmIcUoZEQFTTcWYZ1dhLs/BwyecexfbIW5OnFhir/QpSNiov/HSHqy/b/l3w2BZUIvlZ5QUENr8RPnsJAqZde3JlEEuavg0RUQ2A2FleR09NgXrtDJlJ7b/gZV/eAGo2zv0b0l5F6a6DUcCHKeubKK8oNm3+9qHjZEJeJ92v5UAhH0n6DQAZ8C1AlNCXqEsbhZ300z9MHpFEHlFBUhMoKrLyqbKUtQCWHdRlF4V12VPlsGOJSN2xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zj9+hB8ZBRU3lZSb5pn2qqRCz7DQGcUjmLtk4z/tFNs=;
 b=bfSsdwNlJ5K89zTuwU7qjyWUqsbUT5darnxluYdpsb9+QzQ0UcOqxzNRD71s6EdBjkopActW3mQPzfPhVVNscf4lP7T4wRQOnDMebeWmkR+QvI0HHcjAfd6KvYWI1STgRFATWfYJWSsZZK6US0m8j/z0j44O159bKZym29b8MGfOvcA7+jscd3JeaQWqIehKnziOTWIcrt3+gxazTE3MHUmq0FtIZii0IIaHsSzW4Mf1LroVCAtoFC+iQttHMO8F5E8wEfC9khaunLrAgzblBt9vCDmgojZeuoGiT7LV3FZRadaTGGLjvrpc3WFtjTbnxF9fzFCcFvArsPPAS8jY8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com (2603:10a6:3:4b::17)
 by AS8PR08MB8273.eurprd08.prod.outlook.com (2603:10a6:20b:537::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Mon, 2 Oct
 2023 08:57:55 +0000
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::4d4a:2d8c:6f96:4c77]) by HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::4d4a:2d8c:6f96:4c77%5]) with mapi id 15.20.6838.028; Mon, 2 Oct 2023
 08:57:55 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH 08/19] parallels: Make mark_used() and mark_unused() global
 functions
Date: Mon,  2 Oct 2023 10:57:27 +0200
Message-Id: <20231002085738.369684-9-alexander.ivanov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 87f65909-4eb8-4291-6345-08dbc325aa21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SERmA9QhNxKzeWVKt6TqpylnyLevOS0BoqFY7yegohWR7961pJJt7p2dL1eyVbacYZ+aPJexgzy3409+biHf4yciRJ7jhVyMRUTQLRUptFzUS/j7S7D5HgnuEhcb1Bq+AiXqu+EZjDSE7u/LDxWp/mzb0TvoGWq9dt0O6OQOb+fUfZlgVcyURkRDH6IPmcMtEXpDzoO12F7afHr/W4Cev3bqo7iRTq2DFpGEsJkA7LKjiEGYsXMy7L+No2+u4w+tpX3JLFEvwm3FAPtZPS3r7oT7F9/eqLArkIkz/9BOZDKkYqFyZwdiKbmj+RI7zpVhRL0xdhl/h+bpgCAH16YGne22UgyjygLytYcaSOZwLfW/uFL8kkqekWxGlosVRvbi7Tgzzg6dk99s1S3f7pX4WJ6yhBiheKMaHkwrIy6hz6Bhek05mrsSdOVzIJCpGfnanGjjnAp1/xaG1aRfFr4hAGl0YNv1iQ2aLXDKc/ry9x8Rxr1PjHXZhokP7S3DrIAu12tqs9hX7ugPkvcgOJ7PJFLljO0zsNNhedtGukrCK44rkmGDlN5J7+/8kOFh31yqNk3qFgiv7qRIbnMupGazNXqreWuNPCiK1mJtRvivJg2WMuTQtzmjWN2Qtn0lqJvI
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB1931.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(346002)(366004)(39840400004)(396003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(478600001)(1076003)(38100700002)(2616005)(26005)(6506007)(52116002)(6486002)(6512007)(38350700002)(86362001)(83380400001)(36756003)(6666004)(316002)(8936002)(4326008)(8676002)(6916009)(41300700001)(66476007)(66556008)(66946007)(44832011)(2906002)(5660300002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gSZxQtC2VFP82cineK3K9Vy3qL21mjT4VOeAWcw/dPvBwjtbSbdW15ts8mBd?=
 =?us-ascii?Q?WmdXaI+SdPurIGjXqkhAL5D6vaPCQMUW7baBWxpRIDX0RawygxRuuJVyNdad?=
 =?us-ascii?Q?tfwL47OePWzBk1xxhmuJhzdUsQtWIaMIQtMO3XUHpUV5u94wwnKfXEaCh0/W?=
 =?us-ascii?Q?kdOY9hGw/c4huSaNh5FQalxaXY8HC2NW4+VqFT4W3c4We/+ycGWMw43GFLK/?=
 =?us-ascii?Q?ZDmpZ8tItVnXQyCyCovHJCbNDmdj92tRFp1pgcjMuyqUzcq2Hp+bTwpA2Xtn?=
 =?us-ascii?Q?1dnSxOlGhW3/fHioINHPto586DRPOigrLXuVQY5SnSBGaYWCeoENrLd1CWy5?=
 =?us-ascii?Q?zWxcxX2+YpRx3ZLp99L8ptc55j7yhRNmPyICEyQxJZbX6dk+whufNn7o0G41?=
 =?us-ascii?Q?AfJleGrzOEZxRVwjznjzE0QjhXg4iOM64kg5g0VIc+01GLwtRMwteHDXsuCF?=
 =?us-ascii?Q?pYSzVWM6fLN0ilg36A+Iclah1Rwdo8JJlq0puoyEqZ7pdp4RGDjukrro7Xem?=
 =?us-ascii?Q?8IzpnYj6/68DJ8SWxLIvKobsibwegIHWjs3LpZruLZDurj1OKylBU4JEe6YY?=
 =?us-ascii?Q?jBu5E0/+3xKxuJbdXhrtJStrWbM0f6bkLIedTynHTlYZxTIKf4SgrwfzpYk3?=
 =?us-ascii?Q?ZCn4YdtYMGuaKcdDOm1VqTIOU7+Pr87jU+xNXDnFKKworOJnqc2cJ/yCBdnf?=
 =?us-ascii?Q?O0itRUohnEiAWrNeIXULTEIolvy8faVqv//s3R/MABOgNHSWga1lARjlKPsx?=
 =?us-ascii?Q?+/wu0Itn5j1tI0bnotCARHlm/aA27jOX46YOy8tHdEYyUHPeVX5tK62wJXXQ?=
 =?us-ascii?Q?Ql80xI0CT+WH8uDQNiqrYatf1ayP777EyNAyFxW11ADzh8cDKBmlN/0c35wr?=
 =?us-ascii?Q?BpKHwIQKEXHfkWWiQI2+CWFFBWScTg4xrLyoFqsjHp9NxgPsgXum4ZjvP4eG?=
 =?us-ascii?Q?DQQDoFWK11ZtVypwKzWBoktY/4ZLpnqdAM/+ajgK/h1L7LAgLoSv3j3pPMnU?=
 =?us-ascii?Q?eH7rpCxT2fO5SSDNG62UqAa/M0cbW57ZZuG88rMHUF11rfR4sb1/TVl5c5Sz?=
 =?us-ascii?Q?5RD6QXotTBp+9dHeyH7IUoTFOtckPwJ25SlwZY8x62oXaG3QX4j6sJTfl0wA?=
 =?us-ascii?Q?ZM1Ns5Nspe2FvFf5EoufJHu/cypOKPagxWnE0oUy0uuwPtgOa68UZ3IVJn5Z?=
 =?us-ascii?Q?uvplZA8sJAQ1HFhf8VLYZ15XTvUP587ke1wAtvBFkCcNSVFVmJSS4Z2G274f?=
 =?us-ascii?Q?ACwxJHSEJGoFkMhjMwilQZ2Wby9BcHy/Vemz87jHt8FW28QIi+PXoOn98IjV?=
 =?us-ascii?Q?83cd4gHwyRjwfP9D4Y2utG1ikhpbsBItFPa/6X4q4XhVp/XOELzc40FQPgyZ?=
 =?us-ascii?Q?gaPuDsJ65MsI2RuTOWcqvOm5HrCpr1N/TeqdryP0EzQAYcuYVpAYV+GbNoNJ?=
 =?us-ascii?Q?9cnQkdJm/oJUme0FjH6qPcDwTijce1F47knKtgvU7aFQoq+1nyJelN8B3v/V?=
 =?us-ascii?Q?lFkoVr8BRdsevVBBEJW8Lmaz0Sbbz7vhWtK8L++8Ijl+XZOux1l7cNS2aeiQ?=
 =?us-ascii?Q?0wkUGcnh85YWjEr7TRSe0O+WhpttmlaCCbmJRKRRemxgQWwxuRsd9LS8Zw7I?=
 =?us-ascii?Q?eDZa/DH1U6mZaGomKSm4Nig=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87f65909-4eb8-4291-6345-08dbc325aa21
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB1931.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 08:57:53.9985 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uY5MHj+a7QiiS9fooo8ZXHvyHbeA2BG6JNp+tzLuVTARHARojqUPEfYJZaPSE8M+uAWhKafuAvgpugaxPcSwFzcaDW1jDD+4Rpry8THr/zw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8273
Received-SPF: pass client-ip=2a01:111:f400:7e1a::71c;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
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

We will need these functions in parallels-ext.c too. Let them be global
functions parallels_mark_used() and parallels_mark_unused().

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 22 ++++++++++++----------
 block/parallels.h |  5 +++++
 2 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index 8208c0bc1a..adb43a7069 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -178,8 +178,8 @@ static void parallels_set_bat_entry(BDRVParallelsState *s,
     bitmap_set(s->bat_dirty_bmap, bat_entry_off(index) / s->bat_dirty_block, 1);
 }
 
-static int mark_used(BlockDriverState *bs, unsigned long *bitmap,
-                     uint32_t bitmap_size, int64_t off, uint32_t count)
+int parallels_mark_used(BlockDriverState *bs, unsigned long *bitmap,
+                        uint32_t bitmap_size, int64_t off, uint32_t count)
 {
     BDRVParallelsState *s = bs->opaque;
     uint32_t cluster_index = host_cluster_index(s, off);
@@ -195,8 +195,8 @@ static int mark_used(BlockDriverState *bs, unsigned long *bitmap,
     return 0;
 }
 
-static int mark_unused(BlockDriverState *bs, unsigned long *bitmap,
-                       uint32_t bitmap_size, int64_t off, uint32_t count)
+int parallels_mark_unused(BlockDriverState *bs, unsigned long *bitmap,
+                          uint32_t bitmap_size, int64_t off, uint32_t count)
 {
     BDRVParallelsState *s = bs->opaque;
     uint32_t cluster_index = host_cluster_index(s, off);
@@ -249,7 +249,8 @@ static int parallels_fill_used_bitmap(BlockDriverState *bs)
             continue;
         }
 
-        err2 = mark_used(bs, s->used_bmap, s->used_bmap_size, host_off, 1);
+        err2 = parallels_mark_used(bs, s->used_bmap, s->used_bmap_size,
+                                   host_off, 1);
         if (err2 < 0 && err == 0) {
             err = err2;
         }
@@ -323,7 +324,8 @@ int64_t parallels_allocate_host_clusters(BlockDriverState *bs,
         }
     }
 
-    ret = mark_used(bs, s->used_bmap, s->used_bmap_size, host_off, *clusters);
+    ret = parallels_mark_used(bs, s->used_bmap, s->used_bmap_size,
+                              host_off, *clusters);
     if (ret < 0) {
         /* Image consistency is broken. Alarm! */
         return ret;
@@ -390,8 +392,8 @@ allocate_clusters(BlockDriverState *bs, int64_t sector_num,
 
         qemu_vfree(buf);
         if (ret < 0) {
-            mark_unused(bs, s->used_bmap, s->used_bmap_size,
-                        host_off, to_allocate);
+            parallels_mark_unused(bs, s->used_bmap, s->used_bmap_size,
+                                  host_off, to_allocate);
             return ret;
         }
     }
@@ -865,7 +867,7 @@ parallels_check_duplicate(BlockDriverState *bs, BdrvCheckResult *res,
             continue;
         }
 
-        ret = mark_used(bs, bitmap, bitmap_size, host_off, 1);
+        ret = parallels_mark_used(bs, bitmap, bitmap_size, host_off, 1);
         assert(ret != -E2BIG);
         if (ret == 0) {
             continue;
@@ -925,7 +927,7 @@ parallels_check_duplicate(BlockDriverState *bs, BdrvCheckResult *res,
          * considered, and the bitmap size doesn't change. This specifically
          * means that -E2BIG is OK.
          */
-        ret = mark_used(bs, bitmap, bitmap_size, host_off, 1);
+        ret = parallels_mark_used(bs, bitmap, bitmap_size, host_off, 1);
         if (ret == -EBUSY) {
             res->check_errors++;
             goto out_repair_bat;
diff --git a/block/parallels.h b/block/parallels.h
index 3e4f397502..4e7aa6b80f 100644
--- a/block/parallels.h
+++ b/block/parallels.h
@@ -90,6 +90,11 @@ typedef struct BDRVParallelsState {
     Error *migration_blocker;
 } BDRVParallelsState;
 
+int parallels_mark_used(BlockDriverState *bs, unsigned long *bitmap,
+                        uint32_t bitmap_size, int64_t off, uint32_t count);
+int parallels_mark_unused(BlockDriverState *bs, unsigned long *bitmap,
+                          uint32_t bitmap_size, int64_t off, uint32_t count);
+
 int64_t parallels_allocate_host_clusters(BlockDriverState *bs,
                                          int64_t *clusters);
 
-- 
2.34.1


