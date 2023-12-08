Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D4280A546
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 15:19:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBbgF-0005uH-IU; Fri, 08 Dec 2023 09:18:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daejun7.park@samsung.com>)
 id 1rBU7Z-0005ua-Pz
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 01:13:58 -0500
Received: from mailout3.samsung.com ([203.254.224.33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daejun7.park@samsung.com>)
 id 1rBU7V-0003lj-7R
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 01:13:57 -0500
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20231208061350epoutp03e8c4c9bd66fd9ce01f0519c72daf6c8f~exo-450bq2769227692epoutp03V
 for <qemu-devel@nongnu.org>; Fri,  8 Dec 2023 06:13:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20231208061350epoutp03e8c4c9bd66fd9ce01f0519c72daf6c8f~exo-450bq2769227692epoutp03V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1702016030;
 bh=UJAwXbUBpNhblGN3NC7suRaBoeMvvD3zzXXDfL7xeT0=;
 h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
 b=fC2PQawvSv52r71yzC5p88+Ip+AZeuhurcGhfCYlL1+kBHz/9kXpyWZQPyJfaAd8W
 bDhiA+s7b5c2FjyxJE4TV1SfeLfA8/gTy3DVxvQDzWgAOD7hqtYrFIxR2oFth0l37C
 TE+8kz6QTgEmiO4vzGDmv7eJISRuz8XcygUC6Ecs=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTP id
 20231208061350epcas2p1dd29736baa2b23b4c52eb94284c3281e~exo-hdyrK0517805178epcas2p1U;
 Fri,  8 Dec 2023 06:13:50 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.97]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4SmgnR2W9Xz4x9Pw; Fri,  8 Dec
 2023 06:13:47 +0000 (GMT)
X-AuditID: b6c32a45-3ebfd70000002716-c3-6572b40bd01a
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
 epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 F5.C3.10006.B04B2756; Fri,  8 Dec 2023 15:13:31 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH 1/3] hw/ufs: Support for Zoned UFS
From: Daejun Park <daejun7.park@samsung.com>
To: Jeuk Kim <jeuk20.kim@samsung.com>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "fam@euphon.net" <fam@euphon.net>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: JinHwan Park <jh.i.park@samsung.com>, Seokhwan Kim
 <sukka.kim@samsung.com>, Yonggil Song <yonggil.song@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20231208060902epcms2p3810b29fefbddaf16a7f3f2758cf218ba@epcms2p3>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20231208061330epcms2p2f742a2d517b6836eca695a9b59bd109c@epcms2p2>
Date: Fri, 08 Dec 2023 15:13:30 +0900
X-CMS-MailID: 20231208061330epcms2p2f742a2d517b6836eca695a9b59bd109c
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnk+LIzCtJLcpLzFFi42LZdljTQpd7S1GqwcPjmhYvD2laXNl/ntHi
 /tZrjBb9/9pZLPZv+8dqcbx3B4vFqo65jBZTzx9hcuDw+HGunc3jybXNTB7v911l8+jbsoox
 gCUq2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6Awl
 hbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToF5gV5xYm5xaV66Xl5qiZWhgYGRKVBh
 QnZGz+ELLAXL9jNWPH39kq2BcWcrYxcjJ4eEgInE2SWfmboYuTiEBHYwSly/toali5GDg1dA
 UOLvDmGQGmEBI4knbxYzg9hCAkoS6y/OYoeI60ncergGbA6bgI7E9BP3weIiAqsYJR5NkgSx
 mQUqJbbPvQm1i1diRvtTFghbWmL78q1gcU4BP4klPycyQcQ1JH4s62WGsEUlbq5+yw5jvz82
 H2qOiETrvbNQNYISD37uhopLStyeuwmqPl/i/5XlUHaNxLYD86BsfYlrHRvBbuAV8JW4d3Ui
 2BwWAVWJ16vvskHUuEg0fPzFCHG/vMT2t3OYQUHCLKApsX6XPogpIaAsceQWC0QFn0TH4b/s
 MB82bPyNlb1j3hOoD9Uk1v1czzSBUXkWIpxnIdk1C2HXAkbmVYxiqQXFuempxUYFhvDITc7P
 3cQITpFarjsYJ7/9oHeIkYmD8RCjBAezkghvzvn8VCHelMTKqtSi/Pii0pzU4kOMpkBfTmSW
 Ek3OBybpvJJ4QxNLAxMzM0NzI1MDcyVx3nutc1OEBNITS1KzU1MLUotg+pg4OKUamEwmaD+3
 f/2YjUuwWWFil/y573tfqqbpCu16acyazvyheZuolgjbkj//99aYpNwWNPOuOiv3xOzWFNEt
 f2aK16mxTxLo7L3zQro0vOIrt2nkX9Y3DHVNGx+m5+8qjZIP2Fw3WZlhlsL/yemtF3blLhB/
 YGFY23l4/duduZ7TUyce+ZyvdSSvbjfvwt0rRa2yN01sPupdqdW5vY7hzYzS6dy7vzMIfQgX
 Y+5pvsZeYfwy38PKq+bV7tKu7Rn/bTbWfg/eIKz4SHKhdvffQ2/YS90yw2RVWrglZoXnx7WZ
 hn69cj9d9G9W7vLKPrPDzOvV2GIn6aQamW2ySJdjFHXV3eMftEg/KuZZ+6dipf9KLMUZiYZa
 zEXFiQADs+yAGgQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231208060902epcms2p3810b29fefbddaf16a7f3f2758cf218ba
