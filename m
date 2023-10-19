Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 689077CFA28
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:01:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtSdL-000695-VM; Thu, 19 Oct 2023 09:00:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qtScb-0005qx-0J; Thu, 19 Oct 2023 08:59:29 -0400
Received: from mail-vi1eur04on0703.outbound.protection.outlook.com
 ([2a01:111:f400:fe0e::703]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qtScZ-0002f3-9h; Thu, 19 Oct 2023 08:59:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ivgt68UaUmqIOsqSNvwhqtKv2HwgL1RkMqaWa0zZb8qgGm2LWUz5lESjwM5vc/tECThfx7KrKq9X2HrqHuZuC0OhW4QOtpjZ9O83rYsN+4GXXpxQKb9tnVh/Ujj5GQuzGoJUQ+PmZfFgjpEYVTzy5dUWhEHAywA7hXJSLuo8SmNHsUUbAb1HW0tWtm4miWf2btg+sbZn+tKbyBhGI4Hgc4yoqsKNSD1OdYUJpGvgaed7L3PVBGaWQ2R0sdkaSGP0lnHTRH0qQZdRBKF7QMcIcTBehEpwJw+9NcrzKnKeL6erVMLxTQ3sEreaQnJ2nndiQFn9wM85x2WT933camS9rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=neC7FT5ECeFNIwS8hQFOvVmkATsBRQuXlwfArRxGcro=;
 b=TuJiFFQowvjdfAci1FUnS37DAZS23sCSV3UgenS9CU2VEK8ChCaQ1Wln+x76EbjQAMme+tcqaIU8TlV+vu1O6yjJeSkHs4VsgPDF2avVN8Lr3ilhM34ZxgOK28LuMoA/Y2IJCZkG2/mHG19x5mVxYRMr+ORlBSG85CJjc8MdJJu9Oc8dwDrEQH/DacYjO9mZ/WsHzK9VZ59UajCdKunjAQwdCkodKAredyyfmXiDjrH6uJPWYEt3ulfs8dT/VyjSUsXfh02cTdUwQki+ZBZAZP3IEM8UmSS3XA35uQUrzy1+Y87/MW9X5NUosd7wsdChNIRyO/nnhap+ZI4IwJ0mhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=neC7FT5ECeFNIwS8hQFOvVmkATsBRQuXlwfArRxGcro=;
 b=AbqvT1KaEvxhe2ETg5tfDkhrWanNkGyHDXfeNxTi9KmkHd0kV3E250YPHz6AJGnCfeQNNp2bY7ipMYEsTieYUn1N1UesvfuTsNKknP32GQVtNHEVOMxTPPEl8PnoW5ejkFqXdESLj4wAfPqNxbl8rlTRLAQ3ZpXebB/JVEYzVLIwepZETucJP/U8rcNOkpSKrQVnYzNecRtcYtrje29WG7h0s9z8HYdk9YlDe+fNLAjZL00Dy0Nupu3NoZ6Z29/oAOtMWJXhfvyDDgqFCi32eOd55XvYmS1m5rCWsIp346HBt8GULCiRC8YKbIu6uaDFIVVNG9+d/Zpkd5YUbDvObg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com (2603:10a6:3:4b::17)
 by DBBPR08MB10554.eurprd08.prod.outlook.com (2603:10a6:10:52d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Thu, 19 Oct
 2023 12:59:17 +0000
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::cefd:987d:e77f:71e0]) by HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::cefd:987d:e77f:71e0%11]) with mapi id 15.20.6907.022; Thu, 19 Oct
 2023 12:59:17 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v2 17/20] parallels: Remove unnecessary data_end field
