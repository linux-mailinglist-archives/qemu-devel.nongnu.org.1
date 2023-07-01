Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C553744861
	for <lists+qemu-devel@lfdr.de>; Sat,  1 Jul 2023 12:09:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFXWh-0001cH-J4; Sat, 01 Jul 2023 06:08:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qFXWe-0001ac-RY; Sat, 01 Jul 2023 06:08:20 -0400
Received: from mail-db3eur04on071e.outbound.protection.outlook.com
 ([2a01:111:f400:fe0c::71e]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qFXWd-00076K-4d; Sat, 01 Jul 2023 06:08:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=isVBw38ihEsoSb6DiVJyfdeudfe6drVhkBfdOAmeD4E4DwTWOL/44ay4n9/RkfcpeecrctIiz6kGXwWrZJa1eQsWYzL4a0Ah73tsRS7SRe20LFZkZ5sMzYO9zLZXjeOooPOYlDhjnMqG0+jZEE1LoWkIJpMdjWjffDi0jNOxhA3XD/Px46/u0FhXzKIPBhZkiP26gHH9pMNi2EaGsRLw5c9OaHqwkSrNSs7K1O+d+czQzFch6W4jVrnDuu/DvUE7lsTx1wYaeBTonnqn4grMmbTeccMrWunoevCFT2vARTrbn/OoiOLuRasWQo8p0YixeYy0I0Dz2bVDemnXlBP9RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U3BcdPQNdG3Nb34lNGe7htFHPepO6EN9GIGkGd7p1KE=;
 b=m86HnZvQPrzUdkGEDEL8bddQa4o9h0otFRjgBbbA9nDtq8JkGPGbpAVggord5utFSPGqtjbEShHGT1YW5q2MFD0H9tAzVgn+z8ftJ5OI+M7l5OeZAvJhtJ44VNOG0Al+mN9VosJ2lXm4gqyv0RFQe0S+nzYO8Dvsu93/r0PylvphaV3O0YJRdNe9cyXIrFdf5I5YufPFXp6Ju4+R9C8Hwi2Qn9ozgk/hD7aXTN3cervgrBqcfMJOqwSXMo94PR7DjZnf+lx2yw42mcTfeRlejzzWnbKUVusx2p389QkEa7wck0A/90Tt6gvbFCUaU/yLejYNT1J+Cb6MaiG0sai6mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U3BcdPQNdG3Nb34lNGe7htFHPepO6EN9GIGkGd7p1KE=;
 b=lQ2kg5qL9IWV3UwiDergzrUi+fd4qlTd40eG55GNGH4y/bgkD4Cr8cLVWSQp9tyN9qkVKfJnedvUFfCAZ/oXgpahyJqCE3wy0bAH8kbwBV+C6zm5eRlm3KW9cozvb1pFs+W9jEkEBbad9e1sB3YpgAkVNtQob9fWTaHzoKwHRKn+Qpqah9sgwQkO5ij2fESP+BbP1s68lXvAksxRCjc4VR1DO6eZ+UvasgNVAF2RHjtn3j8HEtEjODgCvivpEmESK2XaSf27UIfaPT/IXVanaKFZzbnjWkFTK/jHAM6QGm8q1WuBgjNaIL/VUB6NEFuYYF6icEAX59PRAzCq6yQHCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com (2603:10a6:20b:402::11)
 by AS2PR08MB8832.eurprd08.prod.outlook.com (2603:10a6:20b:5e6::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Sat, 1 Jul
 2023 10:08:10 +0000
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::ea9f:354c:ea46:3243]) by AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::ea9f:354c:ea46:3243%7]) with mapi id 15.20.6544.024; Sat, 1 Jul 2023
 10:08:10 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v7 6/8] parallels: Image repairing in parallels_open()