References: <20231208060902epcms2p3810b29fefbddaf16a7f3f2758cf218ba@epcms2p3>
 <CGME20231208060902epcms2p3810b29fefbddaf16a7f3f2758cf218ba@epcms2p2>
Received-SPF: pass client-ip=203.254.224.33;
 envelope-from=daejun7.park@samsung.com; helo=mailout3.samsung.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 08 Dec 2023 09:17:30 -0500
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
Reply-To: daejun7.park@samsung.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

This patch enables zoned ufs support.

By setting the LU parameter, each LU can be a host-managed zoned device.
This patch manages the zone condition and write pointer of each zone for
a zoned LU. It supports the report zones and reset write pointer commands
for Zoned LUs.

Signed-off-by: Daejun Park <daejun7.park@samsung.com>
---
 hw/ufs/lu.c         | 616 ++++++++++++++++++++++++++++++++++++++++++++
 hw/ufs/ufs.c        |   6 +-
 hw/ufs/ufs.h        |  32 +++
 include/block/ufs.h |  31 +++
 4 files changed, 684 insertions(+), 1 deletion(-)

diff --git a/hw/ufs/lu.c b/hw/ufs/lu.c
index 81bfff9b4e..e709b75f38 100644
--- a/hw/ufs/lu.c
+++ b/hw/ufs/lu.c
@@ -20,6 +20,7 @@
 #include "ufs.h"
 
 #define SCSI_COMMAND_FAIL (-1)
+#define REPORT_ZONES_DESC_HD_SIZE (64)
 
 static void ufs_build_upiu_sense_data(UfsRequest *req, uint8_t *sense,
                                       uint32_t sense_len)
@@ -59,6 +60,79 @@ static void ufs_build_scsi_response_upiu(UfsRequest *req, uint8_t *sense,
                           status, data_segment_length);
 }
 
+static inline uint32_t ufs_zone_idx(UfsLu *lu, uint64_t lba)
+{
+    return lba / lu->zone_desc.zone_size;
+}
+
+static inline UfsZoneState *ufs_get_zone_by_lba(UfsLu *lu, uint64_t lba)
+{
+    uint32_t zone_idx = ufs_zone_idx(lu, lba);
+
+    if (zone_idx >= lu->zone_desc.nr_zones) {
+        return NULL;
+    }
+
+    return &lu->zone_array[zone_idx];
+}
+
+static void ufs_assign_zone_cond(UfsLu *lu, UfsZoneState *zone,
+                                 UfsZoneCond new_cond)
+{
+    switch (zone->cond) {
+    case ZONE_COND_IMPLICIT_OPEN:
+    case ZONE_COND_EXPLICIT_OPEN:
+        lu->zone_desc.nr_open--;
+        break;
+    case ZONE_COND_CLOSED:
+    case ZONE_COND_FULL:
+        break;
+    default:
+        break;
+    }
+
+    zone->cond = new_cond;
+
+    switch (new_cond) {
+    case ZONE_COND_EMPTY:
+        zone->wp = zone->start;
+        break;
+    case ZONE_COND_IMPLICIT_OPEN:
+    case ZONE_COND_EXPLICIT_OPEN:
+        lu->zone_desc.nr_open++;
+        break;
+    case ZONE_COND_CLOSED:
+    case ZONE_COND_FULL:
+    case ZONE_COND_READ_ONLY:
+        break;
+    default:
+        break;
+    }
+}
+
+static inline uint64_t ufs_zone_wr_boundary(UfsLu *lu, UfsZoneState *zone)
+{
+    return zone->start + lu->zone_desc.zone_cap;
+}
+
+static int ufs_full_zone(UfsLu *lu, UfsZoneState *zone)
+{
+    switch (zone->cond) {
+    case ZONE_COND_IMPLICIT_OPEN:
+    case ZONE_COND_EXPLICIT_OPEN:
+        ufs_assign_zone_cond(lu, zone, ZONE_COND_FULL);
+        return 0;
+
+    case ZONE_COND_EMPTY:
+    case ZONE_COND_CLOSED:
+    case ZONE_COND_READ_ONLY:
+    case ZONE_COND_FULL:
+    case ZONE_COND_OFFLINE:
+    default:
+        return SCSI_COMMAND_FAIL;
+    }
+}
+
 static void ufs_scsi_command_complete(SCSIRequest *scsi_req, size_t resid)
 {
     UfsRequest *req = scsi_req->hba_private;
@@ -81,6 +155,29 @@ static QEMUSGList *ufs_get_sg_list(SCSIRequest *scsi_req)
     return req->sg;
 }
 
