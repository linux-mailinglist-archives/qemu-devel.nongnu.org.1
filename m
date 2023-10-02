Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A66947B4E50
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 10:58:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnEkw-0001cj-4q; Mon, 02 Oct 2023 04:58:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qnEkn-0001VV-FV; Mon, 02 Oct 2023 04:58:14 -0400
Received: from mail-vi1eur02on20713.outbound.protection.outlook.com
 ([2a01:111:f400:fe16::713]
 helo=EUR02-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qnEkk-0003Qj-V8; Mon, 02 Oct 2023 04:58:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c8VJFMPxbVS799+5Yb6VsfE39uPpwaIhD4j44m7/JdKV4KgyaKqfUX8HvvS5D3TzPrCeA3vCTdz/zU7Loam9rQmSlt/7bWurN2TV5JW1/czdg+JB1z5z5RTn9BWWTyexoFvb7FPo2nl4oYdX/M4ncU/vKkhSJHQriywIygOCOqchOLhEa3Ck4BlWxrIGWuyv53KmqxBgls0yWxI013sy7fqYywAgFZrKyGRcDXHLE7WaixNDFiincnQFG1gFDMhpk3HKdK9DBfpC+dCdbIsvXHOdqWhDnbx8R1Y5uvt5LzeiquOMGVHW25FrPFQSPgr10/tcmjoe3AwOxM6/Jv6cOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i6K6zzT9GO4UNAoOajoFS2DdUso8JcFoaNjCb6Xo06o=;
 b=M7XKz29rgZheN4UaXr4ufNwMCgirdXO+DbyzC56WioukqBs2dBYYAXYVmCsoCPSEql5RmYw785OxvIaRfXnt8zKl2Kzsr/0Til9+7EFrv31lnCFMfn3If/rWj69dvxL8m4+NPGCKJAEEeYVkZNOz0XL1Y3ebUWBvjEDO/RPoqw2CgC+CN7VPokRHblXCsv048HvnhkuADD42Ga7kiVHV8N+As/uSTosIvd8+luAoLxYZc3w6c2JT7aSGqqUAfMT+uh9Johrspp7m9Lb99lyW7vmnZKOg6oux2luNHdiNAudldxHSSz9NYj/GOArJSGXDx+q4SlztV0Fwpor4YciafQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i6K6zzT9GO4UNAoOajoFS2DdUso8JcFoaNjCb6Xo06o=;
 b=aDDq3A/G2J0k2dlfl15Zx/+OWzlKq12B5+IjED2lx588QS7yuSfrfHG6jZldyuAbpJ7titCWSBvlaKeZLl14WGbe3UFCBEyzhnudM696UDtqbg1MlmXBaFe7fpXH1abr0asRuuJynYvSfU7BnxTBBKFpOShqk+P6RYHarliQx8hBMRz0UKI+GLGFAYj5EADtcy44ZQWfTtm8LfBu9YxM/zV45ZNc3G6C2l7tjP5kUI1TNTAyViuIegO6xxejXhr/JJDHQk8FWxLUHKDP7b2/wvJD4h1BjiFthPjNzXJedfFY/XUdmDb0ZLuU08OudeRTW6ODK8HfxHEHKtZGwxau9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com (2603:10a6:3:4b::17)
 by AS8PR08MB8273.eurprd08.prod.outlook.com (2603:10a6:20b:537::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Mon, 2 Oct
 2023 08:57:56 +0000
Received: from HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::4d4a:2d8c:6f96:4c77]) by HE1PR0801MB1931.eurprd08.prod.outlook.com
 ([fe80::4d4a:2d8c:6f96:4c77%5]) with mapi id 15.20.6838.028; Mon, 2 Oct 2023
 08:57:56 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH 09/19] parallels: Add dirty bitmaps saving
