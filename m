Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 64691A57331
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Mar 2025 21:57:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqekI-0000Sa-SO; Fri, 07 Mar 2025 15:56:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tqejp-0008QJ-5w
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 15:56:14 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tqejl-0003yf-My
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 15:56:08 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 527Jtknc017497;
 Fri, 7 Mar 2025 20:56:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=BBN4eRBGJ70X67dVWh+0OrnPfczBU7a0pQTRxmEagm0=; b=
 H5StVGd4CSolU0wb72gD1NO4JRAURoV9C3UwQ5tAjtNON1pWqJiGuEi4SObLh0FC
 TZ+pJk2EQIbMQjwC28z2XoTxojEo98VSeZeCdoh2e20FqJRsC3oi5+HiFm5h4UO2
 YAAWo3daewE7HN9SHN6zlx05u0amzRdWIPgLVGdWCBGjOy11ky2EOPdswMin2c2J
 f80biwzGmd2RfCjoaWL0hpeZiZGP1tpWAxpsF/03g5ordCVeK9yHzcCTPp0+OFKB
 wPQ+ltB3lX7RytXz8aiqlDXa9FL1xQjS7eRgWuiuejQvVqMljlXsgA802mW6u40d
 SHOx8f0y0FC18JjoUejnww==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453uaw51ha-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 07 Mar 2025 20:56:03 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 527JwRrV011083; Fri, 7 Mar 2025 20:56:01 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 453rpfmv4s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 07 Mar 2025 20:56:01 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 527KtuLx016275;
 Fri, 7 Mar 2025 20:56:01 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 453rpfmv2c-5; Fri, 07 Mar 2025 20:56:00 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Philippe Mathieu-Daude <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V1 4/4] hw/qxl: fix cpr
Date: Fri,  7 Mar 2025 12:55:54 -0800
Message-Id: <1741380954-341079-5-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1741380954-341079-1-git-send-email-steven.sistare@oracle.com>
References: <1741380954-341079-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_07,2025-03-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503070158
X-Proofpoint-GUID: YrHoVE4Da09EFYh02sqa9fTBqi78xQ5V
X-Proofpoint-ORIG-GUID: YrHoVE4Da09EFYh02sqa9fTBqi78xQ5V
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

During normal migration, new QEMU creates and initializes memory regions,
then loads the preserved contents of the region from vmstate.

During CPR, memory regions are preserved in place, then the realize
method initializes the regions contents, losing the old contents.  To
fix, skip writes to the qxl memory regions during CPR load.

Reported-by: andrey.drobyshev@virtuozzo.com
Tested-by: andrey.drobyshev@virtuozzo.com
Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/display/qxl.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index 2efdc77..da14da5 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -30,6 +30,7 @@
 #include "qemu/module.h"
 #include "hw/qdev-properties.h"
 #include "system/runstate.h"
+#include "migration/cpr.h"
 #include "migration/vmstate.h"
 #include "trace.h"
 
@@ -333,6 +334,10 @@ static void init_qxl_rom(PCIQXLDevice *d)
     uint32_t fb;
     int i, n;
 
+    if (cpr_is_incoming()) {
+        goto skip_init;
+    }
+
     memset(rom, 0, d->rom_size);
 
     rom->magic         = cpu_to_le32(QXL_ROM_MAGIC);
@@ -390,6 +395,7 @@ static void init_qxl_rom(PCIQXLDevice *d)
             sizeof(rom->client_monitors_config));
     }
 
+skip_init:
     d->shadow_rom = *rom;
     d->rom        = rom;
     d->modes      = modes;
@@ -403,6 +409,9 @@ static void init_qxl_ram(PCIQXLDevice *d)
 
     buf = d->vga.vram_ptr;
     d->ram = (QXLRam *)(buf + le32_to_cpu(d->shadow_rom.ram_header_offset));
+    if (cpr_is_incoming()) {
+        return;
+    }
     d->ram->magic       = cpu_to_le32(QXL_RAM_MAGIC);
     d->ram->int_pending = cpu_to_le32(0);
     d->ram->int_mask    = cpu_to_le32(0);
@@ -539,6 +548,10 @@ static void interface_set_compression_level(QXLInstance *sin, int level)
 
     trace_qxl_interface_set_compression_level(qxl->id, level);
     qxl->shadow_rom.compression_level = cpu_to_le32(level);
+    if (cpr_is_incoming()) {
+        assert(qxl->rom->compression_level == cpu_to_le32(level));
+        return;
+    }
     qxl->rom->compression_level = cpu_to_le32(level);
     qxl_rom_set_dirty(qxl);
 }
@@ -997,7 +1010,8 @@ static void interface_set_client_capabilities(QXLInstance *sin,
     }
 
     if (runstate_check(RUN_STATE_INMIGRATE) ||
-        runstate_check(RUN_STATE_POSTMIGRATE)) {
+        runstate_check(RUN_STATE_POSTMIGRATE) ||
+        cpr_is_incoming()) {
         return;
     }
 
@@ -1200,6 +1214,10 @@ static void qxl_reset_state(PCIQXLDevice *d)
 {
     QXLRom *rom = d->rom;
 
+    if (cpr_is_incoming()) {
+        return;
+    }
+
     qxl_check_state(d);
     d->shadow_rom.update_id = cpu_to_le32(0);
     *rom = d->shadow_rom;
@@ -1370,8 +1388,11 @@ static int qxl_add_memslot(PCIQXLDevice *d, uint32_t slot_id, uint64_t delta,
     memslot.virt_start = virt_start + (guest_start - pci_start);
     memslot.virt_end   = virt_start + (guest_end   - pci_start);
     memslot.addr_delta = memslot.virt_start - delta;
-    memslot.generation = d->rom->slot_generation = 0;
-    qxl_rom_set_dirty(d);
+    if (!cpr_is_incoming()) {
+        d->rom->slot_generation = 0;
+        qxl_rom_set_dirty(d);
+    }
+    memslot.generation = d->rom->slot_generation;
 
     qemu_spice_add_memslot(&d->ssd, &memslot, async);
     d->guest_slots[slot_id].mr = mr;
-- 
1.8.3.1