+static int ufs_open_zone(UfsLu *lu, UfsZoneState *zone)
+{
+    switch (zone->cond) {
+    case ZONE_COND_EMPTY:
+    case ZONE_COND_CLOSED:
+        if (lu->zone_desc.nr_open >= lu->zone_desc.max_open) {
+            return SCSI_COMMAND_FAIL;
+        }
+        ufs_assign_zone_cond(lu, zone, ZONE_COND_IMPLICIT_OPEN);
+        return 0;
+
+    case ZONE_COND_IMPLICIT_OPEN:
+    case ZONE_COND_EXPLICIT_OPEN:
+        return 0;
+
+    case ZONE_COND_FULL:
+    case ZONE_COND_READ_ONLY:
+    case ZONE_COND_OFFLINE:
+    default:
+        return SCSI_COMMAND_FAIL;
+    }
+}
+
 static const struct SCSIBusInfo ufs_scsi_info = {
     .tcq = true,
     .max_target = 0,
@@ -190,6 +287,430 @@ static int ufs_emulate_wlun_inquiry(UfsRequest *req, uint8_t *outbuf,
 
     return SCSI_INQUIRY_LEN;
 }
+static int ufs_emulate_zbc_vpd_page(UfsLu *lu, UfsRequest *req, uint8_t *outbuf,
+                                    uint32_t outbuf_len)
+{
+    uint8_t page_code = req->req_upiu.sc.cdb[2];
+    int start, buflen = 0;
+
+    outbuf[buflen++] = TYPE_ZBC;
+    outbuf[buflen++] = page_code;
+    outbuf[buflen++] = 0x00;
+    outbuf[buflen++] = 0x00;
+    start = buflen;
+
+    switch (page_code) {
+    case 0x00: /* Supported page codes, mandatory */
+    {
+        outbuf[buflen++] = 0x00; /* list of supported pages (this page) */
+        outbuf[buflen++] = 0x87; /* mode page policy */
+        outbuf[buflen++] = 0xb1; /* block device characteristics */
+        outbuf[buflen++] = 0xb6; /* ZBC device characteristics */
+        break;
+    }
+    case 0xb6: /* ZBC device characteristics */
+    {
+        outbuf[buflen++] = 0x01; /* Host aware zoned block device model */
+        /* reserved */
+        outbuf[buflen++] = 0x00;
+        outbuf[buflen++] = 0x00;
+        outbuf[buflen++] = 0x00;
+
+        /* optimal number of open sequential write preferred zones */
+        stl_be_p(&outbuf[buflen], 0xffffffff);
+        buflen += 4;
+
+        /* optimal number of non-seq. written seq. write preferred zones  */
+        stl_be_p(&outbuf[buflen], 0xffffffff);
+        buflen += 4;
+
+        /* maximum number of open sequential write required zones */
+        if (lu->zone_desc.max_open) {
+            stl_be_p(&outbuf[buflen], lu->zone_desc.max_open);
+            buflen += 4;
+        }
+
+        /* reserved */
+        outbuf[buflen++] = 0x00;
+        outbuf[buflen++] = 0x00;
+        outbuf[buflen++] = 0x00;
+        break;
+    }
+    default:
+        return SCSI_COMMAND_FAIL;
+    }
+    /* done with EVPD */
+    assert(buflen - start <= 255);
+    outbuf[start - 1] = buflen - start;
+    return buflen;
+}
+
+static int ufs_scsi_emulate_zbc_in(UfsLu *lu, UfsRequest *req, uint8_t *outbuf)
+{
+    uint8_t *cdb = req->req_upiu.sc.cdb;
+    uint64_t zone_start_lba, lba,
+        max_lba = be64_to_cpu(lu->unit_desc.logical_block_count);
+    uint32_t alloc_len, rep_opts, buf_offset;
+    bool partial;
+    unsigned int rep_max_zones, num_zones = 0;
+    UfsZoneState *zone;
+
+    if (cdb[1] != ZI_REPORT_ZONES) {
+        return SCSI_COMMAND_FAIL;
+    }
+
+    zone_start_lba = ldq_be_p(&cdb[2]);
+    alloc_len = ldl_be_p(&cdb[10]);
+
+    if (alloc_len == 0) {
+        return 0;
+    }
+    rep_opts = cdb[14] & 0x3f;
+    partial = cdb[14] & 0x80;
+
+    if (zone_start_lba > max_lba) {
+        return SCSI_COMMAND_FAIL;
+    }
+
+    rep_max_zones = alloc_len / REPORT_ZONES_DESC_HD_SIZE;
+    buf_offset = REPORT_ZONES_DESC_HD_SIZE;
+
+    for (lba = zone_start_lba; lba < max_lba; lba = zone->start + zone->size) {
+        zone = ufs_get_zone_by_lba(lu, lba);
+        if (!zone) {
+            break;
+        }
+
+        switch (rep_opts) {
+        case 0x00:
+            /* All zones */
+            break;
+        case 0x01:
+            /* Empty zones */
+            if (zone->cond != ZONE_COND_EMPTY) {
+                continue;
+            }
+            break;
+        case 0x02:
+            /* Implicit open zones */
+            if (zone->cond != ZONE_COND_IMPLICIT_OPEN) {
+                continue;
+            }
+            break;
+        case 0x03:
+            /* Explicit open zones */
+            if (zone->cond != ZONE_COND_EXPLICIT_OPEN) {
+                continue;
+            }
+            break;
+        case 0x04:
+            /* Closed zones */
+            if (zone->cond != ZONE_COND_CLOSED) {
+                continue;
+            }
+            break;
+        case 0x05:
+            /* Full zones */
+            if (zone->cond != ZONE_COND_FULL) {
+                continue;
+            }
+            break;
+        case 0x06:
+        case 0x07:
+        case 0x10:
+            /*
+             * Read-only, offline, reset WP recommended are
+             * not emulated: no zones to report;
+             */
+            continue;
+        case 0x11:
+            /* non-seq-resource set */
+            break;
+        case 0x3e:
+            /* All zones except gap zones. */
+            break;
+        case 0x3f:
+            /* Not write pointer (conventional) zones */
+            break;
+        default:
+            return SCSI_COMMAND_FAIL;
+        }
+
+        if (num_zones < rep_max_zones) {
+            /* Fill zone descriptor */
+            outbuf[0 + buf_offset] = zone->type;
+            outbuf[1 + buf_offset] = zone->cond << 4;
+
+            stq_be_p(&outbuf[8 + buf_offset], zone->size);
+            stq_be_p(&outbuf[16 + buf_offset], zone->start);
+            stq_be_p(&outbuf[24 + buf_offset], zone->wp);
+            buf_offset += REPORT_ZONES_DESC_HD_SIZE;
+        }
+
+        if (partial && num_zones >= rep_max_zones) {
+            break;
+        }
+
+        num_zones++;
+    }
+
+    /* Report header */
+    /* Zone list length. */
+    stl_be_p(&outbuf[0], num_zones * REPORT_ZONES_DESC_HD_SIZE);
+    /* Maximum LBA */
+    stq_be_p(&outbuf[8], be64_to_cpu(lu->unit_desc.logical_block_count) - 1);
+    /* Zone starting LBA granularity. */
+    if (lu->zone_desc.zone_cap < lu->zone_desc.zone_size) {
+        stq_be_p(&outbuf[16], lu->zone_desc.zone_size);
+    }
+
+    return buf_offset;
+}
+
+static void ufs_reset_write_pointer_zone(UfsLu *lu, UfsZoneState *zone)
+{
+    switch (zone->cond) {
+    case ZONE_COND_EMPTY:
+        /* nothing to do */
+        break;
+    case ZONE_COND_IMPLICIT_OPEN:
+    case ZONE_COND_EXPLICIT_OPEN:
+    case ZONE_COND_READ_ONLY:
+    case ZONE_COND_OFFLINE:
+        /* ignore reset write pointer */
+        break;
+    case ZONE_COND_CLOSED:
+    case ZONE_COND_FULL:
+        ufs_assign_zone_cond(lu, zone, ZONE_COND_EMPTY);
+        break;
+    default:
+        break;
+    }
+}
+
+static void ufs_reset_write_pointer_all(UfsLu *lu)
+{
+    unsigned int i;
+
+    for (i = 0; i < lu->zone_desc.nr_zones; i++) {
+        ufs_reset_write_pointer_zone(lu, &lu->zone_array[i]);
+    }
+}
+
+static int ufs_scsi_emulate_zbc_out(UfsLu *lu, UfsRequest *req)
+{
+    uint8_t *cdb = req->req_upiu.sc.cdb;
+    uint64_t zone_start_lba,
+        max_lba = be64_to_cpu(lu->unit_desc.logical_block_count);
+    UfsZoneState *zone;
+
+    switch (cdb[1]) {
+    case ZO_CLOSE_ZONE:
+        break;
+    case ZO_FINISH_ZONE: {
+        zone_start_lba = ldq_be_p(&cdb[2]);
+
+        if (zone_start_lba > max_lba) {
+            /* overflow lba range */
+            return SCSI_COMMAND_FAIL;
+        }
+
+        zone = ufs_get_zone_by_lba(lu, zone_start_lba);
+
+        if (zone_start_lba != zone->start) {
+            /* invalid field error */
+            return SCSI_COMMAND_FAIL;
+        }
+
+        if (ufs_full_zone(lu, zone)) {
+            /* fail to finish zone */
+            return SCSI_COMMAND_FAIL;
+        }
+        break;
+    }
+    case ZO_OPEN_ZONE:
+        /* TODO: support open zone command */
+        break;
+
+    case ZO_RESET_WRITE_POINTER: {
+        bool all = cdb[14] & 0x01;
+
+        if (all) {
+            ufs_reset_write_pointer_all(lu);
+            return 0;
+        }
+
+        zone_start_lba = ldq_be_p(&cdb[2]);
+
+        if (zone_start_lba > max_lba) {
+            /* overflow lba range */
+            return SCSI_COMMAND_FAIL;
+        }
+
+        zone = ufs_get_zone_by_lba(lu, zone_start_lba);
+
+        if ((zone->cond == ZONE_COND_READ_ONLY) ||
+            (zone->cond == ZONE_COND_OFFLINE))
+            return SCSI_COMMAND_FAIL;
+
+        if (zone_start_lba != zone->start) {
+            /* invalid field error */
+            return SCSI_COMMAND_FAIL;
+        }
+
+        ufs_reset_write_pointer_zone(lu, zone);
+        break;
+    }
+    default:
+        return SCSI_COMMAND_FAIL;
+    }
+
+    return 0;
+}
+
+static int ufs_check_zone_state_for_write(UfsZoneState *zone)
+{
+    switch (zone->cond) {
+    case ZONE_COND_EMPTY:
+    case ZONE_COND_IMPLICIT_OPEN:
+    case ZONE_COND_EXPLICIT_OPEN:
+    case ZONE_COND_CLOSED:
+        return 0;
+
+    case ZONE_COND_FULL:
+    case ZONE_COND_READ_ONLY:
+    case ZONE_COND_OFFLINE:
+    default:
+        return SCSI_COMMAND_FAIL;
+    }
+}
+
+/* Unaligned Write fail */
+const struct SCSISense sense_code_UNALIGNED_WRITE = { .key = ILLEGAL_REQUEST,
+                                                      .asc = 0x21,
+                                                      .ascq = 0x04 };
+
+/* Insufficient zone resource fail */
+const struct SCSISense sense_code_INSUFFICENT_ZONE_RESOURCES = {
+    .key = DATA_PROTECT, .asc = 0x0C, .ascq = 0x12
+};
+
+
+static int ufs_check_zone_write(UfsLu *lu, UfsZoneState *zone, uint64_t lba,
+                                uint32_t len)
+{
+    if (ufs_check_zone_state_for_write(zone)) {
+        return SCSI_COMMAND_FAIL;
+    }
+
+    if (unlikely((lba + len) > ufs_zone_wr_boundary(lu, zone))) {
+        return SCSI_COMMAND_FAIL;
+    }
+
+    return 0;
+}
+
+static UfsReqResult ufs_emulate_zbc_cmd(UfsLu *lu, UfsRequest *req)
+{
+    g_autofree uint8_t *outbuf = NULL;
+    uint8_t sense_buf[UFS_SENSE_SIZE];
+    uint8_t scsi_status;
+    int len = 0;
+
+    switch (req->req_upiu.sc.cdb[0]) {
+    case WRITE_6:
+    case WRITE_10:
+        scsi_build_sense(sense_buf, SENSE_CODE(INVALID_FIELD));
+        scsi_status = CHECK_CONDITION;
+        break;
+    case WRITE_16: {
+        uint64_t lba = ldq_be_p(&req->req_upiu.sc.cdb[2]);
+        uint32_t req_len = ldl_be_p(&req->req_upiu.sc.cdb[10]);
+        UfsZoneState *zone = ufs_get_zone_by_lba(lu, lba);
+
+        if (unlikely(lba != zone->wp)) {
+            /* unaligned write error */
+            scsi_build_sense(sense_buf, SENSE_CODE(UNALIGNED_WRITE));
+            scsi_status = CHECK_CONDITION;
+            break;
+        }
+
+        len = ufs_check_zone_write(lu, zone, lba, req_len);
+        if (len == SCSI_COMMAND_FAIL) {
+            scsi_build_sense(sense_buf, SENSE_CODE(INVALID_FIELD));
+            scsi_status = CHECK_CONDITION;
+            break;
+        }
+
+        len = ufs_open_zone(lu, zone);
+        if (len == SCSI_COMMAND_FAIL) {
+            scsi_build_sense(sense_buf, SENSE_CODE(INSUFFICENT_ZONE_RESOURCES));
+            scsi_status = CHECK_CONDITION;
+            break;
+        }
+
+        zone->wp += req_len;
+
+        if (zone->wp == ufs_zone_wr_boundary(lu, zone)) {
+            ufs_full_zone(lu, zone);
+        }
+        return UFS_REQUEST_NO_COMPLETE;
+    }
+    case ZBC_IN:
+        outbuf = g_new0(uint8_t, req->data_len + REPORT_ZONES_DESC_HD_SIZE);
+        len = ufs_scsi_emulate_zbc_in(lu, req, outbuf);
+        if (len == SCSI_COMMAND_FAIL) {
+            scsi_build_sense(sense_buf, SENSE_CODE(INVALID_FIELD));
+            scsi_status = CHECK_CONDITION;
+        } else {
+            scsi_status = GOOD;
+        }
+        break;
+    case ZBC_OUT:
+        len = ufs_scsi_emulate_zbc_out(lu, req);
+        if (len == SCSI_COMMAND_FAIL) {
+            scsi_build_sense(sense_buf, SENSE_CODE(INVALID_FIELD));
+            scsi_status = CHECK_CONDITION;
+        } else {
+            scsi_status = GOOD;
+        }
+        break;
+    case INQUIRY:
+        /* bypass standard inquiry */
+        if (!(req->req_upiu.sc.cdb[1] & 0x1)) {
+            return UFS_REQUEST_NO_COMPLETE;
+        }
+        /* processing only ZBC related page codes */
+        if (!(req->req_upiu.sc.cdb[2] == 0x00) &&
+            !(req->req_upiu.sc.cdb[2] == 0xb6)) {
+            return UFS_REQUEST_NO_COMPLETE;
+        }
+        /* Vital product data */
+        outbuf = g_new0(uint8_t, UFS_BLOCK_SIZE);
+        len = ufs_emulate_zbc_vpd_page(lu, req, outbuf, UFS_BLOCK_SIZE);
+        if (len == SCSI_COMMAND_FAIL) {
+            scsi_build_sense(sense_buf, SENSE_CODE(INVALID_FIELD));
+            scsi_status = CHECK_CONDITION;
+        } else {
+            scsi_status = GOOD;
+        }
+        break;
+    default:
+        return UFS_REQUEST_NO_COMPLETE;
+    }
+
+    len = MIN(len, (int)req->data_len);
+    if (scsi_status == GOOD && len > 0 &&
+        dma_buf_read(outbuf, len, NULL, req->sg, MEMTXATTRS_UNSPECIFIED) !=
+            MEMTX_OK) {
+        return UFS_REQUEST_FAIL;
+    }
+
+    ufs_build_scsi_response_upiu(req, sense_buf, sizeof(sense_buf), len,
+                                 scsi_status);
+
+    return UFS_REQUEST_SUCCESS;
+}
 
 static UfsReqResult ufs_emulate_scsi_cmd(UfsLu *lu, UfsRequest *req)
 {
@@ -252,6 +773,13 @@ static UfsReqResult ufs_process_scsi_cmd(UfsLu *lu, UfsRequest *req)
 {
     uint8_t task_tag = req->req_upiu.header.task_tag;
 
+    if (lu->zone_enabled) {
+        UfsReqResult result = ufs_emulate_zbc_cmd(lu, req);
+        /* UFS_REQUEST_NO_COMPLETE continues command processing */
+        if (result != UFS_REQUEST_NO_COMPLETE) {
+            return result;
+        }
+    }
     /*
      * Each ufs-lu has its own independent virtual SCSI bus. Therefore, we can't
      * use scsi_target_emulate_report_luns() which gets all lu information over
@@ -277,6 +805,11 @@ static UfsReqResult ufs_process_scsi_cmd(UfsLu *lu, UfsRequest *req)
 static Property ufs_lu_props[] = {
     DEFINE_PROP_DRIVE("drive", UfsLu, conf.blk),
     DEFINE_PROP_UINT8("lun", UfsLu, lun, 0),
+    DEFINE_PROP_BOOL("zoned", UfsLu, params.zoned, false),
+    DEFINE_PROP_SIZE("zoned.zone_size", UfsLu, params.zone_size,
+                     UFS_DEFAULT_ZONE_SIZE /* 128MiB */),
+    DEFINE_PROP_SIZE("zoned.zone_capacity", UfsLu, params.zone_cap, 0),
+    DEFINE_PROP_UINT32("zoned.max_open", UfsLu, params.zone_max_open, 6),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -310,12 +843,84 @@ void ufs_init_wlu(UfsLu *wlu, uint8_t wlun)
     wlu->scsi_op = &ufs_emulate_scsi_cmd;
 }
 
+static void ufs_zoned_init_state(UfsLu *lu)
+{
+    uint64_t start = 0, zone_size = lu->zone_desc.zone_size;
+    uint64_t nblocks = be64_to_cpu(lu->unit_desc.logical_block_count);
+    UfsZoneState *zone;
+    int i;
+
+    lu->zone_array = g_new0(UfsZoneState, lu->zone_desc.nr_zones);
+    zone = lu->zone_array;
+
+    for (i = 0; i < lu->zone_desc.nr_zones; i++, zone++) {
+        if (start + zone_size > nblocks) {
+            zone_size = nblocks - start;
+        }
+        zone->id = i;
+        /* SEQUENTIAL WRITE REQUIRED */
+        zone->type = 0x2;
+        zone->cond = ZONE_COND_EMPTY;
+        zone->start = start;
+        zone->size = zone_size;
+        zone->wp = start;
+
+        start += zone_size;
+    }
+}
+
+static void ufs_lu_init_zoned(UfsLu *lu)
+{
+    ufs_zoned_init_state(lu);
+
+    lu->zone_desc.nr_open = 0;
+    lu->zone_desc.max_open = lu->params.zone_max_open;
+    lu->zone_enabled = true;
+
+    /* Host-managed zoned block device */
+    lu->scsi_dev->type = TYPE_ZBC;
+}
+
+static int ufs_lu_zoned_check_calc_geometry(UfsLu *lu, Error **errp)
+{
+    uint64_t zone_size = lu->params.zone_size, zone_cap = lu->params.zone_cap,
+             nr_blocks;
+
+    if (!zone_cap) {
+        zone_cap = zone_size;
+    }
+
+    if (zone_cap > zone_size) {
+        error_setg(errp,
+                   "zone capacity %" PRIu64 "B exceeds "
+                   "zone size %" PRIu64 "B",
+                   zone_cap, zone_size);
+        return -1;
+    }
+
+    nr_blocks = be64_to_cpu(lu->unit_desc.logical_block_count);
+    lu->zone_desc.zone_size = zone_size / UFS_BLOCK_SIZE;
+    lu->zone_desc.zone_cap = zone_cap / UFS_BLOCK_SIZE;
+    lu->zone_desc.nr_zones = DIV_ROUND_UP(nr_blocks, lu->zone_desc.zone_size);
+
+    if (!lu->zone_desc.nr_zones) {
+        error_setg(errp,
+                   "insufficient drive capacity, must be at least the size "
+                   "of one zone (%" PRIu64 "B)",
+                   zone_size);
+        return -1;
+    }
+
+    return 0;
+}
+
 static void ufs_init_lu(UfsLu *lu)
 {
     BlockBackend *blk = lu->conf.blk;
     int64_t brdv_len = blk_getlength(blk);
 
     memset(&lu->unit_desc, 0, sizeof(lu->unit_desc));
+    lu->zone_enabled = false;
     lu->unit_desc.length = sizeof(UnitDescriptor);
     lu->unit_desc.descriptor_idn = UFS_QUERY_DESC_IDN_UNIT;
     lu->unit_desc.lu_enable = 0x01;
@@ -408,6 +1013,13 @@ static void ufs_lu_realize(DeviceState *dev, Error **errp)
     }
 
     ufs_init_scsi_device(lu, blk, errp);
+
+    if (lu->params.zoned) {
+        if (ufs_lu_zoned_check_calc_geometry(lu, errp)) {
+            return;
+        }
+        ufs_lu_init_zoned(lu);
+    }
 }
 
 static void ufs_lu_unrealize(DeviceState *dev)
