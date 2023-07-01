Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FAC74485E
	for <lists+qemu-devel@lfdr.de>; Sat,  1 Jul 2023 12:09:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFXWl-0001e9-6V; Sat, 01 Jul 2023 06:08:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qFXWh-0001cK-QU; Sat, 01 Jul 2023 06:08:23 -0400
Received: from mail-db3eur04on071e.outbound.protection.outlook.com
 ([2a01:111:f400:fe0c::71e]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qFXWf-00076K-IC; Sat, 01 Jul 2023 06:08:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=crGIvzREH7uFLQEiU01nxyNffXSmlG43JNqm7+Sr05QdKDtjeV90H9T44VMFa3a0rmtb/sNqxjfc2wHYKFUv8LDENhEzqIE1XFegiTPZct+u5qMCRqgCD4jQzrRLu/HRuz6Z/7+eNUvQqyBHGFHEuGjBK6qI132PI5CgE5VthCGfiTmQ+OZ2Dj196hy1d/oyebbcwy62dX6Ao5fG1+LSF7SAmvGQwnDwKT7j5yXD4fmHUSz3vEBIA5wcrgkjWczetOxf3SpByNwYuC2TzQveK1MEwhHS1QU2GWF7goPrnSdbRCS+Pl/NVnTzUHGGYducTp2MtW3w5iWwVjOaX1xm4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xjxa6m8ziEeGyp7pGl3c8eS67NElujkYYuKqcoWAapk=;
 b=mNCYFzt0LrHZDYDOs07uu3SoKS2nEXWkFd9WMgn09QX4pyUrXl3kuezpvZjBmv0Yx09TOCZCBWOq9b32ZfN5cEYd/89Ymwf+nI9gb7wZNewDrZbB61fTOQF00p/CdZSFOkGpJxfXqTeD72+OWzgZi/xgwFq3ZTBQCKbw8Eev3CnJdLJucdBPxCoaqmdFRCaUNsvtBa2jXvalzgNpwaVBWsEFKBLqo4BJ1fiZDFmTn3275tq5B0RgaorYovJKn/uWvAOSJVSJ+N46QPmId7nYm3VUxtR520rrsnCQIHWJB9liWaYnMFiIDZnkTe1f2xLCOyTaFsytXNtP3Hr32TE81Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xjxa6m8ziEeGyp7pGl3c8eS67NElujkYYuKqcoWAapk=;
 b=SaOFms6a0F6/ADA3G8s5N7u36z6jrA3scqNJiIHuphJKQ1p0cJTZS/xQiK/ykkoHah9dckbqRDv1PJRAHgSH5wAXWeRnwAbLDzpensilGEmi8jIeSFw2U57Tlp2l2nBDnh3OWDKbmOFguNpCy3b7WWExxQjlZQNlmnlzA8U+67xPH6UCLxi68rRDPObgQseRqCIgo6UBmTz8yKRFWN6JnMgsF2ReLv6xrfOWk7qrGQStq0M/b6wW1csFdQUhmy5rONUX8Zouccy5KeWPsSOTgY8eqQMmw4oMOoWaHHgTVHjEIJse5ieGqbiCuF+eORkJOQjCy8vZbdUYbYwj1sMO+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com (2603:10a6:20b:402::11)
 by AS2PR08MB8832.eurprd08.prod.outlook.com (2603:10a6:20b:5e6::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Sat, 1 Jul
 2023 10:08:11 +0000
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::ea9f:354c:ea46:3243]) by AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::ea9f:354c:ea46:3243%7]) with mapi id 15.20.6544.024; Sat, 1 Jul 2023
 10:08:11 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v7 8/8] parallels: Add data_off check