Date: Sat,  1 Jul 2023 12:07:57 +0200
Message-Id: <20230701100759.261007-7-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230701100759.261007-1-alexander.ivanov@virtuozzo.com>
References: <20230701100759.261007-1-alexander.ivanov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR10CA0108.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::37) To AS8PR08MB7095.eurprd08.prod.outlook.com
 (2603:10a6:20b:402::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR08MB7095:EE_|AS2PR08MB8832:EE_
X-MS-Office365-Filtering-Correlation-Id: b7758162-0668-4287-9ee7-08db7a1b1299
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: enOXJlISMhRh8RT5DCmy4ux+zq/OULtzCm3UBA4FoWSyezck5dzoQDDGc/GoW4+MZ/oTrvoPKGJaWE2nebxnXE6Dpg+tAsCGgsj4pO3nVyRIFWuCA42E6biqh1ImyvftBHrW2c4PCGPkm/sH1/YiirbzQ85DVtENzfSnEOIXp+Tz5b3jMfs9oGBbpTHT4CeKOrIyLSNJwwKHkzEivr0h2Nw34XNW/hSiIyPYLz88ijlkLDpO+sJceBXdjnJKmV8bmY3fr3y1UdZEO+gYmAnF4aX7XhpkctJfGgnwQT4mjcbn+rKyj2cWZb2EXl/kX7HfOA5ZEeyJgzF32QE6oramoNoe0qGLpzOaDvnGrWWfV3zhiJ87gyXmX1oegfuL+OhF5x8OGQ2DfoAECTp1hYcR0/xTiY7yFhTlyCXeV2+yOqPyKVens/QJQ/ybf2VRqQv2as4XfQs8rwcopyPVg0JwJLdCRLELjNuaEwvLa3+EnobwUm/6JT8lWaHpd9W83wbm5eo2VHMbTluFRylm4Ghv+638prUvP3/6Vj9WL9VpPpAayngCVWYj0y47fDAbDLOdELyJHla4naNMiCI+a8kNCXtIREujVHqe1hcvR6i071FsL9QUXr+9WT0bMY7ixcsn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB7095.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(376002)(39850400004)(396003)(366004)(451199021)(26005)(478600001)(1076003)(6666004)(6506007)(6512007)(86362001)(2616005)(186003)(38350700002)(38100700002)(6916009)(66556008)(66946007)(4326008)(66476007)(83380400001)(52116002)(6486002)(316002)(5660300002)(8676002)(8936002)(44832011)(41300700001)(2906002)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Cb2MtzPnAa9O5UUWZJ1Ah6jsEhJv3PNk0ZVUCamTGq+qcflNwRx6ge4L8UNb?=
 =?us-ascii?Q?tu3oNV78x/ej6Rh6tz54HaXwDFSdH1I3wYWFkAPu11nLTyXcp6mekgZqg1R5?=
 =?us-ascii?Q?tDnIOkQFNRXg0K27u9ek5SFYY2soB4eXpAr8NlKKKv1xQPrGWvaP5e99CF9N?=
 =?us-ascii?Q?CisJvPY8c3sz8DqV4/5JoTabN9OnJ42inpC+tOYf6lPP4BoaelrYxhzXiMoC?=
 =?us-ascii?Q?j88/OozMU3ijq+hyJwTBpnTGZadaD8NEK7T9xg9R+6QatDttwC2DnqQ9A/8c?=
 =?us-ascii?Q?a7xlM8dm+X5HcKPZRhGLs112a0oDLR0eAO6lk/sH6ahd+qPyzWL9HC9WXr3E?=
 =?us-ascii?Q?EYV2NIxLTQEcRS7HjwcZYO2iOqhyFM36jt3LhzQ9AcczWbZj3pL/CVRrcLOQ?=
 =?us-ascii?Q?TC+IPl8LejhY+X1rMXh/QNbNztxGOxGE2/cXkCKucZHfnmx93SlFGaqRf3Iw?=
 =?us-ascii?Q?CNOGB3koi0nLhf3Vu3WYmCpymg+LaDWMzfcRFVcMHy+/KFWOFDVOt9+H8HcM?=
 =?us-ascii?Q?r/bHi0Up0q3k+AhoH0o/dTweXJmYi3+BKNqdboG7XjSj6uIhn6MOxTHhKRT+?=
 =?us-ascii?Q?aDPHmSVX+p/0VXI5KtRlzgMOPT36iIB5LP3bFcfR04zALAAurdc86MKkFHTR?=
 =?us-ascii?Q?tQ8QcQvdTFQCVSu+qw+EPPzsWzO54xLq4fJ74tWzn/ydODkGr3MElxuayh77?=
 =?us-ascii?Q?sBnx5LR6OUZPQIckmI7klb1xsZlTD7Msm8gNzusCQPX82scV77nOSQKchUK/?=
 =?us-ascii?Q?6XX+U54BRWMOFD/ukBb1UdoJnz6PLh0gvT+V/e3SGig8PribI142Rsa9FZ4G?=
 =?us-ascii?Q?r08mVaRdL8ppQZhwExf15T6Jn+0NMfwtT2pkCnJcgjs15F/v6YhDMSMuaBfS?=
 =?us-ascii?Q?QXb5+dL6taLSOxQSwl/rn/NrfTzhpvPk2uDJBdy5sJk8xhooEqlho2skkpZ8?=
 =?us-ascii?Q?ttjS5TJqBX6uKimBLSnyD9v9qLdEYUzvWBcukrHEeWAnSflMm4zbQ0XzFWWz?=
 =?us-ascii?Q?R7F/bT2M4CH2/795gKfGkP0qPmq2iTZMC16L3nGdbTavha01rinrKmymWEiF?=
 =?us-ascii?Q?TNWCU1dl/sfPdmsMaPqXNxoBy7s8B772qmdDXvlNP/DdE1B96Jf8EBNYV2CH?=
 =?us-ascii?Q?w2DsdlmU1JzyFyW+5wM5T7ShLOSJYeGIf+FmngaRvEe166y3/OLtbhZ5b/Kv?=
 =?us-ascii?Q?QYsW5B/pveZbx60ngLfg/9YFSndNGcjkJnIAzOCwAuICcBdH/Dm5WYKhZvqe?=
 =?us-ascii?Q?QB1OJyCiVK3lK/ZpCaIgia8Nac3KwjQFEl6mT5EGD1dVTfPLD2dLE6ag923t?=
 =?us-ascii?Q?Q5WkcJGD0rTRobtCRaR1c7/aobkLUVUzZBH+qO/xv44NyOyxko+xmi1Ig8Pq?=
 =?us-ascii?Q?rxB+LSyqbfvsxY6vrRqBOV0LDjnLfo/4tTGF9+plNoWhq8nwfLVXTOUtkz/H?=
 =?us-ascii?Q?1Xvr/69dKfpnuntRCSZoelv42xDeIPeTkVoT8XP0O821snt0lIjPKaLfakIv?=
 =?us-ascii?Q?LBUbxdwNerjDLfr+2u4QIiVahtAr8iLLnZ+yvaBLfy4UVxXkd4JMtqrt3PQi?=
 =?us-ascii?Q?AmkIu1YBAX+66cP8l3ABWe/0xgdSYtJMj0+It+qZcg1oaqJKgIApvItbi3vr?=
 =?us-ascii?Q?v4wbhnMB/emte/SXLDq1FHQ=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7758162-0668-4287-9ee7-08db7a1b1299
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB7095.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2023 10:08:09.9568 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: InTQu6SLibfMZbnOWENouaqbq17fQH9w5MyG4H4PB2KXUhYPKuejYJcKmVVwt0PKXx1IYiasUr+Tug4Ip019CH8eAX9p43Eb0w/e+2C+wyY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8832
Received-SPF: pass client-ip=2a01:111:f400:fe0c::71e;
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
---
 block/parallels.c | 70 +++++++++++++++++++++++++----------------------
 1 file changed, 38 insertions(+), 32 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index 0f207c4b32..51fd8ddf5a 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -947,7 +947,7 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
     BDRVParallelsState *s = bs->opaque;
     ParallelsHeader ph;
     int ret, size, i;
-    int64_t file_nb_sectors;
+    int64_t file_nb_sectors, sector;
     QemuOpts *opts = NULL;
     Error *local_err = NULL;
     char *buf;
@@ -1018,11 +1018,6 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
            and actual data. We can't avoid read-modify-write... */
         s->header_size = size;
     }
-    if (s->data_end > file_nb_sectors) {
-        error_setg(errp, "Invalid image: incorrect data_off field");
-        ret = -EINVAL;
-        goto fail;
-    }
 
     ret = bdrv_pread(bs->file, 0, s->header_size, s->header, 0);
     if (ret < 0) {
@@ -1030,33 +1025,8 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
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
@@ -1117,10 +1087,40 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
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
@@ -1128,6 +1128,12 @@ fail_format:
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