@@ -418,6 +1030,10 @@ static void ufs_lu_unrealize(DeviceState *dev)
         object_unref(OBJECT(lu->scsi_dev));
         lu->scsi_dev = NULL;
     }
+    if (lu->zone_enabled) {
+        /* release zoned ufs structure */
+        g_free(lu->zone_array);
+    }
 }
 
 static void ufs_lu_class_init(ObjectClass *oc, void *data)
diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index 68c5f1f6c9..15faa634e4 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -18,7 +18,11 @@
  *      -drive file=<file>,if=none,id=<drive_id>
  *      -device ufs,serial=<serial>,id=<bus_name>, \
  *              nutrs=<N[optional]>,nutmrs=<N[optional]>
- *      -device ufs-lu,drive=<drive_id>,bus=<bus_name>
+ *      -device ufs-lu,drive=<drive_id>,bus=<bus_name>, \
+ *              zoned=<true|false[optional]>,
+ *              zoned.zone_size=<N[optional]>, \
+ *              zoned.zone_capacity=<N[optional]>, \
+ *              zoned.max_open=<N[optional]>
  */
 
 #include "qemu/osdep.h"
diff --git a/hw/ufs/ufs.h b/hw/ufs/ufs.h
index 8fda94f4ef..205df4d7d2 100644
--- a/hw/ufs/ufs.h
+++ b/hw/ufs/ufs.h
@@ -15,6 +15,26 @@
 #include "hw/scsi/scsi.h"
 #include "block/ufs.h"
 