Date: Sat,  1 Jul 2023 12:07:59 +0200
Message-Id: <20230701100759.261007-9-alexander.ivanov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: e46202c5-727e-443b-c907-08db7a1b134e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GFcG1tn97qBMF/uK87fNBQ+p1+VPvRiUqf+wnxiMpM9ENBK1dhCXmiUNwEU7eyQsvdJcL7i10S7/oaeiyPT5XHJEXqChNW3ccfJgCLYcRXaXhfhYOpRaSJQUN9F7VTzRstjVBvnT6V2DzlBBVx/X4t+tDaF4UPOtzh3g83JZ7OR/LYau+7ko+R6NuvmbCc12rxVoyHJBT66UQQGWd0z8se/xBFyz7SnyW1CpkFyEbe4jHA1NhwUFDXhaea60MwK/hMxBr2K96iMoGANKsjv+r+3puGqZMukdrPwsyaAvB5zmFrLv9vuRO/qUWGpeudfbR8C3f7D2JaiXX0p1KMc5LvW5ZyyLne+EfWwUvXJFH+Z2TnXQyUviJzLrhDWWO7hiLbySqPiXVpEnLBF7hy0yGvJTri4njMwJAbPIR9snumaNp16fjqINVSxxWcNVnXc7DbE9uCcNcCwGMdmC5H2LxKPC2lwF5TozS8Q1paUwRO8jy7KBJj59E1NfIvwW2xTguje2u69xiImWcMLUJTwNxXEGWHA0e+iEe+tenZvcxZK1f/y5TYXIlPdobGA/6XvnOCFdGZSdYj8DPNEGAytvkvT6W2E9Y+n/mayptakaXQn5Yrd1WB8EKCEkcjjYR+ot
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB7095.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(376002)(39850400004)(396003)(366004)(451199021)(26005)(478600001)(1076003)(6666004)(6506007)(6512007)(86362001)(2616005)(186003)(38350700002)(38100700002)(6916009)(66556008)(66946007)(4326008)(66476007)(83380400001)(52116002)(6486002)(316002)(5660300002)(8676002)(8936002)(44832011)(41300700001)(2906002)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mfdsi0GwC9MDR/Q46k7H22JdbJEE1Z83+IsdPOueqRSNW9baw8K12qAEbNcd?=
 =?us-ascii?Q?fVvbBYjynTaLfnL1gOO5oM4Hm5tiOMe41sgC0NpMzZfQDSI7RqY2ODp83u3+?=
 =?us-ascii?Q?4pIWDyzCWTppSKwybTdO0lV1BGwRoiLY4eQ1OVAkXe0fGhF2KMC9lxnJU0ev?=
 =?us-ascii?Q?Ph/jMBsy8i5DD4ySDIdmudzU/FUKzb0CTOvTybc2w1b0Ix5G53HMK28L0psN?=
 =?us-ascii?Q?voGUqvMmp0DmjeiJh5fdUCNB+gOUT22zE6QNRedcw1TBi2Ekj2XPudeYlw9m?=
 =?us-ascii?Q?k9D9qzwjHgeExZL/S7ElcE7b6hrtxxATGhqCJfbdZdDyJRJc01+85zd71IrH?=
 =?us-ascii?Q?ifMDfV147rEar/uve2hFzMrvVpVQKi3ATowVsicQNMyyVCm07S4PTp5PaOpJ?=
 =?us-ascii?Q?Z375fQY95I8AvF36Ndt542oJ/RwDgyRHflSp5Dyx5HwrhwKVOmAE1bNAxRhU?=
 =?us-ascii?Q?XWLiyMCYDOOOFSZcC1j4ECXQo2t8KO+0onC4zXbKQQSZRllCjMygtxtdQrAr?=
 =?us-ascii?Q?yegSO5Q1i8OoOGKYJFcT/8ICGf5sGjZZLFnPVIf94bEUuHdKjQR+rraL6DJE?=
 =?us-ascii?Q?Z8BbhjroNygwB8kFVBi7/tEkurr03NsUq+uwunhPT5OxNN6wiDYUTqxToYKZ?=
 =?us-ascii?Q?0n80er/BrJxgK1iMTLu+QVVIh3fxXQOjYKmwvTFNj/PR5eAKN1L0E1fBMc24?=
 =?us-ascii?Q?bb9n4go8hhDrl6EMBYUAv+bD/E6UXHO2VVDXNHX7CaBzPCrjnNUyXWK0Wfee?=
 =?us-ascii?Q?rmk0pp1wi3hVHEmZNHrt3Oc2s3pv48j6QR1O0lUeiWohqqliy/DNzRJAlbjm?=
 =?us-ascii?Q?SiSvidjTKvjKVh0xTnH/F37Y53biK/13/E2PyM16iIApfBzbRRl4We79vc6o?=
 =?us-ascii?Q?+R+T094/L8e94SAfrCNGSHAb5Loxbt1SLt6Mf8d3/pgPCsqocDxfMzoX2K69?=
 =?us-ascii?Q?Q+4wZeRCJ7waQwmFjWXubujYhX6i2Acthgwp0u+HJpd9IKRTIGvgijUDgHAH?=
 =?us-ascii?Q?h2kVgsNYgqg8H6j3HiIXwrRAryqoJPbj+CrVvOY7GzL7J1scIiOSoBkCVHX7?=
 =?us-ascii?Q?f39Bc6uMlAV44iHbNocc5Pzh78cZY5Vq6b6feKH7A4rt/vQhMfKvGp0dcrE5?=
 =?us-ascii?Q?IBilmLbBOUSFOoYbNL2oKIc0X/nQLxO4X2dsvZ7kusNU7zQKq+5umIX7oima?=
 =?us-ascii?Q?WwGXtlajiW0CFkgV/lkjPSuPGIJf3R+ATbibw4wqWB5JMxN8T8hQsOui3M1F?=
 =?us-ascii?Q?hUmRIdT6GJFGI+OI8MY4mcxeVZ+edgKKLXF0QghW1TJOYuKceick+mjhryfL?=
 =?us-ascii?Q?Io2T0HEJ6qCRxZnTmSxBcBPDHBNF4+PTGM26x+xDyP7PhVp3qGxftT1HXzEb?=
 =?us-ascii?Q?BYkDe2xNhGpoobnqNvXaxTv7oaeLvyOzZtpXWGXrB1WowdOZoSWO6GIvzoAR?=
 =?us-ascii?Q?VLAtB7R+/f3C0Jmd7bbCOIerQ7qKD1zDap6zZCY9bdiyqthQayk5IhlTwCJh?=
 =?us-ascii?Q?3UoR4IoyfOCS3E8K+WVuC1gBeV31UNT4FsFBPxR6AfYj2b2ulG5KVNABtlxz?=
 =?us-ascii?Q?brVm2vuM5ow+X7oYUu+qpP3PxLAMGBlAfiQBqZVDjRBMfNKb9Mz6f5zQTXJH?=
 =?us-ascii?Q?/mZP/8kwFtGR0HUkXPEFyW4=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e46202c5-727e-443b-c907-08db7a1b134e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB7095.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2023 10:08:11.0809 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 08nLBvOMMQYsOP6lv2eF8Zx3k9/cBbUkNjwW3GKRuPMtwkS4IYDjVwy9ejKnLpa7Hq/ilF/9K2YQvb5HgalvAggtrF801yKv5/XkSCngjBU=
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