Date: Mon,  2 Oct 2023 10:57:28 +0200
Message-Id: <20231002085738.369684-10-alexander.ivanov@virtuozzo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 342ceefb-c2bb-468d-1fef-08dbc325aaa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I9H/xMKDk8MwnWkdQJfb4rNMULuzeCiTiXC8ruGoUhBDJetGxxAH+e4hVNJVk1lLptjEqUQpOacNvb7BYwUTI2po8QO9jd9zThloQoLbue1vZo3oC10FhPXWuC04q+MzjLV2SU0UGrFQ5amjaI8+bcBdzAXFaiJRngn4UVc3Q5WQw0oTNrzmgUl+OWunwbygsc9iazMWQ2AxPz6TjbJ/YjQJs/RDNEDYTZxkvl1ujsEmE1Gk6v00s/Tsk5ssI2RC8EuEeXno+MoaIkrcRVPhDge1pjBYNZNCJrNEMhaIB3hdRkk8CYERNvOjUWfYPI855IpsQL1D7KIeWHE1MA7+XrxeyaLb2m7a+CgFc8AvYCUq4Cf5QyK7NNsUDRvL+7CpJR4LLE55SUtKrgeFYSA/3AZ/EiBmmJ2yhAYmKxDzTpX3HW4CFPvO32NYOur5kaRsXhcUvyniKE0cxyi82juD+ZPTxf1DNrr+Ddpo0Y3ZmVjlbs19zxdf72ExqDfKAxnDJJM+TpbVtjHaMWVo/TqqxoF9G0JVJw7IQk/SPT6ZZ/2R6AimvucuyEqeluuWqpSoTWTcusbEWeVyt4Q/PPd+f7Dy8nxLm5FyL7dxMwLsS9+4gpNi/iOx+haVPA/0qdpPSu4GcZMK+/Z7gszEtC5+Dw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB1931.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(346002)(366004)(39840400004)(396003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(478600001)(1076003)(38100700002)(2616005)(26005)(6506007)(52116002)(6486002)(6512007)(38350700002)(86362001)(83380400001)(36756003)(6666004)(316002)(8936002)(4326008)(8676002)(6916009)(41300700001)(66476007)(66556008)(66946007)(44832011)(2906002)(5660300002)(14143004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bsJeiW6KiD5DBM/WZVDPmj/w+qGQt98f1XjH3quvTITOM5o3z5efs1RK6hoQ?=
 =?us-ascii?Q?kkTMYus/B7BW6ibzIC8/5ZivmKwbPClpSyznegEzR/zghFzComJLNI/Bwb3L?=
 =?us-ascii?Q?V4EOb0J0WJYvg7wwdWoxsibox/Ci1Srprf7bm+j1tqkGFk8KqBbBQZuqpfn6?=
 =?us-ascii?Q?4V2Qh6eb6a+07pUO59vDpOo12wdVU11a0y/VAPbPlOx46nIHcxQj9uhFq/jH?=
 =?us-ascii?Q?jzQjci7Y0bDNkXGEBgWbl7n9yOUr4P12dtU82ZTS0LHkmhrzeU/vdHeXJRH7?=
 =?us-ascii?Q?r2r/si5hc4f4rK2vXUOqB8EvqZ6GXDyYVgWQqWwwni4Om6M0qCAmY2ng7LPH?=
 =?us-ascii?Q?F5CBwjcyTwXimGiogTdwwPBB8HY1c4ALL90ISocRSuh5K6WOAsFs05rp0NkB?=
 =?us-ascii?Q?KtfgJiHZjn7DewPK21gSLpmYgLPdV/GXoyLAbFkuHYLxVoJDY5NAXoDPM6Wi?=
 =?us-ascii?Q?nCkuCKIyXHaNeq0rcBuyyGXknIEMdUADuDtUsfLxL5fAlSoJxpethEngQaka?=
 =?us-ascii?Q?P/LGhx394jLBepOtOSBF6BPeboCxfJ2sP3r60TL+WbOwFo5bn2Kmw4vOyg59?=
 =?us-ascii?Q?dtLm6zs7aaL5h9PXSTS1JHG8cH0/FDaV3iRSj35jCNRtOk/nJJXA/Bunz3ID?=
 =?us-ascii?Q?7gEyzI1kquNK1rX1PYDFNxH9hYkAuc+Buuyhm94xKRxAE7y0JWlC54qsYDXN?=
 =?us-ascii?Q?HCXfgbAtkOf41J1srH+4FEAUXRuuAKOvpfppZhLM5hwsdkHqhfntBVOZLPFS?=
 =?us-ascii?Q?J77T88uMuMFLNQbyOOO0FocdJXaEh0lhmADdkRVxpxFGmqERcu64hBbs+41B?=
 =?us-ascii?Q?VCReWFU40YchWmqBvyfxk7ZxAVu9yOerr5MC9DKHdhjY/KrdwcVi5QG1WREt?=
 =?us-ascii?Q?LyJ3prmRJ6HU/RC9K23M/MhwJWgUvea80B9fD+HMhfNmVB2d6gZiouHI/GTP?=
 =?us-ascii?Q?cmHoEEeM791Oj/UgohJWfYXOMkkWMK/tQwvdH09LEfdDwQd70VVxUG0rVpNQ?=
 =?us-ascii?Q?8c6O6E6fVYfpFwVa3nD1CLDz5Ob8aSsu9N6E2xPlXJYlRoup2+pAXOXunFtH?=
 =?us-ascii?Q?y2t+SW7U9FNGr68Fov5HMI+zfyXoL+sQZczgTvQxVYkCQv/ryTwQ11BUEo2d?=
 =?us-ascii?Q?UHzg1sKLftSdlpuzd/A/6831cfl3UtU4p9B+VOxX0ftlmvVIVvDwZtGA1s0l?=
 =?us-ascii?Q?g0ttKjqeprYGQ9eYknMs9O4sHVsBl26PJ5BMTVQNs9mga7OV2a2Yv8dW/YU4?=
 =?us-ascii?Q?P8UrYVvhgga1I8AQV145+ZfRi/bqqQJn92joMO5mLaMdrLDNx5RGOLjiVs8O?=
 =?us-ascii?Q?42GC5bnoZygmc6sVMtkGM//5vfJg+IE5TPSjPPSCpVOt6T4qKH2M4xT7OUPN?=
 =?us-ascii?Q?m8q0OO8RbyluLa2NPLrkGRLM+7sE/4sBiUkNiCf6cY7COZceXEU+C2RmUoQe?=
 =?us-ascii?Q?dsCrWmrKnsqoIAMngXkOC1+Ofb2XNiEqtIOHOqJtfByU9OvJkaqC6s0xd020?=
 =?us-ascii?Q?0XkaKQ1mKSyeN+fEScqFNt+5ycWqoo2TXuygZY30EWPGmyFw+fbbM8STV+EM?=
 =?us-ascii?Q?d3DvKrzD/Tz8Kv/w/sHM9c1UDSI9BcPBZ0CxTNFER65KllxlWeltN2h7n6aN?=
 =?us-ascii?Q?mWIptFr+jLHcNlOP5/a0NYY=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 342ceefb-c2bb-468d-1fef-08dbc325aaa2
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB1931.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 08:57:54.8283 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ihhLTryMSSX/uPucYkuZt+eapk4ztGjDIyKMneUIq7GKBoOeYeJ4ldqQI/h+0IpinXCMOJZp4kmVxOnyEwFHkgEvWSWeQGIv6hLuCKYxqQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8273
Received-SPF: pass client-ip=2a01:111:f400:fe16::713;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR02-VI1-obe.outbound.protection.outlook.com
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

Now dirty bitmaps can be loaded but there is no their saving. Add code for
dirty bitmap storage.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 block/parallels-ext.c | 167 ++++++++++++++++++++++++++++++++++++++++++
 block/parallels.c     |  16 +++-
 block/parallels.h     |   5 ++
 3 files changed, 186 insertions(+), 2 deletions(-)

diff --git a/block/parallels-ext.c b/block/parallels-ext.c
index 8a109f005a..0a632a2331 100644
--- a/block/parallels-ext.c
+++ b/block/parallels-ext.c
@@ -24,6 +24,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "block/block-io.h"
 #include "block/block_int.h"
@@ -301,3 +302,169 @@ out:
 
     return ret;
 }
+
+static void parallels_save_bitmap(BlockDriverState *bs, BdrvDirtyBitmap *bitmap,
+                                  uint8_t **buf, int *buf_size)
+{
+    BDRVParallelsState *s = bs->opaque;
+    ParallelsFeatureHeader *fh;
+    ParallelsDirtyBitmapFeature *bh;
+    uint64_t *l1_table, l1_size, granularity, limit;
+    int64_t bm_size, ser_size, offset, buf_used;
+    int64_t alloc_size = 1;
+    const char *name;
+    uint8_t *bm_buf;
+    QemuUUID uuid;
+    int ret = 0;
+
+    if (!bdrv_dirty_bitmap_get_persistence(bitmap) ||
+        bdrv_dirty_bitmap_inconsistent(bitmap)) {
+        return;
+    }
+
+    bm_size = bdrv_dirty_bitmap_size(bitmap);
+    granularity = bdrv_dirty_bitmap_granularity(bitmap);
+    limit = bdrv_dirty_bitmap_serialization_coverage(s->cluster_size, bitmap);
+    ser_size = bdrv_dirty_bitmap_serialization_size(bitmap, 0, bm_size);
+    l1_size = DIV_ROUND_UP(ser_size, s->cluster_size);
+
+    buf_used = l1_size * 8 + sizeof(*fh) + sizeof(*bh);
+    /* Check if there is enough space for the final section */
+    if (*buf_size - buf_used < sizeof(*fh)) {
+        return;
+    }
+
+    name = bdrv_dirty_bitmap_name(bitmap);
+    ret = qemu_uuid_parse(name, &uuid);
+    if (ret < 0) {
+        error_report("Can't save dirty bitmap: ID parsing error: '%s'", name);
+        return;
+    }
+
+    fh = (ParallelsFeatureHeader *)*buf;
+    bh = (ParallelsDirtyBitmapFeature *)(*buf + sizeof(*fh));
+    l1_table = (uint64_t *)((uint8_t *)bh + sizeof(*bh));
+
+    fh->magic = cpu_to_le64(PARALLELS_DIRTY_BITMAP_FEATURE_MAGIC);
+    fh->data_size = cpu_to_le32(l1_size * 8 + sizeof(*bh));
+
+    bh->l1_size = cpu_to_le32(l1_size);
+    bh->size = cpu_to_le64(bm_size >> BDRV_SECTOR_BITS);
+    bh->granularity = cpu_to_le32(granularity >> BDRV_SECTOR_BITS);
+    memcpy(bh->id, &uuid, sizeof(uuid));
+
+    bm_buf = qemu_blockalign(bs, s->cluster_size);
+
+    offset = 0;
+    while ((offset = bdrv_dirty_bitmap_next_dirty(bitmap, offset, bm_size)) >= 0) {
+        uint64_t idx = offset / limit;
+        int64_t cluster_off, end, write_size;
+
+        offset = QEMU_ALIGN_DOWN(offset, limit);
+        end = MIN(bm_size, offset + limit);
+        write_size = bdrv_dirty_bitmap_serialization_size(bitmap, offset,
+                                                          end - offset);
+        assert(write_size <= s->cluster_size);
+
+        bdrv_dirty_bitmap_serialize_part(bitmap, bm_buf, offset, end - offset);
+        if (write_size < s->cluster_size) {
+            memset(bm_buf + write_size, 0, s->cluster_size - write_size);
+        }
+
+        cluster_off = parallels_allocate_host_clusters(bs, &alloc_size);
+        if (cluster_off <= 0) {
+            goto end;
+        }
+
+        ret = bdrv_pwrite(bs->file, cluster_off, s->cluster_size, bm_buf, 0);
+        if (ret < 0) {
+            memset(&fh->magic, 0, sizeof(fh->magic));
+            parallels_mark_unused(bs, s->used_bmap, s->used_bmap_size,
+                                  cluster_off, 1);
+            goto end;
+        }
+
+        l1_table[idx] = cpu_to_le64(cluster_off >> BDRV_SECTOR_BITS);
+        offset = end;
+    }
+
+    *buf_size -= buf_used;
+    *buf += buf_used;
+
+end:
+    qemu_vfree(bm_buf);
+}
+
+void parallels_store_persistent_dirty_bitmaps(BlockDriverState *bs,
+                                              Error **errp)
+{
+    BDRVParallelsState *s = bs->opaque;
+    BdrvDirtyBitmap *bitmap;
+    ParallelsFormatExtensionHeader *eh;
+    int remaining = s->cluster_size;
+    uint8_t *buf, *pos;
+    int64_t header_off, alloc_size = 1;
+    g_autofree uint8_t *hash = NULL;
+    size_t hash_len = 0;
+    int ret;
+
+    s->header->ext_off = 0;
+
+    if (!bdrv_has_named_bitmaps(bs)) {
+        return;
+    }
+
+    buf = qemu_blockalign0(bs, s->cluster_size);
+
+    eh = (ParallelsFormatExtensionHeader *)buf;
+    pos = buf + sizeof(*eh);
+
+    eh->magic = cpu_to_le64(PARALLELS_FORMAT_EXTENSION_MAGIC);
+
+    FOR_EACH_DIRTY_BITMAP(bs, bitmap) {
+        parallels_save_bitmap(bs, bitmap, &pos, &remaining);
+    }
+
+    header_off = parallels_allocate_host_clusters(bs, &alloc_size);
+    if (header_off < 0) {
+        error_report("Can't save dirty bitmap: cluster allocation error");
+        ret = header_off;
+        goto end;
+    }
+
+    ret = qcrypto_hash_bytes(QCRYPTO_HASH_ALG_MD5,
+                             (const char *)(buf + sizeof(*eh)),
+                             s->cluster_size - sizeof(*eh),
+                             &hash, &hash_len, errp);
+    if (ret < 0 || hash_len != sizeof(eh->check_sum)) {
+        error_report("Can't save dirty bitmap: hash error");
+        ret = -EINVAL;
+        goto end;
+    }
+    memcpy(eh->check_sum, hash, hash_len);
+
+    ret = bdrv_pwrite(bs->file, header_off, s->cluster_size, buf, 0);
+    if (ret < 0) {
+        error_report("Can't save dirty bitmap: IO error");
+        parallels_mark_unused(bs, s->used_bmap, s->used_bmap_size,
+                              header_off, 1);
+        goto end;
+    }
+
+    s->header->ext_off = cpu_to_le64(header_off / BDRV_SECTOR_SIZE);
+end:
+    qemu_vfree(buf);
+}
+
+bool coroutine_fn parallels_co_can_store_new_dirty_bitmap(BlockDriverState *bs,
+                                                          const char *name,
+                                                          uint32_t granularity,
+                                                          Error **errp)
+{
+    if (bdrv_find_dirty_bitmap(bs, name)) {
+        error_setg(errp, "Bitmap already exists: %s", name);
+        return false;
+    }
+
+    return true;
+}
diff --git a/block/parallels.c b/block/parallels.c
index adb43a7069..d2a45e0c04 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -1464,14 +1464,25 @@ fail:
 static int parallels_inactivate(BlockDriverState *bs)
 {
     BDRVParallelsState *s = bs->opaque;
+    Error *err = NULL;
     int ret;
 
+    parallels_store_persistent_dirty_bitmaps(bs, &err);
+    if (err != NULL) {
+        error_reportf_err(err, "Lost persistent bitmaps during "
+                          "inactivation of node '%s': ",
+                          bdrv_get_device_or_node_name(bs));
+    }
+
     s->header->inuse = 0;
     parallels_update_header(bs);
 
     /* errors are ignored, so we might as well pass exact=true */
-    ret = bdrv_truncate(bs->file, s->data_end << BDRV_SECTOR_BITS, true,
-                        PREALLOC_MODE_OFF, 0, NULL);
+    ret = bdrv_truncate(bs->file, s->data_end << BDRV_SECTOR_BITS,
+                        true, PREALLOC_MODE_OFF, 0, NULL);
+    if (ret < 0) {
+        error_report("Failed to truncate image: %s", strerror(-ret));
+    }
 
     return ret;
 }
@@ -1522,6 +1533,7 @@ static BlockDriver bdrv_parallels = {
     .bdrv_co_pdiscard           = parallels_co_pdiscard,
     .bdrv_co_pwrite_zeroes      = parallels_co_pwrite_zeroes,
     .bdrv_inactivate            = parallels_inactivate,
+    .bdrv_co_can_store_new_dirty_bitmap = parallels_co_can_store_new_dirty_bitmap,
 };
 
 static void bdrv_parallels_init(void)
diff --git a/block/parallels.h b/block/parallels.h
index 4e7aa6b80f..18b4f8068e 100644
--- a/block/parallels.h
+++ b/block/parallels.h
@@ -100,6 +100,11 @@ int64_t parallels_allocate_host_clusters(BlockDriverState *bs,
 
 int parallels_read_format_extension(BlockDriverState *bs,
                                     int64_t ext_off, Error **errp);
+void parallels_store_persistent_dirty_bitmaps(BlockDriverState *bs,
+                                              Error **errp);
+bool coroutine_fn
+parallels_co_can_store_new_dirty_bitmap(BlockDriverState *bs, const char *name,
+                                        uint32_t granularity, Error **errp);
 
 
 #endif
-- 
2.34.1