+typedef struct UfsZoneState {
+    int id;
+    int type;
+    UfsZoneCond cond;
+    uint64_t start;
+    uint64_t size;
+    uint64_t wp;
+} UfsZoneState;
+
+/* For Zoned Ufs */
+typedef struct UfsZoneDescriptor {
+    unsigned int zone_cap;
+    unsigned int zone_size;
+    unsigned int nr_zones;
+    unsigned int nr_open;
+    unsigned int max_open;
+} UfsZoneDescriptor;
+
+#define UFS_DEFAULT_ZONE_SIZE (128 * MiB)
+
 #define UFS_MAX_LUS 32
 #define UFS_BLOCK_SIZE_SHIFT 12
 #define UFS_BLOCK_SIZE (1 << UFS_BLOCK_SIZE_SHIFT)
@@ -62,6 +82,13 @@ typedef struct UfsRequest {
 struct UfsLu;
 typedef UfsReqResult (*UfsScsiOp)(struct UfsLu *, UfsRequest *);
 
+typedef struct UfsLuParams {
+    bool zoned;
+    uint64_t zone_cap;
+    uint64_t zone_size;
+    uint32_t zone_max_open;
+} UfsLuParams;
+
 typedef struct UfsLu {
     DeviceState qdev;
     uint8_t lun;
@@ -70,6 +97,11 @@ typedef struct UfsLu {
     SCSIDevice *scsi_dev;
     BlockConf conf;
     UfsScsiOp scsi_op;
+    /* For Zoned Ufs */
+    UfsLuParams params;
+    bool zone_enabled;
+    UfsZoneDescriptor zone_desc;
+    UfsZoneState *zone_array;
 } UfsLu;
 
 typedef struct UfsParams {
diff --git a/include/block/ufs.h b/include/block/ufs.h
index 0b6ec0814d..d4d81d7845 100644
--- a/include/block/ufs.h
+++ b/include/block/ufs.h
@@ -547,6 +547,37 @@ enum {
     UFS_MASK_OCS = 0x0F,
 };
 
+/* enumeration names taken from table 26, zbcr05 */
+typedef enum UfsZoneCond {
+    ZBC_NOT_WRITE_POINTER = 0x0,
+    ZONE_COND_EMPTY = 0x1,
+    ZONE_COND_IMPLICIT_OPEN = 0x2,
+    ZONE_COND_EXPLICIT_OPEN = 0x3,
+    ZONE_COND_CLOSED = 0x4,
+    ZONE_COND_READ_ONLY = 0xd,
+    ZONE_COND_FULL = 0xe,
+    ZONE_COND_OFFLINE = 0xf,
+} UfsZoneCond;
+
+/*
+ *  ZBC_IN/OUT codes
+ */
+
+#define ZBC_OUT 0x94
+#define ZBC_IN 0x95
+
+typedef enum ZbcInCodes {
+    ZI_REPORT_ZONES = 0x00,
+    /* Support only ZI_REPORT_ZONES */
+} ZbcInCodes;
+
+typedef enum ZbcOutCodes {
+    ZO_CLOSE_ZONE = 0x01,
+    ZO_FINISH_ZONE = 0x02,
+    ZO_OPEN_ZONE = 0x03,
+    ZO_RESET_WRITE_POINTER = 0x04,
+} ZbcOutCodes;
+
 /*
  * struct UfshcdSgEntry - UFSHCI PRD Entry
  * @addr: Physical address; DW-0 and DW-1.
-- 
2.25.1