Date: Thu, 19 Oct 2023 14:58:51 +0200
Message-Id: <20231019125854.390385-18-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019125854.390385-1-alexander.ivanov@virtuozzo.com>
References: <20231019125854.390385-1-alexander.ivanov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P189CA0026.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::39) To HE1PR0801MB1931.eurprd08.prod.outlook.com
 (2603:10a6:3:4b::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1931:EE_|DBBPR08MB10554:EE_
X-MS-Office365-Filtering-Correlation-Id: 18027701-a2b6-412e-0455-08dbd0a33406
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q4kpbmG1ARelq1RtbMC5kLtBJYaXRldlvIRO514ggBG/INkIK/h8gr/uKOpDMIT/cxWsk5LIXvDbV1NghHIS9e3jen+y4ywnLhp2Wvll10q5hMD+9GaEoBOlMoDpWkNHwPyxVEAFGYAeUJgCo2aw1C4ezcmyi+m3bKgqNvYOScJ7itLiqt0MzoC14syO1ZwZHc8LxA6Pk7rEFebpnan9YP0eQ3qeyl5+B+mau0mO0XyG0+vG9xG1zdJWk22aiOvWamoNcaZzsPYVcccH0BDlXicGrx3B/AzevS9vhR7Hwmz2AlmtGwwFq5LmhFcdpnP7Qmk8YFahK+fv6Ovoqjr7HG/wsXDXgMcsl2COrbJyHSI7wJg/USC3pOlZvGxjnVP7SnLHoavBMd9t9efkJTXve26jQM1MVRd6swFFbF2r2t73JzfWkMR7KP0jS7BjnvvhrbaKcAglRTEOCXH+zBSMCx63LGbtgzvvnJwECSkZsU8Jn6sJoMuE/T4hnOL//RYJboeXChS5otRfQ9ADzqU+t8dinCGvRfBaeRYxkZ0fr1q/t++/k/dVIGzTDQ+qh6RY8WgffFiozTMUcNOJHVYIJ5LAhBy0PsrF3sgut9ZtQu0Hc5zySyT1E9ySN4ll/TA2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB1931.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(396003)(376002)(346002)(39850400004)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(26005)(38350700005)(38100700002)(5660300002)(83380400001)(44832011)(41300700001)(86362001)(8676002)(4326008)(66946007)(8936002)(316002)(1076003)(6916009)(66476007)(66556008)(6486002)(6666004)(6506007)(478600001)(52116002)(2906002)(2616005)(6512007)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+bqL8LuHD7PRdkTH6eHZF4HlHZSGhLTT6ZwQJPoATyOMgn5Uk6Ewy6BHi1Tm?=
 =?us-ascii?Q?zNHMhaHVOT24C98uCs0opEH4L3pQzzKRJMrqSC9kvhyCcPimPBTSPeBrMSnr?=
 =?us-ascii?Q?Lira/wGZedhAtceXkEznd0Q+4ZBcqtGr7yQ5CCBHps2AWVW5MNs8z0kLyr9s?=
 =?us-ascii?Q?mYh6M/vuIpOJKwnGgQllfWsAgd96au2XVzBiUJ5cdXK3yApsI8MDDnUKXIWf?=
 =?us-ascii?Q?4P+i9V3eeWhkEj6Bno0mqCPM/0IpwSHnQOq/XvUzpWVGver33mVYua7/Yfk/?=
 =?us-ascii?Q?wyndUgAG/sVUxhTe7CV9cSFbDsNtEYANmJE7Xp37DzcM0SsDJIDh5GPqHOVS?=
 =?us-ascii?Q?ziAkiQxMA7nOOZmqaj3Nc5wnR3JJwwD9os8L3X/JqM8WBikVjgdlIlIPBTk8?=
 =?us-ascii?Q?Nf3Nn3IDqDoaYo3ImjAf9OIelWp31Yhy/9+fWxBCzOxNZ/8oQAmF+iCa83Zn?=
 =?us-ascii?Q?HfHGpECLAM2nOJEaHZnzi5gvkFqVFmhx7SlAqg03NCLkvf9WKMGoYHEbRmvK?=
 =?us-ascii?Q?WE1MjnzX/ArNOHlra58oXVXmM/XNtFWeH3YW4TnKSnu0IyoUJo2kq0eEeek0?=
 =?us-ascii?Q?gHeB4ZlywUta07V7s4bgbrZ0vQH+pIOgHbyGegmuTl5Mmi4YAYYltooluUdK?=
 =?us-ascii?Q?hf8ppZJnmMo4ITmTa8W3386rzkErSD7x0vQGlOHChaYxwMtqJRVU5vMyEt3K?=
 =?us-ascii?Q?4IYDFcENR2d8RUVBgKzqwGc0mhH6roQXAWnAsFhnby5R+LjaUmkcU8Xmb2Az?=
 =?us-ascii?Q?pqGHpnlJJleQJYb8Ar3FnUHXhyVaxCKXyHTbOPBlUeqKG2Hb2inFUr6E/nWi?=
 =?us-ascii?Q?6PdCtAD9DvXoQsW8qEV9Vh+wVvidBiiL4Ut4w16DRlkhuzNGulN78qEsKNW3?=
 =?us-ascii?Q?iAxG3rRfxdIPf80Omg2sZdBBb9UXWVzd1NzQJ2r6GybzhVJvT8BBR9Hs8NNW?=
 =?us-ascii?Q?yrdeMxCoMrX8dTmK2dAWrP7umjpbQK08A8R/d4ugr/OsEzRfdxKJ1FB85utS?=
 =?us-ascii?Q?nMWAb+rRANFQxFith2JszJujzDgcExko8wUIx/kJSKgvfReSC8BF9nn1UINe?=
 =?us-ascii?Q?u8gGMX/QrKOJMyX+w+oXiOJ+tHu7Pb2MRpO9hUgPuhwva4WcidwonlQx0O2b?=
 =?us-ascii?Q?BbsFAeNratekSCy91kU5uHJvUnayv6BAX6cGcamzlCLtT+2kA1OywL/C2pbT?=
 =?us-ascii?Q?jacguCSaWFVpgGEPQ49KqYQQk2Q52xXUnojrtmLZWgXZeJjyIksrOi0BnESm?=
 =?us-ascii?Q?9EifJNfiiqnOGp+IoWo1dhHHOZV66kG/GOtAP6Demes5sbxaEuMoo/2Wn23N?=
 =?us-ascii?Q?5H2glAHc1UHT+h26G6lk/S0G3n3VN938hJ2GrP+JanbBtl3mJtvyAxKpEE2l?=
 =?us-ascii?Q?LQdncAdTko98eiuaiVuhYEF0kWZzP/YgUYLEjv02MvSuEqwRBJdxc6QRISXV?=
 =?us-ascii?Q?t+tC1kSwxITPbJWAsJ9TvOzjI2q4YvL6lE5Bw/rX8hnxo4fPr0SjZ/OFDSnX?=
 =?us-ascii?Q?yDhiWS3lPGJoXFCgcggGW3x9BFsdGnqH6gWho8IchnEX0AEasKGps8WqlI/1?=
 =?us-ascii?Q?8U7ngnCIpV3S3K3+qqOKXyHW3vv6m/IoBIHpmn3z/cji35wJpzAQaW7TF9T3?=
 =?us-ascii?Q?yo9YSH9dExyvaYeFncj7zoI=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18027701-a2b6-412e-0455-08dbd0a33406
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB1931.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 12:59:17.5634 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i20ZJlqRgCQsUPjQdtR233WTfJALEX45RxIr6jhMJ8xRGFN26locZPh8PKUnrGLaWcnhyBUmBOqxGTYglRwX+yMhWZnKL13fg+dpINHal/g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10554
Received-SPF: pass client-ip=2a01:111:f400:fe0e::703;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
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

Since we have used bitmap, field data_end in BDRVParallelsState is
redundant and can be removed.

Add parallels_data_end() helper and remove data_end handling.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels.c | 33 +++++++++++++--------------------
 block/parallels.h |  1 -
 2 files changed, 13 insertions(+), 21 deletions(-)

diff --git a/block/parallels.c b/block/parallels.c
index b1100dc65c..fcea44276a 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -266,6 +266,13 @@ static void parallels_free_used_bitmap(BlockDriverState *bs)
     g_free(s->used_bmap);
 }
 
