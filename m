Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA32B75797B
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 12:46:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLiCK-00021E-CD; Tue, 18 Jul 2023 06:44:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qLiCI-0001zb-0J; Tue, 18 Jul 2023 06:44:50 -0400
Received: from mail-db3eur04on0703.outbound.protection.outlook.com
 ([2a01:111:f400:fe0c::703]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qLiCG-0001xm-Ej; Tue, 18 Jul 2023 06:44:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iYH4WgUVA6Mf9xIz0/uzwmY70u0iYtHnF2P4+VeYlZC3xMDVRJMqkp73cuYh90+XrWy2Xro07MC2bIYLgxcSkdx/56XzQNBdEzcLZXTQnSSOJQwCnRlxE6OHd6LXyxasOu+t1rBR21iXIZOSopWkjXhj2Vw7dekSSF/PDCCNBbUUigojmZAt0JlfS12ge20CiEXi0zoyzQ1/+22FDBXTh3CXdk9pv5+y+UzXCtCXYnTac/iKr6jpwjE2Fw81wPD6LWVDnQDGhgwGCAn46aZV9O876BQOZ5QNrV76n5BPNx+QR+h3KmPMo4t79sqkQsrPdCudgxtcTrLWz+mx6eDHMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Omio7khsQfaVO42vuev55B+XfAfSpsQYbNkUeuTdOg8=;
 b=JKW59SmOCFoC5mbzILhdMafxApK0nvnEhPVbPqnhMluoT98w1H4tZvb4nwHK2nCz/6pGboQOYHVNRcoGfVMcC4ThDiFeyJyK4MvYpK5MZLeJzW+O+l0YTVslRb/Zgf7lqHQcqhbysklI1dYwW7Adi6dbNL+GPGZr5D64u2/ZQPNV7sLJN+pO9svsm7bxxiu9dfrSu50X8BJkGslxUMEfjSzabXBP8V8m6na3Jz++sDJVe9E2vEW2U5IW/ik4mdTvDgFk3qlLn4UktvugoLNbjilIbM/1NhUim+6J3wFC55XjHNl19SrP6rnbjzh/wc9G65Y+obEIYYmJkV5u/glncg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Omio7khsQfaVO42vuev55B+XfAfSpsQYbNkUeuTdOg8=;
 b=GoUrcyrkGL0mGh8ToS6a9rGKLXuvGxX3xF+odIBEhqOXEgoBLaSLiq+S9qw4P5hyco6HAj05khhHHt86sXIueVpRjuoBYwFGCJKd+japt/v6N5SDb6quKj/2f/Kx36CQy5rHhtF06ncEUe303GJjaLPvFHpKA7fTX9yJ7G0JfiySOAwrYVuLFIqDDgW9k0s6e9rT9tjhf8//13mtGEkf9s+ytisGuOC0PM5P3FSgEtdgia0CzAdUpMIXSgJ6DrNhqgEGE3PubzwLNmENjeagmeV/rQUK7d/Xya9Kw/OLX0b6s40Q9s4rM5KN8XcpZjKgxsQjvXFp/o9mO/IEO78+bQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com (2603:10a6:20b:402::11)
 by PAWPR08MB9784.eurprd08.prod.outlook.com (2603:10a6:102:2ea::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Tue, 18 Jul
 2023 10:44:40 +0000
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::f4dc:6db6:8d7b:111f]) by AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::f4dc:6db6:8d7b:111f%3]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 10:44:39 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v8 01/10] parallels: Fix comments formatting inside parallels
 driver
