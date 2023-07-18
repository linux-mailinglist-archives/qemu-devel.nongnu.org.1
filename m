Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3EB757982
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 12:47:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLiCL-00021y-Ue; Tue, 18 Jul 2023 06:44:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qLiCK-00021b-AZ; Tue, 18 Jul 2023 06:44:52 -0400
Received: from mail-db3eur04on0704.outbound.protection.outlook.com
 ([2a01:111:f400:fe0c::704]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qLiCI-0001yi-M8; Tue, 18 Jul 2023 06:44:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZpACukj2booSeJg3ohyApqdDjqSwmzLkKIkpJbuFP+k4pdBMuO//ruQDwTpZ5i/7kCRSs1Q2c1NbnF9lOmIzWdUx/qk6zwzd1dFYb1wsihF6IpzFsX5ecWU0HeDAIhmBPBAaQY5eIRlrT/TYUs++tlw3SlzOt6QkeHVRCaRAxjsfXUZZmF73MF5OcQET5cZKTN02l8QGjmTjf5xtCH2EjhfWhKvoBiAyWjwZZp2dxVZNlfVfnSju+9nQ3G0/tJdoBOHcMO0Xd8gFQ62qrH/RPUjdUaNwyYdlSmw6nd1IsF8gPj8DF5P46dsaC6bGVMqVUqy62y7jneRIDr4Pa2BiXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D1RskmucYx0jDWELW0pmuzc4yCYxf7SoIxQ51ylVmUA=;
 b=YXuhZkjxbA8eD7f9DlScIEmzU5lljSOyb9DCtMPGU4bke/tctycYBadcL2tvIx8j7aOyUT8oBvazyYxDYLibiK4t5ER/wZcYoNAIwmRB9bvDQ1dOAFarsGVbOQngeFut0e4UxgppEKmbpRO4X7mSx9ELNaILmD7S13gXwHoWNddPeuSYjzhkE5CX541XfrlC3uOyFJmFXMWKaqcFZXfYIqSPFQE4VRdr/k6MxCScD2nKJmHADFnOV1bDGAAqigygcVZv14a3aHy3nXSj74l5oHh5fiS92X6dmRYwE/3Qyy0RzFb5PfEW9ytzgCz5569tDu/uMesC1Se3GPBDUROP5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D1RskmucYx0jDWELW0pmuzc4yCYxf7SoIxQ51ylVmUA=;
 b=hMOlVFFwWW85E4bU6izplKlww3/X6doB4HDtIAgg4h+vP31XL/xUuC9fLUNTYJA0gxp+aEfohxXvUBwPcuK+1Uc6mW0M8mCdzVy4GYob07stB3RU9idRSki2U5YwuZeN2AAXRFRYXBkPw731Rl8tsuPExwhC4MtrRtLbjlYYDpzVccMm2+hAUdq7QS5lZWI99yULm5Q3n9Wxy1MPbrDhQ2Mc7lXV+aKxBDFWwx38auxTGYt+0m0RKj0HBx6bA5WxS1yZHbfmQb3XvWL0CQCW64dIX0Yy3xnDZQoeGhfkvJ7jsqKvBr9yJvjK9WEXrLrLpbAv5h7f7zV+w/gFM8x2+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com (2603:10a6:20b:402::11)
 by GVXPR08MB7894.eurprd08.prod.outlook.com (2603:10a6:150::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.31; Tue, 18 Jul 2023 10:44:43 +0000
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::f4dc:6db6:8d7b:111f]) by AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::f4dc:6db6:8d7b:111f%3]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 10:44:43 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v8 07/10] parallels: Image repairing in parallels_open()
Date: Tue, 18 Jul 2023 12:44:29 +0200
Message-Id: <20230718104432.1130469-8-alexander.ivanov@virtuozzo.com>
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
X-MS-TrafficTypeDiagnostic: AS8PR08MB7095:EE_|GVXPR08MB7894:EE_
X-MS-Office365-Filtering-Correlation-Id: ae9e4011-f526-48f5-5667-08db877bfee7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mfN7wMUxTSTKGOnaeV30AsWwusnDHKl/+Lr19dDl69WYgbEbrh+nZYXwUIzEKRRyLrjy++fNOWN+UhAmDJEaqTl7MKfMGQ1iwp/36hOOiOQ/7yFEPSI1A1PxND9tq+7Uts+q4Eo8V8FnLoC+9xVkS+ay0ig21/8lC48eF4jqjZtrOS5KdBu0P5n8xZZdfFclb+h0T0MIBxzc3YQAciz5/7PUtVcE85ygG9nmR7DQHdTtvybtWZ8x5w0BIxzP1sbXG62TADwGfqMaJR6B16AhxxxhoQub8iedN47hmYohaL1KdpywZvdiR3hszU7TSENTAvaIpILxxMn8/tVp1k7kv3ORDXYpr4TVbyLqFK9QAvvHK/Pun/QQ4rDs7QUyouKBWbDDijK/2KbmIUmz/OXma1UVRtyd0H9jZ8KbUmi/fBY5KBEkxFlav/dhb3o22KVYbMEBIkRFgJTBQ0m9cXPHEf67i3egpMAyS9nmbJrFKTA9iVJdBO0hSZ/bPAoN0Z2pJUcQ8PevM0/xUNmZjOfJ/deGr00TuYp7gIB4AYpKMOc4tCKpAMjryXr8motgS9vyUcf1hRs/PBL7kj0OKJ1n+RsYgQhYieohbTRSA7BhYrHxAnbXixfZnGbNq1Eb3orN
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB7095.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(366004)(39850400004)(346002)(396003)(451199021)(86362001)(2906002)(36756003)(44832011)(6512007)(2616005)(186003)(83380400001)(26005)(6506007)(1076003)(38100700002)(6486002)(52116002)(6666004)(38350700002)(66556008)(5660300002)(6916009)(478600001)(316002)(66476007)(66946007)(4326008)(41300700001)(8936002)(8676002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HU4zOq7o4g7q2to8XYv/C/fgjxNIVOG9wTxGtHZiTGJS4JYYfPZu82ftcskN?=
 =?us-ascii?Q?surcQ5g/eFXCHzgT0iC5Sn+Z15dkT77/hIeYiGd+CC0GE7fZwV/eh1eRMMFv?=
 =?us-ascii?Q?qJoGp4bSXuceMbXUBLy+TsIM7jPY4FktDUQ4cQvO47efWY23P6DYIayYtqag?=
 =?us-ascii?Q?KpQlZ8gKx7G7FyGx3/XGXE4KOw+3Zbg03p9baxuNlIXIhz+HU8uPHfyR3GvU?=
 =?us-ascii?Q?j8na2Zsyk2LwPyLET/Q5UCL1VtsnRC4I4MH4gHIyDXMMRSk5BbrnJLgCHI7H?=
 =?us-ascii?Q?uPRgn2kcTKWZv2Un797JowNT8H5Gp21A9UJNEb5+SU67bmc7W54wJ85WNLEw?=
 =?us-ascii?Q?QLjf9KmVpMMytPT+3hesHXaQBP6XTCf367LYs+DkI8/Ucyew9tf1xVJjgDfj?=
 =?us-ascii?Q?8xwapBxTaiwKDsSziUcoTBq/u9Rc499m/O6q68YThaQL0tgRuZ58xQJVZPyp?=
 =?us-ascii?Q?s07yEP7n3lnPoDR0h2a56QG3VprQJgUGavthG0d0c3s+jWLNeK1bA/PXElZW?=
 =?us-ascii?Q?87kNx4VUneOaue1sqrAS/Bzv+1UOG3eCnyotW5NOhVLGD1xAWQhuthVk8N8O?=
 =?us-ascii?Q?yjV+2kV5RZVvv3zJ3p+mWeuccELJd3RileM/A6ydNibvokIw4/8awim7O4xI?=
 =?us-ascii?Q?nyIBiM+4oL9TjItz+aP+NCJutKlMfbgvwIahI07XaTqTA/FF9/8/hPjyg7JM?=
 =?us-ascii?Q?pFAynOn0WbH9vJv+yqmAVuJbe9oBI/qTapopZSX+xPG5K4PyIh0RkLZjWHnO?=
 =?us-ascii?Q?pXAnc83e+6BoMvdz5usm4fp69rcVMbmqKTExtV2xxadIbOoWrJLAa1zUO+OI?=
 =?us-ascii?Q?+XqraSe9umxEpT3Abypj6ROu+wuYrwQ/ZZg9WIuoi24ez8YBUPy/ksZ4qSQf?=
 =?us-ascii?Q?abhszoiJZWvDI4D4MvD42uKNzpA4WC0a0c+CpEUTOF7HkhzSzczk4vE2QZ8B?=
 =?us-ascii?Q?3B/NxnDEVh/aG7+4GdoyKWPlrTCtvqhSLQ4ITth0LRU7OMD+OorlH5h/RMPw?=
 =?us-ascii?Q?5xk1spk8jtv+xL/lGa/AS/Vj9SM/BS05qumXuyexSScYpdTXeChoOD2WLgYf?=
 =?us-ascii?Q?cluy527Sd7vtkUaI0o0SAdkOecB9epDoeuEW18I72u8j+ImpPFH9UKDW3iGy?=
 =?us-ascii?Q?tcSn3KNlbKdkr1SnODeKI+kFC52CoTqBqnkHUHy/UTwMXREj8dHjcKDJCbAn?=
 =?us-ascii?Q?sGFuVle26bkavYl2XSu+hSOe6uSbmEB0BzkABeN7r6mqbH1iOuXywiGZ9S/i?=
 =?us-ascii?Q?8WuH0hdH7foCplfMfEaaIMAQi8GxdXqcF/ru+dwPnntRLd7b2niMCeBiUqEA?=
 =?us-ascii?Q?O52Q8eezhZB+BpSZBtmaOD19GBxesT0Zs0GAmv0+m3keijYU0aLwUUZG6Jau?=
 =?us-ascii?Q?IlTS1u960CTHy9+9yrb0+jkHH+fmUcJjmidn8TYezuBVICpGOJjjyYK6CBkP?=
 =?us-ascii?Q?bw1EVqE0hdkNeVC1T4zBVCUfYITxjR0Sis2U+k3CrD+q6L2dEsXmG8fNrkA0?=
 =?us-ascii?Q?kMgr+LfldpjCpTom2LWJL24oSzxMB9wUDtf/2jcY6nDu79TC1jqqme76Hmll?=
 =?us-ascii?Q?OUo/v1h8FcV0lZ61h/Npu1xexg954ws4Aq/4u4sz0/dscU/On/FnxJ/D/hKl?=
 =?us-ascii?Q?P4BLTpuGkDVd30357b9UyIk=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae9e4011-f526-48f5-5667-08db877bfee7
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB7095.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 10:44:43.1376 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fqe/Z3wxVqacHXDsfJ5kGtGyeupbrgM1Jf6ARrg24Cw6ZB/m4JCgu6EBjf09TT4Vo+f75yZES+/hMDl+puTqmsAZU1vDHJ8ZkIPBBWVIcv4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB7894
Received-SPF: pass client-ip=2a01:111:f400:fe0c::704;
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

Repair an image at opening if the image is unclean or out-of-image
corruption was detected.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Reviewed-by: Denis V. Lunev <den@openvz.org>
---
 block/parallels.c | 70 +++++++++++++++++++++++++----------------------
 1 file changed, 38 insertions(+), 32 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index a78238eadd..5100c8f903 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -951,7 +951,7 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
     BDRVParallelsState *s = bs->opaque;
     ParallelsHeader ph;
     int ret, size, i;
-    int64_t file_nb_sectors;
+    int64_t file_nb_sectors, sector;
     QemuOpts *opts = NULL;
     Error *local_err = NULL;
     char *buf;
@@ -1024,11 +1024,6 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
          */
         s->header_size = size;
     }
-    if (s->data_end > file_nb_sectors) {
-        error_setg(errp, "Invalid image: incorrect data_off field");
-        ret = -EINVAL;
-        goto fail;
-    }
 
     ret = bdrv_pread(bs->file, 0, s->header_size, s->header, 0);
     if (ret < 0) {
@@ -1036,33 +1031,8 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
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
@@ -1123,10 +1093,40 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
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
@@ -1134,6 +1134,12 @@ fail_format:
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


