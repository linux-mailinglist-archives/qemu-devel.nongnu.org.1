Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D727931A68
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jul 2024 20:36:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTQXB-0007hh-Hz; Mon, 15 Jul 2024 14:34:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.vnet.ibm.com>)
 id 1sTQX9-0007a3-7n; Mon, 15 Jul 2024 14:34:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.vnet.ibm.com>)
 id 1sTQX7-0007I8-CE; Mon, 15 Jul 2024 14:34:46 -0400
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46FHSwMJ013911;
 Mon, 15 Jul 2024 18:34:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding; s=pp1; bh=B2CoWZz9w+MVa
 rIuh5/hyG6bwc0jEobCFx2UkMfFq00=; b=FdX1SnkppnPnLoLnNU/ytCodJq8+0
 I/LpL1kb/MxLGc2Z6pme87isGXKX9ZkgSLjA2/1EqQ48LMQyUmMqK6oCDfBpJ8kn
 BQtRErLRdoQGZ+p4gsqcssyYI1EScgVwWnZX0ulUeUGiqfAoeN4Wh6N4KcC+TKjb
 qDlvQK6xYQYTUizVawcPugj1LgZreRt4JlRe+MNoO56uwZjMwLCf5xW/WK5i/miy
 h88+MRWODbVKLYms+yvRMCU7+pCaFO1tqpLdL1qiAAZdzq04PBR4sil/IkyJZVUG
 kocxBH0QVgTVZNpdtNNvySbxO6QdgX2TbznAl0CfyubRgA2YOkuq4KI9Q==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40d86rr3jc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jul 2024 18:34:35 +0000 (GMT)
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46FIYY7S011865;
 Mon, 15 Jul 2024 18:34:34 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40d86rr3jb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jul 2024 18:34:34 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 46FHMspO022103; Mon, 15 Jul 2024 18:34:33 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40c5dnr5v4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jul 2024 18:34:33 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 46FIYRKh49217936
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 15 Jul 2024 18:34:29 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C37CE2004B;
 Mon, 15 Jul 2024 18:34:27 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A2D7320040;
 Mon, 15 Jul 2024 18:34:26 +0000 (GMT)
Received: from gfwr518.rchland.ibm.com (unknown [9.10.239.106])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 15 Jul 2024 18:34:26 +0000 (GMT)
From: Michael Kowal <kowal@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@kaod.org, fbarrat@linux.ibm.com,
 npiggin@gmail.com, milesg@linux.ibm.com
Subject: [PATCH v2 5/9] pnv/xive2: Configure Virtualization Structure Tables
 through the PC
Date: Mon, 15 Jul 2024 13:33:28 -0500
Message-Id: <20240715183332.27287-6-kowal@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240715183332.27287-1-kowal@linux.vnet.ibm.com>
References: <20240715183332.27287-1-kowal@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: CTVwA8Shp9iy7HlG1qxE9u4vofm2Espi
X-Proofpoint-ORIG-GUID: T9q7z90IxJP3pfT44sT5DsaoV7fcOQfA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_12,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 bulkscore=0
 spamscore=0 malwarescore=0 adultscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 mlxscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407150143
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=kowal@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Frederic Barrat <fbarrat@linux.ibm.com>

Both the virtualization layer (VC) and presentation layer (PC) need to
be configured to access the VSTs. Since the information is redundant,
the xive model combines both into one set of tables and only the
definitions going through the VC are kept. The definitions through the
PC are ignored. That works well as long as firmware calls the VC for
all the tables.

For the NVG and NVC tables, it can make sense to only configure them
with the PC, since they are only used by the presenter. So this patch
allows firmware to configure the VST tables through the PC as well.
The definitions are still shared, since the VST tables can be set
through both the VC and/or PC, they are dynamically re-mapped in
memory by first deleting the memory subregion.

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
Signed-off-by: Michael Kowal <kowal@linux.vnet.ibm.com>
---
 hw/intc/pnv_xive2.c | 47 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 38 insertions(+), 9 deletions(-)

diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index c72c66dd6a..9e45161869 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -759,6 +759,9 @@ static void pnv_xive2_vst_set_exclusive(PnvXive2 *xive, uint8_t type,
          * entries provisioned by FW (such as skiboot) and resize the
          * ESB window accordingly.
          */
+        if (memory_region_is_mapped(&xsrc->esb_mmio)) {
+            memory_region_del_subregion(&xive->esb_mmio, &xsrc->esb_mmio);
+        }
         if (!(VSD_INDIRECT & vsd)) {
             memory_region_set_size(&xsrc->esb_mmio, vst_tsize * SBE_PER_BYTE
                                    * (1ull << xsrc->esb_shift));
@@ -774,6 +777,9 @@ static void pnv_xive2_vst_set_exclusive(PnvXive2 *xive, uint8_t type,
         /*
          * Backing store pages for the END.
          */
+        if (memory_region_is_mapped(&end_xsrc->esb_mmio)) {
+            memory_region_del_subregion(&xive->end_mmio, &end_xsrc->esb_mmio);
+        }
         if (!(VSD_INDIRECT & vsd)) {
             memory_region_set_size(&end_xsrc->esb_mmio, (vst_tsize / info->size)
                                    * (1ull << end_xsrc->esb_shift));
@@ -798,13 +804,10 @@ static void pnv_xive2_vst_set_exclusive(PnvXive2 *xive, uint8_t type,
  * Both PC and VC sub-engines are configured as each use the Virtual
  * Structure Tables
  */
-static void pnv_xive2_vst_set_data(PnvXive2 *xive, uint64_t vsd)
+static void pnv_xive2_vst_set_data(PnvXive2 *xive, uint64_t vsd,
+                                   uint8_t type, uint8_t blk)
 {
     uint8_t mode = GETFIELD(VSD_MODE, vsd);
-    uint8_t type = GETFIELD(VC_VSD_TABLE_SELECT,
-                            xive->vc_regs[VC_VSD_TABLE_ADDR >> 3]);
-    uint8_t blk = GETFIELD(VC_VSD_TABLE_ADDRESS,
-                           xive->vc_regs[VC_VSD_TABLE_ADDR >> 3]);
     uint64_t vst_addr = vsd & VSD_ADDRESS_MASK;
 
     if (type > VST_ERQ) {
@@ -839,6 +842,16 @@ static void pnv_xive2_vst_set_data(PnvXive2 *xive, uint64_t vsd)
     }
 }
 
+static void pnv_xive2_vc_vst_set_data(PnvXive2 *xive, uint64_t vsd)
+{
+    uint8_t type = GETFIELD(VC_VSD_TABLE_SELECT,
+                            xive->vc_regs[VC_VSD_TABLE_ADDR >> 3]);
+    uint8_t blk = GETFIELD(VC_VSD_TABLE_ADDRESS,
+                           xive->vc_regs[VC_VSD_TABLE_ADDR >> 3]);
+
+    pnv_xive2_vst_set_data(xive, vsd, type, blk);
+}
+
 /*
  * MMIO handlers
  */
@@ -1268,7 +1281,7 @@ static void pnv_xive2_ic_vc_write(void *opaque, hwaddr offset,
     case VC_VSD_TABLE_ADDR:
        break;
     case VC_VSD_TABLE_DATA:
-        pnv_xive2_vst_set_data(xive, val);
+        pnv_xive2_vc_vst_set_data(xive, val);
         break;
 
     /*
@@ -1487,6 +1500,16 @@ static uint64_t pnv_xive2_ic_pc_read(void *opaque, hwaddr offset,
     return val;
 }
 
+static void pnv_xive2_pc_vst_set_data(PnvXive2 *xive, uint64_t vsd)
+{
+    uint8_t type = GETFIELD(PC_VSD_TABLE_SELECT,
+                            xive->pc_regs[PC_VSD_TABLE_ADDR >> 3]);
+    uint8_t blk = GETFIELD(PC_VSD_TABLE_ADDRESS,
+                           xive->pc_regs[PC_VSD_TABLE_ADDR >> 3]);
+
+    pnv_xive2_vst_set_data(xive, vsd, type, blk);
+}
+
 static void pnv_xive2_ic_pc_write(void *opaque, hwaddr offset,
                                   uint64_t val, unsigned size)
 {
@@ -1497,12 +1520,18 @@ static void pnv_xive2_ic_pc_write(void *opaque, hwaddr offset,
     switch (offset) {
 
     /*
-     * VSD table settings. Only taken into account in the VC
-     * sub-engine because the Xive2Router model combines both VC and PC
-     * sub-engines
+     * VSD table settings.
+     * The Xive2Router model combines both VC and PC sub-engines. We
+     * allow to configure the tables through both, for the rare cases
+     * where a table only really needs to be configured for one of
+     * them (e.g. the NVG table for the presenter). It assumes that
+     * firmware passes the same address to the VC and PC when tables
+     * are defined for both, which seems acceptable.
      */
     case PC_VSD_TABLE_ADDR:
+        break;
     case PC_VSD_TABLE_DATA:
+        pnv_xive2_pc_vst_set_data(xive, val);
         break;
 
     case PC_NXC_PROC_CONFIG:
-- 
2.43.0