+static int64_t parallels_data_end(BDRVParallelsState *s)
+{
+    int64_t data_end = s->data_start * BDRV_SECTOR_SIZE;
+    data_end += s->used_bmap_size * s->cluster_size;
+    return data_end;
+}
+
 int64_t parallels_allocate_host_clusters(BlockDriverState *bs,
                                          int64_t *clusters)
 {
@@ -277,7 +284,7 @@ int64_t parallels_allocate_host_clusters(BlockDriverState *bs,
 
     first_free = find_first_zero_bit(s->used_bmap, s->used_bmap_size);
     if (first_free == s->used_bmap_size) {
-        host_off = s->data_end * BDRV_SECTOR_SIZE;
+        host_off = parallels_data_end(s);
         prealloc_clusters = *clusters + s->prealloc_size / s->tracks;
         bytes = *clusters * s->cluster_size;
         prealloc_bytes = prealloc_clusters * s->cluster_size;
@@ -300,9 +307,6 @@ int64_t parallels_allocate_host_clusters(BlockDriverState *bs,
         s->used_bmap = bitmap_zero_extend(s->used_bmap, s->used_bmap_size,
                                           new_usedsize);
         s->used_bmap_size = new_usedsize;
-        if (host_off + bytes > s->data_end * BDRV_SECTOR_SIZE) {
-            s->data_end = (host_off + bytes) / BDRV_SECTOR_SIZE;
-        }
     } else {
         next_used = find_next_bit(s->used_bmap, s->used_bmap_size, first_free);
 
@@ -318,8 +322,7 @@ int64_t parallels_allocate_host_clusters(BlockDriverState *bs,
          * branch. In the other case we are likely re-using hole. Preallocate
          * the space if required by the prealloc_mode.
          */
-        if (s->prealloc_mode == PRL_PREALLOC_MODE_FALLOCATE &&
-                host_off < s->data_end * BDRV_SECTOR_SIZE) {
+        if (s->prealloc_mode == PRL_PREALLOC_MODE_FALLOCATE) {
             ret = bdrv_pwrite_zeroes(bs->file, host_off, bytes, 0);
             if (ret < 0) {
                 return ret;
@@ -760,13 +763,7 @@ parallels_check_outside_image(BlockDriverState *bs, BdrvCheckResult *res,
         }
     }
 
-    if (high_off == 0) {
-        res->image_end_offset = s->data_end << BDRV_SECTOR_BITS;
-    } else {
-        res->image_end_offset = high_off + s->cluster_size;
-        s->data_end = res->image_end_offset >> BDRV_SECTOR_BITS;
-    }
-
+    res->image_end_offset = parallels_data_end(s);
     return 0;
 }
 
@@ -805,8 +802,6 @@ static int64_t parallels_check_unused_clusters(BlockDriverState *bs,
         return ret;
     }
 
-    s->data_end = end_off / BDRV_SECTOR_SIZE;
-
     parallels_free_used_bitmap(bs);
     ret = parallels_fill_used_bitmap(bs);
     if (ret < 0) {
@@ -1394,8 +1389,7 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
     }
 
     s->data_start = data_start;
-    s->data_end = s->data_start;
-    if (s->data_end < (s->header_size >> BDRV_SECTOR_BITS)) {
+    if (s->data_start < (s->header_size >> BDRV_SECTOR_BITS)) {
         /*
          * There is not enough unused space to fit to block align between BAT
          * and actual data. We can't avoid read-modify-write...
@@ -1439,11 +1433,10 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
 
     for (i = 0; i < s->bat_size; i++) {
         sector = bat2sect(s, i);
-        if (sector + s->tracks > s->data_end) {
-            s->data_end = sector + s->tracks;
+        if (sector + s->tracks > file_nb_sectors) {
+            need_check = true;
         }
     }
-    need_check = need_check || s->data_end > file_nb_sectors;
 
     ret = parallels_fill_used_bitmap(bs);
     if (ret == -ENOMEM) {
diff --git a/block/parallels.h b/block/parallels.h
index 18b4f8068e..a6a048d890 100644
--- a/block/parallels.h
+++ b/block/parallels.h
@@ -79,7 +79,6 @@ typedef struct BDRVParallelsState {
     unsigned int bat_size;
 
     int64_t  data_start;
-    int64_t  data_end;
     uint64_t prealloc_size;
     ParallelsPreallocMode prealloc_mode;
 
-- 
2.34.1


