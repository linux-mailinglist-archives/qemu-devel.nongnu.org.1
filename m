Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7322981F665
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 10:44:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rImuJ-0008HF-L7; Thu, 28 Dec 2023 04:42:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rImu9-0008CH-Cq; Thu, 28 Dec 2023 04:42:17 -0500
Received: from mail-am6eur05on20700.outbound.protection.outlook.com
 ([2a01:111:f403:2612::700]
 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1rImu7-0008HI-9x; Thu, 28 Dec 2023 04:42:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gsuNWYmcKmT2pVXhIemT4L+P6HNdqrgvGAKJhtqAfA/CHCdBhgxhIOI4KvYkWZUkscGk03J6Z0JVrGf0PLDp1hd1BjZJuW2NCLRp7w6P3n90a+pE92DaZSdwLzza488UwBh6fNMToC9cpoO8lAFsHwWQnewuZRIdAW7lCVeObQ84GUyDQAKmMfJpBfBo94Bkul98KZ6q1SI5BU+PBDMiP9k0K+Wxpm1kIxexsHFxcqOH3MFv7TSQJOg6TcUlCh6c9RNX83y7ncY0AqfDKOXg/5AnpQe+qRHyYk5mIOrFriq9AL2VygMAF5wRlEOOZNrLVYfGTlrI9xoIQM+0TIHqgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e3JRRZLsEPXH1NNIs6vNbF/7zbteI2Z70fhLrLAUmgc=;
 b=T9w+6+PPtflXcfXtX/PCwBD79vwb2keMP4EQD50zH3p5sQKb0w2naKRDw1IzW+V3rdVAbmyUuZ26zvGH2pm4N0NT0ZkZ+1+f2V7P909hOupet5WmsbHu4IiKiIX5mItlYD2ZTAvZsKtAH1fD7FVer1FIjpzX/b+L1Weps5bTk33Mcp4m+QlL+t/8NJA2cFPAmIUb8TJhAWu2k3t1QNCvXKYkbwyHyF9MS8IFEIJAP5czyEt9kZ6Ewh+yZjIyB7evilNqfB0TI52ht78JdJZYWsYoCAgcU6KiqUlk0hK5U1BH0tLxFAnukZUWQDRsVVqWlnBMFo+Tk6G/0RckYcVKNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3JRRZLsEPXH1NNIs6vNbF/7zbteI2Z70fhLrLAUmgc=;
 b=jdBMzk1vXDZhzGy1jAgbUAdALgDBexx32KLg2P7UKM5H+ouPuIplff9OKKw/RJlSjcgq2WmxUcBqFW229DKR42EQCeIRCemMMfP0fFStBZiDuC76t7OKvpb52v8/FdEwR8XFIsotAW+wB2Y0PYNYR3U82OrA7Fd9Yp1rhzTXN02UdG2w3UXH4NYITQqWYuvhpJqTOEY21AK/QccKearqgNb14xvgfni17fBH7m/EXD3XXxt2s9mQEQ6rwU29jUOKpLqBP1o73wFwmiJzK1eVlTuePxNMYBVAZB/N6em1zLTiLO4IPn3AXAvD2c/yRtt115BwDpK+N3vUEAso5+yL9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by PA4PR08MB6064.eurprd08.prod.outlook.com
 (2603:10a6:102:e2::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20; Thu, 28 Dec
 2023 09:42:04 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::60f7:3267:9f9d:cdc0%5]) with mapi id 15.20.7135.019; Thu, 28 Dec 2023
 09:42:03 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH 10/21] parallels: Create used bitmap even if checks needed