data_off field of the parallels image header can be corrupted. Check if
this field greater than the header + BAT size and less than file size.
Change checking code in parallels_open() accordingly.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 98 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 83 insertions(+), 15 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index 456a13bd28..51e79056df 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -446,6 +446,65 @@ static void parallels_check_unclean(BlockDriverState *bs,
     }
 }
 
+/*
+ * Returns 0 if data_off is correct or returns correct offset.
+ */
+static uint32_t parallels_test_data_off(BDRVParallelsState *s,
+                                        int64_t file_nb_sectors)
+{
+    uint32_t data_off, min_off;
+    bool old_magic;
+
+    old_magic = !memcmp(s->header->magic, HEADER_MAGIC, 16);
+
+    data_off = le32_to_cpu(s->header->data_off);
+    if (data_off == 0 && old_magic) {
+        return 0;
+    }
+
+    min_off = DIV_ROUND_UP(bat_entry_off(s->bat_size), BDRV_SECTOR_SIZE);
+    if (!old_magic) {
+        min_off = ROUND_UP(min_off, s->cluster_size / BDRV_SECTOR_SIZE);
+    }
+
+    if (data_off >= min_off && data_off <= file_nb_sectors) {
+        return 0;
+    }
+
+    return min_off;
+}
+
+static int coroutine_fn GRAPH_RDLOCK
+parallels_check_data_off(BlockDriverState *bs, BdrvCheckResult *res,
+                         BdrvCheckMode fix)
+{
+    BDRVParallelsState *s = bs->opaque;
+    int64_t file_size;
+    uint32_t data_off;
+
+    file_size = bdrv_co_nb_sectors(bs->file->bs);
+    if (file_size < 0) {
+        res->check_errors++;
+        return file_size;
+    }
+
+    data_off = parallels_test_data_off(s, file_size);
+    if (data_off == 0) {
+        return 0;
+    }
+
+    res->corruptions++;
+    if (fix & BDRV_FIX_ERRORS) {
+        s->header->data_off = cpu_to_le32(data_off);
+        res->corruptions_fixed++;
+    }
+
+    fprintf(stderr, "%s data_off field has incorrect value\n",
+            fix & BDRV_FIX_ERRORS ? "Repairing" : "ERROR");
+
+    return 0;
+}
+
 static int coroutine_fn GRAPH_RDLOCK
 parallels_check_outside_image(BlockDriverState *bs, BdrvCheckResult *res,
                               BdrvCheckMode fix)
