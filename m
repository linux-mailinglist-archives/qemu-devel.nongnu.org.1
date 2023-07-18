Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 854A075797E
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 12:46:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLiCS-000282-HP; Tue, 18 Jul 2023 06:45:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qLiCR-00027R-6W; Tue, 18 Jul 2023 06:44:59 -0400
Received: from mail-db3eur04on0704.outbound.protection.outlook.com
 ([2a01:111:f400:fe0c::704]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qLiCP-0001yi-KX; Tue, 18 Jul 2023 06:44:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QO4eXZP/ceO5vMWBCYOw/p7CN6YImqprl9HRAKBmv99cB8yjQexZIOxLLWny4S7NsmAcLUbOxHBErPO2lXGvtCY0a8pMH9WPP3yN5M6cXyELMvHd5/hQngsiuIJbChUccnhxoUFoKXheSrm0wY4W6QQZnTkM4wld03Ijlm6CjvQbt6Vc3VoPtj2HW99E/D6ruOAr0x9o1xchyd+7F1ym+gw2B15VQQQ/CebRNR2cm/WzWEl5yCMxcCCTQYbdcsiVwn3Hcge13NUg1sIOuq1/uhxVPNmrSFOIani6TJahTSWxFRh5iN+PtvhfIcjvlcGRlXh/ojQpMpmmpEYZ1oB9Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7BPX9ZxvIk/vuOmfPWHFCN4M3fikoFLGEUDvVWdKPNU=;
 b=WzeH+YYnuq2Hzm+v5ULNDJ0sz5PbTR47e3T83r0+8yCx+ji2KpgNrdGr0Coi6MuEZMv38BjzjOtlDYzt0u8Aoz58DBtLDKHsd7TpqQUSyoRwuTyKd0ab1kX+ZpLftx1VR+msQWpcwLvZPDzIm3wlHySKLRgyYVb7kErxQDRuIj6JpSQBOA/t8pGZiZlZ1IzlHSFXttEqu9ZcPlz13LvAYf2KvToNhrno6SmYMc8L9Owyv09UMTg5+H1cMVvm0GUqUhzw8wijEObi1MMPZKwKv8FkElEp4raL86IRK6vVrtmNfSPzyB5puf+Gb6KBll7nwQLWMPdUfVLlfgd4kc5yMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7BPX9ZxvIk/vuOmfPWHFCN4M3fikoFLGEUDvVWdKPNU=;
 b=E4BjxyaKUuEbkZn9XO0SzfxuWDSSzVyYQP27gaRxxnLv6dqy7LKtWZ3hvI/xcXDTi5GqQaSdxswd8q9elAu8+zuNOp0x7BVV7zmR8XnSnlKOr7dmOTlUqcAxUz1jh7PtCaUXOMXtHsVqDD9tSpOoUrBrN4ipnG5DRoKEcrSMe7kwzL0wNOG/2PMvCTB8yjUW+9Vq5cjm+WoSlfzB9UrviVff+xx32nnVuOIJBynqHsh6/5sReFI/PjFOcy7ESrGrgMiqvrUwKbXyS2sTMoDb8Z3g6LHxLyMAhdoji7VMOaPEP5SdE5ssGPHIjFqRV0WzVSv//AQwgV3LMlnQkDT08g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com (2603:10a6:20b:402::11)
 by GVXPR08MB7894.eurprd08.prod.outlook.com (2603:10a6:150::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.31; Tue, 18 Jul 2023 10:44:44 +0000
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::f4dc:6db6:8d7b:111f]) by AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::f4dc:6db6:8d7b:111f%3]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 10:44:44 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v8 10/10] parallels: Add data_off repairing to parallels_open()
Date: Tue, 18 Jul 2023 12:44:32 +0200
Message-Id: <20230718104432.1130469-11-alexander.ivanov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 35053f14-2c2a-4664-03eb-08db877bffe4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w2Xw+H87YH9gJX4wBgPGZdYahgMW/EHK9bLcdPpeGLiRiP5HHtMsH2rSmbEl12SoTdFbukLdx5y1TsQxwiqNfPi8/tpIIOywN/9oGIjvA/clh1bw5eYdoDr4WvqaPYjmiOc8zDUS/q9iFLelztFIgdemgzuJdJnhoiYhm5I2NNIHgWCccb3cefQDhUQ/y/86OBUkcUJIHPvF6+KFYB5deHfCFLA0gx+4IqIHy7TqqAwFI0sc4JjlKIbMhogkANmYIucryBMX/dxOaecouvxJ2eEIAycuEyX/9N+ZoiXde8M7hnoa1hDhgfOrTYyXvWj/H+cH+h568evFXctSfArf5INj6xpTDjhJw7m13JOrsv1lNci8v/TOhV1+X+X/bJ4xoxWY2QqxFTKzhmB6ODHlJfGHWFzJg6otOJfMgkravbXLd16d2cj7AnwvoegC/0eb/jHvmQQwK/CuNFec0PZNp1w7Xpe0UXoFxnGRk65rPApbSvJFo+EIJh3hYSPKEgAIT6lz7QEdi2EJxD+EQ0GMp9W237rcOTex/gR7rQ6BEhfZnx37XRJ20mYzdFgC4Gu1bWoODEfdkqXJR2XL1n4xO1AlhZ1JPubeTSEKNurjmVt4N/05rx17qOqTuHWqA2iZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB7095.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(366004)(39850400004)(346002)(396003)(451199021)(86362001)(2906002)(36756003)(44832011)(6512007)(2616005)(186003)(83380400001)(26005)(6506007)(1076003)(38100700002)(6486002)(52116002)(6666004)(38350700002)(66556008)(5660300002)(6916009)(478600001)(316002)(66476007)(66946007)(4326008)(41300700001)(8936002)(8676002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A1Dj/44r5YJBSrRduAudSLxZmtjSh7wL4vRucveXMwUThLvsMGJtyIMNudy4?=
 =?us-ascii?Q?senHuzyYjWyGdGh/XyMUvuxd4/emnek3I0QdahrOSto64sZabK+a0KHrsEoU?=
 =?us-ascii?Q?7hdbYKnEVzGzncVWp/qhk57WujyWCptRbAlD3XozXVyzS3ug7kIbFjL5awrp?=
 =?us-ascii?Q?fTt3Vd6GmebDsEm9HFJJSsuVwDHSiFlgkXZvodprkvTndPOWZPUa+GMWIvXD?=
 =?us-ascii?Q?9U+mLT4dCWDPeoCaezdNUY2m9yeOeXlMo3mj5k5v4EJXHaApYhH8TrUx1uV8?=
 =?us-ascii?Q?wmoTJ89z+wWUhwt8jneGvHDrnbS+ksavMoBwOI8a3cihfylkVMgIN+bfZC7v?=
 =?us-ascii?Q?poLpvYiS1Wsfu7d2dLWefqoHrZUtMh3XGlXNX22Nww3uI29yrMaNMznqBiLK?=
 =?us-ascii?Q?KDEsjzy+YxEprbWSpZcU2yQJqhSGLRXYEjEpNOnxt0q/WLgCtno+JUf84Iqq?=
 =?us-ascii?Q?gPJaDpMa3zzRcnD5emzdx6VW/N46tIFMCf234YFHr0VU7EjzTBIX06IvgC0/?=
 =?us-ascii?Q?bKXwdBcZpiSnqsG/FEQhSbw72NigLUfecQPI5fX0T6Ynx1mTW3/KReAaIVXg?=
 =?us-ascii?Q?gUC2uSoU2qz/5F7AOAssms4mHuDSTEBPjUXUDuzWsXWIlT2hNBQjh6e+PWc0?=
 =?us-ascii?Q?UT1wkj8iADrqw5y8IZq2o5zJrfyFt6nio7/OpW7V3EvPSVM55D4Nzp+wgO2u?=
 =?us-ascii?Q?AO+3QnskRyfOn1QmVzY9k4qrgRxt4UbO8C229rC/znr32Gt5regaOsAkTDzA?=
 =?us-ascii?Q?C1cWy7BF9ufqLNk5Vhgw9f8rJB5EEABKCwkPn0ygBY9H/hH1/hN4CW08rjNP?=
 =?us-ascii?Q?d1SFVTep4pFz6IEnKAaDon5zKa+N9vZ2ovspQL/zulbOU1M9nN+2t4zSdWxG?=
 =?us-ascii?Q?yRK6QO5wYya90m7t67Srwl2imCrwmh/mg2aW8ZIZxLLAmWB/56aYh3XjrojF?=
 =?us-ascii?Q?Vl0Y1R9Kq8xmENieNZDjoQI5J2Ayr7qyQM4Sa2fm3Ixjl0x0To9fY7N3PkS5?=
 =?us-ascii?Q?w4oWcF/EnW/X8Yky8ivsyLom6dNTrDc8RhjKM8p3Cv2/TDYaUt1ngbCey0Cx?=
 =?us-ascii?Q?INi22f/KVfquFbNZ/YIb7HdOUVJ0VcWdUBmHh0ZVFi20lMWiVH44ewc2+xVh?=
 =?us-ascii?Q?kjnVv58IhX2subYJCHxHujx5rpqtGwOfiEjHp4ZUYoitXAqieUoMSsBb4cLY?=
 =?us-ascii?Q?1xfZeHps1U1T/bSJAkWz2DALpfCfGXnS2M3NtpImWltfi5dWWcpA8xWFBOLO?=
 =?us-ascii?Q?5cWVX1p800WbQ353PWevucK1nDryWCSL0FhdWRDRg7/OuZBLRJqecLD+MGqE?=
 =?us-ascii?Q?NKtcW3caa/y9Zbha4H5+1yrS9G4kl38hZbwp2X5TeOUlXXBqIF5qgKqiPmTR?=
 =?us-ascii?Q?/bWvQz0/MN6gnY6shfgAMeVw1q0VpnipUaZXjUf9Iwf+ZKgX+cDdYyzV6mNu?=
 =?us-ascii?Q?QHg7Ko1s/rWZhqdkHjqd65+IcoIkXtxAVVLu5yIL48R5nVwsBkiyphOtnvK7?=
 =?us-ascii?Q?L9AcwK27+MdHWLzUYykYyGjDEDnSx7NvLTbiIYol5squitODPdvSKU4UzLY0?=
 =?us-ascii?Q?zT6qyg3qtgI6qvh8+gmKGzWUabz2Xgqe36rEU3jOycZG6LEtqSFycW36vlz5?=
 =?us-ascii?Q?a0rMRcH2NWDyC0t6SlYGQVQ=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35053f14-2c2a-4664-03eb-08db877bffe4
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB7095.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 10:44:44.7849 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oFK/ojl4G1FYZODI0/CbSqdelhytTSaR999q/KO9d6IvqwUq5AB73C+VMY9rZTVJ1yIpgnXN8hIHLisvL8rWdfrMsW6uiZprVAcMoYFFbt0=
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

Place data_start/data_end calculation after reading the image header
to s->header. Set s->data_start to the offset calculated in
parallels_test_data_off(). Call bdrv_check() if data_off is incorrect.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index 103acb7b40..48c32d6821 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -1032,9 +1032,11 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
     ParallelsHeader ph;
     int ret, size, i;
     int64_t file_nb_sectors, sector;
+    uint32_t data_start;
     QemuOpts *opts = NULL;
     Error *local_err = NULL;
     char *buf;
+    bool data_off_is_correct;
 
     ret = bdrv_open_file_child(NULL, options, "file", bs, errp);
     if (ret < 0) {
@@ -1092,10 +1094,20 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
         ret = -ENOMEM;
         goto fail;
     }
-    s->data_start = le32_to_cpu(ph.data_off);
-    if (s->data_start == 0) {
-        s->data_start = DIV_ROUND_UP(size, BDRV_SECTOR_SIZE);
+
+    ret = bdrv_pread(bs->file, 0, s->header_size, s->header, 0);
+    if (ret < 0) {
+        goto fail;
     }
+    s->bat_bitmap = (uint32_t *)(s->header + 1);
+
+    if (le32_to_cpu(ph.inuse) == HEADER_INUSE_MAGIC) {
+        s->header_unclean = true;
+    }
+
+    data_off_is_correct = parallels_test_data_off(s, file_nb_sectors,
+                                                  &data_start);
+    s->data_start = data_start;
     s->data_end = s->data_start;
     if (s->data_end < (s->header_size >> BDRV_SECTOR_BITS)) {
         /*
@@ -1105,16 +1117,6 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
         s->header_size = size;
     }
 
-    ret = bdrv_pread(bs->file, 0, s->header_size, s->header, 0);
-    if (ret < 0) {
-        goto fail;
-    }
-    s->bat_bitmap = (uint32_t *)(s->header + 1);
-
-    if (le32_to_cpu(ph.inuse) == HEADER_INUSE_MAGIC) {
-        s->header_unclean = true;
-    }
-
     opts = qemu_opts_create(&parallels_runtime_opts, NULL, 0, errp);
     if (!opts) {
         goto fail_options;
@@ -1197,7 +1199,8 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
      * Repair the image if it's dirty or
      * out-of-image corruption was detected.
      */
-    if (s->data_end > file_nb_sectors || s->header_unclean) {
+    if (s->data_end > file_nb_sectors || s->header_unclean
+        || !data_off_is_correct) {
         BdrvCheckResult res;
         ret = bdrv_check(bs, &res, BDRV_FIX_ERRORS | BDRV_FIX_LEAKS);
         if (ret < 0) {
-- 
2.34.1