Date: Thu, 28 Dec 2023 10:41:42 +0100
Message-Id: <20231228094153.370291-10-alexander.ivanov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 92795731-2f9e-431c-2a5f-08dc07893f4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4VlIWEwHETvWTHLGyR3XI0kW602uBv72tgFAKDNp87Y1fHupzada14GHswD85BaMPTadI1Z9YodsNOpauAl0RaVWpUb/lX25TsfI+CMd4CrAl0fzjkzHQq6/74zZh+BdV4AhfxYCrbhkyBefZ9pblrUcwTLs4FWs1OgvVOnUxFxplclvBt/b/ejZTv3XU4Lzv0CMV0l85SlhgRSLhH/kTiOgYVN510LyK/ofdaF0KNw3x94usN8RzF1ZnFQKEUkRJpY0wzrOgOsLyfG8A0WX7EOTVd/pSRQhdNy/gFnmj2DVpVaSvRaPDl9LWiJfytuxF/IOtbC6hT9FmpCgztKBu2P13Kggbt3/BkYJ9sW9dI1C1ggWwxhQeIdZ05ljLgMyu/IMD1LjKX+M8zX8P35rVCdFRAYFw0j77lFA6U7+rdZcG42ghcKae105AGmCtLaDAIkbQP1o7G5GZfCCNSGVHA/ulgn6IKS3aiDnjvXoudBPlwQ6a5obwayz+KXsQqIN2pyLMI/h1HPMoQwzmUmZcLuOaNhXuhwiEEvZ6cYDAmc5ZCR7kVYrNRKoa4mX88620TtN3mYlddAiBfqBmdvr4oKFqL3VJ+t0v2eOUOoPUm7UEfnDgq4aXAnoxCr6EvKT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39840400004)(396003)(346002)(136003)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(66556008)(66476007)(66946007)(6916009)(6486002)(4326008)(44832011)(316002)(36756003)(8936002)(2616005)(26005)(1076003)(83380400001)(478600001)(6512007)(6506007)(6666004)(52116002)(8676002)(4744005)(5660300002)(2906002)(41300700001)(38350700005)(38100700002)(86362001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aoWbd1VzvbiA0U4bTpyCjTJceTeVXsqr7dzIWmQhyjujjGA+D72fEBAJjeAA?=
 =?us-ascii?Q?ttuxwKo6O24jU/gp+7GMmRl9cP0b+qgr6UeLkjEQqO10BNOla6IUt2HfUblr?=
 =?us-ascii?Q?gA2jtaZIdHzhh7UZk0VTGsVZ3axAUO1Xt7gQDBVV97avuMI2/a3YNqQqSC6H?=
 =?us-ascii?Q?+fuSw/zUuRUyNrQZxMIgCjQW43qPDf6MrovdIwvLg8RFErD0iQZSr7orZCRT?=
 =?us-ascii?Q?DxJoM4Rz6fUzIgA71CUavWz5aFf4oud12fJyboEftF5NpGLtu1xf/jTNWpJt?=
 =?us-ascii?Q?fm2p8uze1OTex2DOL2n+ovp7dUzbfA1wM2Bte/rxVXVhLhPjv0cyn1EoP6KI?=
 =?us-ascii?Q?Gb0YFOkt/2+sFHXOZqL19hft6RheYSwdHDKYNW4CsfvAWuQIRKEaCjC3zKaM?=
 =?us-ascii?Q?0BreVm18++ZTEkRT1c1Ku05j93T4qwK5MbNFZbB1uD0AUZAM42qndrcuAXgh?=
 =?us-ascii?Q?VemzYyfh1z1LcLs92Kb7kwpGeX45dTUZ9Ew+/OyhUCGZ0bcEKIAvY9A9onDU?=
 =?us-ascii?Q?IlGBm2Inqk7+haopNYCF8A39jPrcqkMOsbewemaLUJoV5CAolEqb9D1W8IaK?=
 =?us-ascii?Q?O60wDdbscNIrMMrxhOHHlJY5VkzloWb0CSiEjWGIbhGsODWsmI5wvhGlcgYv?=
 =?us-ascii?Q?oB5pTJ72EYXC4ijrovioD7asOGGoO0VHNkq4F0OnNIe0pq3Qb6JyXCxg+6gw?=
 =?us-ascii?Q?10EjWm2qsx+tMgKen1zzm0ghJMZeWuR86MjAVo15+2hQBbn11FLAOkG+pI3g?=
 =?us-ascii?Q?oniELDsmR2fyHHvswidymdI2aZcPrUBhGp1cZTf6VKe5iU2T4PXkHTNdqZmX?=
 =?us-ascii?Q?Dvi6kdyq9phzS8rykw5tIHzJBCq6GL+9KU0oo4PJrBVyWIPZUVGDQVYY0EsK?=
 =?us-ascii?Q?o3cnuTfaGJ8RRRXGovKnkfkDhSWFWO8bKBdQCyK2PbS+Dwvt7aevBa6C/zaq?=
 =?us-ascii?Q?lGya90pvxF4in/seybGysXLk5jSrrFUeVWEPzp5oqSHdqyvZtAaqrQzwVHGm?=
 =?us-ascii?Q?Tz7ff5NdH08rPlHUPPoXAkJ4M7uKowPGJ+kLXSywNna/y21hCoVy76S4UxkG?=
 =?us-ascii?Q?wxrW89VE9vNMCgFY+AiYmr0nK1z2ckddhWdKGuG8zu89V6TqT4r7IjC8IZ+0?=
 =?us-ascii?Q?2Thk9Ne6AKTB3ziJBHATQYRI+ly6HvSNCptiHtxopHYXiwWT/z0kpwSvRth+?=
 =?us-ascii?Q?98bEzPYZYc+zGOgpmeURPEVsZmyVCeLOIdlf4jmZKS5dAOovv2Evo9ggQiHO?=
 =?us-ascii?Q?jLydS9dAY0x6qj8mfHx/9RjOVX9Cm65wVmInHSSh4oZXKEmX7mSF8E+/k7zx?=
 =?us-ascii?Q?jS+xx7b/T9ZCLAO4HhYUpshJDeOiwbO4u2BIde8TqxbqokIAMrSr6ihZZzhB?=
 =?us-ascii?Q?e8nE0ak+g0j6qc+j/IvWkH3IW4vSn3xBtK5dKN9MvMAWd76rx3DLmcPXUTeb?=
 =?us-ascii?Q?Uk4giQDlwH8Cs8G+JStRTq+zd4bWswp9BnRFIhGdT6mo0/ahAuEWrqAbWTb9?=
 =?us-ascii?Q?5QSNKr7GluGiM49XSrZkuJbTAZiImaPB2+MbSZjug4VwfMQizwSGfqOrqd79?=
 =?us-ascii?Q?8JXMiTYJzC93vYEVm962foulqxDJqCYBv5aqHU0eEf62bOPVxcb5GnfhyLFU?=
 =?us-ascii?Q?Wvcnr08po0oEpvGzIXoc4c8=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92795731-2f9e-431c-2a5f-08dc07893f4d
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 09:42:03.4671 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FDq4+2nPfwQ3/07dgMl7hSEOt7bmK3KwDqEaPPg+uYsw9CBFGWYaLKjyZBSLZneN/wrjMhUaYPwl6os50i+sIddRRgjf2EcsOKVbXj9/7V0=
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

All the checks were fixed to work with used bitmap. Create used bitmap in
parallels_open() even if need_check is true.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index 0ae06ec0b1..f38dd2309c 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -1421,13 +1421,11 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
     }
     need_check = need_check || s->data_end > file_nb_sectors;
 
-    if (!need_check) {
-        ret = parallels_fill_used_bitmap(bs);
-        if (ret == -ENOMEM) {
-            goto fail;
-        }
-        need_check = need_check || ret < 0; /* These are correctable errors */
+    ret = parallels_fill_used_bitmap(bs);
+    if (ret == -ENOMEM) {
+        goto fail;
     }
+    need_check = need_check || ret < 0; /* These are correctable errors */
 
     /*
      * We don't repair the image here if it's opened for checks. Also we don't
-- 
2.40.1