@@ -709,6 +768,11 @@ parallels_co_check(BlockDriverState *bs, BdrvCheckResult *res,
     WITH_QEMU_LOCK_GUARD(&s->lock) {
         parallels_check_unclean(bs, res, fix);
 
+        ret = parallels_check_data_off(bs, res, fix);
+        if (ret < 0) {
+            return ret;
+        }
+
         ret = parallels_check_outside_image(bs, res, fix);
         if (ret < 0) {
             return ret;
@@ -947,7 +1011,7 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
     BDRVParallelsState *s = bs->opaque;
     ParallelsHeader ph;
     int ret, size, i;
-    int64_t file_nb_sectors, sector;
+    int64_t file_nb_sectors, sector, new_data_start;
     QemuOpts *opts = NULL;
     Error *local_err = NULL;
     char *buf;
@@ -1008,9 +1072,22 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
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
+    }
+    s->bat_bitmap = (uint32_t *)(s->header + 1);
+
+    if (le32_to_cpu(ph.inuse) == HEADER_INUSE_MAGIC) {
+        s->header_unclean = true;
+    }
+
+    new_data_start = parallels_test_data_off(s, file_nb_sectors);
+    if (new_data_start == 0) {
+        s->data_start = le32_to_cpu(ph.data_off);
+    } else {
+        s->data_start = new_data_start;
     }
     s->data_end = s->data_start;
     if (s->data_end < (s->header_size >> BDRV_SECTOR_BITS)) {
@@ -1019,16 +1096,6 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
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
@@ -1111,7 +1178,8 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
      * Repair the image if it's dirty or
      * out-of-image corruption was detected.
      */
-    if (s->data_end > file_nb_sectors || s->header_unclean) {
+    if (s->data_end > file_nb_sectors || s->header_unclean
+        || new_data_start != 0) {
         BdrvCheckResult res;
         ret = bdrv_check(bs, &res, BDRV_FIX_ERRORS | BDRV_FIX_LEAKS);
         if (ret < 0) {
-- 
2.34.1