Date: Tue, 18 Jul 2023 12:44:23 +0200
Message-Id: <20230718104432.1130469-2-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230718104432.1130469-1-alexander.ivanov@virtuozzo.com>
References: <20230718104432.1130469-1-alexander.ivanov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0202CA0001.eurprd02.prod.outlook.com
 (2603:10a6:803:14::14) To AS8PR08MB7095.eurprd08.prod.outlook.com
 (2603:10a6:20b:402::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR08MB7095:EE_|PAWPR08MB9784:EE_
X-MS-Office365-Filtering-Correlation-Id: d895f593-8ff9-4671-2224-08db877bfcf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z2pTxughYmgCy7OYxa6CPQU+KrkHmwY9rl+bQLmwejHkV5+Yp9UyWrFhBfX/BvmPOoFvQ/P7v8VoMlFuKNItID+ewAZG4TBRnOtVK5vw0Opk2roPLUjjOh+8uTu6vAJmuKCN7FNHdeM0hG7rtEV8W6R4Z9qa0Qp71OLQ/Ak4n+FHzJEmTlq9IV28RErQlWa2NMSRGZ0vppk8k3jMfmuwp12VAsoC/7CAsX/1lS/IDTFok+fIZ7vD/ycvuZj9JXEKN0xkybLVNbJiBmRsUHdUi7VzzpA6e+PxQbec9JgfIdmQcs5RCPho+sNhbLA9tHuvHSQ8OwSSnjhvVNET051L1/bSvkkMsjYEQfN0VA8BriHmFYhdJwhrj5mx70ZiExu1IjCvcQJAFi6zfXaVTjC9izps9CdAdMn70vk67yIJhOF3zz6euweivEz/iVIMaglLNzfdbtK0ZsVvrXPmfKt44+kzUaG29yjtKCNIKOxTwWqFVXAo44gBzboCz7eFNmILM/DWi/I7cXtHPtm9+HK0YKmDUZYe1GKCMFCCgO9j/i1W7VPcC3wJAj4m6rQC6qb/57sWM0akCqhMuQ6MZGAssUndB0Crdw4763fEOdTrc0FE2E1Q2wOsBQ2UhLWnCPh1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB7095.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39850400004)(136003)(346002)(376002)(366004)(451199021)(478600001)(52116002)(6486002)(6666004)(1076003)(83380400001)(2616005)(36756003)(86362001)(2906002)(44832011)(186003)(26005)(6506007)(6512007)(38350700002)(38100700002)(66476007)(4326008)(66946007)(316002)(66556008)(6916009)(41300700001)(5660300002)(8676002)(8936002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yRHfSMAp2WhOw28N4Stbc3ecdlUZjKlqhRomYEnfJnaNG7EBkAvNyxGJEM1k?=
 =?us-ascii?Q?zSBNGh/NBLC/va7ap9Xe2NV87YA9DyqVYQzPXvFSh8YBNZVA5/HP5sTLm+Di?=
 =?us-ascii?Q?/hH8nFQeLnOGyrKC1lmU5bamiIFBRNPiXfK2RKIg+kvjO5hdnYRWhCJ8TLQL?=
 =?us-ascii?Q?j558gmr4C7xYprhFPzCwfNv7P1ttvtThmOa4oIFs0zgYSRFkOMR5rtqmW6vg?=
 =?us-ascii?Q?g65AMNGzs3geu9WjAzJGhLqgfwwQE+pjF6l13h1Z9WfjqeZC2E21O8qimXra?=
 =?us-ascii?Q?3ZGlN3xpf+9xIEw4MKlUEvQl46HhIrnvs01djOiGhzcos9/f3MiNURAMnU8b?=
 =?us-ascii?Q?nnEi2AXQWrruiOP4SBZ2RReIK9jE1kk5dDe/MRagZoJoUoYVJkRck1D9+to3?=
 =?us-ascii?Q?dUVvDxA+H5rWEqZ1clHarzViu2eP2q2Xy1x+Rb92MoKDl+WvT6FmOvAVwJlU?=
 =?us-ascii?Q?ef8n0ZEA35JTrbtvRjKwUmxMs7a3A5j//vQyIxnQV9xwEg7Q5dSaHaNd7Xxi?=
 =?us-ascii?Q?P4FuITK3nl5a433szXkofl9N6Xx9RLcHZ8ZokzPWpT2TGIrzaP6Qh0CDd8OM?=
 =?us-ascii?Q?BYnvOi2pjSUIB+pci6iFpObRI4SvJe4yfMtatxtcAnBvhf/aJPpdrB8vUKba?=
 =?us-ascii?Q?aW/gSQmlA7dtb3TqHZBg8sRUIFVcVPecDl959YbUF4aw3m8+B2GywQCiNnB9?=
 =?us-ascii?Q?zn1fjyYj+IDG01zxu3hYQDG2MbUqAYDM9p0jkseofaqk5qTBaVWO7tfuJCYn?=
 =?us-ascii?Q?zma3n00W+qvv+ENXcgps/D8+XoXtUbFDjvVifno57uwYqDamjCcC5coJda95?=
 =?us-ascii?Q?GQbh5xosDukNTyy7mVjcZWJht8q7IV26ExkWts9Vi/lev1W+hYH676JBN4i+?=
 =?us-ascii?Q?wCcSPgXArkrZ0g0Xj3ETRUwmoLoUgN2HhiYQk2lB0dWwi7sdoHs/VV5aAPrh?=
 =?us-ascii?Q?QWmGAMKZKRrb4qvPYvsgu7o4I6vD2yEGTPsHkLjJURC0PmC/2QJsGmGVB6l+?=
 =?us-ascii?Q?OtwwawsyITAWd9sa/HvG3s6TO8i6nAd9xkELokVPYXgLECdnEoeM3ffVai8H?=
 =?us-ascii?Q?5gNSJQBS6DJWew9fTuFtC46a8nRK4UEeAa2gb/zkYrHNgBktjY3vT1yDJJj2?=
 =?us-ascii?Q?4p37Cu++rmrwaV3/sqI15dsRedJJcLeBthe0OzMz4joyKh9PR5mNQMk9FdZI?=
 =?us-ascii?Q?Ur1v0UCukVPqaRj3zHSjH6JHpO9QcjDTeKyhR67MV+1tgapdccwakJLoWA3D?=
 =?us-ascii?Q?dXfGegXqxwg73b83mLTqr7IUaTntHOcLLRdlXexALFGdh2NaXxS3y3IfEES8?=
 =?us-ascii?Q?I9PByTCgeZXxOcLIDyAEvkARz2dkqp1L17ji/wYLPCWCkKgiZtyJlXrzV48r?=
 =?us-ascii?Q?mmBVjNnFPEOJPoChtvD78LSA0hSQrh1JrQw6gMWbTs4fIWDZtHtYt+lrUUid?=
 =?us-ascii?Q?ZWRW9G0w6nv9RLaHSF6SY/CTPLeL+/3Ulk1RmFbX8rsWJDbGdUgMv00hJCDb?=
 =?us-ascii?Q?hp2rZqBBzM3utDFJ6WTvcXH1bawyLSn/ELanfwOxMkygbMaTjXESQd98sp8p?=
 =?us-ascii?Q?losXJMmBX0u2OxL7IqBjy+nyktSHTowWjcV+h0sd+Dhsj6HAIXy+nNawpA7s?=
 =?us-ascii?Q?93CulE36l3e8IF8JdwMVhWE=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d895f593-8ff9-4671-2224-08db877bfcf5
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB7095.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 10:44:39.9091 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: reprq1rIFO80FdTzIea4XKqxHMnBjy3MJTRuIjog6I8Ajt6mHORx4e7JrhtenPdKGK6j0yqlGjXsErfZzx77DTBjwVVh9FcQqBM98f2Rxe8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9784
Received-SPF: pass client-ip=2a01:111:f400:fe0c::703;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
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

This patch is technically necessary as git patch rendering could result
in moving some code from one place to the another and that hits
checkpatch.pl warning. This problem specifically happens within next
series.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index 18e34aef28..c7b2ed5a54 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -188,7 +188,8 @@ allocate_clusters(BlockDriverState *bs, int64_t sector_num,
     idx = sector_num / s->tracks;
     to_allocate = DIV_ROUND_UP(sector_num + *pnum, s->tracks) - idx;
 
-    /* This function is called only by parallels_co_writev(), which will never
+    /*
+     * This function is called only by parallels_co_writev(), which will never
      * pass a sector_num at or beyond the end of the image (because the block
      * layer never passes such a sector_num to that function). Therefore, idx
      * is always below s->bat_size.
@@ -196,7 +197,8 @@ allocate_clusters(BlockDriverState *bs, int64_t sector_num,
      * exceed the image end. Therefore, idx + to_allocate cannot exceed
      * s->bat_size.
      * Note that s->bat_size is an unsigned int, therefore idx + to_allocate
-     * will always fit into a uint32_t. */
+     * will always fit into a uint32_t.
+     */
     assert(idx < s->bat_size && idx + to_allocate <= s->bat_size);
 
     space = to_allocate * s->tracks;
@@ -230,13 +232,15 @@ allocate_clusters(BlockDriverState *bs, int64_t sector_num,
         }
     }
 
-    /* Try to read from backing to fill empty clusters
+    /*
+     * Try to read from backing to fill empty clusters
      * FIXME: 1. previous write_zeroes may be redundant
      *        2. most of data we read from backing will be rewritten by
      *           parallels_co_writev. On aligned-to-cluster write we do not need
      *           this read at all.
      *        3. it would be good to combine write of data from backing and new
-     *           data into one write call */
+     *           data into one write call.
+     */
     if (bs->backing) {
         int64_t nb_cow_sectors = to_allocate * s->tracks;
         int64_t nb_cow_bytes = nb_cow_sectors << BDRV_SECTOR_BITS;
@@ -864,8 +868,10 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
         s->data_end = ROUND_UP(bat_entry_off(s->bat_size), BDRV_SECTOR_SIZE);
     }
     if (s->data_end < s->header_size) {
-        /* there is not enough unused space to fit to block align between BAT
-           and actual data. We can't avoid read-modify-write... */
+        /*
+         * There is not enough unused space to fit to block align between BAT
+         * and actual data. We can't avoid read-modify-write...
+         */
         s->header_size = size;
     }
 
-- 
2.34.1


